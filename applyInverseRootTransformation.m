function imgChannel = applyInverseRootTransformation(imgChannel,a,b)

imgChannel = a*((1/4)*(imgChannel.^2) + (1/4)*((3/2).^(1/2))*(imgChannel.^(-1)) - (11/8)*(imgChannel.^(-2))+(5/8)*((3/2)^(1/2))*(imgChannel.^(-3))-(1/8)-(b/(a.^2)));

end