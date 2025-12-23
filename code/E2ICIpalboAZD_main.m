function E2ICIpalboAZD_main()
%% (1) Function index in the GitHub repository
% This function runs the simulation.
% Generates plots for Figures 5A-F, 6E-F, Supplementary Figures 1A-D, and 2
% using the single optimized parameter. These are primary simulation
% results, compared directly with experimental data.

% Load the experimental data.
data = E2ICIpalboAZD_loaddata();
args = E2ICIpalboAZD_modelpar();

% initial value of variables
x0 = zeros(args.Numvariable,1);
x0(args.E2mediaindex) = args.ValE2normal;
x0 = E2ICIpalboAZD_replating(x0,args);
tspan = [0,24*30];
[t,~,xinitial] = E2ICIpalboAZD_sim(x0,tspan,args.treat_non,args);

child_plotinit(t,xinitial,args)
% set the steady state
x0 = xinitial(end,:);
for i = 1:numel(x0)
    disp(append(args.modelvariable(i), ' = ',num2str(x0(i))))
end
%% --------different treatment---------%%
%% (1)E2(10nM)
clc; close
tspan = [0,720];
x0(args.ind_reset) = 0;
x0 = E2ICIpalboAZD_replating(x0,args);
[tE2,simE2,~] = E2ICIpalboAZD_sim(x0,tspan,args.treat_non,args);
%% (2)E2(10nM)+ICI(500nM)
[tICI500nM,simICI500nM,~] = E2ICIpalboAZD_sim(x0,tspan,args.treat_ICI500nM,args);
%% (3)E2(10nM)+palbo(500nM)
[tpalbo500nM,simpalbo500nM,~] = E2ICIpalboAZD_sim(x0,tspan,args.treat_palbo500nM,args);
%% (4)E2(10nM)+palbo(1uM)
[tpalbo1uM,simpalbo1uM,~] = E2ICIpalboAZD_sim(x0,tspan,args.treat_palbo1uM,args);
%% (5)Alternating treatment over 12 months
x0 = xinitial(end,:);
x0(args.ind_reset) = 0;
x0 = E2ICIpalboAZD_replating(x0,args);
Num_month = 13;
tspan = [0, 28*24*Num_month];
x0(args.E2mediaindex) = xinitial(end,args.E2mediaindex);
% E2(10nM)+palbo(750nM) mono
treatalter = cell(1,Num_month);
for i = 1:Num_month
    treatalter{i}.treat = args.treat_palbo750nM;
    treatalter{i}.duration = args.daypermonth;
end
cycletime = sum(cell2mat(cellfun(@(x) x.duration,treatalter,'UniformOutput',false)));
cycletime = cycletime * 24;
replate = true;
[tpalbo750nM_13m,simpalbo750nM_13m,xpalbo750nM_13m] =...
    E2ICIpalboAZD_simalternation(x0,tspan,treatalter,cycletime,replate,args);
clearvars treatalter

% E2(10nM)+ICI(750nM) mono
for i = 1: Num_month
    treatalter{i}.treat = args.treat_ICI750nM;
    treatalter{i}.duration = args.daypermonth;
end
[tICI750nM_13m,simICI750nM_13m,xICI750nM_13m] =...
    E2ICIpalboAZD_simalternation(x0,tspan,treatalter,cycletime,replate,args);

% E2(10nM)+AZD(250nM) mono
for i = 1:Num_month
    treatalter{i}.treat = args.treat_AZD250nM;
    treatalter{i}.duration = args.daypermonth;
end
[tAZD250nM_13m,simAZD250nM_13m,~] =...
    E2ICIpalboAZD_simalternation(x0,tspan,treatalter,cycletime,replate,args);

% E2(10nM)+AZD(250nM)+ICI(750nM) mono
for i = 1:Num_month
    treatalter{i}.treat = args.treat_ICI750nM_AZD250nM;
    treatalter{i}.duration = args.daypermonth;
end
[tICI750nMAZD250nM_13m,simICI750nMAZD250nM_13m,~] =...
    E2ICIpalboAZD_simalternation(x0,tspan,treatalter,cycletime,replate,args);

% Alter: E2(10nM)+palbo(750nM) -> E2(10nM)+ICI(750nM)
for i = 1:Num_month
    if mod(i,2) == 1
        treatalter{i}.treat = args.treat_palbo750nM;
    else
        treatalter{i}.treat = args.treat_ICI750nM;
    end
    treatalter{i}.duration = args.daypermonth;
end
[tAlter_palbo750nM_ICI750nM_13m,simAlter_palbo750nM_ICI750nM_13m,~] =...
    E2ICIpalboAZD_simalternation(x0,tspan,treatalter,cycletime,replate,args);

% Alter: E2(10nM)+palbo(750nM) -> E2(10nM)+ICI(750nM)+AZD(250nM)
for i = 1:Num_month
    if mod(i,2) == 1
        treatalter{i}.treat = args.treat_palbo750nM;
    else
        treatalter{i}.treat = args.treat_ICI750nM_AZD250nM;
    end
    treatalter{i}.duration = args.daypermonth;
end
[tAlter_palbo750nM_ICI750nMAZD250nM_13m,simAlter_palbo750nM_ICI750nMAZD250nM_13m,...
    xAlter_palbo750nM_ICI750nMAZD250nM_13m] =...
    E2ICIpalboAZD_simalternation(x0,tspan,treatalter,cycletime,replate,args);

close all
%% (8)Synergy
tspan = [0, 17 * 24];
% E2(10nM)+ICI(200nM)
x0(args.E2mediaindex) = xinitial(end,args.E2mediaindex);
[tICI200nM_d17,simICI200nM_d17,~] = E2ICIpalboAZD_sim(x0,tspan,args.treat_ICI200nM,args);
% E2(10nM)+ICI(200nM)+palbo(50nM)
[tICI200nM_palbo50nM_d17,simICI200nM_palbo50nM_d17,~] =...
    E2ICIpalboAZD_sim(x0,tspan,args.treat_ICI200nM_palbo50nM,args);
% E2(10nM)+ICI(200nM)+palbo(100nM)
[tICI200nM_palbo100nM_d17,simICI200nM_palbo100nM_d17,~] =...
    E2ICIpalboAZD_sim(x0,tspan,args.treat_ICI200nM_palbo100nM,args);
% E2(10nM)+ICI(200nM)+palbo(300nM)
[tICI200nM_palbo300nM_d17,simICI200nM_palbo300nM_d17,~] =...
    E2ICIpalboAZD_sim(x0,tspan,args.treat_ICI200nM_palbo300nM,args);
%% protein data
% week 1d
teval = 7;
val = child_proteinnorm_all(tpalbo750nM_13m/24,...
                            xpalbo750nM_13m,...
                            teval,...
                            xpalbo750nM_13m,...
                            {args.ind_containcyclinE1});
cyclinE1_palbo750nM_w1 = val{:};

val = child_proteinnorm_all(tICI750nM_13m/24,...
                            xICI750nM_13m,...
                            teval,...
                            xICI750nM_13m,...
                            {args.ind_containcdk6});
cdk6_ICI750nM_w1 = val{:};

% week 2
teval = 14;
val = child_proteinnorm_all(tpalbo750nM_13m/24,...
                            xpalbo750nM_13m,...
                            teval,...
                            xpalbo750nM_13m,...
                            {args.ind_containcyclinE1});
cyclinE1_palbo750nM_w2 = val{:};

val = child_proteinnorm_all(tICI750nM_13m/24,...
                            xICI750nM_13m,...
                            teval,...
                            xICI750nM_13m,...
                            {args.ind_containcdk6});
cdk6_ICI750nM_w2 = val{:};

% month 12
teval = 336;
val = child_proteinnorm_all(tpalbo750nM_13m/24,...
                            xpalbo750nM_13m,...
                            teval,...
                            xpalbo750nM_13m,...
                            {args.ind_containcyclinE1});
cyclinE1_palbo750nM_m12 = val{:};

val = child_proteinnorm_all(tICI750nM_13m/24,...
                            xICI750nM_13m,...
                            teval,...
                            xICI750nM_13m,...
                            {args.ind_containcdk6});
cdk6_ICI750nM_m12 = val{:};

val = child_proteinnorm_all(tAlter_palbo750nM_ICI750nMAZD250nM_13m/24,...
                            xAlter_palbo750nM_ICI750nMAZD250nM_13m,...
                            teval,...
                            xAlter_palbo750nM_ICI750nMAZD250nM_13m,...
                            {args.ind_containcyclinE1,...
                            args.ind_containcdk6});
[cyclinE1_alter_palbo750nM_ICI750nMAZD250nM_m12,...
 cdk6_alter_palbo750nM_ICI750nMAZD250nM_m12] = val{:};

positionval = [867,294,1026,792];
% cyclinE1 plot
CyclinE1_data_mean = data.CyclinE1.mean;
CyclinE1_data_sem = data.CyclinE1.sem;
CyclinE1_label = data.CyclinE1.label;
CyclinE1_sim_mean = [1,cyclinE1_palbo750nM_w1,cyclinE1_palbo750nM_w2,...
                     cyclinE1_palbo750nM_m12,cyclinE1_alter_palbo750nM_ICI750nMAZD250nM_m12];
CyclinE1_sim_sem = zeros(1,numel(CyclinE1_sim_mean));
CyclinE1_mean = [CyclinE1_data_mean;CyclinE1_sim_mean]';
CyclinE1_sem = [CyclinE1_data_sem;CyclinE1_sim_sem]';

title_str = 'CyclinE1, Fig.6F';
ylabel_str = 'Normalized to T=0';
ylimval = [0,3];
E2ICIpalboAZD_barplot(CyclinE1_mean,CyclinE1_sem,CyclinE1_label,title_str,ylabel_str,ylimval,positionval)

% Cdk6 plot
Cdk6_data_mean = data.Cdk6.mean;
Cdk6_data_sem = data.Cdk6.sem;
Cdk6_label = data.Cdk6.label;
Cdk6_sim_mean = [1,cdk6_ICI750nM_w1,cdk6_ICI750nM_w2,...
                 cdk6_ICI750nM_m12,cdk6_alter_palbo750nM_ICI750nMAZD250nM_m12];
Cdk6_sim_sem = zeros(1,numel(Cdk6_sim_mean));
Cdk6_mean = [Cdk6_data_mean;Cdk6_sim_mean]';
Cdk6_sem = [Cdk6_data_sem;Cdk6_sim_sem]';

title_str = 'Cdk6, Fig.6E';
ylabel_str = 'Normalized to T=0';
ylimval = [0,7];
E2ICIpalboAZD_barplot(Cdk6_mean,Cdk6_sem,Cdk6_label,title_str,ylabel_str,ylimval,positionval)
%% Synergy
%% Supplementary Figure 2.
teval = 17;
% E2(10nM)+ICI(200nM)
pos = find(tICI200nM_d17/24 == teval, 1,'first');
simICI200nM_d17 = simICI200nM_d17(end,pos);
% E2(10nM)+ICI(200nM)+palbo(50nM)
pos = find(tICI200nM_palbo50nM_d17/24 == teval, 1,'first');
simICI200nM_palbo50nM_d17 = simICI200nM_palbo50nM_d17(end,pos);
% E2(10nM)+ICI(200nM)+palbo(100nM)
pos = find(tICI200nM_palbo100nM_d17/24 == teval, 1,'first');
simICI200nM_palbo100nM_d17 = simICI200nM_palbo100nM_d17(end,pos);
% E2(10nM)+ICI(200nM)+palbo(300nM)
pos = find(tICI200nM_palbo300nM_d17/24 == teval, 1,'first');
simICI200nM_palbo300nM_d17 = simICI200nM_palbo300nM_d17(end,pos);

data_mean = [data.Synergy_ICI200nM_17day_pro.mean,data.Synergy_palbo50nM_17day_pro.mean,...
    data.Synergy_palbo100nM_17day_pro.mean, data.Synergy_palbo300nM_17day_pro.mean];
data_std = [data.Synergy_ICI200nM_17day_pro.std,data.Synergy_palbo50nM_17day_pro.std,...
    data.Synergy_palbo100nM_17day_pro.std, data.Synergy_palbo300nM_17day_pro.std];
sim_mean = [simICI200nM_d17, simICI200nM_palbo50nM_d17, simICI200nM_palbo100nM_d17,...
    simICI200nM_palbo300nM_d17];
x = 1:numel(data_mean);

figure;hold on
l1 = errorbar(x, data_mean, data_std, 'color', 'b', 'linewidth', 2);
l2 = plot(x, sim_mean, 'color', 'r', 'linewidth', 2);
xlim([0.4,numel(data_mean)+0.6])
title('Cellnum at 17day, Supplementary Fig. 2')
ylabel('Normalized to T=0')
legend([l1,l2],{'Experiment','Simulation'},'box','off','location','NE');
set(gca,'xtick',x,'xticklabel',{'ICI(200nM)', 'ICI200nM+palbo(50nM)', 'ICI200nM+palbo(100nM)',...
    'ICI200nM+palbo300nM)'},'Fontsize',20,'linewidth',2, 'box', 'on')
grid on
set(gcf,'position', [466,456,797,638],'color','w')
%% Proliferation
%% Supplementary Figures 1A–D. 
figure
prctile50_or_min = []; 
prctile_low = [];
prctile_high = [];
index_mincost = 1;
plottype = 'one';
color = 'b';
FontsizeNum = 16;
width = 0.05;
length = 0.05;
num_row = 2;
num_col = 2;
n = 1;

% (1)E2(10nM)
subplot_tight(num_row,num_col,n,[length width]);hold on
n = n+1;
titlename = 'E2(10nM), Supplementary Fig.1A';
legendloc = 'SE';
ylimval = [-.1,180];
xlimval = [-.2,28.5];
timepoint = [args.timepoint_pro(1:5), 11, args.timepoint_pro(6:end)];
xticklabel = num2cell(timepoint);
expmean = [data.E210nM_pro.mean(1:5),data.E210nM_day11_pro.mean,data.E210nM_pro.mean(6:end)];
expstd = [data.E210nM_pro.std(1:5),data.E210nM_day11_pro.std,data.E210nM_pro.std(6:end)];
E2ICIpalboAZD_plotpro(timepoint,expmean,expstd,tE2(1:pos),simE2(end,1:pos),...
                      index_mincost,prctile50_or_min,prctile_low,prctile_high,titlename,plottype,...
                      xlimval,ylimval,xticklabel,color,[],[],[],FontsizeNum,legendloc);

pos = find(tE2/24 == 29,1,'first');

% (2)E2(10nM)+ICI(500nM)
subplot_tight(num_row,num_col,n,[length width]);hold on
n = n+1;
titlename = 'E2(10nM)+ICI(500nM), Supplementary Fig.1B';
legendloc = 'NW';
ylimval = [-.1,40];
E2ICIpalboAZD_plotpro(args.timepoint_pro,data.E210nM_ICI500nM_pro.mean,data.E210nM_ICI500nM_pro.std,...
                      tICI500nM(1:pos),simICI500nM(end,1:pos), index_mincost,prctile50_or_min,prctile_low,...
                      prctile_high,titlename,plottype,xlimval,ylimval,xticklabel,color,[],[],[],...
                      FontsizeNum,legendloc);

% (3)E2(10nM)+palbo(500nM)
subplot_tight(num_row,num_col,n,[length width]);hold on
n = n+1;
titlename = 'E2(10nM)+palbo(500nM), Supplementary Fig.1C';
legendloc = 'NW';
ylimval = [-.1,40];
E2ICIpalboAZD_plotpro(args.timepoint_pro,data.E210nM_palbo500nM_pro.mean,data.E210nM_palbo500nM_pro.std,...
                      tpalbo500nM(1:pos),simpalbo500nM(end,1:pos), index_mincost,prctile50_or_min,prctile_low,...
                      prctile_high,titlename,plottype,xlimval,ylimval,xticklabel,color,[],[],[],...
                      FontsizeNum,legendloc);

% (4)E2(10nM)+palbo(1uM)
subplot_tight(num_row,num_col,n,[length width]);hold on
titlename = 'E2(10nM)+palbo(1uM), Supplementary Fig.1D';
legendloc = 'NW';
ylimval = [-.1,10];
E2ICIpalboAZD_plotpro(args.timepoint_pro,data.E210nM_palbo1uM_pro.mean,data.E210nM_palbo1uM_pro.std,...
                      tpalbo1uM(1:pos),simpalbo1uM(end,1:pos),index_mincost,prctile50_or_min,prctile_low,...
                      prctile_high,titlename,plottype,xlimval,ylimval,xticklabel,color,[],[],[],...
                      FontsizeNum,legendloc);
set(gcf,'position', [982,31,1346,913])

figure
prctile50_or_min = []; 
prctile_low = [];
prctile_high = [];
index_mincost = 1;
plottype = 'one';
color = 'b';
FontsizeNum = 16;
width = 0.05;
length = 0.05;
num_row = 1;
num_col = 2;
n = 1;

% (5)E2(10nM)+AZD(250nM)
subplot_tight(num_row,num_col,n,[length width]);hold on
n = n+1;
titlename = 'E2(10nM)+AZD(250nM), Fig.5E';
legendloc = 'NW';
ylimval = [-1,80];
E2ICIpalboAZD_plotpro(args.timepoint_pro([1,end]),...
                        data.E210nM_AZD250nM_pro.mean,...
                        data.E210nM_AZD250nM_pro.std,...
                        tAZD250nM_13m(1:pos),...
                        simAZD250nM_13m(end,1:pos),...
                        index_mincost,prctile50_or_min,prctile_low,prctile_high,titlename,...
                        plottype,xlimval,ylimval,xticklabel([1,end]),color,[],[],[],...
                        FontsizeNum,legendloc);

% (6)E2(10nM)+ICI(750nM)+AZD(250nM)
subplot_tight(num_row,num_col,n,[length width]);hold on
titlename = 'E2(10nM)+ICI(750nM)+AZD(250nM), Fig.5F';
ylimval = [-1,30];
color = ['g','g'];
E2ICIpalboAZD_plotalterpro(data.Long12month.time(1:2),...
                           data.E210nM_AZD250nMICI750nM_pro.mean,...
                           data.E210nM_AZD250nMICI750nM_pro.std,...
                           tICI750nMAZD250nM_13m,...
                           simICI750nMAZD250nM_13m(end,:),...
                           index_mincost,prctile50_or_min,prctile_low,prctile_high,titlename,...
                           plottype,[0,data.Long12month.time(4)+2],ylimval,...
                           num2cell(data.Long12month.time),...
                           color,FontsizeNum,replate);
set(gcf,'position',[258,616,1346,450])
%% Alternating treatment over 12 months
figure;
xlimval = [-5,data.Long12month.time(end)+10];
FontsizeNum = 21;
width = 0.08;
length = 0.08;

% E2(10nM)+palbo(750nM) mono
n = 1;
subplot_tight(2,2,n,[length width]);hold on
ylimval = [-1,180];
color = ["m","m"];
titlename = '12 months Palbo mono (750nM), Fig.5A';
replate = true;
E2ICIpalboAZD_plotalterpro(data.Long12month.time,...
                           data.Long12month.palbo750nM_Mono.mean,...
                           data.Long12month.palbo750nM_Mono.std,...
                           tpalbo750nM_13m,...
                           simpalbo750nM_13m(end,:),...
                           index_mincost,prctile50_or_min,prctile_low,prctile_high,titlename,...
                           plottype,xlimval,ylimval,...
                           num2cell(data.Long12month.time),...
                           color,FontsizeNum,replate);

% E2(10nM)+ICI(750nM) mono
n = 2;
subplot_tight(2,2,n,[length width]);hold on
ylimval = [-1,100];
color = ["k","k"];
titlename = '12 months ICI mono (750nM), Fig.5B';
E2ICIpalboAZD_plotalterpro(data.Long12month.time,...
                           data.Long12month.ICI750nM_Mono.mean,...
                           data.Long12month.ICI750nM_Mono.std,...
                           tICI750nM_13m,...
                           simICI750nM_13m(end,:),...
                           index_mincost,prctile50_or_min,prctile_low,prctile_high,titlename,...
                           plottype,xlimval,ylimval,...
                           num2cell(data.Long12month.time),...
                           color,FontsizeNum,replate);

% Alternating: E2(10nM)+palbo(750nM) -> E2(10nM)+ICI(750nM)
n = 3;
subplot_tight(2,2,n,[length width]);hold on
ylimval = [-1,150];
color = ["m","k"];
titlename = '12 months alter palbo (750nM) ICI mono (750nM), Fig.5C';
E2ICIpalboAZD_plotalterpro(data.Long12month.time,...
                           data.Long12month.Alter_palbo750nM_ICI750nM.mean,...
                           data.Long12month.Alter_palbo750nM_ICI750nM.std,...
                           tAlter_palbo750nM_ICI750nM_13m,...
                           simAlter_palbo750nM_ICI750nM_13m(end,:),...
                           index_mincost,prctile50_or_min,prctile_low,prctile_high,titlename,...
                           plottype,xlimval,ylimval,...
                           num2cell(data.Long12month.time),...
                           color,FontsizeNum,replate);
set(gcf,'position',[340, 300, 1120, 790])

% Alternating: E2(10nM)+palbo(750nM) -> E2(10nM)+ICI(750nM)+AZD(250nM)
n = 4;
subplot_tight(2,2,n,[length width]);hold on
ylimval = [-0.1,20];
color = ["m","g"];
titlename = '12 months alter palbo (750nM) ICI mono (750nM), Fig.5D';
E2ICIpalboAZD_plotalterpro(data.Long12month.time,...
                           data.Long12month.Alter_palbo750nM_ICI750nMAZD250nM.mean,...
                           data.Long12month.Alter_palbo750nM_ICI750nMAZD250nM.std,...
                           tAlter_palbo750nM_ICI750nMAZD250nM_13m,...
                           simAlter_palbo750nM_ICI750nMAZD250nM_13m(end,:),...
                           index_mincost,prctile50_or_min,prctile_low,prctile_high,titlename,...
                           plottype,xlimval,ylimval,...
                           num2cell(data.Long12month.time),...
                           color,FontsizeNum,replate);
set(gcf,'position',[1236,151,1523,946])
end

function child_plotinit(t,x,args)
x(:,args.ind_reset) = [];
plot(t/24,log10(x));
ylim([-10,10])
end

function val = child_proteinnorm_all(t, x, teval, xref, ind)
val = cell(numel(ind),1);
for i = 1:numel(ind)
val{i} = child_proteinnorm(t, x, teval, xref, ind{i});
end
end

function val = child_proteinnorm(t, x, teval, xref, ind)
pos = find(t == teval, 1,'first');
val = sum(x(pos,ind))/sum(xref(1,ind));
end
