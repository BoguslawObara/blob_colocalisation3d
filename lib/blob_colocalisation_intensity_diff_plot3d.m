function [w,m,cc] = BOColocalisationPlotIntensityDifferenceMap3D(im1,np1c,np2c,rx,ry,rz)
[xs,ys,zs] = size(im1);

v1 = []; v2 = [];
for i=1:size(np1c,1)
    v1(i) = np1c(i,4);
    v2(i) = np2c(i,4);
end

n = 5; cmap = jet(n); 
m = max(abs(v1 - v2)); 
w = min(abs(v1 - v2));
d = abs(v1 - v2);
[~,e] = hist(d,n);

cc = zeros(size(np1c,1),3);
for i=1:size(np1c,1)
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

scatter3(np1c(:,1)/1000,np1c(:,2)/1000,np1c(:,3)/1000,20,cc,'filled','o');
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
title('Intensity Difference Map of Colocalized Particles');

end