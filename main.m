function main

% Load the images in Matlab and convert them to double.
[img_oof] = imread('outoffocus.tiff');
[img_nat] = imread('natural.tiff');

% convert images to double

[img_oof] = im2double(img_oof);
[img_nat] = im2double(img_nat);

% Visualize the images and illustrate the Bayer mosaic arrays.
visualiseImgAndIllusBayerArray(img_oof,img_nat);

% Separate the BayerMosaic images into separate channels 

img_oof_b = getRGBImgFromBayerArray(img_oof); 
img_nat_b = getRGBImgFromBayerArray(img_nat);

img_oof_Ir = img_oof_b(:,:,1);
img_oof_Ig = img_oof_b(:,:,2);
img_oof_Ib = img_oof_b(:,:,3);

img_nat_Ir = img_nat_b(:,:,1);
img_nat_Ig = img_nat_b(:,:,2);
img_nat_Ib = img_nat_b(:,:,3);

figure;
subplot(2,3,1), imshow(img_oof_Ir,[]), title('R')
subplot(2,3,2), imshow(img_oof_Ig,[]), title('G')
subplot(2,3,3), imshow(img_oof_Ib,[]), title('B')
subplot(2,3,4), imshow(img_nat_Ir,[]), title('R')
subplot(2,3,5), imshow(img_nat_Ig,[]), title('G')
subplot(2,3,6), imshow(img_nat_Ib,[]), title('B')


% Analyze each subchannel of the out-of-focus image with a sliding window operator that outputs 
% the local sample means and local sample variances for each position of the window. 
% Create mean-variance scatterplots (i.e scatterplots where the coordinates of each point in the plot are the sample mean and sample variance over a window) 
% to visualize the signal dependent variance within each subchannel.

[mean_Ir,var_Ir] = visualiseSigDepdtVarInEachSubChannel(img_oof_Ir);
[mean_Ig,var_Ig] = visualiseSigDepdtVarInEachSubChannel(img_oof_Ig);
[mean_Ib,var_Ib] = visualiseSigDepdtVarInEachSubChannel(img_oof_Ib);

figure;
subplot(3,1,1), scatter(mean_Ir, var_Ir, 'rx'), title('red');
subplot(3,1,2), scatter(mean_Ig, var_Ig, 'gx'), title('green');
subplot(3,1,3), scatter(mean_Ib, var_Ib, 'bx'), title('blue');

% Fit straight lines on the scatter plot and visualise them against plots

fit_Ir = fit(mean_Ir',var_Ir','poly1');
fit_Ig = fit(mean_Ig',var_Ig','poly1');
fit_Ib = fit(mean_Ib',var_Ib','poly1');

figure;
scatter(mean_Ir, var_Ir, 'rx');
hold on;
plot(fit_Ir, 'b');
hold off;

figure;
scatter(mean_Ig, var_Ig, 'gx');
hold on;
plot(fit_Ig, 'b');
hold off;

figure;
scatter(mean_Ib, var_Ib, 'bx');
hold on;
plot(fit_Ib, 'r');
hold off;

% applying Fwd Root Transformation

img_oof_Ir1 = applyFwdRootTransformation(img_oof_Ir, fit_Ir.p1, fit_Ir.p2);
img_oof_Ig1 = applyFwdRootTransformation(img_oof_Ig, fit_Ig.p1, fit_Ig.p2);
img_oof_Ib1 = applyFwdRootTransformation(img_oof_Ib, fit_Ib.p1, fit_Ib.p2);

img_nat_Ir1 = applyFwdRootTransformation(img_nat_Ir, fit_Ir.p1, fit_Ir.p2);
img_nat_Ig1 = applyFwdRootTransformation(img_nat_Ig, fit_Ig.p1, fit_Ig.p2);
img_nat_Ib1 = applyFwdRootTransformation(img_nat_Ib, fit_Ib.p1, fit_Ib.p2);

% Compute the mean-variance scatterplots of the transformed out-of-focus image 
% and compare it to the scatterplots from the original out-of-focus image. 
% Draw some conclusions. What has the transformation achieved

[mean_Ir1,var_Ir1] = visualiseSigDepdtVarInEachSubChannel(img_oof_Ir1);
[mean_Ig1,var_Ig1] = visualiseSigDepdtVarInEachSubChannel(img_oof_Ig1);
[mean_Ib1,var_Ib1] = visualiseSigDepdtVarInEachSubChannel(img_oof_Ib1);

figure;
subplot(3,1,1), scatter(mean_Ir1, var_Ir1, 'rx'), title('red');
subplot(3,1,2), scatter(mean_Ig1, var_Ig1, 'gx'), title('green');
subplot(3,1,3), scatter(mean_Ib1, var_Ib1, 'bx'), title('blue');

% Below Section deals with Denoising of Image

% Decorelate colors in image non transformed and transformed image

img_nat_filt = zeros([size(img_nat)/2 3],class(img_nat)); % natural image not transfromed
img_nat_filt(:,:,1) = img_nat_Ir;
img_nat_filt(:,:,2) = img_nat_Ig;
img_nat_filt(:,:,3) = img_nat_Ib;


img_nat_filt = decorr(img_nat_filt);

im_nat_transf_filt = zeros([size(img_nat)/2 3],class(img_nat)); % transformed image
im_nat_transf_filt(:,:,1) = img_nat_Ir1;
im_nat_transf_filt(:,:,2) = img_nat_Ig1;
im_nat_transf_filt(:,:,3) = img_nat_Ib1;

im_nat_transf_filt = decorr(real(im_nat_transf_filt));

% Applying DCT filter on image channels

thres = 0.01;

img_nat_Ir_filt = applyDCTFilter(img_nat_filt(:,:,1), thres);
img_nat_Ig_filt = applyDCTFilter(img_nat_filt(:,:,2), thres);
img_nat_Ib_filt = applyDCTFilter(img_nat_filt(:,:,3), thres);

img_nat_filt(:,:,1) = img_nat_Ir_filt;
img_nat_filt(:,:,2) = img_nat_Ig_filt;
img_nat_filt(:,:,3) = img_nat_Ib_filt;

img_nat_Ir1_filt = applyDCTFilter(im_nat_transf_filt(:,:,1), thres);
img_nat_Ig1_filt = applyDCTFilter(im_nat_transf_filt(:,:,2), thres);
img_nat_Ib1_filt = applyDCTFilter(im_nat_transf_filt(:,:,3), thres);

im_nat_transf_filt(:,:,1) = img_nat_Ir1_filt;
im_nat_transf_filt(:,:,2) = img_nat_Ig1_filt;
im_nat_transf_filt(:,:,3) = img_nat_Ib1_filt;

% Applying Inverse Decorrelation on colors

img_nat_filt = inversedecorr(img_nat_filt);

figure;
imshow(img_nat_filt), title('Filtered Natural Image');

im_nat_transf_filt = inversedecorr(real(im_nat_transf_filt));

img_nat_Ir1_filt = im_nat_transf_filt(:,:,1);
img_nat_Ig1_filt = im_nat_transf_filt(:,:,2);
img_nat_Ib1_filt = im_nat_transf_filt(:,:,3);

% Applying inverse transform on transformed and denoised image

im_nat_transf_filt_inv = zeros([size(img_nat)/2 3],class(img_nat));

im_nat_transf_filt_inv(:,:,1) = applyInverseRootTransformation(img_nat_Ir1_filt, fit_Ir.p1, fit_Ir.p2);
im_nat_transf_filt_inv(:,:,2) = applyInverseRootTransformation(img_nat_Ig1_filt, fit_Ig.p1, fit_Ig.p2);
im_nat_transf_filt_inv(:,:,3) = applyInverseRootTransformation(img_nat_Ib1_filt, fit_Ib.p1, fit_Ib.p2);

figure;
imshow(im_nat_transf_filt_inv), title('Transformed and Filtered and Inverse Transformed');



% Applying Demosaicing

img_dem = demosaicing(im_nat_transf_filt_inv);

% figure;
% subplot(3,1,1), imshow(img_dem(:,:,1)), title('img demosaiced red');
% subplot(3,1,2), imshow(img_dem(:,:,2)), title('img demosaiced green');
% subplot(3,1,3), imshow(img_dem(:,:,3)), title('img demosaiced blue');

figure;
imshow(img_dem), title('Composed Color Image After Demosaicing');

% Gamma Correction after Demosaicking

img_dem_gc = lin2rgb(img_dem);
figure;
imshow(img_dem_gc), title('Result After Gamma Correction');

% Task12And13(img_dem);
end