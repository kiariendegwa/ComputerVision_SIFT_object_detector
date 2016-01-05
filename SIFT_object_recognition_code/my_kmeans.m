function [data_clusters, cluster_stats] = my_kmeans(data, nc)

% This function performs k-means clustering on data, read from im2feature,   given (nc) = the number of clusters.
%  Random Initialization
%remember data is the location of feature points

%X and y are the positions on the original image
ndata = size(data,1);
ndims = size(data,2);

random_labels = floor(rand(ndata,1) * nc) + 1;
data_clusters = random_labels;
cluster_stats = zeros(nc,ndims+1);
distances = zeros(ndata,nc);

while(1)
    pause(0.03);
    % Make a copy of cluster statistics for 
    % comparison purposes.  If the difference is very small, the while loop will exit.
    last_clusters = cluster_stats;
    
    %For each cluster    
    for c=1:nc   
        %Find all data points assigned to this cluster
        [ind] = find(data_clusters == c);
        num_assigned = size(ind,1);
        
        % some heuristic codes for exception handling. 
        if( num_assigned < 1 )
            % Calculate the maximum distances from each cluster
            max_distances = max(distances);
            [~,data_point] = max(max_distances);
            %Data clusters, assigns k_n to each pixel
            data_clusters(data_point) = c;
            ind = data_point;
            num_assigned = 1;
        end   %%end of exception handling.   
        
        %Save number of points per cluster,  plus the mean vectors.
        cluster_stats(c,1) = num_assigned;
        if( num_assigned > 1 )
            summ = sum(data(ind,:));
            cluster_stats(c,2:ndims+1) = summ / num_assigned;
        else
            cluster_stats(c,2:ndims+1) = data(ind,:);
        end
    end

        
   %update distances
   for i= 1:ndata
      index = data_clusters(i);
      distances(i, index) = abs(sum(cluster_stats(index) - data(i)));
   end
 
   %update the data clusters
   for i=1:nc
      [count_ind] = find(data_clusters == i);
      counter = size(count_ind, 1);
      summer = zeros(1, 4);
      
      for j =1:size(count_ind, 1)
          summer =summer+data(count_ind(j),:);           
      end
     
      if counter ==0
         avg = zeros(1, 4);
      else
         avg = summer/counter;
      end
   
      up = [counter, avg];
      cluster_stats(i, :) = up;
   end
   
   %update cluster allocations based on distance
   for j=1:size(data, 1)
       tmp = zeros(1, nc); 
       for k=1:nc
           %find dist between single feature pt and cluster pt mean diff
           %find the manhattan dist
           tmp(1, k) = norm((data(j, :)-cluster_stats(k,2:end)));
       end
       %picks closest feature based on manhattan dist
       [~, index] = min(tmp);
       data_clusters(j) = index;
   end
    
    % Exit criteria
    diff = sum(abs(cluster_stats(:) - last_clusters(:)));
    if( diff < 0.1)
        break;
    end
end 
