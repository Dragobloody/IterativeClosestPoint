function Y = getCorrespondences(A1,A2)  
% Function for getting the list of the clossest points for each point in A1
% from A2.
%
% Input
%     A1: first pointcloud
%     A2: second pointcloud
% Output
%     Y: list of closses points to A1 from A2

    na1 = size(A1,2);
    na2 = size(A2,2);
    ndim = size(A1,1);
    Y = zeros(ndim,na1);
    
    for i = 1:na1
        dist = zeros(1,na2);
        for j = 1:na2
            dist(j) = sqrt(sum( ( A1(:,i) - A2(:,j) ).^2 ));           
        end
        
        [~, k] = min(dist);
        Y(:,i) = A2(:,k);       
        
    end
end

