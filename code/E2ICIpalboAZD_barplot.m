function E2ICIpalboAZD_barplot(data_mean,data_sem,data_label,title_str,ylabel_str,ylimval,positionval)
% Barplot
figure
b = bar(data_mean,0.9,'Linewidth',2);hold on
ngroups = size(data_mean,1);
nbars = size(data_mean,2);
groupwidth = min(0.8,nbars/(nbars + 1.5));
for i = 1:nbars
    x = (1:ngroups) - groupwidth/2 + (2*i-1) * groupwidth / (2*nbars);
    errorbar(x,data_mean(:,i),data_sem(:,i), 'k', 'linestyle', 'none','linewidth',2);
end

title(title_str);
ylabel(ylabel_str);
legend(b,{'Experiment','Simulation'},'box','off','location','NW');
set(gca,'Fontsize',20,'linewidth',2,'xticklabel',data_label);
ylim(ylimval);
xlim([0.4,ngroups+.6]);
grid on
set(gcf,'Position',positionval,'color','w');
end