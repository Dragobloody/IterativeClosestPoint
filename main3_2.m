clear all
close all
path = 'Data/data/' ;

%% 3.2
% Initialize matrices outside the loop 

target_file = strcat(path, num2str(1, '%010d'), '.pcd');
target = readPcd(target_file);
[target_mat, target_rgb] = preprocessPointCloud(target, 1);

merged_b = target_mat;
step = 10 ;
for j = [0:step:99]
   
    source_file = strcat(path, num2str(j, '%010d'), '.pcd');
    source_normals_file = strcat(path, num2str(j, '%010d'), '_normal.pcd');
    
    source = readPcd(source_file) ;
    source_normals = readPcd(source_normals_file) ;
    
    tic
    [source_mat, source_normals_mat] = preprocessNormals(source, source_normals) ;
    [R, t, error, transformed] = ICP(source_mat, source_normals_mat, merged_b, 'informative', 100, 0) ;    
    
    % The new target will be the merged cloud points, which gives more
    % robustness to the reconstruction
    merged_b = [merged_b transformed] ;
    toc
end

fscatter3(merged_b(1, :), merged_b(2, :), merged_b(3, :), merged_b(3, :));
