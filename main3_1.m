clear all
close all
path = 'Data/data/' ;

%% 3.1
% Initialize matrices outside the loop 
source_file = strcat(path, num2str(0, '%010d'), '.pcd');
source = readPcd(source_file);
[source_mat, source_rgb] = preprocessPointCloud(source, 1);

step = 2 ; % step is 1 for a) and 2, 4, 10 for b)
merged = source_mat ;

R_previous = eye(3);
t_previous = zeros(3,1);

for j = [0:step:(20-step)]
    j
    source_file = strcat(path, num2str(j+step, '%010d'), '.pcd');
    source_normals_file = strcat(path, num2str(j+step, '%010d'), '_normal.pcd');
    target_file = strcat(path, num2str(j, '%010d'), '.pcd');
    target_normals_file = strcat(path, num2str(j, '%010d'), '_normal.pcd');
    
    source = readPcd(source_file) ;
    source_normals = readPcd(source_normals_file) ;
    target = readPcd(target_file);
    target_normals = readPcd(target_normals_file) ;
    
    [source_mat, source_normals_mat] = preprocessNormals(source, source_normals) ;
    [target_mat, target_normals_mat] = preprocessNormals(target, target_normals) ;    
    [R, t, error, transformed] = ICP(source_mat, source_normals_mat, target_mat, 'informative', 100, 0) ;
    
    % transformed is from source->target, we want to get to the original
    % camera pose:
    transformed = R_previous*transformed + t_previous;
   
    merged = [merged transformed] ;
    
    % Keep track of all transf. to get back to the original camera pose
    R_previous = R_previous * R;
    t_previous = t_previous + R_previous*t;
    
    %target_mat = source_mat ;
end

%%
fscatter3(merged(1, :), merged(2, :), merged(3, :), merged(3, :));
%%
fscatter3(source_mat(1, :), source_mat(2, :), source_mat(3, :), source_mat(3, :));
figure()
fscatter3(target_mat(1, :), target_mat(2, :), target_mat(3, :), target_mat(3, :));
figure()
fscatter3(transformed(1, :), transformed(2, :), transformed(3, :), transformed(3, :));
%%
fscatter3(transformed(1, :), transformed(2, :), transformed(3, :), transformed(3, :));
figure()
fscatter3(transformed1(1, :), transformed1(2, :), transformed1(3, :), transformed1(3, :));
%%
save('merged_pointclouds/merged_3_1_a.mat', 'merged');
