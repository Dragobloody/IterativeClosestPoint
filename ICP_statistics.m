%% ICP statistics on first 9 frames
path = 'Data/data/000000000';
for i=0:8
    path_pcd = strcat(path,string(i),'.pcd');
    path_pcd_normal = strcat(path,string(i),'_normal.pcd');
    path_next_frame_pcd = strcat(path,string(i+1),'.pcd');
    
    A1 = readPcd(path_pcd);
    A1_normals = readPcd(path_pcd_normal);
    A2 = readPcd(path_next_frame_pcd);
    
    [A1,A1_normals] = preprocessNormals(A1, A1_normals);
    [A2, ~] = preprocessPointCloud(A2,1);
    
    [time, errors, R, t] = getICPStatistics(A1, A1_normals, A2);  
    
    save_path = strcat('statistics/statistics_', string(i), '_', string(i+1), '.mat');
    save(save_path, 'time', 'errors', 'R', 't');
    
    
end
