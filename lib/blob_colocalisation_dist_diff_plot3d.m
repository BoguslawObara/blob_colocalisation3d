function [w,m,cc] = blob_colocalisation_dist_diff_plot3d(im1,b1c,d12,rx,ry,rz)

[xs,ys,zs] = size(im1);
n = 5; cmap = jet(n); 
d12 = d12/1000;
m = max(d12); 
w = min(d12);
d = d12;
[~,e] = hist(d,n);

cc = zeros(size(b1c,1),3);
for i=1:size(b1c,1)
    j = 1;
    for k=1:n
        if d(i)>=(e(k)-(m-w)/(2*n)) && d(i)<(e(k)+(m-w)/(2*n))
            j = k;
        end
        if d(i)==(e(n)+(m-w)/(2*n))
            j = n;
        end
    end
    if j<1; j = 1; end
    if j>n; j = n; end    
    cc(i,:) = cmap(j,:);
end

scatter3(b1c(:,1)/1000,b1c(:,2)/1000,b1c(:,3)/1000,20,cc,'filled','o');
colormap(cmap);
nt = 3; 
zl = get(gca,'ZLim'); 
set(gca,'ZTick',linspace(zl(1),zl(2),nt))
ch = colorbar;
t = get(ch,'ytick');
s = length(t);

f = w:(m-w)/(s-1):m;
fs = {};
for i=1:length(f)
    fs{i} = mat2str(f(i),2);
end
set(ch,'YTickLabel',fs)
axis equal; axis tight; box on; ax = gca; ax.BoxStyle = 'full';
xlim([rx*1/1000,rx*xs/1000]); 
ylim([ry*1/1000,ry*ys/1000]); 
zlim([rz*1/1000,rz*zs/1000]);
xlabel('X [\mum]'); ylabel('Y [\mum]'); zlabel('Z [\mum]');
title('Distance Difference Map of Colocalized Particles');

end