function [output]=demosaicing(im)

    
M = size(im, 1);
N = size(im, 2);


red_mask = repmat([1 0; 0 0], M/2, N/2);
green_mask = repmat([0 1; 1 0], M/2, N/2);
blue_mask = repmat([0 0; 0 1], M/2, N/2);

R=im(:,:,1).*red_mask;
G=im(:,:,2).*green_mask;
B=im(:,:,3).*blue_mask;

    
% Interpolation for the green at the missing points

    G= G + imfilter(G, [0 1 0; 1 0 1; 0 1 0]/4);
    
% Interpolation for the blue at the missing points

% First, calculate the missing blue pixels at the red location

    B1 = imfilter(B,[1 0 1; 0 0 0; 1 0 1]/4);
% Second, calculate the missing blue pixels at the green locations
% by averaging the four neighouring blue pixels
    B2 = imfilter(B+B1,[0 1 0; 1 0 1; 0 1 0]/4);
    B = B + B1 + B2;
    
% Interpolation for the red at the missing points
% First, calculate the missing red pixels at the blue location
    R1 = imfilter(R,[1 0 1; 0 0 0; 1 0 1]/4);
% Second, calculate the missing red pixels at the green locations   
    R2 = imfilter(R+R1,[0 1 0; 1 0 1; 0 1 0]/4);
    R = R + R1 + R2;
    

    output(:,:,1)=R; 
    output(:,:,2)=G; 
    output(:,:,3)=B;