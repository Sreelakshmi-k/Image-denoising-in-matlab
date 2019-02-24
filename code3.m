close(gcf)
clc;
clear all;
close all;

% reading the image 
img=imread('D:/sree/matlab excersises/sem2/signal/assignment2/CB.EN.P2CEN18017/cyclone-debbie.jpg');
img1=im2double(img); % converting the image to double
imshow(img) % displaying the image 
title('original image')


% adding gaussian noise with mean =0 and varience =0.1 to the image
y=imnoise(img1,'gaussian',0,0.1) ;
figure
imshow(y) % displaying th enoisy image 
title('noisy image')


% extracting the rgb componets of the image
yr=y(:,:,1);
yg=y(:,:,2);
yb=y(:,:,3);

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
 F=full(F) ; % getting the full size of F(since F is a sparse matrix)  
 xr1 = inv(F)*yr; % finding the inverse of F (fast solveing) for r component          
 xg1 = inv(F)*yg; % finding the inverse of F (fast solveing) for g component                  
 xb1 = inv(F)*yb; % finding the inverse of F (fast solveing) for b component                   
 
 xr2 = inv(F)*xr1'; % finding the inverse of F (fast solveing) for r component         
 xg2 = inv(F)*xg1'; % finding the inverse of F (fast solveing) for g component        
 xb2 = inv(F)*xb1'; % finding the inverse of F (fast solveing) for b component         
 
 xr3 =xr2'; %taking the transposed of final denoised r component 
 xg3=xg2';  %taking the transposed of final denoised g component 
 xb3=xb2';  %taking the transposed of final denoised b component 
 
 
 % combining the rgb components
 X(:,:,1)=xr3;
 X(:,:,2)=xg3;
 X(:,:,3)=xb3;
 
 % displaying the denoised image
 figure
 imshow(X)
 title('denoised image')
 
  
 noisy_psnr=psnr(y,img1); % psnr for noisy image
 denoised_psnr=psnr(X,img1); % psnr for denoised image