%% clear
clc; clear all; close all;

%% path
addpath('./lib');
addpath('../blob3d/lib');

%% load images
im1 = imread3d('./im/im_r.tif');
im2 = imread3d('./im/im_g.tif');

%% normalise images
im1 = double(im1); im1 = (im1 - min(im1(:))) / (max(im1(:)) - min(im1(:)));
im2 = double(im2); im2 = (im2 - min(im2(:))) / (max(im2(:)) - min(im2(:)));

%% 3d blob colocalisation
rx = 60.7; ry = 60.7; rz = 140; % resolution in nm/pixels
s = 180;  % s - blob size [microns]; 
t1 = 0.3; % t1 - threshold value in [0-1] range
t2 = 0.3; % t2 - threshold value in [0-1] range
dt = 2*s;  % dt - distance threshold value [microns]
[b1,b2,b1c,b2c,d12] = blob_colocalisation3d(im1,im2,rx,ry,rz,s,t1,t2,dt);

%% plot
figure; blob_colocalisation_scatter_plot3d(im1,b1,b2,b1c,b2c,rx,ry,rz);
figure; [wd,md,cd] = blob_colocalisation_dist_diff_plot3d(im1,b1c,d12,rx,ry,rz);
figure; [wi,mi,ci] = blob_colocalisation_intensity_diff_plot3d(im1,b1c,b2c,rx,ry,rz);
figure; blob_colocalisation_max_projection_plot2d(im1,b1,b1c,rx,ry,1);
figure; blob_colocalisation_max_projection_plot2d(im2,b2,b2c,rx,ry,2);
figure; [h,e] = blob_colocalisation_dist_hist_plot3d(d12,dt);
figure; blob_colocalisation_max_projections_plot3d(im1,im2,b1,b2,b1c,b2c,rx,ry);
figure; blob_colocalisation_max_projection_dist_diff_plot3d(im1,b1c,rx,ry,wd,md,cd);
figure; blob_colocalisation_max_projection_intensity_diff_plot3d(im1,b1c,rx,ry,wi,mi,ci);