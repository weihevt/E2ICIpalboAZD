function h = E2ICIpalboAZD_28_plotpro(ttimedata,expmean,expsem,cohort_t,cohort_x,index_mincost,...
                                      prctile50_or_min, prctile_low,prctile_high,titlename,plotind,...
                                      xlimval,ylimval,xticklabeldata,color,varargin)
% This function plots the simulation results alongside the experimental data.

if isempty(varargin) || isempty(varargin{1})
    linsty = '-';
else
    linsty = varargin{1};
end

if ~all(isnan(expmean))
    expt = ttimedata(~isnan(expmean));
    expmean = expmean(~isnan(expmean));
    expsem = expsem(~isnan(expsem));
else
    expt = ttimedata;
end
pos = find(cohort_t/24 == expt(end),1,'first');

if isequal(plotind,'one')
    h = plot(cohort_t(1:pos)/24,cohort_x(index_mincost,1:pos),'color',color,'linewidth',2);
elseif isequal(plotind,'shaded')
    data1_low = prctile(cohort_x,prctile_low,1);
    if strcmp(prctile50_or_min,'percentile')
        data1_50 = prctile(cohort_x,50,1);
    elseif strcmp(prctile50_or_min,'min')
        data1_50 = cohort_x(index_mincost,:);
    end
    data1_high = prctile(cohort_x,prctile_high,1);
    errBar = [data1_high - data1_50;data1_50 - data1_low];
    h = shadedErrorBar(cohort_t(1:pos)/24,data1_50(1:pos),errBar(:,1:pos),'lineprops',{color,linsty,'markerfacecolor',color,'linewidth',2});
elseif isequal(plotind,'all')
    for i = 1:size(cohort_x,1)
        plot(cohort_t(1:pos)/24,cohort_x(i,1:pos),'b','linewidth',0.5,'color',color)
    end
else
    error('')
end

if ~all(isnan(expmean))
    if isempty(varargin) || isempty(varargin{2})
        color_errbar = 'r';
    else
        color_errbar = varargin{2};
    end
    if ~isempty(varargin) && ~isempty(varargin{3})
        linsty = varargin{3};
    end
    h1 = errorbar(expt,expmean,expsem,'o','color',color_errbar,'LineStyle',linsty,'linewidth',2,'CapSize',0);
    h = {h,h1};
end
if ~isempty(varargin) && ~isempty(varargin{4})
    fontsize = varargin{4};
end

title(titlename);
% xlabel('Time (d)');
ylabel('Normalized cell number');
set(gca,'fontsize',fontsize,'linewidth',2,'xtick',ttimedata,'xticklabel',xticklabeldata);
if isequal(plotind,'one') && ~isempty(varargin{5})
    legend([h{1},h{2}],{'Simulation','Experiment'},'box','off','location',varargin{5})
end
set(gcf,'color','w')
grid on;
box on;
xlim(xlimval);
ylim(ylimval);
end