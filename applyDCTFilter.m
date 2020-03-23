function imgChannel = applyDCTFilter(imgChannel,thres)

%A.*(A>thres) will result in A for items > thres and 0 otherwise

DctFiltPatch = @(theBlockStructure) idct2(dct2(theBlockStructure.data).*(dct2(theBlockStructure.data) > thres)); 
imgChannel = blockproc(imgChannel, [8 8], DctFiltPatch);

end