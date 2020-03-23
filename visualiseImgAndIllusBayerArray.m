function visualiseImgAndIllusBayerArray(img_oof,img_nat)


figure;
imshow(img_oof,[]), title('Out of focus');
figure;
imshow(img_nat,[]), title('Natural');

% To visualize Bayer mosaic arrays, we take a section of these images 

img_oof_sec = img_oof(1:500,1:500);
figure;
imshow(img_oof_sec,[]), title('Out of focus - Illustration of Bayer Mosaic Array');

img_nat_sec = img_nat(1:500,1:500);
figure;
imshow(img_nat_sec,[]), title('Natural - Illustration of Bayer Mosaic Array');

end