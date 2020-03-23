
% This function gets rgb image from Bayer Mosaic gray scale image assuming
% pattern is 'RGGB'

function rgb = getRGBImgFromBayerArray(img)



rgb = zeros([size(img)/2 3],class(img));

rgb(:,:,1) = img(1:2:end,1:2:end); % getting red pixels
rgb(:,:,2) = img(1:2:end,2:2:end); % getting green pixels
rgb(:,:,2) = img(2:2:end,1:2:end); % getting green pixels
rgb(:,:,3) = img(2:2:end,2:2:end); % getting blue pixels


end