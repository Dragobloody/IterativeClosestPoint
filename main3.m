clear all
path = 'Data/data/' ;
N = 10 ;% number of pairs
source_file = strcat(path, num2str(1, '%010d'), '.pcd');
source = readPcd(source_file) ;
[source_mat, source_rgb] = preprocessPointCloud(source, 1) ;

intermediate_merge = source_mat ;
%% 3.1.a
step = 1 ;
merged = [] ;
for j = [2:step:99]
    target_file = strcat(path, num2str(j, '%010d'), '.pcd');
    target = readPcd(target_file);
    [target_mat, target_rgb] = preprocessPointCloud(target, 1);
    tic
    [R, t, error, transformed] = ICP(source_mat, target_mat, 'uniform', 10) ;
    merged = [merged transformed] ;
end

%% 3.1.b (not correct most probably)
for j = [2:step:N]
    j
    target_file = strcat(path, num2str(j, '%010d'), '.pcd');
    target = readPcd(target_file);
    [target_mat, target_rgb] = preprocessPointCloud(target, 1);
    tic
    [R, t, error, transformed] = ICP(source_mat, target_mat, 'uniform', 10) ;
    toc
    tic
    merged = merge(intermediate_merge, target_mat, R, t) ;
    toc
    intermediate_merge = merged ;
end

    
