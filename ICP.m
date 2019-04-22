function [R, t, error, transformed] = ICP(source, target, point_sample_method, sample_nr) 
    A1 = source;
    A2 = target;
    switch(point_sample_method)
        case 'all'          
            sampleA1 = A1;
        case 'uniform'          
            sampleA1 = datasample(A1, sample_nr, 2);
        case 'random' 
            sampleA1 = datasample(A1, sample_nr, 2);
        case 'informative'
            sampleA1 = informativeSampling(A1);         
        
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

