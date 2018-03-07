function b = intensity_weighted_centroid3d(im,b,s)

[xn,yn,zn] = size(im);
s(s<1) = 1;

for i=1:size(b,1)
    idx = ellipsoid3d(xn,yn,zn,b(i,1),b(i,2),b(i,3),s(1),s(2),s(3));        
    p = im(idx);
    [x,y,z] = ind2sub([xn,yn,zn],idx);
    sp = sum(p);
    b(i,1) = sum(x .* p) / sp;
    b(i,2) = sum(y .* p) / sp;
    b(i,3) = sum(z .* p) / sp;
end

end