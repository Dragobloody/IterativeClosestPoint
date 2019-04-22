function sampleA1 = uniformSampling(A1,step)
% Function to uniformly sample from data the value at every 'step' points.
% 
% Input
%     A1: pointcloud
%     step: sample step
% Output
%     sampleA1: uniform sub-sample of A1
    
    na1 = size(A1,2);
    ndim = size(A1,1);
    sampleA1 = zeros(ndim,int8(na1/step));
    for i=1:na1
        if mod(i,step) == 0
            sampleA1(:,i/step) = A1(:,i);            
        end        
    end
end

