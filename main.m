
test = readPcd('Data/data/0000000000.pcd');
rgb = unpackRGBFloat(single(test(:,4)));

%%

fscatter3(new_test(:,1),new_test(:,2),new_test(:,3),new_test(:,3));
%%


new_test = test((test(:,3)< 1),:);
new_rgb = rgb((test(:,3)< 1),:);