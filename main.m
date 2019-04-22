
test = readPcd('Data/data/0000000000.pcd');


%%

fscatter3(source(1,:),source(2,:),source(3,:),source(3,:));
figure();
fscatter3(target(1,:),target(2,:),target(3,:),target(3,:));
figure();
fscatter3(newA1(1,:),newA1(2,:),newA1(3,:),newA1(3,:));
%%

scatter3(pointcloud(1,:),pointcloud(2,:),pointcloud(3,:),10,rgb');
%%
fscatter3(pointcloud(1,:),pointcloud(2,:),pointcloud(3,:),pointcloud(3,:));

