classdef confusion_obj
%Simple holder used to
%generate confusion matrix
    properties
      name, 
      prob, 
      img1,
      img2, 
      img3
    end
   
   methods
       function obj = confusion_obj(name, prob, img1, img2,img3)
       
       obj.name = name;
       obj.prob = prob;
       obj.img1 =img1;
       obj.img2 = img2;
       obj.img3 = img3;
    
       end
       
   end
end