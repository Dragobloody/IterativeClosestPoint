clear all
close all
path = 'Data/data/' ;

%% 3.1
% Initialize matrices outside the loop 
target_file = strcat(path, num2str(0, '%010d'), '.pcd');
target = readPcd(target_file);
[target_mat, target_rgb] = preprocessPointCloud(target, 1);

R_previous = eye(3) ;
t_previous = zeros(3,1) ;

step = 1 ; % step is 1 for a) and 2, 4, 10 for b)
merged = target_mat ;

for j = [0:step:10]
    j
    source_file = strcat(path, num2str(j, '%010d'), '.pcd');
    source_normals_file = strcat(path, num2str(j, '%010d'), '_normal.pcd');
    
    source = readPcd(source_file) ;
    source_normals = readPcd(source_normals_file) ;
    
    [source_mat, source_normals_mat] = preprocessNormals(source, source_normals) ;
    [R, t, error, transformed] = ICP(source_mat, source_normals_mat, target_mat, 'informative', 100, 0) ;
    
    % transformed is from source->target, we want to get to the original
    % camera pose:
    transformed = R_previous * transformed + t_previous ; 
    
    merged = [merged transformed] ;
    
    % Keep track of all transf. to get back to the original camera pose
    R_previous = R_previous * R;
    t_previous = t_previous + t;
    
    target_mat = source_mat ;
end

fscatter3(merged(1, :), merged(2, :), merged(3, :), merged(3, :));


