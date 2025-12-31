function h = E2ICIpalboAZD_27_plotalterpro(ttimedata,expmean,expsem,cohort_t,cohort_x,index_mincost,...
    prctile50_or_min, prctile_low,prctile_high,titlename,plotind,xlimval,ylimval,xticklabeldata,...
    color,fontsize,varargin)
% This function plots the proliferation simulation results for the alternating treatment.

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
    if isequal(plotind,'one')
        plot(cohort_t(pos_bef:pos_i)/24,cohort_x(index_mincost,pos_bef:pos_i),'color',color_i,'linewidth',2);
    elseif isequal(plotind,'shaded')
        data1_low = prctile(cohort_x,prctile_low,1);
        if strcmp(prctile50_or_min,'percentile')
            data1_50 = prctile(cohort_x,50,1);
        elseif strcmp(prctile50_or_min,'min')
            data1_50 = cohort_x(index_mincost,:);
        end
        data1_high = prctile(cohort_x,prctile_high,1);
        errBar = [data1_high - data1_50;data1_50 - data1_low];
        h1 = shadedErrorBar(cohort_t(pos_bef:pos_i)/24,data1_50(pos_bef:pos_i),errBar(:,pos_bef:pos_i),...
            'lineprops',{color_i,'-','markerfacecolor',color_i,'linewidth',2});
        h = [h,h1];
    else
        error('')
    end
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
% xlabel('Time (d)')
ylabel('Normalized cell number')
set(gca,'fontsize',fontsize,'linewidth',2,'xtick',ttimedata,'xticklabel',xticklabeldata);
set(gcf,'color','w')
grid on;
box on;
xlim(xlimval);
ylim(ylimval);
end