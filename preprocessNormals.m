function [filtered_pointcloud, filtered_normals, rgb] = preprocessNormals(pointcloud,normals)
% Function for preprocessing the pointclouds of the image and the normal vectors 
% needed for Normal-Space Sampling.
% 
% Input
%     pointcloud: the raw pointcloud data loaded with readPcd.m
%     normals: the raw poincloud normals loaded with readPcd.m
% Output
%     filtered_pointcloud: pointcloud with background filtered out
%     filtered_normals: normals with NaN values filtered out
    
    rgb = unpackRGBFloat(single(pointcloud(:,4)))';   
    filtered_pointcloud = pointcloud(:,1:end-1)';
    filtered_normals = normals(:,1:end-1)';
    
    % filter normal NaN values
    nnans = ~isnan(filtered_normals);
    filtered_normals = filtered_normals(:, sum(nnans,1) == 3);
    filtered_pointcloud = filtered_pointcloud(:, sum(nnans,1) == 3);
    rgb = rgb(:, sum(nnans,1) == 3);   
    
    % filter pointcloud background (distance >= 1)
    filtered_pointcloud = filtered_pointcloud(:,(filtered_pointcloud(3,:)< 1));
    filtered_normals = filtered_normals(:,(filtered_pointcloud(3,:)< 1));
    rgb = rgb(:, (filtered_pointcloud(3,:)< 1));   
    
    rgb = double(rgb)/255;
end

