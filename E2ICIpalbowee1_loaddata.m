function data = E2ICIpalbowee1_loaddata()
%% protein westernblot
protein = load('protein.mat');
name = 'Cdk6';
[Cdk6,protein] = child_funcellnum(protein,name);
name = 'CyclinE1';
[CyclinE1,~] = child_funcellnum(protein,name);
%% cellnum coulter counter
cellnum = load('cellnum.mat').cellnum;
% E2(10nM)
name = 'E210nM';
[Cellnum_E210nM,cellnum] = child_funcellnum(cellnum,name);
% E2(10nM)+ICI(500nM)
name = 'E210nM_ICI500nM';
[Cellnum_E210nM_ICI500nM,cellnum] = child_funcellnum(cellnum,name);
% E2(10nM)+palbo(500nM)
name = 'E210nM_palbo500nM';
[Cellnum_E210nM_palbo500nM,cellnum] = child_funcellnum(cellnum,name);
% E2(10nM)+palbo(1uM)
name = 'E210nM_palbo1uM';
[Cellnum_E210nM_palbo1uM,cellnum] = child_funcellnum(cellnum,name);
% Synergy palbo ICI
name = 'Synergy_ICIpalbo_ICI200nM_17day';
[Synergy_ICI200nM_17day,cellnum] = child_funcellnum(cellnum,name);
% E2(10nM)+AZD(250nM)
name = 'E210nM_AZD250nM';
[Cellnum_E210nM_AZD250nM,cellnum] = child_funcellnum(cellnum,name);
% Control Proliferation 11day
name = 'E210nM_day11';
[Cellnum_E210nM_day11,cellnum] = child_funcellnum(cellnum,name);

name = 'Synergy_ICIpalbo_palbo50nM_17day';
Synergy_ICIpalbo_palbo50nM_17day = child_funcellnum(cellnum,name);
name = 'Synergy_ICIpalbo_palbo100nM_17day';
Synergy_ICIpalbo_palbo100nM_17day = child_funcellnum(cellnum,name);
name = 'Synergy_ICIpalbo_palbo300nM_17day';
Synergy_ICIpalbo_palbo300nM_17day = child_funcellnum(cellnum,name);
%% 12 months pro
Long12month = cellnum.Long12month;
%% Cellnum mean
% E2(10nM)
E210nM_pro = child_mean(Cellnum_E210nM.pro);
% E2(10nM)+ICI(500nM)
E210nM_ICI500nM_pro = child_mean(Cellnum_E210nM_ICI500nM.pro);
% E2(10nM)+palbo(500nM)
E210nM_palbo500nM_pro = child_mean(Cellnum_E210nM_palbo500nM.pro);
% E2(10nM)+palbo(1uM)
E210nM_palbo1uM_pro = child_mean(Cellnum_E210nM_palbo1uM.pro);
% Rep1-3 Control Proliferation 11day
E210nM_day11_pro = child_mean(Cellnum_E210nM_day11.pro);
% Synergy palbo ICI
Synergy_ICI200nM_17day_pro = child_mean(Synergy_ICI200nM_17day(:));
Synergy_palbo50nM_17day_pro = child_mean(Synergy_ICIpalbo_palbo50nM_17day(:));
Synergy_palbo100nM_17day_pro = child_mean(Synergy_ICIpalbo_palbo100nM_17day(:));
Synergy_palbo300nM_17day_pro = child_mean(Synergy_ICIpalbo_palbo300nM_17day(:));
% (22)E2(10nM)+AZD(250nM)
E210nM_AZD250nM_pro = child_mean(Cellnum_E210nM_AZD250nM.pro);

data.Cdk6 = Cdk6; 
clearvars Cdk6
data.CyclinE1 = CyclinE1; 
clearvars CyclinE1

data.E210nM_pro = E210nM_pro; 
clearvars E210nM_pro
data.E210nM_ICI500nM_pro = E210nM_ICI500nM_pro; 
clearvars E210nM_ICI500nM_pro
data.E210nM_palbo500nM_pro = E210nM_palbo500nM_pro; 
clearvars E210nM_palbo500nM_pro
data.E210nM_palbo1uM_pro = E210nM_palbo1uM_pro; 
clearvars E210nM_palbo1uM_pro
data.E210nM_AZD250nM_pro = E210nM_AZD250nM_pro; 
clearvars E210nM_AZD250nM_pro

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
end

function [Out1,Outcellnum] = child_funcellnum(Outcellnum,name)
Out1 = Outcellnum.(name);
Outcellnum = rmfield(Outcellnum,name);
end

function pro_out = child_mean(pro)
pro_out.mean = mean(pro,1,'omitnan');
pro_out.std = std(pro,[],1,'omitnan')/sqrt(size(pro,1));
end