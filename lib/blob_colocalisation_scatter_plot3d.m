function blob_colocalisation_scatter_plot3d(im1,b1,b2,b1c,b2c,rx,ry,rz)

[xs,ys,zs] = size(im1);

scatter3(b1(:,1)/1000,b1(:,2)/1000,b1(:,3)/1000,'*g'); hold on; 
scatter3(b2(:,1)/1000,b2(:,2)/1000,b2(:,3)/1000,'*r'); hold on; 
scatter3(b1c(:,1)/1000,b1c(:,2)/1000,b1c(:,3)/1000,'ob'); hold on; 
scatter3(b2c(:,1)/1000,b2c(:,2)/1000,b2c(:,3)/1000,'ob');
axis equal; axis tight; box on;
box on; ax = gca; ax.BoxStyle = 'full';

xlim([rx*1/1000,rx*xs/1000]); 
ylim([ry*1/1000,ry*ys/1000]); 
zlim([rz*1/1000,rz*zs/1000]);
xlabel('X [\mum]'); ylabel('Y [\mum]'); zlabel('Z [\mum]');

titlestring{1} = ['Particles channel 1 (green): ' num2str(size(b1,1)) ];
titlestring{2} = ['Particles channel 2 (red): '   num2str(size(b2,1)) ];
titlestring{3} = ['Colocalised (blue): '          num2str(size(b1c,1))];
title(titlestring);

end