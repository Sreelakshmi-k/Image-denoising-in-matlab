# Image-denoising-in-matlab
Denoising a black and white image using least square solution (code1)
Calculating the psnr of denoised image (code2)
Denoising a colour image using least square solution (code3).
The procedure to denoise a colour image is Read the image then denoise it columnwise and then take the transpose of the output
and again denoise (which is row wise denoise). And the final output is transpose.
This step has to be done separately for R, G, B.
