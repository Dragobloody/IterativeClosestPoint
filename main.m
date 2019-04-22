
test = readPcd('Data/data/0000000000.pcd');


%%
[R, t, error, transformed] = ICP(source,target,'random',10);
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

