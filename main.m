
A1 = readPcd('Data/data/0000000000.pcd');
A1_normals = readPcd('Data/data/0000000000_normal.pcd');
A2 = readPcd('Data/data/0000000001.pcd');

%%

[A1,A1_normals] = preprocessNormals(A1, A1_normals);
[A2, ~] = preprocessPointCloud(A2,1);

%[A1_normals, A1_normals_rgb] = preprocessPointCloud(A1_normals,1);


%%
[R, t, error, transformed] = ICP(A1, A1_normals, A2,'informative',50, 300);
%%

fscatter3(A1(1,:),A1(2,:),A1(3,:),A1(3,:));
figure();
fscatter3(A2(1,:),A2(2,:),A2(3,:),A2(3,:));
figure();
fscatter3(transformed(1,:),transformed(2,:),transformed(3,:),transformed(3,:));
%%

scatter3(pointcloud(1,:),pointcloud(2,:),pointcloud(3,:),10,rgb');
%%
fscatter3(pointcloud(1,:),pointcloud(2,:),pointcloud(3,:),pointcloud(3,:));



