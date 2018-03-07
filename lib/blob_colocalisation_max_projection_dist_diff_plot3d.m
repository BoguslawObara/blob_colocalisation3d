function blob_colocalisation_max_projection_dist_diff_plot3d(im1,np1c,rx,ry,w,m,c)

%% [pixel] -> [micron]
np1c(:,1) = np1c(:,1)/rx;
np1c(:,2) = np1c(:,2)/ry;

%% plot
immax = max(im1,[],3);
immax = double(immax); immax = (immax - min(immax(:))) / (max(immax(:)) - min(immax(:))); 
imagesc(immax), colormap gray; hold on; axis equal; axis tight; axis off;

hold on;
for i=1:size(np1c,1)
    plot(np1c(i,2),np1c(i,1),'o','LineWidth',1,...
    'MarkerEdgeColor',c(i,:),'MarkerFaceColor',c(i,:),'MarkerSize',3);
end
colorbar;
freezeColors;

n = 5; cmap = jet(n); 
colormap(cmap);
ch = colorbar;
t = get(ch,'ytick');
s = length(t);

f = w:(m-w)/(s-1):m;
fs = {};
for i=1:length(f)
    fs{i} = mat2str(f(i),2);
end
set(ch,'YTickLabel',fs)
title('Distance Difference Map of Colocalized Particles');

end