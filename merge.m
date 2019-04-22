function merged = merge(base,target, R, t)
%   Merge two frames given camera pose
%   for every point in (R*base+t) finds closest point form target
%   and averages them into a combined frame_{base&target}, see 3.1.b
merged = [] ;

for col_b = 1:size(base,2)
    dist = 1e10 ;
    transf_point = R*base(:,col_b) + t ;
    for col_t = 1:size(target,2)
        d = sum((transf_point - target(:,col_t)).^2) ;
        if d < dist
            dist = d ;
            point_match = target(:,col_t) ;
        end
    end
            
    merge_point = (transf_point + point_match)./2 ;
    merged = [merged merge_point] ;
     
end

