function Task12And13(img_dem)

% Applying White Balancing

img_dem_white_bal = applyWhiteBalancing(img_dem);


figure;
imshow(img_dem_white_bal), title('White balanced image');



% Histogram Equalization


img_dem_white_bal_hsv = rgb2hav(img_dem_white_bal);
img_dem_white_bal_hsv(:,:,3) = histeq(img_dem_white_bal_hsv(:,:,3));
img_dem_white_bal_histeq = hsv2rgb(img_dem_white_bal_hsv);

figure;
imshow(img_dem_white_bal_histeq), title('White balanced histogram equalised image');

% Gamma Correction

g = 0.1;
img_dem_white_bal_histeq_gc = zeros([size(img_dem_white_bal_histeq)],class(img_dem_white_bal_histeq));

img_dem_white_bal_histeq_gc(:,:,1) = img_dem_white_bal_histeq(:,:,1).^g ;
img_dem_white_bal_histeq_gc(:,:,2) = img_dem_white_bal_histeq(:,:,2).^g ;
img_dem_white_bal_histeq_gc(:,:,3) = img_dem_white_bal_histeq(:,:,3).^g ;

figure;
imshow(img_dem_white_bal_histeq_gc), title('White balanced histeq gamma corrected image');


end