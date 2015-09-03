function J=do_extrefine(oframes,octave,smin,thresh,r)
%% file:        extrefine.m
% author:      Noemie Phulpin
% description: Refine the location, threshold strength and remove points on edges

[M,N,S]=size(octave);  
[L,K]=size(oframes);


comp=1;
J=[];
for p = 1:K
    
     b=zeros(1,3) ;
    
     A=oframes(:,p);
     x=A(1)+1;
     y=A(2)+1;
     s=A(3)+1-smin; %The key points to revert to a specific coordinate DoG scale spatial coordinates
    
     %Local maxima extracted from the DOG have coordinates 1<=x<=N-2, 1<=y<=M-2
     % and 1<=s-mins<=S-2. This is also the range of the points that we can refine.
    if(x < 2 || x > N-1 || y < 2 || y > M-1 || s < 2 || s > S-1) 
        continue ;
    end
    
    val=octave(y,x,s); %Gray value of the extreme points
    Dx=0;Dy=0;Ds=0;Dxx=0;Dyy=0;Dss=0;Dxy=0;Dxs=0;Dys=0 ;
    dx = 0 ;
    dy = 0 ;
    
     for iter = 1:5
        
         B = zeros(3,3) ;         
        
         x = x + dx ;
         y = y + dy ;
        
         if (x < 2 || x > N-1 || y < 2 || y > M-1 )  
             break ; 
         end
        
         % Compute the gradient.
         Dx = 0.5 * (octave(y,x+1,s) - octave(y,x-1,s));
         Dy = 0.5 * (octave(y+1,x,s) - octave(y-1,x,s)) ;
         Ds = 0.5 * (octave(y,x,s+1) - octave(y,x,s-1)) ;
        
         % Compute the Hessian.
         Dxx = (octave(y,x+1,s) + octave(y,x-1,s) - 2.0 * octave(y,x,s)) ;
         Dyy = (octave(y+1,x,s) + octave(y-1,x,s) - 2.0 * octave(y,x,s)) ;
         Dss = (octave(y,x,s+1) + octave(y,x,s-1) - 2.0 * octave(y,x,s)) ;
        
         Dys = 0.25 * ( octave(y+1,x,s+1) + octave(y-1,x,s-1) - octave(y-1,x,s+1) - octave(y+1,x,s-1) ) ;
         Dxy = 0.25 * ( octave(y+1,x+1,s) + octave(y-1,x-1,s) - octave(y-1,x+1,s) - octave(y+1,x-1,s) ) ;
         Dxs = 0.25 * ( octave(y,x+1,s+1) + octave(y,x-1,s-1) - octave(y,x-1,s+1) - octave(y,x+1,s-1) ) ;
        
         % Solve linear system.
         B(1,1) = Dxx ;
         B(2,2) = Dyy ;
         B(3,3) = Dss ;
         B(1,2) = Dxy ;
         B(1,3) = Dxs ; 
         B(2,3) = Dys ;
         B(2,1) = Dxy ;
         B(3,1) = Dxs ;
         B(3,2) = Dys ; 
        
         b(1) = - Dx ;
         b(2) = - Dy ;
         b(3) = - Ds ;
       
%         c=b*inv(B);   %行向量线性方程组求解
          c=b/B;
         % If the translation of the keypoint is big, move the keypoint and re-iterate the computation. Otherwise we are all set.
         if (c(1) >  0.6 && x < N-2 )
              if (c(1) < -0.6 && x > 1)
                  dx=0;
              else
                  dx=1;
              end
         else
            if (c(1) < -0.6 && x > 1)
                dx=-1;
            else
                dx=0;
            end
        end
        
        if (c(2) >  0.6 && y < N-2 )
            if (c(2) < -0.6 && y > 1)
                dy=0;
            else
                dy=1;
            end
        else
            if (c(2) < -0.6 && y > 1)
                dy=-1;
            else
                dy=0;
            end
        end        
        
        if( dx == 0 && dy == 0 ) break ; end
    end
    
    %we keep the value only of it verify the conditions
    val = val + 0.5 * (Dx * c(1) + Dy * c(2) + Ds * c(3)) ;%Extreme Extreme Points
    score = (Dxx+Dyy)*(Dxx+Dyy) / (Dxx*Dyy - Dxy*Dxy) ; 
    xn = x + c(1) ;
    yn = y + c(2) ;
    sn = s + c(3) ;
    
    if (abs(val) > thresh) && ...           %Greater than the threshold gray value
        (score < (r+1)*(r+1)/r) && ...  %The proportion of curvature smaller than the threshold value
        (score >= 0) && ...             %Curvature ratio greater than 0
        (abs(c(1)) < 1.5) && ...        %%%%%%%%%%%%%%%%%%%%%%%%%%%%    %%%%%%
        (abs(c(2)) < 1.5) && ...        %
        (abs(c(3)) < 1.5) && ...        %Pixel position deviation is less than 1.5
        (xn >= 0) && ...
        (xn <= M-1) && ...
        (yn >= 0) && ...
        (yn <= N-1) && ...
        (sn >= 0) && ...
        (sn <= S-1)                     %In the range of the image pixel coordinates

        J(1,comp)=xn-1;
        J(2,comp)=yn-1;
        J(3,comp)=sn-1+smin;
        comp=comp+1;
    end
end

return

