###################################################################
#                                                                 #
#    Deep Contour Detector                       #
#    Wei Shen (wei.shen@t.shu.edu.cn)                          #
#                                                                 #
###################################################################

1. Introduction.
This is the testing code for the Deep Contour Detector proposed in

Wei Shen, Xinggang Wang, Yan Wang, Xiang Bai, Zhijiang Zhang. 
DeepContour: A Deep Convolutional Feature Learned by Positive-sharing Loss for Contour Detection. 
IEEE Conference on Computer Vision and Pattern Recognition (CVPR), Boston, USA, 2015.

This code is modified from Piotr Dollar's Structured Edge Detection Toolbox [1,2].


###################################################################

2. License.

Please follow the license terms included in Structured Edge Detection Toolbox [1,2] and Caffe Deep Learning Toolbox [3].


###################################################################

3. Installation.

a) This code is written for the Matlab interpreter (tested with versions R2014a on Windows 7) and requires the Matlab Image Processing Toolbox and CUDA Toolkit (version 6.0 or later). 

b) First, download the binary dependencies from https://drive.google.com/file/d/0BwU2lgiGMpBmQmpGT3BudmV2Yms/view?usp=sharing&resourcekey=0--kgaxYn1AkBAgmwaj6zZhQ and unzip them into the folder "bin".

c) Additionally, Piotr's Matlab Toolbox and Piotr's Structured Edge Detection Toolbox are also required. They can be downloaded at:
 http://vision.ucsd.edu/~pdollar/toolbox/doc/index.html and https://github.com/pdollar/edges respectively.

d) Finally, optionally download the BSDS500 dataset (necessary for evaluation):
 http://www.eecs.berkeley.edu/Research/Projects/CS/vision/grouping/
 After downloading BSR/ should contain BSDS500, bench, and documentation.
 The path of the BSDS500 dataset should be YourCodePath/BSR/BSDS500/data/
 
e) A fully trained deep contour model (deep_contour_model) for RGB images is available as part of this release. The architecture of the used deep network is described in deploy_cov4.prototxt.

###################################################################

4. Getting Started.

 - Make sure to carefully follow the installation instructions above.
 - Please run "Entry_DeepStructureEdge.m". 
 - The default parameter setting leads to 0.75 F-measure on BSDS500. 
   To achieve 0.76 F-measure, set "model.opts.nTreesEval=10" and "model.opts.multiscale=1" in "edgesDLDemo.m". Note that, the evaluation process under this setting is very time consuming.

###################################################################

5. Reference.

[1] P. Dollar and C. L. Zitnick. Structured forests for fast edge detection. In Proc. ICCV, pages 1841–1848, 2013.

[2] P. Dollar and C. L. Zitnick. Fast edge detection using structured forests. arXiv preprint arXiv:1406.5549, 2014.

[3] Y. Jia, E. Shelhamer, J. Donahue, S. Karayev, J. Long, R. Girshick, S. Guadarrama, and T. Darrell. Caffe: Convolutional
architecture for fast feature embedding. arXiv preprint arXiv: 1408.5093, 2014.
###################################################################
