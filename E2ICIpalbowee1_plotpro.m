function h = E2ICIpalbowee1_plotpro(ttimedata,...
                                    expmean,...
                                    expsem,...
                                    cohort_t,...
                                    cohort_x,...
                                    titlename,...
                                    xlimval,...
                                    ylimval,...
                                    xticklabeldata,...
                                    color,...
                                    varargin)
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
h = plot(cohort_t(1:pos)/24,cohort_x(1:pos),'color',color,'linewidth',2);

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
xlabel('Time (d)');
ylabel('Normalized cell number');
set(gca,'fontsize',fontsize,'linewidth',2,'xtick',ttimedata,'xticklabel',xticklabeldata);
if ~isempty(varargin{5})
    legend([h{1},h{2}],{'Simulation','Experiment'},'box','off','location',varargin{5})
end
set(gcf,'color','w')
grid on;
box on;
xlim(xlimval);
ylim(ylimval);
end