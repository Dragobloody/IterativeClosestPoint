function [filtered_pointcloud, filtered_normals] = preprocessNormals(pointcloud,normals)
   
    filtered_pointcloud = pointcloud(:,1:end-1)';
    filtered_normals = normals(:,1:end-1)';
    
    % filter normal NaN values
    nnans = ~isnan(filtered_normals);
    filtered_normals = filtered_normals(:, sum(nnans,1) == 3);
    filtered_pointcloud = filtered_pointcloud(:, sum(nnans,1) == 3);
    
    % filter pointcloud background (distance >= 1)
    filtered_pointcloud = filtered_pointcloud(:,(filtered_pointcloud(3,:)< 1));
    filtered_normals = filtered_normals(:,(filtered_pointcloud(3,:)< 1));
end

