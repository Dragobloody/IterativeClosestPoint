%% ICP base plots

path = 'statistics/statistics_';
accuracies = [];
times = [];
for i=0:8
    load(strcat(path,string(i),'_',string(i+10),'.mat'));
    times = [times; time{1}, time{2}, time{3}];
    accuracies = [accuracies; min(errors{1}), min(errors{2}), min(errors{3})];
    figure;  
    for j=1:3              
        plot(errors{j})
        hold on       
    end
    hold off
    xlabel('Iteration');
    ylabel('RMS');
    legend('Uniform','Random','Informative');
    saveas(gcf,strcat('plots/convergence_',string(i),'_',string(i+10),'.png'));
    close;    
    
end
%%
transformed = R{3}*A1 + t{3};
%%
fscatter3(A1(1,:),A1(2,:),A1(3,:),A1(3,:));
figure();
fscatter3(A2(1,:),A2(2,:),A2(3,:),A2(3,:));
figure();
fscatter3(transformed3(1,:),transformed3(2,:),transformed3(3,:),transformed3(3,:));

%%
[R_uniform, t_uniform, error_uniform, transformed_uniform] = ICP(source, A1_normals, target,'uniform',50, 100);

%%
transformed1 = R{1}*A1 + t{1};
transformed2 = R{2}*A1 + t{2};
transformed3 = R{3}*A1 + t{3};

%%
 Y = getCorrespondences(transformed1, A2);
 rms1 = computeRMS(transformed1, Y);
%%
 Y = getCorrespondences(transformed2, A2);
 rms2 = computeRMS(transformed2, Y);
    
 %%
  Y = getCorrespondences(transformed3, A2);
  rms3 = computeRMS(transformed3, Y);

  


