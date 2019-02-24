close(gcf)
clc;

clear all;

close all;

% reading the inbuilt grey image 
img=imread('cameraman.tif');

%  displaying the original image
imshow(img)
title('original camerama image')

img1=im2double(img)% converting the image to double 

% adding gaussian noise to image
y = imnoise(img1,'gaussian') ;


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
 
 
 lam = 1;   % initializing the control parameter
 F = speye(N) + lam * D' * D; % implementation of the least square denoising equation as linear regression problem by simple matrix operations instead of optimisation         
 F=full(F)  % getting the full size of F(since F is a sparse matrix)  
 x1 = inv(F)*y; % finding the inverse of F (fast solveing)          
 x2=inv(F)*x1' % finding the inverse of F (fast solveing)          
 x=x2'  %getting the transpose of denoised image
 
 
 % displaying the denoised image
 figure
 imshow(x)
 title('denoised image')
 
 % calculating the psnr of noisy image 
 psnrnoisy=psnr(y,img1)

 psnrdenoised=psnr(x,img1) 
 
