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
transformed = R_uniform*source + t_uniform;
%%
fscatter3(source(1,:),source(2,:),source(3,:),source(3,:));
figure();
fscatter3(target(1,:),target(2,:),target(3,:),target(3,:));
figure();
fscatter3(transformed(1,:),transformed(2,:),transformed(3,:),transformed(3,:));

%%

[R_uniform, t_uniform, error_uniform, transformed_uniform] = ICP(source, A1_normals, target,'uniform',50, 100);
