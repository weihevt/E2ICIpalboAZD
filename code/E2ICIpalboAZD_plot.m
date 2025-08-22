function E2ICIpalboAZD_plot()
%% (30) Function index in the GitHub repository
% This function plots the simulation results from the parameter cohort. 
% These are the results included in the paper.

close all
pathsave = './rawfig/';
pathload = './xls/';
args = E2ICIpalboAZD_modelpar();
Num_month = 12;
Num_hours = 24;
% check whether the simulation results already exist and load data.
functionname = 'E2ICIpalboAZD_minimumAZD_2treat';
% cell number, minimize AZD period, two treatment options.
filename = [pathload,'cellnumAlter_minAZD_2treat.xls'];
cellnumAlter_minAZD_2treat = child_checkload(filename,functionname);
% cdk6, minimize AZD period, two treatment options.ebeb
filename = [pathload,'cdk6_minAZD_2treat.xls'];
cdk6_minAZD_2treat = child_checkload(filename,functionname);
% cyclinE1, minimize AZD period, two treatment options.
filename = [pathload,'cyclinE1_minAZD_2treat.xls'];
cyclinE1_minAZD_2treat = child_checkload(filename,functionname);
% treatment used, minimize AZD period, two treatment options.
% 0: E2(10nM)+palbo(750nM) treatment.
% 1: E2(10nM)+ICI(750nM)+AZD(250nM) treatment.
filename = [pathload,'treat_minAZD_2treat.xls'];
treat_minAZD_2treat = child_checkload(filename,functionname);

functionname = 'E2ICIpalboAZD_minimumAZD_3treat';
% cell number, minimize AZD period, three treatment options.
filename = [pathload,'cellnumAlter_minAZD_3treat.xls'];
cellnumAlter_minAZD_3treat = child_checkload(filename,functionname);
% cdk6, minimize AZD period, three treatment options.
filename = [pathload,'cdk6_minAZD_3treat.xls'];
cdk6_minAZD_3treat = child_checkload(filename,functionname);
filename = [pathload,'cyclinE1_minAZD_3treat.xls'];
% cyclinE1, minimize AZD period, three treatment options.
cyclinE1_minAZD_3treat = child_checkload(filename,functionname);
% treatment used, minimize AZD period, three treatment options.
% 0: E2(10nM)+palbo(750nM) treatment.
% 1: E2(10nM)+ICI(750nM) treatment.
% 2: E2(10nM)+ICI(750nM)+AZD(250nM) treatment.
filename = [pathload,'treat_minAZD_3treat.xls'];
treat_minAZD_3treat = child_checkload(filename,functionname);
%%
functionname = 'E2ICIpalboAZD_simparcohort';
% tE2
filename = [pathload,'tE2.xls'];
tE2 = child_checkload(filename,functionname);
% tICI500nM
filename = [pathload,'tICI500nM.xls'];
tICI500nM = child_checkload(filename,functionname);
% tpalbo500nM
filename = [pathload,'tpalbo500nM.xls'];
tpalbo500nM = child_checkload(filename,functionname);
% tpalbo1uM
filename = [pathload,'tpalbo1uM.xls'];
tpalbo1uM = child_checkload(filename,functionname);;
% tAZD
filename = [pathload,'tAZD.xls'];
tAZD = child_checkload(filename,functionname);
% tICIAZD
filename = [pathload,'tICIAZD.xls'];
tICIAZD = child_checkload(filename,functionname);
% cyclinE1
filename = [pathload,'cyclinE1.xls'];
CyclinE1 = child_checkload(filename,functionname);
% cdk6
filename = [pathload,'cdk6.xls'];
Cdk6 = child_checkload(filename,functionname);
% synergy
filename = [pathload,'synergy.xls'];
synergy = child_checkload(filename,functionname);
% cellnumE2
filename = [pathload,'cellnumE2.xls'];
cellnumE2 = child_checkload(filename,functionname);
% cellnumICI500nM
filename = [pathload,'cellnumICI500nM.xls'];
cellnumICI500nM = child_checkload(filename,functionname);
% cellnumpalbo500nM
filename = [pathload,'cellnumpalbo500nM.xls'];
cellnumpalbo500nM = child_checkload(filename,functionname);
% cellnumpalbo1uM
filename = [pathload,'cellnumpalbo1uM.xls'];
cellnumpalbo1uM = child_checkload(filename,functionname);
% cellnumpalbo750nM_12m
filename = [pathload,'cellnumpalbo750nM_12m.xls'];
cellnumpalbo750nM_12m = child_checkload(filename,functionname);
% cdk6palbo750nM_12m
filename = [pathload,'cdk6palbo750nM_12m.xls'];
cdk6palbo750nM_12m = child_checkload(filename,functionname);
% cylinE1palbo750nM_12m
filename = [pathload,'cylinE1palbo750nM_12m.xls'];
cylinE1palbo750nM_12m = child_checkload(filename,functionname);
% segregation
cellnumpalbo750nM_12m = child_seg(cellnumpalbo750nM_12m,cdk6palbo750nM_12m,cylinE1palbo750nM_12m,...
                                  Num_month,Num_hours,args);
% cellnumICI750nM_12m
filename = [pathload,'cellnumICI750nM_12m.xls'];
cellnumICI750nM_12m = child_checkload(filename,functionname);
% cdk6ICI750nM_12m
filename = [pathload,'cdk6ICI750nM_12m.xls'];
cdk6ICI750nM_12m = child_checkload(filename,functionname);
% cylinE1ICI750nM_12m
filename = [pathload,'cylinE1ICI750nM_12m.xls'];
cylinE1ICI750nM_12m = child_checkload(filename,functionname);

cellnumICI750nM_12m = child_seg(cellnumICI750nM_12m,cdk6ICI750nM_12m,cylinE1ICI750nM_12m,...
                                Num_month,Num_hours,args);
% cellnumAlter_palbo_ICI
filename = [pathload,'cellnumAlter_palbo_ICI.xls'];
cellnumAlter_palbo_ICI = child_checkload(filename,functionname);
% cdk6Alter_palbo_ICI
filename = [pathload,'cdk6Alter_palbo_ICI.xls'];
cdk6Alter_palbo_ICI = child_checkload(filename,functionname);
% cyclinE1Alter_palbo_ICI
filename = [pathload,'cyclinE1Alter_palbo_ICI.xls'];
cyclinE1Alter_palbo_ICI = child_checkload(filename,functionname);
% segregation
[cellnumAlter_palbo_ICI,cdk6Alter_palbo_ICI,cyclinE1Alter_palbo_ICI] =...
    child_seg(cellnumAlter_palbo_ICI,cdk6Alter_palbo_ICI,cyclinE1Alter_palbo_ICI,...
              Num_month,Num_hours,args);

% cellnumAlter_palbo_ICIAZD
filename = [pathload,'cellnumAlter_palbo_ICIAZD.xls'];
cellnumAlter_palbo_ICIAZD = child_checkload(filename,functionname);
% cdk6Alter_palbo_ICIAZD
filename = [pathload,'cdk6Alter_palbo_ICIAZD.xls'];
cdk6Alter_palbo_ICIAZD = child_checkload(filename,functionname);
% cyclinE1Alter_palbo_ICIAZD
filename = [pathload,'cyclinE1Alter_palbo_ICIAZD.xls'];
cyclinE1Alter_palbo_ICIAZD = child_checkload(filename,functionname);
% segregation
[cellnumAlter_palbo_ICIAZD,cdk6Alter_palbo_ICIAZD,cyclinE1Alter_palbo_ICIAZD] =...
    child_seg(cellnumAlter_palbo_ICIAZD,cdk6Alter_palbo_ICIAZD,cyclinE1Alter_palbo_ICIAZD,...
              Num_month,Num_hours,args);

% cellnumAZD
filename = [pathload,'cellnumAZD.xls'];
cellnumAZD = child_checkload(filename,functionname);
% cellnumICIAZD
filename = [pathload,'cellnumICIAZD.xls'];
cellnumICIAZD = child_checkload(filename,functionname);
%% load data
data = E2ICIpalboAZD_loaddata();
%%
% Fig.6E
positionval = [867,294,1026,792];
Cdk6_data_mean = data.Cdk6.mean;
Cdk6_data_sem = data.Cdk6.sem;
Cdk6_label = data.Cdk6.label;
Cdk6_sim_mean = [1, mean(Cdk6,1)];
Cdk6_sim_sem = [0, std(Cdk6,1)/sqrt(size(Cdk6,1))];
Cdk6_mean = [Cdk6_data_mean;Cdk6_sim_mean]';
Cdk6_sem = [Cdk6_data_sem;Cdk6_sim_sem]';

title_str = 'Cdk6, Fig.6E';
ylabel_str = 'Normalized to T=0';
ylimval = [0,7];
E2ICIpalboAZD_barplot(Cdk6_mean,Cdk6_sem,Cdk6_label,title_str,ylabel_str,ylimval,positionval)
print(gcf,[pathsave,'FIG6E.pdf'],'-dpdf','-bestfit')
close gcf
% Fig.6F
CyclinE1_data_mean = data.CyclinE1.mean;
CyclinE1_data_sem = data.CyclinE1.sem;
CyclinE1_label = data.CyclinE1.label;
CyclinE1_sim_mean = [1, mean(CyclinE1,1)];
CyclinE1_sim_sem = [0, std(CyclinE1,1)/sqrt(size(CyclinE1,1))];
CyclinE1_mean = [CyclinE1_data_mean;CyclinE1_sim_mean]';
CyclinE1_sem = [CyclinE1_data_sem;CyclinE1_sim_sem]';

title_str = 'CyclinE1, Fig.6F';
ylabel_str = 'Normalized to T=0';
ylimval = [0,4];
E2ICIpalboAZD_barplot(CyclinE1_mean,CyclinE1_sem,CyclinE1_label,title_str,ylabel_str,ylimval,positionval)
print(gcf,[pathsave,'FIG6F.pdf'],'-dpdf','-bestfit')
close gcf
%%
% Supplementary Fig 2
num_exp = numel(data.Synergy_ICI200nM_17day_pro.data);
num_sim = size(synergy,1);

Synergy_ICI200nM = [data.Synergy_ICI200nM_17day_pro.data;synergy(:,1)];
Synergy_palbo50nM = [data.Synergy_palbo50nM_17day_pro.data;synergy(:,2)];
Synergy_palbo100nM = [data.Synergy_palbo100nM_17day_pro.data;synergy(:,3)];
Synergy_palbo300nM = [data.Synergy_palbo300nM_17day_pro.data;synergy(:,4)];
Synergy = [Synergy_ICI200nM,Synergy_palbo50nM,Synergy_palbo100nM,Synergy_palbo300nM];

group = cat(1, repmat("exp", num_exp,1), repmat("sim", num_sim,1));
groups = repmat(group,1,size(Synergy,2));
var = cat(1,"ICI200nM","ICI200nM+palbo50nM","ICI200nM+palbo100nM","ICI200nM+palbo300nM");
vars = repmat(categorical(var),1,size(groups,1)).';
vars = categorical(vars(:),["ICI200nM","ICI200nM+palbo50nM","ICI200nM+palbo100nM","ICI200nM+palbo300nM"]);
boxchart(vars,Synergy(:),'GroupByColor',groups(:))
legend("Exp","Sim",'box','off')
ylabel('Normalized cell number')
title('Supplementary Figure 2')
set(gca,'fontsize',20,'linewidth',2);
set(gcf,'position',[1368,230,950,766])
print(gcf,[pathsave,'SUPPFIG2.pdf'],'-dpdf','-bestfit')
close gcf
%% Proliferation
close all
position = [1348,485,786,618];
% (1)E2(10nM), Supplementary Fig 1A
ylimval = [-.1,140];
xlimval = [-.2,28.5];
xtickdata = {'0','1','3','6','7','11','14','21','28'};
color = [0.9290, 0.6940, 0.1250];
titlename = 'E2(10nM), SUPPFIG1A';
timepro = [0,1,3,6,7,11,14,21,28];
figure;hold on
h = child_plotpro(timepro,...
                  [data.E210nM_pro.mean(1:5),data.E210nM_day11_pro.mean,data.E210nM_pro.mean(6:end)],...
                  [data.E210nM_pro.std(1:5),data.E210nM_day11_pro.std,data.E210nM_pro.std(6:end)],...
                  tE2,...
                  cellnumE2,...
                  titlename,xlimval,ylimval,xtickdata,color);
legend([h{2},h{1}.mainLine],{'Experiment','Calibrated simulation'},'box','off','location','SE')
set(gcf,'position',position)
print(gcf,[pathsave,'SUPPFIG1A.pdf'],'-dpdf','-bestfit')
close gcf
% (2)E2(10nM)+ICI(500nM), Supplementary Fig 1B
ylimval = [-.1,40];
xtickdata = {'0','1','3','6','7','14','21','28'};
timepro = [0,1,3,6,7,14,21,28];
titlename = 'E2+ICI(500nM), SUPPFIG1B';
figure;hold on
h = child_plotpro(timepro,...
                  data.E210nM_ICI500nM_pro.mean,...
                  data.E210nM_ICI500nM_pro.std,...
                  tICI500nM,...
                  cellnumICI500nM,...
                  titlename,xlimval,ylimval,xtickdata,color);
legend([h{2},h{1}.mainLine],{'Experiment','Calibrated simulation'},'box','off','location','NW')
set(gcf,'position',position)
print(gcf,[pathsave,'SUPPFIG1B.pdf'],'-dpdf','-bestfit')
close gcf
% (3)E2(10nM)+palbo(500nM), Supplementary Fig 1C
ylimval = [-.1,40];
titlename = 'E2+palbo(500nM), SUPPFIG1C';
figure;hold on
h = child_plotpro(timepro,...
                  data.E210nM_palbo500nM_pro.mean,...
                  data.E210nM_palbo500nM_pro.std,...
                  tpalbo500nM,...
                  cellnumpalbo500nM,...
                  titlename,xlimval,ylimval,xtickdata,color);
legend([h{2},h{1}.mainLine],{'Experiment','Calibrated simulation'},'box','off','location','NW')
set(gcf,'position',position)
print(gcf,[pathsave,'SUPPFIG1C.pdf'],'-dpdf','-bestfit')
close gcf
% (4)E2(10nM)+palbo(1uM), Supplementary Fig 1D
titlename = 'E2+palbo(1uM), SUPPFIG1D';
figure;hold on
h = child_plotpro(timepro,...
                  data.E210nM_palbo1uM_pro.mean,...
                  data.E210nM_palbo1uM_pro.std,...
                  tpalbo1uM,...
                  cellnumpalbo1uM,...                  
                  titlename,xlimval,ylimval,xtickdata,color);
legend([h{2},h{1}.mainLine],{'Experiment','Calibrated simulation'},'box','off','location','NW')
set(gcf,'position',position)
print(gcf,[pathsave,'SUPPFIG1D.pdf'],'-dpdf','-bestfit')
close gcf
% (10)E2(10nM)+AZD(250nM), Fig.5E
ylimval = [-.1,80];
titlename = 'E2+AZD(100nM), FIG5E';
xtickdata = {'0',28'};
timepro = [0,28];
figure;hold on
h = child_plotpro(timepro,...
                  data.E210nM_AZD250nM_pro.mean,...
                  data.E210nM_AZD250nM_pro.std,...
                  tAZD,...
                  cellnumAZD,... 
                  titlename,xlimval,ylimval,xtickdata,color);
legend([h{2},h{1}.mainLine],{'Experiment','Calibrated simulation'},'box','off','location','NW')
set(gcf,'position',position)
print(gcf,[pathsave,'FIG5E.pdf'],'-dpdf','-bestfit')
close gcf
% (11)E2(10nM)+ICI(750nM)+AZD(250nM), Fig.5F
ylimval = [-.1,10];
titlename = 'E2+ICI(750nM)+palbo(100nM), FIG5F';
figure;hold on
h = child_plotpro(timepro,...
                  data.E210nM_AZD250nMICI750nM_pro.mean,...
                  data.E210nM_AZD250nMICI750nM_pro.std,...
                  tICIAZD,...
                  cellnumICIAZD,... 
                  titlename,xlimval,ylimval,xtickdata,color);
legend([h{2},h{1}.mainLine],{'Experiment','Calibrated simulation'},'box','off','location','NW')
set(gcf,'position',position)
print(gcf,[pathsave,'FIG5F.pdf'],'-dpdf','-bestfit')
close gcf

% Alternating treatment over 12 months
% E2(10nM)+palbo(750nM) mono, Fig.5A
ylimval = [-.1,180];
xlimval = [-.2,360];
Alter_t = [0,28:28:12*28];
xtickdata = {'0','1','2','3','4','5','6','7','8','9','10','11','12'};
titlename = 'E2(10nM)+palbo(750nM) 12m, Fig5A';
figure;hold on
color = ["m","m"];
h = child_plotalterpro(Alter_t,...
                       data.Long12month.palbo750nM_Mono.mean,...
                       data.Long12month.palbo750nM_Mono.std,...
                       cellnumpalbo750nM_12m,...
                       titlename,xlimval,ylimval,xtickdata,color);
legend([h{1},h{3}],{'Experiment palbo(750nM)','sim palbo(750nM)'},'box','off','location','NW')
set(gcf,'position',position)
print(gcf,[pathsave,'FIG5A.pdf'],'-dpdf','-bestfit')
close gcf
% E2(10nM)+ICI(750nM) mono, Fig.5B
ylimval = [-.1,120];
titlename = 'E2(10nM)+ICI(750nM) 12m, Fig5B';
figure;hold on
color = ["k","k"];
h = child_plotalterpro(Alter_t,...
                       data.Long12month.ICI750nM_Mono.mean,...
                       data.Long12month.ICI750nM_Mono.std,...
                       cellnumICI750nM_12m,...
                       titlename,xlimval,ylimval,xtickdata,color);
legend([h{1},h{3}],{'Experiment palbo(750nM)','sim palbo(750nM)'},'box','off','location','NW')
set(gcf,'position',position)
print(gcf,[pathsave,'FIG5B.pdf'],'-dpdf','-bestfit')
close gcf
% Alter: E2(10nM)+palbo(750nM) -> E2(10nM)+ICI(750nM), Fig.5C
titlename = 'palbo(750nM)->ICI(750nM) 12m, Fig5C';
figure;hold on
color = ["m","k"];
h = child_plotalterpro(Alter_t,...
                       data.Long12month.Alter_palbo750nM_ICI750nM.mean,...
                       data.Long12month.Alter_palbo750nM_ICI750nM.std,...
                       cellnumAlter_palbo_ICI,...
                       titlename,xlimval,ylimval,xtickdata,color);
legend([h{1},h{2},h{3},h{4}],{'Experiment palbo(750nM)','Experiment ICI(750nM)',...
                    'sim palbo(750nM)','sim ICI(750nM)'},'box','off','location','NW')
set(gcf,'position',position)
print(gcf,[pathsave,'FIG5C.pdf'],'-dpdf','-bestfit')
close gcf
% Alternating: E2(10nM)+palbo(750nM) -> E2(10nM)+ICI(750nM)+AZD(250nM),
% Fig.5D
ylimval = [-.1,30];
titlename = 'palbo(750nM)->ICI(750nM)+AZD(250nM) 12m, Fig5D';
figure;hold on
color = ["m","g"];
h = child_plotalterpro(Alter_t,...
                       data.Long12month.Alter_palbo750nM_ICI750nMAZD250nM.mean,...
                       data.Long12month.Alter_palbo750nM_ICI750nMAZD250nM.std,...
                       cellnumAlter_palbo_ICIAZD   ,...
                       titlename,xlimval,ylimval,xtickdata,color);
legend([h{1},h{2},h{3},h{4}],{'Experiment palbo(750nM)','Experiment ICI(750nM)+AZD(250nM)',...
                    'sim palbo(750nM)','sim ICI(750nM)+AZD(250nM'},'box','off','location','NW')
set(gcf,'position',position)
print(gcf,[pathsave,'FIG5D.pdf'],'-dpdf','-bestfit')
close gcf
% Cdk6 12m, E2(10nM)+palbo(750nM) and E2(10nM)+ICI(750nM) Fig.6A 
ylimval = [0,8];
xtickdata = {'0','1','2','3','4','5','6','7','8','9','10','11','12'};
timepro = Alter_t;
color = "m";
titlename = 'Cdk6, FIG6A';
figure;hold on
h_palbo = child_plotpro(timepro,...
                        nan,...
                        nan,...
                        cdk6palbo750nM_12m(:,1),...
                        cdk6palbo750nM_12m,...
                        titlename,xlimval,ylimval,xtickdata,color);

color = "k";
h_ICI = child_plotpro(timepro,...
                        nan,...
                        nan,...
                        cdk6ICI750nM_12m(:,1),...
                        cdk6ICI750nM_12m,...
                        titlename,xlimval,ylimval,xtickdata,color);
legend([h_palbo.mainLine, h_ICI.mainLine],{'palbo(750nM)','ICI(750nM)'},'box','off','location','NW')
set(gcf,'position',position)
print(gcf,[pathsave,'FIG6A.pdf'],'-dpdf','-bestfit')
close gcf
% CyclinE1 12m, E2(10nM)+palbo(750nM) and E2(10nM)+ICI(750nM), Fig.6B
ylimval = [0,3];
color = "m";
titlename = 'CyclinE1, FIG6B';
figure;hold on
h_palbo = child_plotpro(timepro,...
                        nan,...
                        nan,...
                        cylinE1palbo750nM_12m(:,1),...
                        cylinE1palbo750nM_12m,...
                        titlename,xlimval,ylimval,xtickdata,color);

color = "k";
h_ICI = child_plotpro(timepro,...
                      nan,...
                      nan,...
                      cylinE1ICI750nM_12m(:,1),...
                      cylinE1ICI750nM_12m,...
                      titlename,xlimval,ylimval,xtickdata,color);
legend([h_palbo.mainLine,h_ICI.mainLine],{'palbo(750nM)','ICI(750nM)'},'box','off','location','NW')
set(gcf,'position',position)
print(gcf,[pathsave,'FIG6B.pdf'],'-dpdf','-bestfit')
close gcf
% Cdk6 12m, E2(10nM)+palbo(750nM)-—>E2(10nM)+ICI(750nM) and 
% E2(10nM)+palbo(750nM)-—>E2(10nM)+ICI(750nM)+AZD(250nM) Fig.6C
titlename = 'Cdk6 12m alter, Fig6C';
ylimval = [0,6];
figure;hold on
color = ["m","k"];
h_palbo_ICI = child_plotalterpro(Alter_t,...
                                 nan,...
                                 nan,...
                                 cdk6Alter_palbo_ICI,...
                                 titlename,xlimval,ylimval,xtickdata,color);
color = ["#FF8800","g"];
h_palbo_ICIAZD = child_plotalterpro(Alter_t,...
                                    nan,...
                                    nan,...
                                    cdk6Alter_palbo_ICIAZD,...
                                    titlename,xlimval,ylimval,xtickdata,color);
legend([h_palbo_ICI{3},h_palbo_ICI{4},h_palbo_ICIAZD{3},h_palbo_ICIAZD{4}],....
       {'Alter palbo->ICI: palbo(750nM)',...
       'Alter palbo->ICI: ICI(750nM)',...
       'Alter palbo->ICI+AZD: palbo(750nM)',...
       'Alter palbo->ICI+AZD: ICI(750nM)+AZD(250nM)'},'box','off','location','NW')
set(gcf,'position',position)
print(gcf,[pathsave,'FIG6C.pdf'],'-dpdf','-bestfit')
close gcf
% CyclinE1 12m, E2(10nM)+palbo(750nM)-—>E2(10nM)+ICI(750nM) and 
% E2(10nM)+palbo(750nM)-—>E2(10nM)+ICI(750nM)+AZD(250nM) Fig.6D
titlename = 'CyclinE1 12m alter, Fig6D';
ylimval = [0,3];
figure;hold on
color = ["m","k"];
h_palbo_ICI = child_plotalterpro(Alter_t,...
                                 nan,...
                                 nan,...
                                 cyclinE1Alter_palbo_ICI,...
                                 titlename,xlimval,ylimval,xtickdata,color);
color = ["#FF8800","g"];
h_palbo_ICIAZD = child_plotalterpro(Alter_t,...
                                    nan,...
                                    nan,...
                                    cyclinE1Alter_palbo_ICIAZD,...
                                    titlename,xlimval,ylimval,xtickdata,color);
legend([h_palbo_ICI{3},h_palbo_ICI{4},h_palbo_ICIAZD{3},h_palbo_ICIAZD{4}],....
       {'Alter palbo->ICI: palbo(750nM)',...
       'Alter palbo->ICI: ICI(750nM)',...
       'Alter palbo->ICI+AZD: palbo(750nM)',...
       'Alter palbo->ICI+AZD: ICI(750nM)+AZD(250nM)'},'box','off','location','NW')
set(gcf,'position',position)
print(gcf,[pathsave,'FIG6D.pdf'],'-dpdf','-bestfit')
close gcf
%% Prediction
% cellnumAlter_minAZD_2treat
Num_eachmonth = 3;
ylimval = [-.1,20];
titlename = 'Cellnum minAZD 2treatment, Fig.7A';
Num_totalmonth = size(cellnumAlter_minAZD_2treat,2)/Num_eachmonth;
xlimval = [-.2,Num_totalmonth * args.daypermonth + 10];
treat_minAZD_2treat = [0,treat_minAZD_2treat];
h = cell(1,Num_totalmonth);
figure;hold on
for i = 1:numel(treat_minAZD_2treat)
    timepro = ([0, 1] + i - 1);
    xtickdata = string(timepro);
    timepro = timepro * args.daypermonth;
    i_t = (0:Num_hours*args.daypermonth) + (Num_hours*args.daypermonth) * (i-1);
    i_cellnum = cellnumAlter_minAZD_2treat(2:end,(1:Num_eachmonth)+(i-1)*Num_eachmonth);
    i_cellnum = [i_t',i_cellnum];
    if treat_minAZD_2treat(i) == 0
        color = 'm';
    elseif treat_minAZD_2treat(i) == 1
        color = 'g';
    end
    h{i} = child_plotpro(timepro,...
                         nan,...
                         nan,...
                         i_t,...
                         i_cellnum,...
                         titlename,xlimval,ylimval,xtickdata,color);   
end
timepro = (0:Num_totalmonth) * args.daypermonth;
xticklabeldata = string((0:Num_totalmonth));
set(gca,'fontsize',20,'linewidth',2,'xtick',timepro,'xticklabel',xticklabeldata);
xlabel('Time (m)');
legend([h{1}.mainLine,h{4}.mainLine],{'palbo(750nM)','ICI(750nM)+AZD(250nM)'},'box','off','location','NE')
set(gcf,'position',[826,381,1113,769]);
print(gcf,[pathsave,'FIG7A.pdf'],'-dpdf','-bestfit')
close gcf
% cdk6_minAZD_2treat
ylimval = [-.1,3];
titlename = 'Cdk6 minAZD 2treatment, Fig.7B';
figure;hold on
for i = 1:numel(treat_minAZD_2treat)
    timepro = ([0, 1] + i - 1);
    xtickdata = string(timepro);
    timepro = timepro * args.daypermonth;
    i_t = (0:Num_hours*args.daypermonth) + (Num_hours*args.daypermonth) * (i-1);
    i_cdk6 = cdk6_minAZD_2treat(2:end,(1:Num_eachmonth)+(i-1)*Num_eachmonth);
    i_cdk6 = [i_t',i_cdk6];
    if treat_minAZD_2treat(i) == 0
        color = 'm';
    elseif treat_minAZD_2treat(i) == 1
        color = 'g';
    end
    h{i} = child_plotpro(timepro,...
                         nan,...
                         nan,...
                         i_t,...
                         i_cdk6,...
                         titlename,xlimval,ylimval,xtickdata,color);   
end
timepro = (0:Num_totalmonth) * args.daypermonth;
xticklabeldata = string((0:Num_totalmonth));
set(gca,'fontsize',20,'linewidth',2,'xtick',timepro,'xticklabel',xticklabeldata);
xlabel('Time (m)');
legend([h{1}.mainLine,h{4}.mainLine],{'palbo(750nM)','ICI(750nM)+AZD(250nM)'},'box','off','location','NE')
set(gcf,'position',[826,381,1113,769]);
print(gcf,[pathsave,'FIG7B.pdf'],'-dpdf','-bestfit')
close gcf
% cyclinE1_minAZD_2treat
ylimval = [-.1,3];
titlename = 'CyclinE1 minAZD 2treatment, Fig.7C';
figure;hold on
for i = 1:numel(treat_minAZD_2treat)
    timepro = ([0, 1] + i - 1);
    xtickdata = string(timepro);
    timepro = timepro * args.daypermonth;
    i_t = (0:Num_hours*args.daypermonth) + (Num_hours*args.daypermonth) * (i-1);
    i_cyclinE1 = cyclinE1_minAZD_2treat(2:end,(1:Num_eachmonth)+(i-1)*Num_eachmonth);
    i_cyclinE1 = [i_t',i_cyclinE1];
    if treat_minAZD_2treat(i) == 0
        color = 'm';
    elseif treat_minAZD_2treat(i) == 1
        color = 'g';
    end
    h{i} = child_plotpro(timepro,...
                         nan,...
                         nan,...
                         i_t,...
                         i_cyclinE1,...
                         titlename,xlimval,ylimval,xtickdata,color);   
end
timepro = (0:Num_totalmonth) * args.daypermonth;
xticklabeldata = string((0:Num_totalmonth));
set(gca,'fontsize',20,'linewidth',2,'xtick',timepro,'xticklabel',xticklabeldata);
xlabel('Time (m)');
legend([h{1}.mainLine,h{4}.mainLine],{'palbo(750nM)','ICI(750nM)+AZD(250nM)'},'box','off','location','NE')
set(gcf,'position',[826,381,1113,769]);
print(gcf,[pathsave,'FIG7C.pdf'],'-dpdf','-bestfit')
close gcf
% cellnumAlter_minAZD_3treat
Num_eachmonth = 3;
ylimval = [-.1,22];
titlename = 'Cellnum minAZD 3treatment, Fig.7D';
Num_totalmonth = size(cellnumAlter_minAZD_3treat,2)/Num_eachmonth;
treat_minAZD_3treat = [0,treat_minAZD_3treat];
h = cell(1,Num_totalmonth);
figure;hold on
for i = 1:numel(treat_minAZD_3treat)
    timepro = ([0, 1] + i - 1);
    xtickdata = string(timepro);
    timepro = timepro * args.daypermonth;
    i_t = (0:Num_hours*args.daypermonth) + (Num_hours*args.daypermonth) * (i-1);
    i_cellnum = cellnumAlter_minAZD_3treat(2:end,(1:Num_eachmonth)+(i-1)*Num_eachmonth);
    i_cellnum = [i_t',i_cellnum];
    if treat_minAZD_3treat(i) == 0
        color = 'm';
    elseif treat_minAZD_3treat(i) == 1
        color = 'k';
    elseif treat_minAZD_3treat(i) == 2
        color = 'g';
    end
    h{i} = child_plotpro(timepro,...
                         nan,...
                         nan,...
                         i_t,...
                         i_cellnum,...
                         titlename,xlimval,ylimval,xtickdata,color);   
end
timepro = (0:Num_totalmonth) * args.daypermonth;
xticklabeldata = string((0:Num_totalmonth));
set(gca,'fontsize',20,'linewidth',2,'xtick',timepro,'xticklabel',xticklabeldata);
xlabel('Time (m)');
legend([h{1}.mainLine,h{4}.mainLine,h{7}.mainLine],...
      {'palbo(750nM)','ICI(750nM)','ICI(750nM)+AZD(250nM)'},'box','off','location','NE')
set(gcf,'position',[826,381,1113,769]);
print(gcf,[pathsave,'FIG7D.pdf'],'-dpdf','-bestfit')
close gcf
% cdk6_minAZD_3treat
ylimval = [-.1,4];
titlename = 'Cdk6 minAZD 3treatment, Fig.7E';
figure;hold on
for i = 1:numel(treat_minAZD_3treat)
    timepro = ([0, 1] + i - 1);
    xtickdata = string(timepro);
    timepro = timepro * args.daypermonth;
    i_t = (0:Num_hours*args.daypermonth) + (Num_hours*args.daypermonth) * (i-1);
    i_cdk6 = cdk6_minAZD_3treat(2:end,(1:Num_eachmonth)+(i-1)*Num_eachmonth);
    i_cdk6 = [i_t',i_cdk6];
    if treat_minAZD_3treat(i) == 0
        color = 'm';
    elseif treat_minAZD_3treat(i) == 1
        color = 'k';
    elseif treat_minAZD_3treat(i) == 2
        color = 'g';
    end
    h{i} = child_plotpro(timepro,...
                         nan,...
                         nan,...
                         i_t,...
                         i_cdk6,...
                         titlename,xlimval,ylimval,xtickdata,color);   
end
timepro = (0:Num_totalmonth) * args.daypermonth;
xticklabeldata = string((0:Num_totalmonth));
set(gca,'fontsize',20,'linewidth',2,'xtick',timepro,'xticklabel',xticklabeldata);
xlabel('Time (m)');
legend([h{1}.mainLine,h{4}.mainLine,h{7}.mainLine],...
      {'palbo(750nM)','ICI(750nM)','ICI(750nM)+AZD(250nM)'},'box','off','location','SE');
set(gcf,'position',[826,381,1113,769]);
print(gcf,[pathsave,'FIG7E.pdf'],'-dpdf','-bestfit')
close gcf
% cyclinE1_minAZD_3treat
ylimval = [-.1,3];
titlename = 'CyclinE1 minAZD 3treatment, Fig.7F';
figure;hold on
for i = 1:numel(treat_minAZD_3treat)
    timepro = ([0, 1] + i - 1);
    xtickdata = string(timepro);
    timepro = timepro * args.daypermonth;
    i_t = (0:Num_hours*args.daypermonth) + (Num_hours*args.daypermonth) * (i-1);
    i_cyclinE1 = cyclinE1_minAZD_3treat(2:end,(1:Num_eachmonth)+(i-1)*Num_eachmonth);
    i_cyclinE1 = [i_t',i_cyclinE1];
    if treat_minAZD_3treat(i) == 0
        color = 'm';
    elseif treat_minAZD_3treat(i) == 1
        color = 'k';
    elseif treat_minAZD_3treat(i) == 2
        color = 'g';
    end
    h{i} = child_plotpro(timepro,...
                         nan,...
                         nan,...
                         i_t,...
                         i_cyclinE1,...
                         titlename,xlimval,ylimval,xtickdata,color);   
end
timepro = (0:Num_totalmonth) * args.daypermonth;
xticklabeldata = string((0:Num_totalmonth));
set(gca,'fontsize',20,'linewidth',2,'xtick',timepro,'xticklabel',xticklabeldata);
xlabel('Time (m)');
legend([h{1}.mainLine,h{4}.mainLine,h{7}.mainLine],...
      {'palbo(750nM)','ICI(750nM)','ICI(750nM)+AZD(250nM)'},'box','off','location','NE');
set(gcf,'position',[826,381,1113,769]);
print(gcf,[pathsave,'FIG7F.pdf'],'-dpdf','-bestfit')
close gcf
end


function h = child_plotpro(ttimedata,expmean,expsem,cohort_t,cohort_x,...
                           titlename,xlimval,ylimval,xticklabeldata,color,varargin)
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
pos = find(cohort_t/24 >= expt(end),1,'first');

data1_low = cohort_x(:,2);
data1_50 = cohort_x(:,4);
data1_high = cohort_x(:,3);
errBar = [(data1_high - data1_50)';(data1_50 - data1_low)'];
h = shadedErrorBar(cohort_t(1:pos)/24,data1_50(1:pos),errBar(:,1:pos),'lineprops',...
                   {color,linsty,'markerfacecolor',color,'linewidth',2});

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

title(titlename);
xlabel('Time (d)');
ylabel('Normalized cell number');
set(gca,'fontsize',20,'linewidth',2,'xtick',ttimedata,'xticklabel',xticklabeldata);
set(gcf,'color','w')
grid on;
box on;
xlim(xlimval);
ylim(ylimval);
end

function h = child_plotalterpro(ttimedata,expmean,expsem,cohort_x,...
                                titlename,xlimval,ylimval,xticklabeldata,color)
if ~isnan(expmean)
    l1 = errorbar(-1,expmean(end),expsem(end),'color',color(1),'linestyle','-.','linewidth',2,'marker','o','CapSize',0);
    l2 = errorbar(-1,expmean(end-1),expsem(end),'color',color(2),'linestyle','-.','linewidth',2,'marker','o','CapSize',0);
else
    l1 = nan;
    l2 = nan;
end
l3 = plot(-2:-1,-2:-1,'color',color(1),'linewidth',2);
l4 = plot(-2:-1,-2:-1,'color',color(2),'linewidth',2);
h = {l1,l2,l3,l4};

time = ttimedata(2):unique(diff(ttimedata)):ttimedata(end);
expmean = expmean(~isnan(expmean));
expsem = expsem(~isnan(expsem));
for i = 1:numel(time)    
    if mod(i,2) == 1
        color_i = color(1);
    else
        color_i = color(2);
    end
    data1_low = cohort_x{i}(:,2);
    data1_50 = cohort_x{i}(:,4);
    data1_high = cohort_x{i}(:,3);

    errBar = [(data1_high - data1_50)';(data1_50 - data1_low)'];
    h1 = shadedErrorBar(cohort_x{i}(:,1)/24,...
                        data1_50,...
                        errBar,...
                        'lineprops',{color_i,'-','markerfacecolor',color_i,'linewidth',2});
    h = [h,h1];
    if ~isnan(expmean)
        plot(ttimedata(i:i+1),[1,expmean(i+1)],'color',color_i,'linestyle','-.','linewidth',2);
    end
    if ~isequal(color{:})
       color_i = setdiff(color,color_i);
    end
    
    if ~isnan(expmean)
        if i ~= 1
            errorbar(ttimedata(i),expmean(i),expsem(i),'color',color_i,'marker','o','CapSize',0,'linewidth',2);
        end
    end
end
if ~isequal(color{:})
    color_i = setdiff(color,color_i);
end
if ~isnan(expmean)
    errorbar(ttimedata(end),expmean(end),expsem(end),'color',color_i,'marker','o','linewidth',2','CapSize',0);
end
title(titlename);
xlabel('Time (m)')
ylabel('Normalized cell number')
set(gca,'fontsize',20,'linewidth',2,'xtick',ttimedata,'xticklabel',xticklabeldata);
set(gcf,'color','w')
grid on;
box on;
xlim(xlimval);
ylim(ylimval);
end

function data = child_checkload(filename,functionname)
    if ~isfile(filename)
        message = "File " + filename + " is missing. Please run " + functionname + " frist.";
        error(message)
    else
        data = readmatrix(filename);
    end
end

function [cellnumAlter,cdk6Alter,cyclinE1Alter] = child_seg(pro,cdk6,cyclinE1,Num_month,Num_hours,args)
    cellnumAlter = cell(1,Num_month);
    cdk6Alter = cell(1,Num_month);
    cyclinE1Alter = cell(1,Num_month);
    for i = 1:Num_month
        t_sel = (i-1)*Num_hours*args.daypermonth:i*Num_hours*args.daypermonth;
        pos = ismember(pro(:,1),t_sel);
        i_cellnumAlter = pro(pos,1:end);
        i_cdk6 = cdk6(pos,1:end);
        i_cyclinE1 = cyclinE1(pos,1:end);
        % The cut may not be exact, adjust by moving one timestep forward or backward.
        while i_cellnumAlter(1,end) > 1.1
            i_cellnumAlter = i_cellnumAlter(2:end,:);
            i_cdk6 = i_cdk6(2:end,:);
            i_cyclinE1 = i_cyclinE1(2:end,:);
        end
        if i ~= 1
            i_cyclinE1(1,2:end) = cyclinE1Alter{i-1}(end,2:end);
        end
        cellnumAlter{i} = i_cellnumAlter;
        cdk6Alter{i} = i_cdk6;
        cyclinE1Alter{i} = i_cyclinE1;
        % fprintf('%.4f ', i_cellnumAlter(1,2:end));
        % disp(' ');
        % fprintf('%.4f ', i_cellnumAlter(end,2:end));
        % disp(' ');
    end
end