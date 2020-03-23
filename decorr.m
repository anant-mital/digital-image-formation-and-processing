function output = decorr(img)

% mask parameters are obtained from ref. paper on DCT denoising

mask = [1/sqrt(3),1/sqrt(3),1/sqrt(3);1/sqrt(2),0,-1/sqrt(2);1/sqrt(6),-2/sqrt(6),1/sqrt(6)];
output = imfilter(img,mask);

end