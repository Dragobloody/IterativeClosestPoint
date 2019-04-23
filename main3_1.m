clear all
close all
path = 'Data/data/' ;

%% 3.1
% Initialize matrices outside the loop 
source_file = strcat(path, num2str(0, '%010d'), '.pcd');
source = readPcd(source_file);
[source_mat, source_rgb] = preprocessPointCloud(source, 1);

step = 1 ; % step is 1 for a) and 2, 4, 10 for b)
merged = source_mat ;

for j = [0:step:(99-step)]
    j
    source_file = strcat(path, num2str(j, '%010d'), '.pcd');
    source_normals_file = strcat(path, num2str(j, '%010d'), '_normal.pcd');
    target_file = strcat(path, num2str(j+step, '%010d'), '.pcd');
    
    source = readPcd(source_file) ;
    source_normals = readPcd(source_normals_file) ;
    target = readPcd(target_file);
    
    [source_mat, source_normals_mat] = preprocessNormals(source, source_normals) ;
    [target_mat, target_rgb] = preprocessPointCloud(target, 1);
    [R, t, error, transformed] = ICP(source_mat, source_normals_mat, target_mat, 'informative', 100, 0) ;
    
    % transformed is from source->target, we want to get to the original
    % camera pose:
    merged = R*merged + t;
    %transformed = R_previous * transformed + t_previous ; 
    
    merged = [merged target_mat] ;
    
    % Keep track of all transf. to get back to the original camera pose
    %R_previous = R_previous * R;
    %t_previous = t_previous + t;
    
    %target_mat = source_mat ;
end

%%

fscatter3(merged(1, :), merged(2, :), merged(3, :), merged(3, :));


