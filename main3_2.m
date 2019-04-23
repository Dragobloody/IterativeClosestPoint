clear all
close all
path = 'Data/data/' ;

%% 3.2
% Initialize matrices outside the loop 

source_file = strcat(path, num2str(0, '%010d'), '.pcd');
source_normals_file = strcat(path, num2str(0, '%010d'), '_normal.pcd');    
source = readPcd(source_file);
source_normals = readPcd(source_normals_file) ;
[source_mat, source_normals_mat] = preprocessNormals(source, source_normals) ;

merged_source = source_mat;
merged_source_normals = source_normals_mat;
step = 1 ;
for j = [1:step:10]
    j
    target_file = strcat(path, num2str(j, '%010d'), '.pcd');
    target_normals_file = strcat(path, num2str(j, '%010d'), '_normal.pcd');
    
    target = readPcd(target_file) ;
    target_normals = readPcd(target_normals_file) ;
    
    tic
    [target_mat, target_normals_mat] = preprocessNormals(target, target_normals) ;
    [R, t, error, transformed] = ICP(merged_source, merged_source_normals, target_mat, 'informative', 100, 0) ;    
    
    % The new target will be the merged cloud points, which gives more
    % robustness to the reconstruction
    merged_source = R*merged_source + t;
    merged_source_normals = R*merged_source_normals + t;
    merged_source = [merged_source target_mat] ;
    toc
end
%%
fscatter3(merged_source(1, :), merged_source(2, :), merged_source(3, :), merged_source(3, :));
