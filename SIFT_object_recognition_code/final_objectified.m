%This is the main method of the SIFT script
%Author: Kiarie Ndegwa
%Uni ID: u4742829
%
%This is the recursvive function used to find 
%objects with close matches and use kmeans clustering
%to tie break.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [flag, identified] = final_objectified(cluster_num, test_im, test_obj, train_obj)
%This function recursively narrows the
%search space in an attempt to tie-break
%a solution that has returned more than 
%a single image

%It returns the final objectified structure
%containing the confusion matrix
cluster_no = cluster_num;

testSIFT=test_obj{test_im}.sift1;

%use this image in threshold to compare 180-270 degree rotation
testimg = test_obj{test_im}.img1;

counter = 0;
while counter ~=1
    %Generate sift values for file
    for i=1:length(train_obj)
    %Compare this file with the trained bag of words set
        if isempty(train_obj{i})
            continue
        else
            [bool, prob, name]=train_obj{i}.hist_comparison(test_obj{test_im}, cluster_no);

            if strcmp(bool, 'True')
               identified{i} = confusion_obj(name, prob, train_obj{i}.img1, train_obj{i}.img2, train_obj{i}.img3);
            else
                   if i==length(train_obj)
                      break;
                   end
             end
        end
    end

    %This counts the number of successfully 100%
    %assigned object
    if exist('identified', 'var')==1
            tmp =0;
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

            %Find number of falsely identified objects
            for i=1: length(identified)
                  if isempty(identified{i}) ~=1  
                     if identified{i}.prob ==100
                      counter = counter+1;
                     end
                  end
            end

            %if more than object identified try and 
            %narrow the search space
            if counter <=1
               flag = 1;
               break;
            else
                disp('More than one match found, verifying correct identification')
                cluster_no = cluster_no-1;
                %set counter to zero
                counter = 0;
                identified = {};
             end
        else
            disp('No object found')
            flag=0;
            identified = {};
            break
    end
end