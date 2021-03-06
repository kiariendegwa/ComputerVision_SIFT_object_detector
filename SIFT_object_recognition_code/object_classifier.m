%Author: Kiarie Ndegwa
%Uni ID: u4742829
%ENGN6528: Group Project
%This is the main method of the SIFT script
%It is used to run the object detector
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc
clear
close all

%Check that variables and structures needed to implement code
%have been generated
variable_generator_script
load('data_images', 'train_obj')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Import images from test_class file and add them
%to the matlab structure labelled train_obj
%The more images added to this file the longer 
%the program takes to classify the images
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
dr1 = 'C:\Users\user\Documents\MATLAB\finished_project\class_test';
list2 =dir([dr1, '\*.jpg']);  


 for j=1:length(list2)
       images1{j}=imread([dr1, '\', list2(j).name]); 
 end
    
 for i= 1:length(list2)
    %test images
        [ ~, l4, locs3] = sift(images1{i});
        coord = locs3;
        coord = sortrows(coord, -3);
        coord = coord(1:35, :);
         
        l4 = [locs3(:, 3), l4];
        l4 = sortrows(l4, -1);
        l4 = l4(:,2:end);
        loc4 = l4(1:35, :);
  
        test_set= test_house_obj(ob_name, images1{i},coord, loc4);
        test_obj{i} = test_set;
 end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%The average accuracy of the program is determined by these three
%parameters

correct = 0;
wrong = 0;
norm = 0;

for img = 1:length(test_obj)
 
    %Load all data generated by training function
    cluster = 35;
    test_im = img;
    %Load test image from test set
    
    testimg = test_obj{test_im}.img1;

    [flag, identified] = final_objectified(cluster, test_im, test_obj, train_obj);
    %Generate a confusion matrix
    tmp =0;
    if flag==1 && exist('identified', 'var')==1
        norm = norm +1;
        if isempty(identified)~=1
                 for i=1: length(identified)
                   if isempty(identified{i}) ~=1
                        if identified{i}.prob > tmp
                            tmp = identified{i}.prob;
                        end
                   end
                end

                %Update all probabilities to generate confusions matrix
                for i=1: length(identified)
                  if isempty(identified{i}) ~=1  
                     identified{i}.prob = identified{i}.prob/tmp*100;
                  end
                end
                %correctness
                %View id images
                if exist('identified', 'var') == 1
                    for i=1: length(identified)
                        if isempty(identified{i}) ~=1  
                            if identified{i}.prob ==100
                                  figure
                                  %Display all the detected objects
                                  disp(['The identified object corresponds to ', identified{i}.name])  
                                  subplot(2, 2, 1), imshow(train_obj{i}.img1), title('Matched training img 1')
                                  subplot(2, 2, 2), imshow(train_obj{i}.img2), title('Matched training img 2')
                                  subplot(2, 2, 3), imshow(train_obj{i}.img3), title('Matching training img 3')
                                  subplot(2, 2, 4), imshow(testimg), title('Unkown object')
                                  if strcmp(identified{i}.name, test_obj{test_im}.name) == 1
                                        correct = correct+1;
                                  else
                                        wrong = wrong+1;
                                  end
                            end
                        end
                    end
                else
                    %If no objects identified return zero results
                    wrong = wrong +1;
                    disp('No object identified');
                    
                end
        else
             %If no objects identified return zero results
                    wrong = wrong +1;
                    disp('No object identified');
        end
    end
end

% Accuracy = (correct/(correct+wrong))*100;
% %Display accuracy after detection is complete
% h = msgbox(sprintf('All objects classified with %d%% accuracy',Accuracy),'Classification complete');
