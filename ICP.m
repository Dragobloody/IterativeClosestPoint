function [R, t, error, newA1] = ICP(source, target, point_sample_method)
    
    switch(point_sample_method)
        case 'all'            
            A1 = source;
        case 'uniform'
            A1 = uniformSampling();
        case 'random' 
            A1 = randomSampling();
        case 'informative'
            A1 = informativeSampling();           
        
    end
    A2 = target;
    newA1 = A1;    
    R = eye(size(A1,1));
    t = zeros(size(A1,1),1);       
    
    max_iter = 1000;
    iter = 1;
    
    Y = getCorrespondences(newA1, A2);
    rms_old = computeRMS(newA1, Y);
    
    while iter < max_iter       
        Y = getCorrespondences(newA1, A2);
        [R, t] = getAllignment(newA1, Y);
        for i = 1:size(newA1,2)
            newA1(:,i) = R*newA1(:,i) + t;            
        end
        rms_new = computeRMS(newA1, Y);
        error(iter) = rms_new;
        iter = iter+1;
        if rms_old == rms_new || iter > max_iter
            break;
        end
        rms_old = rms_new;       
        
    end    
    
    
end

