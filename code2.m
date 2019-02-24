close(gcf)
clc;

clear all;

close all;

% reading the inbuilt grey image 
img=imread('cameraman.tif');

%  displaying the original image
imshow(img)
title('original camerama image')

%converting the image to double 
img1=im2double(img)

% adding speckle noise of variance 0.1 to the image
y=imnoise(img1,'speckle',0.1) ;

% to show the noisy image
figure
imshow(y);
title('image after adding noise') 


%  take the size of the variable y to N
N = length(y);


% Creating a D matrix which is sparse and has only 3 values in each row  (1,-2 ,1) of size n-2*n., where n is the size of input signal y.
e = ones(N, 1); 
D = spdiags([e -2*e e], 0:2, N-2, N);
 
% as the size of D is large only the first and last corners of D is displayed
 full(D(1:5, 1:5))
 full(D(end-4:end, end-4:end))
 
 lam=0; % initializing the control parameter
 for i=0:100 
     F = speye(N) + lam * D' * D; % implementation of the least square denoising equation as linear regression problem by simple matrix operations instead of optimisation         
  F=full(F);% getting the full size of F(since F is a sparse matrix)  
 x1 = inv(F)*y; % finding the inverse of F (fast solveing) 
 x2=inv(F)*x1'; % finding the inverse of F (fast solveing)
 x=x2';%getting the transpose of denoised image
 p(i+1,1)=psnr(x,img1); % calculating psnr for lamda varying from 0 to 100
 lam=lam+1;  %varying lamda from 0 to 100
 end
 
 % plotting psnr
 figure
 j=0:100;
 plot(j,p) 
 title('psnr plot')
 xlabel('lamda')
 ylabel('psnr')
 
 
 % psnr before denoising
 psnrnoisy=psnr(y,img1)
 % psnr after denoising
 psnrdenoisy=p(2,:)  % high psnr at lamda=1
 
 

 
