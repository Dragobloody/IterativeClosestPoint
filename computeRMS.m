function rms = computeRMS(A1,A2)
    rms = 0;
    na1 = size(A1,2);
    for i=1:na1
        rms = rms + sum((A1(:,i) - A2(:,i)).^2);               
    end
    rms = sqrt(rms/na1);
    
end

