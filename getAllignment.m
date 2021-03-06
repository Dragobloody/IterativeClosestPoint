function [R,t] = getAllignment(A1,A2)
% Function for computing the rotation matrix R and translation vector t from poinclouds A1 and A2.
% 
% Input
%     A1: first pointcloud
%     A2: list of clossest points to A1
% Output
%     R: rotation matrix
%     t: translation vector

    R = eye(size(A1,1));
    t = zeros(size(A1,1),1);   
    ndim = size(A1,1);
    
    meanA1 = mean(A1,2);
    meanA2 = mean(A2,2);    
    A1_hat = A1 - meanA1;
    A2_hat = A2 - meanA2;
    
    S = A1_hat*A2_hat';
    [U,E,V] = svd(S);
    
    R(ndim,ndim) = det(V*U');
    
    R = V*R*U';    
    t = meanA2 - R*meanA1;   
    
end

