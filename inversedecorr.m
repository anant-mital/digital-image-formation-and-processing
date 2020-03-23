function output = inversedecorr(img)

% mask parameters are calculated from implementation of ref. paper on denoising at https://github.com/gfacciol/DCTdenoising/blob/master/DCTdenoising.cpp

mask = [sqrt(2)/sqrt(6),1/sqrt(3),sqrt(2)/sqrt(6);sqrt(3)/sqrt(6),0,-sqrt(3)/sqrt(6);1/sqrt(6),-sqrt(2)/sqrt(6),1/sqrt(6)];
output = imfilter(img,mask');


end