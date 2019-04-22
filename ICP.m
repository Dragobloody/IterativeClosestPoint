function [R, t, error, transformed] = ICP(source, source_normals, target, point_sample_method, sample_nr, uniform_step)
% Function which runs the ICP algorithm.
%
%   Input
%     source: first poincloud
%     source_normals: normal vectors on the surface of the first pointcloud
%                     needed for informative sampling     
%     target: second pointcloud
%     point_sample_method: all, uniform, random or informative
%     sample_nr: nr of sample points for random sampling
%     uniform_step: step for uniform sampling
%   Output
%     R: rotation matrix
%     t: translation vector
%     error: vector of RMS convergence
%     transformed: rotated and translated source

  
    A1 = source;
    A1_normals = source_normals;
    A2 = target;
    switch(point_sample_method)
        case 'all'          
            sampleA1 = A1;
        case 'uniform'          
            sampleA1 = uniformSampling(A1, uniform_step);
        case 'random' 
            sampleA1 = datasample(A1, sample_nr, 2);
        case 'informative'
            sampleA1 = informativeSampling(A1, A1_normals);         
        
    end

    threshold = 1e-5;    
        
    R = eye(size(A1,1));
    t = zeros(size(A1,1),1);       
    
    max_iter = 1000;
    iter = 1;
    
    Y = getCorrespondences(sampleA1, A2);
    rms_old = computeRMS(sampleA1, Y);

    while iter < max_iter  

        if strcmp(point_sample_method, 'random')
            sampleA1 = datasample(A1, sample_nr, 2);           
        end
        Y = getCorrespondences(sampleA1, A2);
        [R, t] = getAllignment(sampleA1, Y);
        
        sampleA1 = R*sampleA1 + t;
        A1 = R*A1 + t;
       
        rms_new = computeRMS(sampleA1, Y);

        error(iter) = rms_new;
        iter = iter+1;

        if abs(rms_old - rms_new) < threshold

            break;
        end

        rms_old = rms_new;         

    end   
    
    transformed = A1;
    
    
end

