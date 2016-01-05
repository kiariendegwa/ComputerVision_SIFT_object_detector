%Author: Kiarie Ndegwa
%Uni ID: u4742829
%ENGN6528: Group Project
%
%This is an object that contains the object information
%of the household objects and the function 
%hist_comparison used to determinen whether an object matches
%with another
classdef training_house_obj
   %name: name of household object
   %
   %test images: generic test image names
   %
   %img1, img2: images that make up the
   %training set
   %
   %sift1, sift2 : externally generated sift features
   %
   %Cluster1 and 2: k-means clustering of sift1 and sift2
   properties
      name, 
      
      img1, 
      img2,
      img3, 
      
      sift1, 
      sift2,
      sift3,
        
      loc1, 
      loc2, 
      loc3
   end
   
   methods
       function obj = training_house_obj(name, img1, img2, img3, loc1, loc2, loc3, sift1, sift2, sift3)
        if nargin <5
        sift1 =[];
        sift2 =[];
        sift3 =[];
        end
        
       obj.name = name;
       obj.img1 =img1;
       obj.img2 =img2;
       obj.img3 = img3;
       
       obj.sift1 =sift1;
       obj.sift2 =sift2;
       obj.sift3 = sift3;

       
       end 
       
    
       function [bool, probability, obj_name] =hist_comparison(obj, test_obj, cluster_no)
           %This function takes in an external images sift function and performs a
           %comparison between it and the test images sift features in the
           %match method
           obj_name = obj.name;
           %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
           %Compare with img 1, img 2 and img 3 clustered kmeans:           
           grade = Threshold(obj, test_obj, cluster_no);
   
           %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
           if grade >=1
              bool = 'True'; 
           else
               bool = 'False';
           end
          
           probability = grade;
           end
       end
         
        

end