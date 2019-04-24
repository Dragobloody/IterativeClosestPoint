function sampleA1 = informativeSampling(A1, A1_normals)
% Function for Normal-Space Sampling.
% 
% Input
%     A1: base pointcloud
%     A1_normals: base pointcloud normals
% Output
%     sampleA1: normal-space sub-sample of A1

     sampleA1 = [];
     % get polaroid coordinates from cardinals
     [theta,rho] = cart2pol(A1_normals(1,:),A1_normals(2,:),A1_normals(3,:));
     
     % get histogram of theta values
     polhist = polarhistogram(theta, 36);
     bin_edges = polhist.BinEdges;
     close;
     
     % get bin index for each point
     bin_indexes = discretize(theta, bin_edges);
     bin_number = size(bin_edges,2)-1;
     
     % sample points from each bin
     for i=1:bin_number
         bin_points = A1(:, bin_indexes == i);
         bin_sample_points = datasample(bin_points, 5, 2);
         sampleA1 = [sampleA1, bin_sample_points];
     end   

end

