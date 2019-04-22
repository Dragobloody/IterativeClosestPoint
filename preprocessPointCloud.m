function [pointcloud, rgb] = preprocessPointCloud(point_cloud,distance_threshold)
    rgb = unpackRGBFloat(single(point_cloud(:,4)))';   
    point_cloud = point_cloud';    
    
    pointcloud = point_cloud(:,(point_cloud(3,:)< distance_threshold));
    pointcloud = pointcloud(1:end-1,:);
    rgb = rgb(:,(point_cloud(3,:) < distance_threshold));
    rgb = double(rgb)/255;
    
end

