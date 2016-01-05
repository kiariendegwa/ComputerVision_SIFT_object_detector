%Main SIFT detector Script
%
%Generate training sets
%Author: Kiarie Ndegwa
%Uni ID:  U4742829
%ENGN 6528: COMP Vision
%
%Generate test set and training images
%takes in two images from the 4 image set

dr='C:\Users\user\Documents\MATLAB\finished_project\trainingImage';
list=dir([dr, '\*.jpg']);


%saves us from loading sift features all the time
if exist('data_images.mat','file') ~= 2
  
    for x=1:length(list)
             images{x}=imread([dr, '\', list(x).name]);
             
    end

    
    min = 35;
    for i= 1:4:length(list)
 
        ob_name =  strcat('house_obj_', int2str(i));
        %Get 15 top sift features
        %training images
        [ ~, l1, locs] = sift(images{i});
        [ ~, l2, locs1] = sift(images{i+1});
        [ ~, l3, locs2] = sift(images{i+2});
        
        coord = locs;
        coord1=locs1;
        coord2 = locs2;
        
        coord = sortrows(locs, -3);
        coord1 = sortrows(locs1, -3);
        coord2 = sortrows(locs2, -3);
        
        coord = coord(1:35, :);
        coord1 = coord1(1:35, :);
        coord2 = coord2(1:35, :);
        
       %Sort sift features
        %training images
        l1 = [locs(:, 3), l1];
        l2 = [locs1(:, 3), l2];
        l3 = [locs2(:, 3), l3];
      
        %Get delta lengths, then sort 128D vector
        %using them.
        l1 = sortrows(l1, -1);
        l2 = sortrows(l2, -1);
        l3 = sortrows(l3, -1);
       
        %Delete delta lengths from descriptors
        l1 = l1(:,2:end);
        l2 = l2(:,2:end);
        l3 = l3(:,2:end);
       
        %pick top 35 sift features for test images
        %training set
        loc1 = l1(1:35, :);
        loc2 = l2(1:35, :);
        loc3 = l3(1:35, :);
        %test set
       
        %set up training set
        train_set= training_house_obj(ob_name, images{i}, images{i+1},images{i+2},coord, coord1, coord2, loc1, loc2, loc3);
        train_obj{i} = train_set; 
        
      
    end
    

%%Save file name containing test image data classes
    save 'data_images.mat';
    disp('All image data saved!')
    
else
    clear
    load('data_images.mat')
    disp('All test data loaded successfully!')
end

