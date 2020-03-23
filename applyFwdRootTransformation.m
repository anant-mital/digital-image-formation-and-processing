function imgChannel = applyFwdRootTransformation(imgChannel,a,b)

imgChannel = real(2*sqrt((imgChannel./(a))+(3/8) + (b./((a).^2))));

end