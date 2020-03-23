function img_dem_white_bal = applyWhiteBalancing(img)

img_dem_yuv = rgb2ycbcr(img); % Converting the RGB to HSV
[~,I] = max(max(img_dem_yuv(:,:,1))); % Finding pixel with highest Luminance

img_dem_r = img(:,:,1) ;
img_dem_g = img(:,:,2) ;
img_dem_b = img(:,:,3) ;

% Dividing each color channel by maximumintensity Luminance pixel

img_dem_r = img_dem_r./img_dem_r(I);
img_dem_g = img_dem_g./img_dem_g(I);
img_dem_b = img_dem_b./img_dem_b(I);

img_dem_white_bal = zeros(size(img),class(img));

img_dem_white_bal(:,:,1) = img_dem_r; 
img_dem_white_bal(:,:,2) = img_dem_g;
img_dem_white_bal(:,:,3) = img_dem_b;

end