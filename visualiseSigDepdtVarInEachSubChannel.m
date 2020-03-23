
function [mean,var] = visualiseSigDepdtVarInEachSubChannel(imgChannel)

% Analyze each subchannel of the out-of-focus image with a sliding window operator that outputs 
% the local sample means and local sample variances for each position of the window. 
% Create mean-variance scatterplots (i.e scatterplots where the coordinates of each point in the plot are the sample mean and sample variance over a window) 
% to visualize the signal dependent variance within each subchannel.

meanFilterFunction = @(theBlockStructure) mean2(theBlockStructure.data);
varFilterFunction = @(theBlockStructure) std2(theBlockStructure.data).^2;

mean = blockproc((imgChannel),[8 8], meanFilterFunction);
mean = reshape(mean.',1,[]);
var = blockproc((imgChannel),[8 8], varFilterFunction);
var = reshape(var.',1,[]);

end