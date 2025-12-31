function data = E2ICIpalboAZD_30_result(PAR)
% This function generates simulation results for each parameter set in the parameter cohort. 
% It is called by E2ICIpalboAZD_32_simparcohort().

Num_hours = 24;
Num_days = 30;
args = E2ICIpalboAZD_05_modelpar();
x0 = zeros(args.Numvariable,1);
x0(args.E2mediaindex) = args.ValE2normal;
x0 = E2ICIpalboAZD_21_replating(x0,args);
args.PAR = PAR;
tspan = [0,Num_days*Num_hours];
[~,~,xinitial] = E2ICIpalboAZD_29_sim(x0,tspan,args.treat_non,args);
% set the steady state
x0 = xinitial(end,:);
%% ----------different treatment-----------%%
%% (1)E2(10nM)
tspan = [0,Num_days*Num_hours];
x0(args.ind_reset) = 0;
x0 = E2ICIpalboAZD_21_replating(x0,args);
[tE2,simE2,~] = E2ICIpalboAZD_29_sim(x0,tspan,args.treat_non,args);
%% (3)E2(10nM)+ICI(500nM)
[tICI500nM,simICI500nM] = E2ICIpalboAZD_29_sim(x0,tspan,args.treat_ICI500nM,args);
%% (5)E2(10nM)+palbo(500nM)
[tpalbo500nM,simpalbo500nM] = E2ICIpalboAZD_29_sim(x0,tspan,args.treat_palbo500nM,args);
%% (6)E2(10nM)+palbo(1uM)
[tpalbo1uM,simpalbo1uM] = E2ICIpalboAZD_29_sim(x0,tspan,args.treat_palbo1uM,args);
%% (7)Alternating treatment over 12 months
Num_days = 28;
x0 = xinitial(end,:);
x0(args.ind_reset) = 0;
x0 = E2ICIpalboAZD_21_replating(x0,args);
Num_month = 13;
tspan = [0,Num_month*Num_days*Num_hours];
x0(args.E2mediaindex) = xinitial(end,args.E2mediaindex);
% E2(10nM)+palbo(750nM) mono
treatalter = cell(1,Num_month);
for i = 1:Num_month
    treatalter{i}.treat = args.treat_palbo750nM;
    treatalter{i}.duration = args.daypermonth;
end
cycletime = sum(cell2mat(cellfun(@(x) x.duration,treatalter,'UniformOutput',false)));
cycletime = cycletime * Num_hours;
replate = true;
[tpalbo750nM_12m,simpalbo750nM_12m,xpalbo750nM_12m] =...
    E2ICIpalboAZD_31_simalternation(x0,tspan,treatalter,cycletime,replate,args);
clearvars treatalter

% E2(10nM)+ICI(750nM) mono
for i = 1:Num_month
    treatalter{i}.treat = args.treat_ICI750nM;
    treatalter{i}.duration = args.daypermonth;
end
[tICI750nM_12m,simICI750nM_12m,xICI750nM_12m] =...
    E2ICIpalboAZD_31_simalternation(x0,tspan,treatalter,cycletime,replate,args);

% E2(10nM)+AZD(250nM) mono
for i = 1:Num_month
    treatalter{i}.treat = args.treat_AZD250nM;
    treatalter{i}.duration = args.daypermonth;
end
[tAZD,simAZD250nM] =...
    E2ICIpalboAZD_31_simalternation(x0,tspan,treatalter,cycletime,replate,args);

% E2(10nM)+AZD(250nM)+ICI(750nM) mono
for i = 1:Num_month
    treatalter{i}.treat = args.treat_ICI750nM_AZD250nM;
    treatalter{i}.duration = args.daypermonth;
end
[tICI750nMAZD250nM,simICI750nMAZD250nM] =...
    E2ICIpalboAZD_31_simalternation(x0,tspan,treatalter,cycletime,replate,args);

% Alter: E2(10nM)+palbo(750nM) -> E2(10nM)+ICI(750nM)
for i = 1:Num_month
    if mod(i,2) == 1
        treatalter{i}.treat = args.treat_palbo750nM;
    else
        treatalter{i}.treat = args.treat_ICI750nM;
    end
    treatalter{i}.duration = args.daypermonth;
end
[tAlter_palbo_ICI,simAlter_palbo_ICI, xAlter_palbo_ICI] =...
    E2ICIpalboAZD_31_simalternation(x0,tspan,treatalter,cycletime,replate,args);

% Alter: E2(10nM)+palbo(750nM) -> E2(10nM)+ICI(750nM)+AZD(250nM)
for i = 1:Num_month
    if mod(i,2) == 1
        treatalter{i}.treat = args.treat_palbo750nM;
    else
        treatalter{i}.treat = args.treat_ICI750nM_AZD250nM;
    end
    treatalter{i}.duration = args.daypermonth;
end
[tAlter_palbo_ICIAZD,simAlter_palbo_ICIAZD,xAlter_palbo_ICIAZD] =...
    E2ICIpalboAZD_31_simalternation(x0,tspan,treatalter,cycletime,replate,args);

close all
%% (8)Synergy
Num_days = 17;
tspan = [0,Num_days*Num_hours];
% E2(10nM)+ICI(200nM)
x0(args.E2mediaindex) = xinitial(end,args.E2mediaindex);
[tICI200nM_d17,simICI200nM_d17,~] = E2ICIpalboAZD_29_sim(x0,tspan,args.treat_ICI200nM,args);
% E2(10nM)+ICI(200nM)+palbo(50nM)
[tICI200nM_palbo50nM_d17,simICI200nM_palbo50nM_d17,~] = E2ICIpalboAZD_29_sim(x0,tspan,args.treat_ICI200nM_palbo50nM,args);
% E2(10nM)+ICI(200nM)+palbo(100nM)
[tICI200nM_palbo100nM_d17,simICI200nM_palbo100nM_d17,~] = E2ICIpalboAZD_29_sim(x0,tspan,args.treat_ICI200nM_palbo100nM,args);
% E2(10nM)+ICI(200nM)+palbo(300nM)
[tICI200nM_palbo300nM_d17,simICI200nM_palbo300nM_d17,~] = E2ICIpalboAZD_29_sim(x0,tspan,args.treat_ICI200nM_palbo300nM,args);
%% protein data
% week 1d
teval_days = 7;
val = child_proteinnorm_all(tpalbo750nM_12m/Num_hours,...
                            xpalbo750nM_12m,...
                            teval_days,...
                            xpalbo750nM_12m,...
                            {args.ind_containcyclinE1});
cyclinE1_palbo750nM_w1 = val{:};

val = child_proteinnorm_all(tICI750nM_12m/Num_hours,...
                            xICI750nM_12m,...
                            teval_days,...
                            xICI750nM_12m,...
                            {args.ind_containcdk6});
cdk6_ICI750nM_w1 = val{:};

% week 2
teval_days = 14;
val = child_proteinnorm_all(tpalbo750nM_12m/Num_hours,...
                            xpalbo750nM_12m,...
                            teval_days,...
                            xpalbo750nM_12m,...
                            {args.ind_containcyclinE1});
cyclinE1_palbo750nM_w2 = val{:};

val = child_proteinnorm_all(tICI750nM_12m/Num_hours,...
                            xICI750nM_12m,...
                            teval_days,...
                            xICI750nM_12m,...
                            {args.ind_containcdk6});
cdk6_ICI750nM_w2 = val{:};

% month 12
Num_month = 12;
teval_days = Num_month*Num_days;
val = child_proteinnorm_all(tpalbo750nM_12m/Num_hours,...
                            xpalbo750nM_12m,...
                            teval_days,...
                            xpalbo750nM_12m,...
                            {args.ind_containcyclinE1});
cyclinE1_palbo750nM_m12 = val{:};

val = child_proteinnorm_all(tICI750nM_12m/Num_hours,...
                            xICI750nM_12m,...
                            teval_days,...
                            xICI750nM_12m,...
                            {args.ind_containcdk6});
cdk6_ICI750nM_m12 = val{:};

val = child_proteinnorm_all(tAlter_palbo_ICIAZD/Num_hours,...
                            xAlter_palbo_ICIAZD,...
                            teval_days,...
                            xAlter_palbo_ICIAZD,...
                            {args.ind_containcyclinE1,...
                            args.ind_containcdk6});
[cyclinE1_alter_m12,cdk6_alter_m12] = val{:};
%% Synergy
teval_days = 17;
% E2(10nM)+ICI(200nM)
pos = find(tICI200nM_d17/Num_hours == teval_days,1,'first');
simICI200nM_d17 = simICI200nM_d17(end,pos);
% E2(10nM)+ICI(200nM)+palbo(50nM)
pos = find(tICI200nM_palbo50nM_d17/Num_hours == teval_days, 1,'first');
simICI200nM_palbo50nM_d17 = simICI200nM_palbo50nM_d17(end,pos);
% E2(10nM)+ICI(200nM)+palbo(100nM)
pos = find(tICI200nM_palbo100nM_d17/Num_hours == teval_days, 1,'first');
simICI200nM_palbo100nM_d17 = simICI200nM_palbo100nM_d17(end,pos);
% E2(10nM)+ICI(200nM)+palbo(300nM)
pos = find(tICI200nM_palbo300nM_d17/Num_hours == teval_days, 1,'first');
simICI200nM_palbo300nM_d17 = simICI200nM_palbo300nM_d17(end,pos);
%%
% E2(10nM)
Num_days = 11;
cellnumE2 = simE2(end,:);
pos = find(tE2==Num_days*Num_hours,1,'first');
tE2 = tE2(1:pos);
cellnumE2 = cellnumE2(1:pos);

% E2(10nM)+ICI(500nM)
Num_days = 21;
cellnumICI500nM = simICI500nM(end,:);
pos = find(tICI500nM==Num_days*Num_hours,1,'first');
tICI500nM = tICI500nM(1:pos);
cellnumICI500nM = cellnumICI500nM(1:pos);

% E2(10nM)+palbo(500nM)
Num_days = 28;
cellnumpalbo500nM = simpalbo500nM(end,:);
pos = find(tpalbo500nM==Num_days*Num_hours,1,'first');
tpalbo500nM = tpalbo500nM(1:pos);
cellnumpalbo500nM = cellnumpalbo500nM(1:pos);

% E2(10nM)+palbo(1uM)
Num_days = 21;
cellnumpalbo1uM = simpalbo1uM(end,:);
pos = find(tpalbo1uM==Num_days*Num_hours,1,'first');
tpalbo1uM = tpalbo1uM(1:pos);
cellnumpalbo1uM = cellnumpalbo1uM(1:pos);

% E2(10nM)+palbo(750nM) mono
Num_months = 12;
Num_days = 28;

cellnumpalbo750nM_12m = simpalbo750nM_12m(end,:);
cdk6palbo750nM_12m = child_cdk6cyclinE1(xpalbo750nM_12m,args.ind_containcdk6);
cyclinE1palbo750nM_12m = child_cdk6cyclinE1(xpalbo750nM_12m,args.ind_containcyclinE1);
pos = find(tpalbo750nM_12m==Num_months*Num_days*Num_hours,1,'first');

tpalbo750nM_12m = tpalbo750nM_12m(1:pos);
cellnumpalbo750nM_12m = cellnumpalbo750nM_12m(1:pos);
cdk6palbo750nM_12m = cdk6palbo750nM_12m(1:pos);
cyclinE1palbo750nM_12m = cyclinE1palbo750nM_12m(1:pos);

% E2(10nM)+ICI(750nM) mono
cellnumICI750nM_12m = simICI750nM_12m(end,:);
cdk6ICI750nM_12m = child_cdk6cyclinE1(xICI750nM_12m,args.ind_containcdk6);
cyclinE1ICI750nM_12m = child_cdk6cyclinE1(xICI750nM_12m,args.ind_containcyclinE1);

pos = find(tICI750nM_12m==Num_months*Num_days*Num_hours,1,'first');
tICI750nM_12m = tICI750nM_12m(1:pos);
cellnumICI750nM_12m = cellnumICI750nM_12m(1:pos);
cdk6ICI750nM_12m = cdk6ICI750nM_12m(1:pos);
cyclinE1ICI750nM_12m = cyclinE1ICI750nM_12m(1:pos);

% Alter: E2(10nM)+palbo(750nM) -> E2(10nM)+ICI(750nM)
cellnumAlter_palbo_ICI = simAlter_palbo_ICI(end,:);
cdk6Alter_palbo_ICI = child_cdk6cyclinE1(xAlter_palbo_ICI,args.ind_containcdk6);
cyclinE1Alter_palbo_ICI = child_cdk6cyclinE1(xAlter_palbo_ICI,args.ind_containcyclinE1);
pos = find(tAlter_palbo_ICI==Num_months*Num_days*Num_hours,1,'first');

tAlter_palbo_ICI = tAlter_palbo_ICI(1:pos);
cellnumAlter_palbo_ICI = cellnumAlter_palbo_ICI(1:pos);
cdk6Alter_palbo_ICI = cdk6Alter_palbo_ICI(1:pos);
cyclinE1Alter_palbo_ICI = cyclinE1Alter_palbo_ICI(1:pos);

% Alter: E2(10nM)+palbo(750nM) -> E2(10nM)+ICI(750nM)+AZD(250nM)
cellnumAlter_palbo_ICIAZD = simAlter_palbo_ICIAZD(end,:);
cdk6Alter_palbo_ICIAZD = child_cdk6cyclinE1(xAlter_palbo_ICIAZD,args.ind_containcdk6);
cyclinE1Alter_palbo_ICIAZD = child_cdk6cyclinE1(xAlter_palbo_ICIAZD,args.ind_containcyclinE1);
pos = find(tAlter_palbo_ICIAZD==Num_months*Num_days*Num_hours,1,'first');

tAlter_palbo_ICIAZD = tAlter_palbo_ICIAZD(1:pos);
cellnumAlter_palbo_ICIAZD = cellnumAlter_palbo_ICIAZD(1:pos);
cdk6Alter_palbo_ICIAZD = cdk6Alter_palbo_ICIAZD(1:pos);
cyclinE1Alter_palbo_ICIAZD = cyclinE1Alter_palbo_ICIAZD(1:pos);

% E2(10nM)+AZD(250nM) mono
Num_days = 28;
cellnumAZD = simAZD250nM(end,:);
pos = find(tAZD==Num_days*Num_hours,1,'first');
tAZD = tAZD(1:pos);
cellnumAZD = cellnumAZD(1:pos);

% E2(10nM)+ICI(750nM)+AZD(250nM) mono
cellnumICIAZD = simICI750nMAZD250nM(end,:);
pos = find(tICI750nMAZD250nM==Num_days*Num_hours,1,'first');
tICIAZD = tICI750nMAZD250nM(1:pos);
cellnumICIAZD = cellnumICIAZD(1:pos);

data.cyclinE1_palbo_w1 = cyclinE1_palbo750nM_w1;
data.cyclinE1_palbo_w2 = cyclinE1_palbo750nM_w2;
data.cyclinE1_palbo_m12 = cyclinE1_palbo750nM_m12;
data.cyclinE1_alter_m12 = cyclinE1_alter_m12;

data.cdk6_ICI_w1 = cdk6_ICI750nM_w1;
data.cdk6_ICI_w2 = cdk6_ICI750nM_w2;
data.cdk6_ICI_m12 = cdk6_ICI750nM_m12;
data.cdk6_alter_m12 = cdk6_alter_m12;

data.cellnumICI200nM_d17 = simICI200nM_d17;
data.cellnumICI200nM_palbo50nM_d17 = simICI200nM_palbo50nM_d17;
data.cellnumICI200nM_palbo100nM_d17 = simICI200nM_palbo100nM_d17;
data.cellnumICI200nM_palbo300nM_d17 = simICI200nM_palbo300nM_d17;

data.tE2 = tE2;
data.cellnumE2 = cellnumE2;

data.tICI500nM = tICI500nM;
data.cellnumICI500nM = cellnumICI500nM;

data.tpalbo500nM = tpalbo500nM;
data.cellnumpalbo500nM = cellnumpalbo500nM;

data.tpalbo1uM = tpalbo1uM;
data.cellnumpalbo1uM = cellnumpalbo1uM;

data.tpalbo750nM_12m = tpalbo750nM_12m;
data.cellnumpalbo750nM_12m = cellnumpalbo750nM_12m;
data.cdk6palbo750nM_12m = cdk6palbo750nM_12m;
data.cyclinE1palbo750nM_12m = cyclinE1palbo750nM_12m;

data.tICI750nM_12m = tICI750nM_12m;
data.cellnumICI750nM_12m = cellnumICI750nM_12m;
data.cdk6ICI750nM_12m = cdk6ICI750nM_12m;
data.cyclinE1ICI750nM_12m = cyclinE1ICI750nM_12m;

data.tAlter_palbo_ICI = tAlter_palbo_ICI;
data.cellnumAlter_palbo_ICI = cellnumAlter_palbo_ICI;
data.cdk6Alter_palbo_ICI = cdk6Alter_palbo_ICI;
data.cyclinE1Alter_palbo_ICI = cyclinE1Alter_palbo_ICI;

data.tAlter_palbo_ICIAZD = tAlter_palbo_ICIAZD;
data.cellnumAlter_palbo_ICIAZD = cellnumAlter_palbo_ICIAZD;
data.cdk6Alter_palbo_ICIAZD = cdk6Alter_palbo_ICIAZD;
data.cyclinE1Alter_palbo_ICIAZD = cyclinE1Alter_palbo_ICIAZD;

data.tAZD250nM = tAZD;
data.cellnumAZD = cellnumAZD;
data.tICIAZD = tICIAZD;
data.cellnumICIAZD = cellnumICIAZD;
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

function val = child_cdk6cyclinE1(x, ind)
val = sum(x(:,ind),2);
val = val./val(1);
end