function E2ICIpalboAZD_33_simplotcheck()
% This function plots the dynamics of certain compounds in the model for inspection.

% Plot different compounds in the model.
data = E2ICIpalboAZD_12_loaddata();
args = E2ICIpalboAZD_05_modelpar();

% initial value of variables
x0 = zeros(args.Numvariable,1);
x0(args.E2mediaindex) = args.ValE2normal;
x0 = E2ICIpalboAZD_21_replating(x0,args);

tspan = [0,24 * 30];
[t,~,xinitial] = E2ICIpalboAZD_29_sim(x0,tspan,args.treat_non,args);

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
x0 = E2ICIpalboAZD_21_replating(x0,args);
[tE2,simE2,~] = E2ICIpalboAZD_29_sim(x0,tspan,args.treat_non,args);
%% (2)E2(10nM)+ICI(500nM)
[tICI500nM,simICI500nM,~] = E2ICIpalboAZD_29_sim(x0,tspan,args.treat_ICI500nM,args);
%% (6)E2(10nM)+palbo(500nM)
[tpalbo500nM,simpalbo500nM,~] = E2ICIpalboAZD_29_sim(x0,tspan,args.treat_palbo500nM,args);
%% (7)E2(10nM)+palbo(1uM)
[tpalbo1uM,simpalbo1uM,~] = E2ICIpalboAZD_29_sim(x0,tspan,args.treat_palbo1uM,args);
%% (8)Alternating treatment over 12 months
x0 = xinitial(end,:);
x0(args.ind_reset) = 0;
x0 = E2ICIpalboAZD_21_replating(x0,args);
Num_month = 13;
tspan = [0, 28 * 24 * Num_month];
x0(args.E2mediaindex) = xinitial(args.E2mediaindex);

% E2(10nM)+palbo(750nM) mono
treatalter = cell(1,Num_month);
for i = 1: Num_month
    treatalter{i}.treat = args.treat_palbo750nM;
    treatalter{i}.duration = args.daypermonth;
end
cycletime = sum(cell2mat(cellfun(@(x) x.duration,treatalter,'UniformOutput',false)));
cycletime = cycletime * 24;
replate = true;
[tpalbo750nM_13m,simpalbo750nM_13m,xpalbo750nM_13m] =...
    E2ICIpalboAZD_31_simalternation(x0,tspan,treatalter,cycletime,replate,args);
clearvars treatalter

% E2(10nM)+ICI(750nM) mono
for i = 1: Num_month
    treatalter{i}.treat = args.treat_ICI750nM;
    treatalter{i}.duration = args.daypermonth;
end
[tICI750nM_13m,simICI750nM_13m,xICI750nM_13m] =...
    E2ICIpalboAZD_31_simalternation(x0,tspan,treatalter,cycletime,replate,args);

% Alternating: E2(10nM)+palbo(750nM) -> E2(10nM)+ICI(750nM)
for i = 1: Num_month
    if mod(i,2) == 1
        treatalter{i}.treat = args.treat_palbo750nM;
    else
        treatalter{i}.treat = args.treat_ICI750nM;
    end
    treatalter{i}.duration = args.daypermonth;
end
[tAlter_palbo750nM_ICI750nM_13m,simAlter_palbo750nM_ICI750nM_13m,xAlter_palbo750nM_ICI750nM_13m] =...
    E2ICIpalboAZD_31_simalternation(x0,tspan,treatalter,cycletime,replate,args);

% Alternating: E2(10nM)+palbo(750nM) -> E2(10nM)+ICI(750nM)+AZD(250nM)
for i = 1: Num_month
    if mod(i,2) == 1
        treatalter{i}.treat = args.treat_palbo750nM;
    else
        treatalter{i}.treat = args.treat_ICI750nM_AZD250nM;
    end
    treatalter{i}.duration = args.daypermonth;
end
[tAlter_palbo750nM_ICI750nMAZD250nM_13m,simAlter_palbo750nM_ICI750nMAZD250nM_13m,...
    xAlter_palbo750nM_ICI750nMAZD250nM_13m] =...
    E2ICIpalboAZD_31_simalternation(x0,tspan,treatalter,cycletime,replate,args);

close all
width = 0.04;
length = 0.04;
fontsize = 13;
nrow = 3;
ncol = 4;

% plot E2ER
n = 1;
subplot_tight(nrow,ncol,n,[length width]);hold on
ind = 4;
title_str = 'E2ER';
l0 = plot(tpalbo750nM_13m/24,sum(x0(ind))*ones(1,numel(tpalbo750nM_13m)),'--c','linewidth',2);
l1 = plot(tpalbo750nM_13m/24, sum(xpalbo750nM_13m(:,ind),2),'k','linewidth',2);
l2 = plot(tICI750nM_13m/24, sum(xICI750nM_13m(:,ind),2),'b','linewidth',2);
l3 = plot(tAlter_palbo750nM_ICI750nM_13m/24, sum(xAlter_palbo750nM_ICI750nM_13m(:,ind),2),'r','linewidth',2);
% l4 = plot(tAlter_palbo750nM_ICI750nMAZD250nM_13m/24, sum(xAlter_palbo750nM_ICI750nMAZD250nM_13m(:,ind),2),'g');
legend([l0,l1,l2,l3],{'t0','palbo','ICI','palbo->ICI'},'box','off','location','NW');
title(title_str);
set(gca,'Fontsize',fontsize,'linewidth',2);
grid on

% plot cyclinD1cdk6
n = 2;
subplot_tight(nrow,ncol,n,[length width]);hold on
ind = args.ind_containcyclinD1cdk6;
title_str = 'cyclinD1cdk6';
plot(tpalbo750nM_13m/24,sum(x0(ind))*ones(1,numel(tpalbo750nM_13m)),'--c','linewidth',2);
plot(tpalbo750nM_13m/24, sum(xpalbo750nM_13m(:,ind),2),'k','linewidth',2);
plot(tICI750nM_13m/24, sum(xICI750nM_13m(:,ind),2),'b','linewidth',2);
plot(tAlter_palbo750nM_ICI750nM_13m/24, sum(xAlter_palbo750nM_ICI750nM_13m(:,ind),2),'r','linewidth',2);
% l4 = plot(tAlter_palbo750nM_ICI750nMAZD250nM_13m/24, sum(xAlter_palbo750nM_ICI750nMAZD250nM_13m(:,ind),2),'g');
% legend([l0,l1,l2,l3],{'t0','palbo','ICI','palbo->ICI'},'box','off','location','NW');
title(title_str);
set(gca,'Fontsize',fontsize,'linewidth',2);
grid on

% plot cyclinD1cdk4
n = 3;
subplot_tight(nrow,ncol,n,[length width]);hold on
ind = args.ind_containcyclinD1cdk4;
title_str = 'cyclinD1dk4';
plot(tpalbo750nM_13m/24,sum(x0(ind))*ones(1,numel(tpalbo750nM_13m)),'--c','linewidth',2);
plot(tpalbo750nM_13m/24, sum(xpalbo750nM_13m(:,ind),2),'k','linewidth',2);
plot(tICI750nM_13m/24, sum(xICI750nM_13m(:,ind),2),'b','linewidth',2);
plot(tAlter_palbo750nM_ICI750nM_13m/24, sum(xAlter_palbo750nM_ICI750nM_13m(:,ind),2),'r','linewidth',2);
% l4 = plot(tAlter_palbo750nM_ICI750nMAZD250nM_13m/24, sum(xAlter_palbo750nM_ICI750nMAZD250nM_13m(:,ind),2),'g');
% legend([l0,l1,l2,l3],{'t0','palbo','ICI','palbo->ICI'},'box','off','location','NE');
title(title_str);
set(gca,'Fontsize',fontsize,'linewidth',2);
grid on

% plot res_cdk6ICI
n = 4;
subplot_tight(nrow,ncol,n,[length width]);hold on
ind = 7;
title_str = 'rescdk6ICI';
plot(tpalbo750nM_13m/24,sum(x0(ind))*ones(1,numel(tpalbo750nM_13m)),'--c','linewidth',2);
plot(tpalbo750nM_13m/24, sum(xpalbo750nM_13m(:,ind),2),'k','linewidth',2);
plot(tICI750nM_13m/24, sum(xICI750nM_13m(:,ind),2),'b','linewidth',2);
plot(tAlter_palbo750nM_ICI750nM_13m/24, sum(xAlter_palbo750nM_ICI750nM_13m(:,ind),2),'r','linewidth',2);
% l4 = plot(tAlter_palbo750nM_ICI750nMAZD250nM_13m/24, sum(xAlter_palbo750nM_ICI750nMAZD250nM_13m(:,ind),2),'g');
% legend([l0,l1,l2,l3],{'t0','palbo','ICI','palbo->ICI'},'box','off','location','NE');
title(title_str);
set(gca,'Fontsize',fontsize,'linewidth',2);
grid on

% plot cMyc
n = 5;
subplot_tight(nrow,ncol,n,[length width]);hold on
ind = 19;
title_str = 'cMyc';
plot(tpalbo750nM_13m/24,sum(x0(ind))*ones(1,numel(tpalbo750nM_13m)),'--c','linewidth',2);
plot(tpalbo750nM_13m/24, sum(xpalbo750nM_13m(:,ind),2),'k','linewidth',2);
plot(tICI750nM_13m/24, sum(xICI750nM_13m(:,ind),2),'b','linewidth',2);
plot(tAlter_palbo750nM_ICI750nM_13m/24, sum(xAlter_palbo750nM_ICI750nM_13m(:,ind),2),'r','linewidth',2);
% l4 = plot(tAlter_palbo750nM_ICI750nMAZD250nM_13m/24, sum(xAlter_palbo750nM_ICI750nMAZD250nM_13m(:,ind),2),'g');
legend([l0,l1,l2,l3],{'t0','palbo','ICI','palbo->ICI'},'box','off','location','NW');
title(title_str);
set(gca,'Fontsize',fontsize,'linewidth',2);
grid on

% plot rescyclinE1palbo
n = 6;
subplot_tight(nrow,ncol,n,[length width]);hold on
ind = 6;
title_str = 'rescyclinE1palbo';
plot(tpalbo750nM_13m/24,sum(x0(ind))*ones(1,numel(tpalbo750nM_13m)),'--c','linewidth',2);
plot(tpalbo750nM_13m/24, sum(xpalbo750nM_13m(:,ind),2),'k','linewidth',2);
plot(tICI750nM_13m/24, sum(xICI750nM_13m(:,ind),2),'b','linewidth',2);
plot(tAlter_palbo750nM_ICI750nM_13m/24, sum(xAlter_palbo750nM_ICI750nM_13m(:,ind),2),'r','linewidth',2);
% l4 = plot(tAlter_palbo750nM_ICI750nMAZD250nM_13m/24, sum(xAlter_palbo750nM_ICI750nMAZD250nM_13m(:,ind),2),'g');
% legend([l0,l1,l2,l3],{'t0','palbo','ICI','palbo->ICI'},'box','off','location','NE');
title(title_str);
set(gca,'Fontsize',fontsize,'linewidth',2);
grid on
set(gcf,'Position',[956,335,1450,682],'color','w');

% plot cyclinE1
n = 7;
subplot_tight(nrow,ncol,n,[length width]);hold on
ind = args.ind_containcyclinE1;
title_str = 'cyclinE1';
plot(tpalbo750nM_13m/24,sum(x0(ind))*ones(1,numel(tpalbo750nM_13m)),'--c','linewidth',2);
plot(tpalbo750nM_13m/24, sum(xpalbo750nM_13m(:,ind),2),'k','linewidth',2);
plot(tICI750nM_13m/24, sum(xICI750nM_13m(:,ind),2),'b','linewidth',2);
plot(tAlter_palbo750nM_ICI750nM_13m/24, sum(xAlter_palbo750nM_ICI750nM_13m(:,ind),2),'r','linewidth',2);
% l4 = plot(tAlter_palbo750nM_ICI750nMAZD250nM_13m/24, sum(xAlter_palbo750nM_ICI750nMAZD250nM_13m(:,ind),2),'g');
% legend([l0,l1,l2,l3],{'t0','palbo','ICI','palbo->ICI','palbo->ICIAZD'},'box','off','location','NE');
title(title_str);
set(gca,'Fontsize',fontsize,'linewidth',2);
grid on
set(gcf,'Position',[956,335,1450,682],'color','w');

% plot Rb
n = 8;
subplot_tight(nrow,ncol,n,[length width]);hold on
ind = 22;
title_str = 'Rb';
plot(tpalbo750nM_13m/24,x0(ind)*ones(1,numel(tpalbo750nM_13m)),'--c','linewidth',2);
plot(tpalbo750nM_13m/24, xpalbo750nM_13m(:,ind),'k','linewidth',2);
plot(tICI750nM_13m/24, xICI750nM_13m(:,ind),'b','linewidth',2);
plot(tAlter_palbo750nM_ICI750nM_13m/24, xAlter_palbo750nM_ICI750nM_13m(:,ind),'r','linewidth',2);
% l4 = plot(tAlter_palbo750nM_ICI750nMAZD250nM_13m/24, xAlter_palbo750nM_ICI750nMAZD250nM_13m(:,ind),'g');
% legend([l0,l1,l2,l3,l4],{'t0','palbo','ICI','palbo->ICI','palbo->ICIAZD'})
title(title_str);
set(gca,'Fontsize',fontsize,'linewidth',2);
grid on
set(gcf,'Position',[956,335,1450,682],'color','w');

% plot pRb
n = 9;
subplot_tight(nrow,ncol,n,[length width]);hold on
ind = 23;
title_str = 'pRb';
plot(tpalbo750nM_13m/24,x0(ind)*ones(1,numel(tpalbo750nM_13m)),'--c','linewidth',2);
plot(tpalbo750nM_13m/24, xpalbo750nM_13m(:,ind),'k','linewidth',2);
plot(tICI750nM_13m/24, xICI750nM_13m(:,ind),'b','linewidth',2);
plot(tAlter_palbo750nM_ICI750nM_13m/24, xAlter_palbo750nM_ICI750nM_13m(:,ind),'r','linewidth',2);
% l4 = plot(tAlter_palbo750nM_ICI750nMAZD250nM_13m/24, xAlter_palbo750nM_ICI750nMAZD250nM_13m(:,ind),'g');
% legend([l0,l1,l2,l3,l4],{'t0','palbo','ICI','palbo->ICI','palbo->ICIAZD'})
title(title_str);
set(gca,'Fontsize',fontsize,'linewidth',2);
grid on
set(gcf,'Position',[956,335,1450,682],'color','w');

% plot ppRb
n = 10;
subplot_tight(nrow,ncol,n,[length width]);hold on
ind = args.ind_containppRb;
title_str = 'ppRb';
plot(tpalbo750nM_13m/24,x0(ind)*ones(1,numel(tpalbo750nM_13m)),'--c','linewidth',2);
plot(tpalbo750nM_13m/24, xpalbo750nM_13m(:,ind),'k','linewidth',2);
plot(tICI750nM_13m/24, xICI750nM_13m(:,ind),'b','linewidth',2);
plot(tAlter_palbo750nM_ICI750nM_13m/24, xAlter_palbo750nM_ICI750nM_13m(:,ind),'r','linewidth',2);
% l4 = plot(tAlter_palbo750nM_ICI750nMAZD250nM_13m/24, xAlter_palbo750nM_ICI750nMAZD250nM_13m(:,ind),'g');
% legend([l0,l1,l2,l3,l4],{'t0','palbo','ICI','palbo->ICI','palbo->ICIAZD'})
title(title_str);
set(gca,'Fontsize',fontsize,'linewidth',2);
grid on
set(gcf,'Position',[956,335,1450,682],'color','w');

% pro
n = 11;
subplot_tight(nrow,ncol,n,[length width]);hold on
ind_ppRb = args.ind_containppRb;
ind_cyclinE1 = args.ind_containcyclinE1(1);
title_str = 'pro';
pronotreat = child_prorate(x0(ind_ppRb),x0(ind_cyclinE1),args.PAR);
propalbo750nM = child_prorate(xpalbo750nM_13m(:,ind_ppRb),xpalbo750nM_13m(:,ind_cyclinE1),args.PAR);
proICI750nM = child_prorate(xICI750nM_13m(:,ind_ppRb),xICI750nM_13m(:,ind_cyclinE1),args.PAR);
propalboICI = child_prorate(xAlter_palbo750nM_ICI750nM_13m(:,ind_ppRb),...
                            xAlter_palbo750nM_ICI750nM_13m(:,ind_cyclinE1),args.PAR);
propalboICIAZD = child_prorate(xAlter_palbo750nM_ICI750nMAZD250nM_13m(:,ind_ppRb),...
                               xAlter_palbo750nM_ICI750nMAZD250nM_13m(:,ind_cyclinE1),args.PAR);

plot(tpalbo750nM_13m/24,pronotreat*ones(1,numel(tpalbo750nM_13m)),'--c','linewidth',2);
plot(tpalbo750nM_13m/24, propalbo750nM,'k','linewidth',2);
plot(tICI750nM_13m/24, proICI750nM,'b','linewidth',2);
plot(tAlter_palbo750nM_ICI750nM_13m/24, propalboICI,'r','linewidth',2);
% l4 = plot(tAlter_palbo750nM_ICI750nMAZD250nM_13m/24,propalboICIAZD ,'g');
% legend([l0,l1,l2,l3,l4],{'t0','palbo','ICI','palbo->ICI','palbo->ICIAZD'})
title(title_str);
set(gca,'Fontsize',fontsize,'linewidth',2);
grid on
set(gcf,'Position',[342,244,1370,842],'color','w');

close all
%% (16)Synergy
tspan = [0, 17 * 24];
% E2(10nM)+ICI(200nM)
x0(args.E2mediaindex) = xinitial(args.E2mediaindex);
[tICI200nM_d17,simICI200nM_d17,~] = E2ICIpalboAZD_29_sim(x0,tspan,args.treat_ICI200nM,args);
% E2(10nM)+ICI(200nM)+palbo(50nM)
[tICI200nM_palbo50nM_d17,simICI200nM_palbo50nM_d17,~] = E2ICIpalboAZD_29_sim(x0,tspan,args.treat_ICI200nM_palbo50nM,args);
% E2(10nM)+ICI(200nM)+palbo(100nM)
[tICI200nM_palbo100nM_d17,simICI200nM_palbo100nM_d17,~] = E2ICIpalboAZD_29_sim(x0,tspan,args.treat_ICI200nM_palbo100nM,args);
% E2(10nM)+ICI(200nM)+palbo(300nM)
[tICI200nM_palbo300nM_d17,simICI200nM_palbo300nM_d17,~] = E2ICIpalboAZD_29_sim(x0,tspan,args.treat_ICI200nM_palbo300nM,args);
%% protein data
close all
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

positionval = [153,397,1343,667];

% CyclinE1 plot
CyclinE1_data_mean = data.CyclinE1.mean;
CyclinE1_data_sem = data.CyclinE1.sem;
CyclinE1_time = data.CyclinE1.time;
CyclinE1_sim_mean = [1,cyclinE1_palbo750nM_w1,...
                     cyclinE1_palbo750nM_w2,...
                     cyclinE1_palbo750nM_m12,...
                     cyclinE1_alter_palbo750nM_ICI750nMAZD250nM_m12];
CyclinE1_sim_sem = zeros(1,numel(CyclinE1_sim_mean));
CyclinE1_mean = [CyclinE1_data_mean;CyclinE1_sim_mean]';
CyclinE1_sem = [CyclinE1_data_sem;CyclinE1_sim_sem]';

title_str = 'CyclinE1';
ylabel_str = 'Normalized to T=0';
ylimval = [0,3];
E2ICIpalboAZD_16_barplot(CyclinE1_mean,CyclinE1_sem,CyclinE1_time,title_str,ylabel_str,ylimval,positionval)
xlabel('Time(days)')

% Cdk6 plot
Cdk6_data_mean = data.Cdk6.mean;
Cdk6_data_sem = data.Cdk6.sem;
Cdk6_label = data.Cdk6.time;
Cdk6_sim_mean = [1,cdk6_ICI750nM_w1,...
                 cdk6_ICI750nM_w2,...
                 cdk6_ICI750nM_m12,...
                 cdk6_alter_palbo750nM_ICI750nMAZD250nM_m12];
Cdk6_sim_sem = zeros(1,numel(Cdk6_sim_mean));
Cdk6_mean = [Cdk6_data_mean;Cdk6_sim_mean]';
Cdk6_sem = [Cdk6_data_sem;Cdk6_sim_sem]';

title_str = 'Cdk6';
ylabel_str = 'Normalized to T=0';
ylimval = [0,7];
E2ICIpalboAZD_16_barplot(Cdk6_mean,Cdk6_sem,Cdk6_label,title_str,ylabel_str,ylimval,positionval)
xlabel('Time(days)')
%% Synergy
close all
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

data_mean = [data.Synergy_ICI200nM_17day_pro.mean,...
             data.Synergy_palbo50nM_17day_pro.mean,...
             data.Synergy_palbo100nM_17day_pro.mean,...
             data.Synergy_palbo300nM_17day_pro.mean];
data_std = [data.Synergy_ICI200nM_17day_pro.std,...
            data.Synergy_palbo50nM_17day_pro.std,...
            data.Synergy_palbo100nM_17day_pro.std,...
            data.Synergy_palbo300nM_17day_pro.std];
sim_mean = [simICI200nM_d17,...
            simICI200nM_palbo50nM_d17,...
            simICI200nM_palbo100nM_d17,...
            simICI200nM_palbo300nM_d17];
x = 1:numel(data_mean);

figure;hold on
l1 = errorbar(x, data_mean, data_std, 'color', 'b', 'linewidth', 2);
l2 = plot(x, sim_mean, 'color', 'r', 'linewidth', 2);
xlim([0.4,numel(data_mean)+0.6])
title('Cellnum at 17day')
ylabel('Normalized to T=0')
legend([l1,l2],{'Experiment','Simulation'},'box','off','location','NE');
set(gca,'xtick',x,'xticklabel',{'ICI(200nM)','ICI200nM+palbo(50nM)',...
    'ICI200nM+palbo(100nM)','ICI200nM+palbo300nM)'},'Fontsize',20,'linewidth',2, 'box', 'on')
grid on
set(gcf,'position', [466,456,797,638])
%% Proliferation
close all
prctile50_or_min = []; 
prctile_low = [];
prctile_high = [];
index_mincost = 1;
plottype = 'one';
color = 'b';
FontsizeNum = 12;
width = 0.05;
length = 0.05;
nrow = 2;
ncol = 2;

% (1)E2(10nM)
n = 1;
subplot_tight(nrow,ncol,n,[length width]);hold on
titlename = 'E2(10nM)';
legendloc = 'SE';
ylimval = [-.1,160];
xlimval = [-.2,28.5];
timepoint = [args.timepoint_pro(1:5), 11, args.timepoint_pro(6:end)];
xticklabel = num2cell(timepoint);
expmean = [data.E210nM_pro.mean(1:5),data.E210nM_day11_pro.mean,data.E210nM_pro.mean(6:end)];
expstd = [data.E210nM_pro.std(1:5),data.E210nM_day11_pro.std,data.E210nM_pro.std(6:end)];
E2ICIpalboAZD_28_plotpro(timepoint,expmean,expstd,tE2,simE2(end,:),index_mincost,prctile50_or_min,...
                         prctile_low,prctile_high,titlename,plottype,xlimval,ylimval,xticklabel,color,...
                         [],[],[],FontsizeNum,legendloc);

% (2)E2(10nM)+ICI(500nM)
n = 2;
subplot_tight(nrow,ncol,n,[length width]);hold on
titlename = 'E2(10nM)+ICI(500nM)';
legendloc = 'NW';
ylimval = [-.1,40];
E2ICIpalboAZD_28_plotpro(args.timepoint_pro,data.E210nM_ICI500nM_pro.mean,data.E210nM_ICI500nM_pro.std,...
                         tICI500nM,simICI500nM(end,:),index_mincost,prctile50_or_min,prctile_low,...
                         prctile_high,titlename,plottype,xlimval,ylimval,xticklabel,color,[],[],[],...
                         FontsizeNum,legendloc);

% (3)E2(10nM)+palbo(500nM)
n = 3;
subplot_tight(nrow,ncol,n,[length width]);hold on
titlename = 'E2(10nM)+palbo(500nM)';
legendloc = 'NW';
ylimval = [-.1,40];
E2ICIpalboAZD_28_plotpro(args.timepoint_pro,data.E210nM_palbo500nM_pro.mean,data.E210nM_palbo500nM_pro.std,...
                         tpalbo500nM,simpalbo500nM(end,:), index_mincost,prctile50_or_min,prctile_low,...
                         prctile_high,titlename,plottype,xlimval,ylimval,xticklabel,color,[],[],[],...
                         FontsizeNum,legendloc);

% (4)E2(10nM)+palbo(1uM)
n = 4;
subplot_tight(nrow,ncol,n,[length width]);hold on
titlename = 'E2(10nM)+palbo(1uM)';
legendloc = 'NW';
ylimval = [-.1,10];
E2ICIpalboAZD_28_plotpro(args.timepoint_pro,data.E210nM_palbo1uM_pro.mean,data.E210nM_palbo1uM_pro.std,...
                         tpalbo1uM,simpalbo1uM(end,:), index_mincost,prctile50_or_min,prctile_low,...
                         prctile_high,titlename,plottype,xlimval,ylimval,xticklabel,color,[],[],[],...
                         FontsizeNum,legendloc);
set(gcf,'position', [466,456,797,638])
%% Alternating treatment over 12 months
close all
xlimval = [-5,data.Long12month.time(end)+10];
FontsizeNum = 21;

% E2(10nM)+palbo(750nM) mono
figure;hold on
ylimval = [-1,180];
color = ["m","m"];
titlename = '12 months Palbo mono (750nM)';
replate = true;

E2ICIpalboAZD_27_plotalterpro(data.Long12month.time,...
                              data.Long12month.palbo750nM_Mono.mean,...
                              data.Long12month.palbo750nM_Mono.std,...
                              tpalbo750nM_13m,...
                              simpalbo750nM_13m(end,:),...
                              index_mincost,prctile50_or_min,prctile_low,prctile_high,titlename,...
                              plottype,xlimval,ylimval,...
                              num2cell(data.Long12month.time),...
                              color,FontsizeNum,replate);
set(gcf,'position',[340, 300, 1120, 790])
xlabel('Time(days)')

% E2(10nM)+ICI(750nM) mono
figure;hold on
ylimval = [-1,100];
color = ["k","k"];
titlename = '12 months ICI mono (750nM)';
E2ICIpalboAZD_27_plotalterpro(data.Long12month.time,...
                           data.Long12month.ICI750nM_Mono.mean,...
                           data.Long12month.ICI750nM_Mono.std,...
                           tICI750nM_13m,...
                           simICI750nM_13m(end,:),...
                           index_mincost,prctile50_or_min,prctile_low,prctile_high,titlename,...
                           plottype,xlimval,ylimval,...
                           num2cell(data.Long12month.time),...
                           color,FontsizeNum,replate);
set(gcf,'position',[340, 300, 1120, 790])
xlabel('Time(days)')

% Alternating: E2(10nM)+palbo(750nM) -> E2(10nM)+ICI(750nM)
figure;hold on
ylimval = [-1,150];
color = ["m","k"];
titlename = '12 months alter palbo (750nM) ICI mono (750nM)';
E2ICIpalboAZD_27_plotalterpro(data.Long12month.time,...
                           data.Long12month.Alter_palbo750nM_ICI750nM.mean,...
                           data.Long12month.Alter_palbo750nM_ICI750nM.std,...
                           tAlter_palbo750nM_ICI750nM_13m,...
                           simAlter_palbo750nM_ICI750nM_13m(end,:),...
                           index_mincost,prctile50_or_min,prctile_low,prctile_high,titlename,...
                           plottype,xlimval,ylimval,...
                           num2cell(data.Long12month.time),...
                           color,FontsizeNum,replate);
set(gcf,'position',[340, 300, 1120, 790])
xlabel('Time(days)')

% Alternating: E2(10nM)+palbo(750nM) -> E2(10nM)+ICI(750nM)+AZD(250nM)
figure;hold on
ylimval = [-0.1,15];
color = ["m","g"];
titlename = '12 months alter palbo (750nM) ICI mono (750nM)';
E2ICIpalboAZD_27_plotalterpro(data.Long12month.time,...
                           data.Long12month.Alter_palbo750nM_ICI750nMAZD250nM.mean,...
                           data.Long12month.Alter_palbo750nM_ICI750nMAZD250nM.std,...
                           tAlter_palbo750nM_ICI750nMAZD250nM_13m,...
                           simAlter_palbo750nM_ICI750nMAZD250nM_13m(end,:),...
                           index_mincost,prctile50_or_min,prctile_low,prctile_high,titlename,...
                           plottype,xlimval,ylimval,...
                           num2cell(data.Long12month.time),...
                           color,FontsizeNum,replate);
set(gcf,'position',[340, 300, 1120, 790])
xlabel('Time(days)')
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


function val = child_prorate(ppRb, cyclinE1, PAR)
i = 86;
% (86).Basal proliferation rate
[k_pro, i] = child_par(PAR, i);
% (87).Proliferation rate increased by ppRb
[k_proppRb, i] = child_par(PAR, i);
% (88).Parameter 1 of proliferation rate increased by ppRb
[p_proppRb_1, i] = child_par(PAR, i);
% (89).Parameter 2 of proliferation rate increased by ppRb
[p_proppRb_2, i] = child_par(PAR, i);
% (90).Proliferation rate increased by cyclinE1
[k_procyclinE1, i] = child_par(PAR, i);
% (91).Parameter 1 of proliferation rate increased by cyclinE1
[p_procyclinE1_1, i] = child_par(PAR, i);
% (92).Parameter 2 of proliferation rate increased by cyclinE1
[p_procyclinE1_2, ~] = child_par(PAR, i);

% Hillfun for increased proliferation by ppRb
HF_proppRb = ppRb.^p_proppRb_2./(p_proppRb_1.^p_proppRb_2 + ppRb.^p_proppRb_2);
% Hillfun for increased proliferation by cyclinE1
HF_procyclinE1 = cyclinE1.^p_procyclinE1_2./(p_procyclinE1_1.^p_procyclinE1_2 + cyclinE1.^p_procyclinE1_2);

val = (k_pro...                         % basal proliferation
     + k_proppRb * HF_proppRb...        % ppRb proliferation
     + k_procyclinE1 * HF_procyclinE1); % cyclinE1 proliferation
end

function [i_par, i] = child_par(PAR, i)
i_par = PAR(i);
i = i+1;
end