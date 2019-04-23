%% ICP statistics on first 9 frames
path = 'Data/data/00000000';
for i=0:8
    path_pcd = strcat(path,'0',string(i),'.pcd');
    path_pcd_normal = strcat(path,'0',string(i),'_normal.pcd');
    path_next_frame_pcd = strcat(path,'0',string(i+4),'.pcd');
    
    A1 = readPcd(path_pcd);
    A1_normals = readPcd(path_pcd_normal);
    A2 = readPcd(path_next_frame_pcd);
    
    [A1,A1_normals] = preprocessNormals(A1, A1_normals);
    [A2, ~] = preprocessPointCloud(A2,1);
    
    [time, errors, R, t] = getICPStatistics(A1, A1_normals, A2);  
    
    save_path = strcat('statistics/statistics_', string(i), '_', string(i+10), '.mat');
    save(save_path, 'time', 'errors', 'R', 't');
    
    
end

%% ICP statistics for source.mat and target.mat
[time, errors, R, t] = getICPStatistics(source, A1_normals, target);
%%
save_path = strcat('statistics/statistics_source_target.mat');
save(save_path, 'time', 'errors', 'R', 't');
