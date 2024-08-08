function h = E2ICIpalbowee1_plotalterpro(ttimedata,...
                                         expmean,...
                                         expsem,...
                                         cohort_t,...
                                         cohort_x,...
                                         titlename,...
                                         xlimval,...
                                         ylimval,...
                                         xticklabeldata,...
                                         color,...
                                         fontsize,...
                                         varargin)

l1 = errorbar(-10,expmean(end),expsem(end),'color',color(1),'linestyle','-.','linewidth',2,...
    'marker','o','CapSize',0);
l2 = errorbar(-10,expmean(end-1),expsem(end),'color',color(2),'linestyle','-.','linewidth',2,...
    'marker','o','CapSize',0);
l3 = plot(-20:-10,-20:-10,'color',color(1),'linewidth',2);
l4 = plot(-20:-10,-20:-10,'color',color(2),'linewidth',2);
h = {l1,l2,l3,l4};

time = ttimedata(2):unique(diff(ttimedata)):ttimedata(end);
expmean = expmean(~isnan(expmean));
expsem = expsem(~isnan(expsem));
pos_bef = 1;
for i = 1:numel(time)
    time_i = time(i);
    pos_i = find(cohort_t/24 == time_i,1,'first');
    if mod(i,2) == 1
        color_i = color(1);
    else
        color_i = color(2);
    end

    plot(cohort_t(pos_bef:pos_i)/24,cohort_x(pos_bef:pos_i),'color',color_i,'linewidth',2);

    if ~isempty(varargin) && varargin{1}
        plot(ttimedata(i:i+1),[1, expmean(i+1)],'color',color_i,'linestyle','-.','linewidth',2);
    else
        plot(ttimedata(i:i+1),expmean(i:i+1),'color',color_i,'linestyle','-.','linewidth',2);
    end
    if numel(unique(color)) ~=1
        color_i = setdiff(color,color_i);
    end
    if i ~= 1
        errorbar(ttimedata(i),expmean(i),expsem(i),'color',color_i,'marker','o','CapSize',0,'linewidth',2);
    end
    pos_bef = pos_i;
    if ~isempty(varargin) && varargin{1}
        pos_bef = pos_bef+1;
    end
end
if numel(unique(color)) ~=1
   color_i = setdiff(color,color_i);
end
errorbar(ttimedata(end),expmean(end),expsem(end),'color',color_i,'marker','o','linewidth',2','CapSize',0);
title(titlename);
xlabel('Time (d)')
ylabel('Normalized cell number')
set(gca,'fontsize',fontsize,'linewidth',2,'xtick',ttimedata,'xticklabel',xticklabeldata);
set(gcf,'color','w')
grid on;
box on;
xlim(xlimval);
ylim(ylimval);
end