%Author: Jeygopi Panisilvam 
%Uni ID: u5190766
%ENGN6528: Group Project

%This function generates color histograms and is 
%used to determine the color differences between objects

%It is used to tighten the search space rather than generate
%matches. It is used alongside the match function in threshold to
%generate a search heuristic

function ind = histcomparison(img1,img2)
%%RGB colorrec%%

%% calculate number of bins = root(pixels);
%%All pixel are the same size, so to find the number of bins%%
%no_of_bins = sqrt(number of pixels)%%
total_pixels = 240*320;
bins = floor(sqrt(total_pixels));

img1 = rgb2hsv(img1);
HH = imhist(img1(:,:,1),bins);
SH = imhist(img1(:,:,2),bins);
VH = imhist(img1(:,:,3),bins);
M1(:,1) = HH;
M1(:,2) = SH;
M1(:,3) = VH;

img2 = rgb2hsv(img2);
HH1 = imhist(img2(:,:,1),bins);
SH1 = imhist(img2(:,:,2),bins);
VH1 = imhist(img2(:,:,3),bins);

% figure;
% hold on;
% h(1)=stem(1:bins,HH1);
% h(2)=stem(1:bins + 1/3, SH1);
% h(3)=stem(1:bins + 2/3, VH1); 
% % 
% % 
% set(h, 'marker', 'none');
% set(h(1), 'color', [1 0 0]);
% set(h(2), 'color', [0 1 0]);
% set(h(3), 'color', [0 0 1]);
% % 
% % 
% figure
% hold on;
% h(1)=stem(1:bins,HH);
% h(2)=stem(1:bins + 1/3, SH);
% h(3)=stem(1:bins + 2/3, VH); 
% % 
% 
% set(h, 'marker', 'none');
% set(h(1), 'color', [1 0 0]);
% set(h(2), 'color', [0 1 0]);
% set(h(3), 'color', [0 0 1]);

M2(:,1) = HH1;
M2(:,2) = SH1;
M2(:,3) = VH1;
M1 = M1./total_pixels;
M2 = M2./total_pixels;

euc_dist = sqrt(sum((M2-M1).^2));
    if sum(euc_dist) < 1;
        ind = 1 ;
    else 
        ind = 0;
    end


