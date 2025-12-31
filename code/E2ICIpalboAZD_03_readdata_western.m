function E2ICIpalboAZD_03_readdata_western()
% This function loads western blot data from the ./data/western blot directory and saves it as a .mat file in
% ./code/mat/Outprotein.mat for use in model parameter fitting.

pathsave = './mat/';
pathload = '../data/western blot/';
if ~isfolder(pathsave)
    mkdir(pathsave);
end
%% Un-normalize to T=0, palbo mono 1w, 2w
filename = [pathload,'western012w/data.xlsx'];
CyclinE1_palbomono_1w_2w = readmatrix(filename,'Sheet','CyclinE');
CyclinE1_palbomono_1w_2w = CyclinE1_palbomono_1w_2w(:,2:end);
CyclinE1_palbomono_1w_2w = CyclinE1_palbomono_1w_2w(15:17,[1,2,3,4,5]);
%% Normalized to T=0, ICI mono 1w, 2w, 5w, 12w
filename = [pathload,'06262023 MCF7 750nM ICI_1,2,5 weeks_3 reps/protein.xlsx'];
Cdk6_ICImono_1w_2w_5w = readmatrix(filename,'Sheet','Blot2','DataRange','B24:M24');
Cdk6_ICImono_1w_2w_5w = reshape(Cdk6_ICImono_1w_2w_5w,[3,4]);

filename = [pathload, '07312023 Bill Long-Term Mono ICI_month 10,11,12 + MCF7 basal/protein.xlsx'];
Cdk6_ICImono_12m = readmatrix(filename,'Sheet','Blot2','DataRange','B17:G17');
Cdk6_ICImono_12m = reshape(Cdk6_ICImono_12m,[3,2]);
%% Read the original 12month protein level
close all
filename = [pathload,'010923 Bill Long-Term cells 12+mo (basal, mono palbo, alt Palbo-arm, alt AZD+ICI-arm_3reps_Run#1/protein.xlsx'];
Cdk6_12mnth_rep1 = readmatrix(filename,'Sheet','Blot1','FileType','spreadsheet','DataRange','B29:G29');
CyclinE_12mnth_rep1 = readmatrix(filename,'Sheet','Blot1','FileType','spreadsheet','DataRange','B34:G34');

filename = [pathload, '01092023 Bill Long-term cells 12+mo monthly(basal, mono palbo, alt palbo-arm, alt AZD+ICI arm 3reps)/protein.xlsx'];
CyclinE_12mnth_rep1to3 = readmatrix(filename,'Sheet','Blot1','FileType','spreadsheet','DataRange','B37:M37');
Cdk6_12mnth_rep1to3 = readmatrix(filename,'Sheet','Blot2','FileType','spreadsheet','DataRange','B24:M24');
 
Cdk6_MCF7 = [Cdk6_12mnth_rep1(1), Cdk6_12mnth_rep1to3(1:3)];
Cdk6_AZDAlt_AZD_12mnth = [Cdk6_12mnth_rep1(6), Cdk6_12mnth_rep1to3(10:12)];
clearvars Cdk6_12mnth_rep1to3

CyclinE_MCF7 = [CyclinE_12mnth_rep1(1), CyclinE_12mnth_rep1to3(1:3)];
CyclinE_palbomono_12mnth = [CyclinE_12mnth_rep1(2), CyclinE_12mnth_rep1to3(4:6)];
CyclinE_AZDAlt_AZD_12mnth = [CyclinE_12mnth_rep1(6), CyclinE_12mnth_rep1to3(10:12)];
clearvars CyclinE_12mnth_rep1to3
%% Normlized t0, palbo mono 1w, 2w
CyclinE1_palbomono_1w_2w(:,3) = CyclinE1_palbomono_1w_2w(:,3)/mean(CyclinE1_palbomono_1w_2w(:,2));
CyclinE1_palbomono_1w_2w(:,2) = CyclinE1_palbomono_1w_2w(:,2)/mean(CyclinE1_palbomono_1w_2w(:,2));
CyclinE1_palbomono_1w_2w(:,5) = CyclinE1_palbomono_1w_2w(:,5)/mean(CyclinE1_palbomono_1w_2w(:,4));
CyclinE1_palbomono_1w_2w(:,4) = CyclinE1_palbomono_1w_2w(:,4)/mean(CyclinE1_palbomono_1w_2w(:,4));
%%
xticklabel = ["T0",...
              "1w",...
              "2w",...
              "12m",...
              "12m"];
time = [0, 7, 14, 336, 336];
%% Cdk6
Cdk6_MCF7 = [Cdk6_ICImono_1w_2w_5w(:,1);...
             Cdk6_ICImono_12m(:,1);...
             Cdk6_MCF7'];
Cdk6_ICImono_1w = Cdk6_ICImono_1w_2w_5w(:,2);
Cdk6_ICImono_2w = Cdk6_ICImono_1w_2w_5w(:,3);
Cdk6_ICImono_12mnth = [Cdk6_12mnth_rep1(3);Cdk6_ICImono_12m(:,2)];
Cdk6_palboAZDalt_12mnth_AZD = Cdk6_AZDAlt_AZD_12mnth';

Cdk6 = {Cdk6_MCF7(:),...
        Cdk6_ICImono_1w(:),...
        Cdk6_ICImono_2w(:),...
        Cdk6_ICImono_12mnth,...
        Cdk6_palboAZDalt_12mnth_AZD(:)};

[Cdk6_mean, Cdk6_sem] = child_protein_samerep(Cdk6, xticklabel);
clearvars Cdk6
Cdk6.mean = Cdk6_mean;
Cdk6.sem = Cdk6_sem;
Cdk6.label = ["T0","ICI mono 1w","ICI mono 2w","ICI mono 12m","palbo AZD alt 12m (AZD)"];
Cdk6.time = time;
%% CyclinE
CyclinE1_MCF7 = [CyclinE1_palbomono_1w_2w(:,2);...
                 CyclinE1_palbomono_1w_2w(:,4);...
                 CyclinE_MCF7'];
CyclinE1_palbomono_1w = CyclinE1_palbomono_1w_2w(:,3);
CyclinE1_palbomono_2w = CyclinE1_palbomono_1w_2w(:,5);
CyclinE1_palbomono_12mnth = CyclinE_palbomono_12mnth;
CyclinE1_palboAZDalt_12mnth_AZD = CyclinE_AZDAlt_AZD_12mnth';

CyclinE1 = {CyclinE1_MCF7(:),...
            CyclinE1_palbomono_1w(:),...
            CyclinE1_palbomono_2w(:),...
            CyclinE1_palbomono_12mnth(:),...
            CyclinE1_palboAZDalt_12mnth_AZD(:)};
[CyclinE1_mean, CyclinE1_sem] = child_protein_samerep(CyclinE1, xticklabel);
clearvars CyclinE1

CyclinE1.mean = CyclinE1_mean;
CyclinE1.sem = CyclinE1_sem;
CyclinE1.label = ["T0","palbo mono 1w","palbo mono 2w","palbo mono 12m","palbo AZD alt 12m (AZD)"];
CyclinE1.time = time;
%%
save([pathsave, 'Outprotein.mat'],'Cdk6','CyclinE1','time')
end

function [data_mean, data_sem] = child_protein_samerep(data, datalabel)
if numel(data) ~= numel(datalabel)
    error('number of data and label are diff')
end

data_mean = cell2mat(cellfun(@(x) mean(x), data, 'UniformOutput',false));
data_sem = cell2mat(cellfun(@(x) std(x)/sqrt(numel(x)), data, 'UniformOutput',false));
end