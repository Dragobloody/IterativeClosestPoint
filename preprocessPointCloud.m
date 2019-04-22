function [pointcloud, rgb] = preprocessPointCloud(point_cloud,distance_threshold)
% Function for getting the correct format and filtering pointclouds loaded
% with readPcd.m.
%
% Input
%     point_cloud: point_cloud data structure Nx4 as loaded with readPcd.m
%     distance_threshold: threshold for background filtering
% Output
%     pointcloud: filtered pointcloud with shape 3xN
%     rgb: RGB values for pixels in poincloud also with shape 3xN

    rgb = unpackRGBFloat(single(point_cloud(:,4)))';   
    point_cloud = point_cloud';    
    
    pointcloud = point_cloud(:,(point_cloud(3,:)< distance_threshold));
    pointcloud = pointcloud(1:end-1,:);
    rgb = rgb(:,(point_cloud(3,:) < distance_threshold));
    rgb = double(rgb)/255;
    
end

