function [h,e] = blob_colocalisation_dist_hist_plot3d(d12,d)

%% histogram
n = 20;
d12 = d12/1000;
m = max(d12); 
w = min(d12);
e = linspace(0,d/1000,n+2);
e(1) = []; e(end) = [];
[h,e] = hist(d12,e);
bar(e,h,'r');
xlabel('Colocalisation Distance Threshold [\mum]'); ylabel('Frequency');
set(gca,'xlim',[0 d/1000]);

%% first axes 
nd = 10;
xticks = linspace(0,d/1000,nd);
set(gca,'XTick',xticks);
xtickslabels = cell(nd,1);
for i=1:nd 
    xtickslabels{i} = sprintf('%5.2f',xticks(i)); 
end
set(gca,'XTickLabel',xtickslabels);
xticks = get(gca,'Xtick');
pa = get(gca,'position');

%% second axes
xl = get(gca,'xlim');
yl = get(gca,'ylim');
box off;
ha = axes('xlim',xl,'ylim',yl,'color','none','YAxisLocation','right','XAxisLocation','top');
set(ha,'XTick',xticks);
set(ha,'XTickLabel',xtickslabels);
set(ha,'YTick',[]);
set(ha,'XGrid','on');
box off;
haxl = xlabel(ha,'Number of Colocalised Particles');
p = get(haxl,'Position');
set(haxl,'Position',[p(1) p(2)-p(2)/40 p(3)]);

%% second axes - ticks
c = zeros(nd,1);
for i=1:nd
    c(i) = sum(d12<=xticks(i));
end
set(gca,'XTickLabel',c);
set(ha,'position',pa);

end