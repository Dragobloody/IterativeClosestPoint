
A1 = readPcd('Data/data/0000000000.pcd');
A1_normals = readPcd('Data/data/0000000000_normal.pcd');

[A1,A1_normals] = preprocessNormals(A1, A1_normals);

%[A1, ~] = preprocessPointCloud(A1,1);
%[A1_normals, A1_normals_rgb] = preprocessPointCloud(A1_normals,1);


%%
[R, t, error, transformed] = ICP(source,target,'uniform',10,200);
%%

fscatter3(source(1,:),source(2,:),source(3,:),source(3,:));
figure();
fscatter3(target(1,:),target(2,:),target(3,:),target(3,:));
figure();
fscatter3(transformed(1,:),transformed(2,:),transformed(3,:),transformed(3,:));
%%

scatter3(pointcloud(1,:),pointcloud(2,:),pointcloud(3,:),10,rgb');
%%
fscatter3(pointcloud(1,:),pointcloud(2,:),pointcloud(3,:),pointcloud(3,:));



