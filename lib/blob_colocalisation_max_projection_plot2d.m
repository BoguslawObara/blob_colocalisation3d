function blob_colocalisation_max_projection_plot2d(im1,b1,b1c,rx,ry,ch)

%% [pixel] -> [micron]
b1(:,1) = b1(:,1)/rx;
b1(:,2) = b1(:,2)/ry;
if ~isempty(b1c)
    b1c(:,1) = b1c(:,1)/rx;
    b1c(:,2) = b1c(:,2)/ry;
end

%% plot
immax = max(im1,[],3);
immax = double(immax); 
immax = (immax - min(immax(:))) / (max(immax(:)) - min(immax(:))); 

imagesc(immax); colormap gray; hold on; axis image; axis tight;
set(gca,'xtick',[]); set(gca,'ytick',[]);
plot(b1(:,2),b1(:,1),'.r'); hold on; 
if ~isempty(b1c)
    plot(b1c(:,2),b1c(:,1),'.y'); hold on; 
end

titlestring{1} = ['Particles channel ' num2str(ch) ' (red): ' num2str(size(b1,1)) ];
titlestring{2} = ['Colocalised (yellow): ' num2str(size(b1c,1))];
title(titlestring);

end