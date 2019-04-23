clear all
close all
path = 'Data/data/' ;

%% 3.1
% Initialize matrices outside the loop 
base_file = strcat(path, num2str(0, '%010d'), '.pcd');
base_normals_file = strcat(path, num2str(0, '%010d'), '_normal.pcd');
base = readPcd(base_file) ;
base_normals = readPcd(base_normals_file) ;
[base_mat, base_normals_mat] = preprocessNormals(base, base_normals) ;

R_previous = eye(3) ;
t_previous = zeros(3,1) ;

step = 10 ; % step is 1 for a) and 2, 4, 10 for b)
merged = [] ;

for j = [step:step:30]
    j
    target_file = strcat(path, num2str(j, '%010d'), '.pcd');
    target_normals_file = strcat(path, num2str(j, '%010d'), '_normal.pcd');
    target = readPcd(target_file);
    target_normals = readPcd(target_normals_file) ;
    
    [target_mat, target_normals_mat] = preprocessNormals(target, target_normals) ;

    [R, t, error, transformed] = ICP(base_mat, base_normals_mat, target_mat, 'informative', 100, 0) ;
    
    % transformed is from source->target, we want to get to the original
    % camera pose:
    transformed = R_previous * transformed + t_previous ; 
    
    merged = [merged transformed] ;
    
    % Keep track of all transf. to get back to the original camera pose
    R_previous = R_previous * R;
    t_previous = t_previous + R_previous*t;
    
    base_mat = target_mat ;
    base_normals_mat = target_normals_mat ;
end

fscatter3(merged(1, :), merged(2, :), merged(3, :), merged(3, :));


