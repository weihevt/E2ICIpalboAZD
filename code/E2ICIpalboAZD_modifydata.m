function  data = E2ICIpalboAZD_modifydata(data)
% flag_samesem_pro = false;
sem_threshold = 0.1;
%% CyclinE1
% data.CyclinE1.sem(data.CyclinE1.sem < sem_threshold) = sem_threshold;
%% Cdk6
% data.Cdk6.sem(data.Cdk6.sem < sem_threshold) = sem_threshold;
%% cellnum coulter counter
%% Modify the std of cell proliferation
low_val = 0.6;
low_valset = 0.6;
high_val = 1;
high_valset = 1;
% (1)E2(10nM)
data.E210nM_pro.std(data.E210nM_pro.std < low_val) = low_valset;
data.E210nM_pro.std(data.E210nM_pro.std > high_val) = high_valset;
% (5)E2(10nM)+ICI(500nM)
data.E210nM_ICI500nM_pro.std(data.E210nM_ICI500nM_pro.std < low_val) = low_valset;
data.E210nM_ICI500nM_pro.std(data.E210nM_ICI500nM_pro.std > high_val) = high_val;
% (6)E2(10nM)+palbo(250nM)
data.E210nM_palbo250nM_pro.std(data.E210nM_palbo250nM_pro.std < low_val) = low_valset;
data.E210nM_palbo250nM_pro.std(data.E210nM_palbo250nM_pro.std > high_val) = high_val;
% (7)E2(10nM)+palbo(500nM)
data.E210nM_palbo500nM_pro.std(data.E210nM_palbo500nM_pro.std < low_val) = low_valset;
data.E210nM_palbo500nM_pro.std(data.E210nM_palbo500nM_pro.std > high_val) = high_val;
% (8)E2(10nM)+palbo(1uM)
data.E210nM_palbo1uM_pro.std(data.E210nM_palbo1uM_pro.std < low_val) = low_valset;
data.E210nM_palbo1uM_pro.std(data.E210nM_palbo1uM_pro.std > high_val) = high_val;
% (15)AZD250nM Mono
data.E210nM_AZD250nM_pro.std(data.E210nM_AZD250nM_pro.std < low_val) = low_valset;
data.E210nM_AZD250nM_pro.std(data.E210nM_AZD250nM_pro.std > high_val) = high_val;
% Alternating treatment over 12 months
Long12month = data.Long12month;
data.Long12month.time = Long12month.time;
% E2(10nM)+palbo750(nM) Mono
data.Long12month.palbo750nM_Mono.mean = Long12month.palbo750nM_Mono.mean;
data.Long12month.palbo750nM_Mono.std =  Long12month.palbo750nM_Mono.std;
data.Long12month.palbo750nM_Mono.std(data.Long12month.palbo750nM_Mono.std < low_val) = low_val;
data.Long12month.palbo750nM_Mono.std(data.Long12month.palbo750nM_Mono.std > high_val) = high_val;
% E2(10nM)+ICI(750nM) Mono
data.Long12month.ICI750nM_Mono.mean = Long12month.ICI750nM_Mono.mean;
data.Long12month.ICI750nM_Mono.std = Long12month.ICI750nM_Mono.std;
data.Long12month.ICI750nM_Mono.std(data.Long12month.ICI750nM_Mono.std < low_val) = low_val;
data.Long12month.ICI750nM_Mono.std(data.Long12month.ICI750nM_Mono.std > high_val) = high_val;
% E2(10nM)+AZD(250nM) Mono
data.Long12month.AZD250nM_Mono.mean = data.E210nM_AZD250nM_pro.mean;
data.Long12month.AZD250nM_Mono.std = data.E210nM_AZD250nM_pro.std;
data.Long12month.AZD250nM_Mono.std(data.Long12month.AZD250nM_Mono.std < low_val) = low_val;
data.Long12month.AZD250nM_Mono.std(data.Long12month.AZD250nM_Mono.std > high_val) = high_val;
% E2(10nM)+AZD(250nM)+ICI(750nM) Mono
data.Long12month.AZD250nMICI750nM_Mono.mean = data.E210nM_AZD250nMICI750nM_pro.mean;
data.Long12month.AZD250nMICI750nM_Mono.std = data.E210nM_AZD250nMICI750nM_pro.std;
data.Long12month.AZD250nMICI750nM_Mono.std(data.Long12month.AZD250nMICI750nM_Mono.std < low_val) = low_val;
data.Long12month.AZD250nMICI750nM_Mono.std(data.Long12month.AZD250nMICI750nM_Mono.std > high_val) = high_val;

% Alternating: E2(10nM)+palbo750nM -> E2(10nM)+ICI750nM
data.Long12month.Alter_palbo750nM_ICI750nM.mean = Long12month.Alter_palbo750nM_ICI750nM.mean;
data.Long12month.Alter_palbo750nM_ICI750nM.std = Long12month.Alter_palbo750nM_ICI750nM.std;
data.Long12month.Alter_palbo750nM_ICI750nM.std(data.Long12month.Alter_palbo750nM_ICI750nM.std < low_val) = low_val;
data.Long12month.Alter_palbo750nM_ICI750nM.std(data.Long12month.Alter_palbo750nM_ICI750nM.std > low_val) = high_val;
% Alternating: E2(10nM)+palbo750nM -> E2(10nM)+ICI(750nM)+AZD(250nM)
data.Long12month.Alter_palbo750nM_ICI750nMAZD250nM.std = Long12month.Alter_palbo750nM_ICI750nMAZD250nM.std;
data.Long12month.Alter_palbo750nM_ICI750nMAZD250nM.std(data.Long12month.Alter_palbo750nM_ICI750nMAZD250nM.std < low_val) = low_val;
data.Long12month.Alter_palbo750nM_ICI750nMAZD250nM.std(data.Long12month.Alter_palbo750nM_ICI750nMAZD250nM.std > low_val) = high_val;
% synergy
data.Synergy_ICI200nM_17day_pro.std = 1.1*high_val;
data.Synergy_palbo50nM_17day_pro.std = 1.1*high_val;
data.Synergy_palbo50nM_17day_pro.std = 1.1*high_val;
data.Synergy_palbo50nM_17day_pro.std = 1.1*high_val;
%%
% Alternating treatment over 12 months
% E2(10nM)+palbo750(nM) Mono
data.Long12month.palbo750nM_Mono.mean([8,9,10]) = repmat(mean(data.Long12month.palbo750nM_Mono.mean([8,9,10])),1,3);
% E2(10nM)+ICI(750nM) Mono
data.Long12month.ICI750nM_Mono.mean([3,4,5,6]) =  repmat(mean(data.Long12month.ICI750nM_Mono.mean([3,4,5,6])),1,4);
data.Long12month.ICI750nM_Mono.mean([11,12,13]) = repmat(mean(data.Long12month.ICI750nM_Mono.mean([11,12,13])),1,3);
% Alternating: E2(10nM)+palbo750nM -> E2(10nM)+ICI750nM
data.Long12month.Alter_palbo750nM_ICI750nM.mean([11,13]) = ...
    repmat(mean(data.Long12month.Alter_palbo750nM_ICI750nM.mean([11,13])),1,2);
% Alternating: E2(10nM)+palbo750nM -> E2(10nM)+ICI(750nM)+AZD(250nM)
data.Long12month.Alter_palbo750nM_ICI750nMAZD250nM.mean(2:2:end) = ...
    repmat(mean(data.Long12month.Alter_palbo750nM_ICI750nMAZD250nM.mean(2:2:end)),1,6);
data.Long12month.Alter_palbo750nM_ICI750nMAZD250nM.mean(3:2:end) = ...
    repmat(mean(data.Long12month.Alter_palbo750nM_ICI750nMAZD250nM.mean(3:2:end)),1,6);
end