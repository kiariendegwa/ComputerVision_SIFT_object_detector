%Author: Kiarie Ndegwa
%Uni ID: u4742829
%ENGN6528: Group Project

%This function stores the test objects used to verify the 
%effeciency of the object classifier

classdef test_house_obj
   %name: name of household object
   %test images: generic test image names
   properties
      name, 
      img1, 
      sift1, 
      loc1
   end
   
   methods
       function obj = test_house_obj(name, img1, loc1, sift1)
        if nargin <3
        sift1 = [];

        end
        
       obj.name = name;
       obj.img1 =img1;
       obj.sift1 =sift1;
       obj.loc1 = loc1;
       end
       
   end
end