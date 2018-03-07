function blob_colocalisation_max_projections_plot3d(im1,im2,b1,b2,b1c,b2c,rx,ry)

%% [pixel] -> [micron]
b1(:,1) = b1(:,1)/rx;
b1(:,2) = b1(:,2)/ry;
if ~isempty(b1c)
    b1c(:,1) = b1c(:,1)/rx;
    b1c(:,2) = b1c(:,2)/ry;
end
b2(:,1) = b2(:,1)/rx;
b2(:,2) = b2(:,2)/ry;
if ~isempty(b2c)
    b2c(:,1) = b2c(:,1)/rx;
    b2c(:,2) = b2c(:,2)/ry;
end

%% plot
immax1 = max(im1,[],3);
immax2 = max(im2,[],3);
immax = max(immax1,immax2);
immax = double(immax); immax = (immax - min(immax(:))) / (max(immax(:)) - min(immax(:))); 
imagesc(immax), colormap gray; hold on; axis equal; axis tight; axis off;

plot(b1(:,2),b1(:,1),'.r'); hold on; 
plot(b2(:,2),b2(:,1),'.g'); hold on; 
if ~isempty(b1c)
    plot(b1c(:,2),b1c(:,1),'.y'); hold on; 
end
if ~isempty(b2c)
    plot(b2c(:,2),b2c(:,1),'.y'); hold on; 
end

titlestring{1} = ['Particles channel 1' ' (red): ' num2str(size(b1,1)) ];
titlestring{2} = ['Particles channel 2' ' (green): ' num2str(size(b2,1)) ];
titlestring{3} = ['Colocalised (yellow): ' num2str(size(b1c,1))];
title(titlestring);

end