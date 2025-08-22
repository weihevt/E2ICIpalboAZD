function data = E2ICIpalboAZD_loaddata()
%% (9) Function index in the GitHub repository
% This function loads the data from the ./code/mat/ folder needed for parameter calibration in the model.

pathload = './mat/';
%% protein westernblot
protein = load([pathload,'Outprotein.mat']);
name = 'Cdk6';
[Cdk6,protein] = child_funcellnum(protein,name);
name = 'CyclinE1';
[CyclinE1,~] = child_funcellnum(protein,name);
%% cellnum coulter counter
Outcellnum = load([pathload,'Outcellnum.mat']).Outcellnum;
% (1)E2(10nM)
name = 'E210nM';
[Cellnum_E210nM,Outcellnum] = child_funcellnum(Outcellnum,name);
% (5)E2(10nM)+ICI(500nM)
name = 'E210nM_ICI500nM';
[Cellnum_E210nM_ICI500nM,Outcellnum] = child_funcellnum(Outcellnum,name);
% (6)E2(10nM)+palbo(250nM)
name = 'E210nM_palbo250nM';
[Cellnum_E210nM_palbo250nM,Outcellnum] = child_funcellnum(Outcellnum,name);
% (7)E2(10nM)+palbo(500nM)
name = 'E210nM_palbo500nM';
[Cellnum_E210nM_palbo500nM,Outcellnum] = child_funcellnum(Outcellnum,name);
% (8)E2(10nM)+palbo(1uM)
name = 'E210nM_palbo1uM';
[Cellnum_E210nM_palbo1uM,Outcellnum] = child_funcellnum(Outcellnum,name);
% (20)Control Proliferation 11day
name = 'E210nM_day11';
[Cellnum_E210nM_day11,Outcellnum] = child_funcellnum(Outcellnum,name);
% (21)Synergy palbo ICI
name = 'Synergy_ICIpalbo_ICI200nM_17day';
[Synergy_ICI200nM_17day,Outcellnum] = child_funcellnum(Outcellnum,name);

name = 'Synergy_ICIpalbo_palbo50nM_17day';
Synergy_ICIpalbo_palbo50nM_17day = child_funcellnum(Outcellnum,name);
name = 'Synergy_ICIpalbo_palbo100nM_17day';
Synergy_ICIpalbo_palbo100nM_17day = child_funcellnum(Outcellnum,name);
name = 'Synergy_ICIpalbo_palbo300nM_17day';
Synergy_ICIpalbo_palbo300nM_17day = child_funcellnum(Outcellnum,name);
%% 12 months pro
Long12month = load([pathload,'Outcellnum_12m.mat']).Outcellnum_12m;
%% 1 months
Outcellnum = load([pathload,'Outcellnum_AZD1m.mat']).Outcellnum_AZD1m;
name = 'AZD250nM_Mono';
[Cellnum_E210nM_AZD250nM,Outcellnum] = child_funcellnum(Outcellnum,name);
E210nM_AZD250nM_pro.mean = Cellnum_E210nM_AZD250nM.mean(1:2);
E210nM_AZD250nM_pro.std = Cellnum_E210nM_AZD250nM.std(1:2);
name = 'AZD250nMICI750nM_Mono';
[Cellnum_E210nM_AZD250nMICI750nM,~] = child_funcellnum(Outcellnum,name);
E210nM_AZD250nMICI750nM_pro.mean = Cellnum_E210nM_AZD250nMICI750nM.mean(1:2);
E210nM_AZD250nMICI750nM_pro.std = Cellnum_E210nM_AZD250nMICI750nM.std(1:2);
%% Cellnum mean
% (1)E2(10nM)
E210nM_pro = child_mean(Cellnum_E210nM.pro);
% (5)E2(10nM)+ICI(500nM)
E210nM_ICI500nM_pro = child_mean(Cellnum_E210nM_ICI500nM.pro);
% (6)E2(10nM)+palbo(250nM)
E210nM_palbo250nM_pro = child_mean(Cellnum_E210nM_palbo250nM.pro);
E210nM_palbo250nM_pro.mean(end) = NaN;
E210nM_palbo250nM_pro.std(end) = NaN;
% (7)E2(10nM)+palbo(500nM)
E210nM_palbo500nM_pro = child_mean(Cellnum_E210nM_palbo500nM.pro);
% (8)E2(10nM)+palbo(1uM)
E210nM_palbo1uM_pro = child_mean(Cellnum_E210nM_palbo1uM.pro);
% (20)Rep1-3 Control Proliferation 11day
E210nM_day11_pro = child_mean(Cellnum_E210nM_day11.pro);
% (21)Synergy palbo ICI
Synergy_ICI200nM_17day_pro = child_mean(Synergy_ICI200nM_17day(:));
Synergy_ICI200nM_17day_pro.data = Synergy_ICI200nM_17day;
Synergy_palbo50nM_17day_pro = child_mean(Synergy_ICIpalbo_palbo50nM_17day(:));
Synergy_palbo50nM_17day_pro.data = Synergy_ICIpalbo_palbo50nM_17day;
Synergy_palbo100nM_17day_pro = child_mean(Synergy_ICIpalbo_palbo100nM_17day(:));
Synergy_palbo100nM_17day_pro.data = Synergy_ICIpalbo_palbo100nM_17day;
Synergy_palbo300nM_17day_pro = child_mean(Synergy_ICIpalbo_palbo300nM_17day(:));
Synergy_palbo300nM_17day_pro.data = Synergy_ICIpalbo_palbo300nM_17day;

data.Cdk6 = Cdk6; 
clearvars Cdk6
data.CyclinE1 = CyclinE1; 
clearvars CyclinE1

data.E210nM_pro = E210nM_pro; 
clearvars E210nM_pro
data.E210nM_ICI500nM_pro = E210nM_ICI500nM_pro; 
clearvars E210nM_ICI500nM_pro
data.E210nM_palbo250nM_pro = E210nM_palbo250nM_pro; 
clearvars E210nM_palbo250nM_pro
data.E210nM_palbo500nM_pro = E210nM_palbo500nM_pro; 
clearvars E210nM_palbo500nM_pro
data.E210nM_palbo1uM_pro = E210nM_palbo1uM_pro; 
clearvars E210nM_palbo1uM_pro
data.E210nM_AZD250nM_pro = E210nM_AZD250nM_pro; 
clearvars E210nM_AZD250nM_pro
data.E210nM_AZD250nMICI750nM_pro = E210nM_AZD250nMICI750nM_pro;
clearvars E210nM_AZD250nMICI750nM_pro
data.E210nM_day11_pro = E210nM_day11_pro;
clearvars E210nM_day11_pro
data.Synergy_ICI200nM_17day_pro = Synergy_ICI200nM_17day_pro;
clearvars Synergy_ICI200nM_17day_pro
data.Synergy_palbo50nM_17day_pro = Synergy_palbo50nM_17day_pro;
clearvars Synergy_ICIpalbo_palbo50nM_17day_pro
data.Synergy_palbo100nM_17day_pro = Synergy_palbo100nM_17day_pro;
clearvars Synergy_ICIpalbo_palbo100nM_17day_pro
data.Synergy_palbo300nM_17day_pro = Synergy_palbo300nM_17day_pro;
clearvars Synergy_ICIpalbo_palbo300nM_17day_pro
data.Long12month = Long12month;
clearvars Long12month
end

function [Out1,Outcellnum] = child_funcellnum(Outcellnum,name)
Out1 = Outcellnum.(name);
Outcellnum = rmfield(Outcellnum,name);
end

function pro_out = child_mean(pro)
pro_out.mean = mean(pro,1,'omitnan');
pro_out.std = std(pro,[],1,'omitnan')/sqrt(size(pro,1));
end