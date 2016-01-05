%Author: Kiarie Ndegwa
%Uni ID: u4742829
%ENGN6528: Group Project
%
%This function is used to generate the heuristic
%That is used to find matching images using kmeans clustering
%for the bag of words model and the function histompare to
%tighted the search space
function grade = Threshold(house_obj, test_obj, cluster_no)
%%Kmean clustering
[~, k1, ~] = kmeans(house_obj.sift1, cluster_no,'Distance','cosine','Distance','sqeuclidean');
[~, k2, ~] = kmeans(house_obj.sift2, cluster_no, 'Distance','cosine','Distance','sqeuclidean');
[~, k3, ~] = kmeans(house_obj.sift3, cluster_no, 'Distance','cosine','Distance','sqeuclidean');
[~, test, ~] = kmeans(test_obj.sift1, cluster_no, 'Distance','cosine','Distance','sqeuclidean');
%figure
%figure containing clustered kmeans 128D vectors

if size(k1, 1) && size(k2, 1) && size(k3, 1) && size(test, 1) >=20
    grade =0;

    %test sift features
    if match(k1, test) ~=0
        grade=grade + match(k1, test);
    end
    if  match(k2, test) ~=0
        grade=grade + match(k2, test);
    end
    if match(k3, test)~=0
        grade=grade +match(k3, test);
    end
    
   %colour histogram comparison
   if histcomparison(house_obj.img1, test_obj.img1)==1
       grade = grade +2;
   end
   
    if histcomparison(house_obj.img2, test_obj.img1)==1
       grade = grade +2;
    end
   
   if histcomparison(house_obj.img3, test_obj.img1)==1
       grade = grade +2;
   end
else
    grade =0;
end
end