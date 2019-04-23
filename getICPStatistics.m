function [time, errors, R, t] = getICPStatistics(A1, A1_normals, A2)    
    time = {};
    errors = {};
    R = {};
    t = {};
    
%     tic
%     [R_all, t_all, error_all, transformed_all] = ICP(A1, A1_normals, A2,'all',50, 300);
%     time_all = toc;
%     Y = getCorrespondences(transformed_all, A2);
%     rms_all = computeRMS(transformed_all, Y);
%     
%     rms{1} = rms_all;
%     time{1} = time_all;
%     errors{1} = error_all;
%     R{1} = R_all;
%     t{1} = t_all;   
    
    tic
    [R_uniform, t_uniform, error_uniform, transformed_uniform] = ICP(A1, A1_normals, A2,'uniform',50, 300);
    time_uniform = toc;   
    
   
    time{1} = time_uniform;
    errors{1} = error_uniform;
    R{1} = R_uniform;
    t{1} = t_uniform; 
    
    tic
    [R_random, t_random, error_random, transformed_random] = ICP(A1, A1_normals, A2,'random',50, 300);
    time_random = toc;
   
   
    time{2} = time_random;
    errors{2} = error_random;
    R{2} = R_random;
    t{2} = t_random; 
    
    tic
    [R_informative, t_informative, error_informative, transformed_informative] = ICP(A1, A1_normals, A2,'informative',50, 300);
    time_informative = toc;
   
    
    
    time{3} = time_informative;
    errors{3} = error_informative;
    R{3} = R_informative;
    t{3} = t_informative;   
    
    
end

