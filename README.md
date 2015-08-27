基于RGB颜色空间的颜色特征与SIFT特征提取
=============================
##目录

* [项目背景](#背景介绍)

* [项目介绍](#项目介绍)

* [项目使用](#项目使用)
	* [获取代码](#获取代码)
	* [使用样例](#使用样例)


<a name="背景介绍"></a>
##背景介绍
本项目是我参加大学生创新项目的一部分，我们将要创建一个旅游推荐系统，通过用户输入的图片进行相关的图像处理，最后得到与输入图片相关的图片集，其中颜色特征和SIFT特征的提取就是本项目的关键技术。

<a name="项目介绍"></a>
##项目介绍
一般的图像特征提取分为局部特征提取和全局特征提取，全局特征就是方差、颜色直方图等等，全局特征用来描述总是比较合适的。但是无法分辨出前景和背景却是全局特征本身就有的劣势，而所谓局部特征，顾名思义就是一些局部才会出现的特征，就是指一些能够稳定出现并且具有良好的可区分性的一些点了，这样在物体不完全受到遮挡的情况下，一些局部特征依然稳定在，以代表这个物体（甚至这幅图像）。因此本项目采用将局部特征与全局特征相融合的方式进行特征的提取，在全局特征方面采用基于RGB颜色空间的颜色特征直方图；而在局部特征方面，采用不比较经典的SIFT特征。本开源项目的只是给出了基本的测试代码，详细描述了颜色特征和SIFT特征提取的过程。

<a name="项目使用"></a>
##项目使用

<a name="获取代码"></a>
###获取代码
* gitcafe项目主页:<https://github.com/Stephan14/colour-and-SIFT-feature->
<a name="使用样例"></a>

###使用样例

将本代码下载后，放到Matlab的文件夹中，然后运行结果如下：
原始图像：

![icon1](https://github.com/Stephan14/colour-and-SIFT-feature-/blob/master/picture/figure1.png)

颜色特征提取的直方图：

![icon2](https://github.com/Stephan14/colour-and-SIFT-feature-/blob/master/picture/figure2.png)

得到的差分金字塔：

![icon3](https://github.com/Stephan14/colour-and-SIFT-feature-/blob/master/picture/figure3.png)

最后得到的特征方向：

![icon4](https://github.com/Stephan14/colour-and-SIFT-feature-/blob/master/picture/figure4.png)





