function [b1,b2,b1c,b2c,d12] = blob_colocalisation3d(im1,im2,rx,ry,rz,s,t1,t2,dt)
%%  blob_colocalisation2d - 2d blob colocalisation
%   
%   REFERENCE:
%       C. J. Nelson, P. Duckney, T. J. Hawkins, M. J. Deeks, P. Laissue, 
%       P. J. Hussey, B. Obara, Bioimage informatics for plant sciences. 
%       Blobs and curves: object-based colocalisation for plant cells,
%       Functional Plant Biology, 42, 5, 471-485, 2015
%
%   INPUT:
%       im1     - first image
%       im2     - second image
%       rx      - image resolution in x [micron/pixel]
%       ry      - image resolution in y [micron/pixel]
%       rz      - image resolution in z [micron/pixel]
%       s       - blob size [microns]
%       t1      - threshold value in [0-1] range
%       t2      - threshold value in [0-1] range
%       dt      - distance threshold value [microns]
%
%   OUTPUT:
%       b1      - detected blob positions in first image
%       b1      - detected blob positions in second image
%       b1c     - collocalised blob positions in first image
%       b2c     - collocalised blob positions in second image
%       d12     - distance between collocalised blob positions 
%                   in first and second image
%
%   AUTHOR:
%       Boguslaw Obara

%% 3d blob detector
s = [s/rx s/ry s/rz];
b1 = blob_detector3d(im1,s,t1);
b2 = blob_detector3d(im2,s,t2);

%% 3d weighted centroids
b1 = intensity_weighted_centroid3d(im1,b1,s);
b2 = intensity_weighted_centroid3d(im2,b2,s);

%% [pixel] -> [micron]
b1(:,1) = rx*b1(:,1); b1(:,2) = ry*b1(:,2); b1(:,3) = rz*b1(:,3);
b2(:,1) = rx*b2(:,1); b2(:,2) = ry*b2(:,2); b2(:,3) = rz*b2(:,3);

%% 3d matching
d = pdist2(b1(:,1:3),b2(:,1:3),'minkowski',2);
d(d>=dt) = Inf;
[m,~] = Hungarian(d);
[m1,m2] = find(m==1);
idx = sub2ind(size(d),m1,m2);
d12 = d(idx);

%% outputs
b1c = b1(m1,:); 
b2c = b2(m2,:);

end