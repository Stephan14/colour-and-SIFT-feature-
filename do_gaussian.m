function L = do_gaussian(I,sigmaN,O,S,omin,smin,smax,sigma0)

%% file:        do_gaussian.m
 % author:      Noemie Phulpin
 % description: gaussian scale space of image I
 %%

if(nargin<7)        %nargin is used to determine the number of input variables of the function
   sigma0=1.6*k;
end              do_sift function has been defined sigma0, and enter the total amount of variable> 7 therefore does not perform step
if omin<0
   for o=1:-omin
	I=doubleSize(I);
   end
elseif omin>0
   for o=1:-omin
	I=halveSize(I);
   end
end              % do_sift already defined omin = 0, therefore step is not performed

[M,N] = size(I);
% Used to calculate sigma0 value, convenience
k = 2^(1/S);                          %scale space multiplicative step k
sigma0=1.6*k;
dsigma0 = sigma0*sqrt(1-1/k^2);
sigmaN=0.5;                           %nominal smoothing of the image
so=-smin+1;                           %index offset

%scale space structure
L.O = O;
L.S = S;
L.sigma0 = sigma0;
L.omin = omin;
L.smin = smin;
L.smax = smax;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%First Octave
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%The first set of initialization
L.octave{1} = zeros(M,N,smax-smin+1); 

%The first set of initialization
sig=sqrt( (sigma0*k^smin)^2 - (sigmaN/2^omin)^2 );
%b=smooth2(I,sig) ;
%[N1,M1]=size(b)
%b(1:4,1:4)
%c=imsmooth(I,sig) ;
%[N2,M2]=size(c)
%c(1:4,1:4)
L.octave{1}(:,:,1) = smooth(I,sig);

%other sub-levels
for s=smin+1:smax
    dsigma = k^s * dsigma0;
    L.octave{1}(:,:,s+so) = smooth( squeeze(L.octave{1}(:,:,s-1+so)) ,dsigma);
end    
%% Sigma0 and just recorded the number of layers used, does not determine the specific value of each dimension, specific scale value can be derived

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The next group
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Conversion all groups
for o=2:O     % Next start from the second group
    
    sbest = min(smin+S,smax);
    TMP = halvesize( squeeze(L.octave{o-1}(:,:,sbest+so)) );% In the fourth layer downsampling
    sigma_next = sigma0*k^smin;
    sigma_prev = sigma0*k^(sbest-S);
    
    if (sigma_next>sigma_prev)
       sig=sqrt(sigma_next^2-sigma_prev^2);
       TMP= smooth( TMP,sig);
    end
    
    [M,N] = size(TMP);
    L.octave{o} = zeros(M,N,smax-smin+1); % Initialization next set
    L.octave{o}(:,:,1) = TMP;             % Down sampled image as the set of the first layer
    %other sub-levels 
    for s=smin+1:smax
        dsigma = k^s * dsigma0;
        L.octave{o}(:,:,s+so) = smooth( squeeze(L.octave{o}(:,:,s-1+so)) ,dsigma);
    end

end




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Auxiliary functions

function J = halvesize(I)
J=I(1:2:end,1:2:end);

function J = doubleSize(I)
[M,N]=size(I) ;
J = zeros(2*M,2*N) ;
J(1:2:end,1:2:end) = I ;
J(2:2:end-1,2:2:end-1) = ...
	0.25*I(1:end-1,1:end-1) + ...
	0.25*I(2:end,1:end-1) + ...
	0.25*I(1:end-1,2:end) + ...
	0.25*I(2:end,2:end) ;
J(2:2:end-1,1:2:end) = ...
	0.5*I(1:end-1,:) + ...
    0.5*I(2:end,:) ;
J(1:2:end,2:2:end-1) = ...
	0.5*I(:,1:end-1) + ...
    0.5*I(:,2:end) ;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

