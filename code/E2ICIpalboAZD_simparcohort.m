function E2ICIpalboAZD_simparcohort()
%% (28) Function index in the GitHub repository
% This function simulates all parameter sets stored in ./code/mat/opmat.mat.

pathload_optmat = './mat/opmat.mat';
pathload_ind_opmat_maxcv = './mat/ind_opmat_maxcv.mat';
pathsavefig = './rawfig/';
pathsavexls = './xls/';

if ~isfolder(pathsavefig)
    mkdir(pathsavefig);
end
if ~isfolder(pathsavexls)
    mkdir(pathsavexls);
end

PopulationSize = 100;
flag_showfval = false;
cost_thr = 700;

Num_select = 100;
mse_error = 1e2;
args = E2ICIpalboAZD_modelpar();
PAR = args.PAR;
opmat = load(pathload_optmat);
populationT = opmat.populationT;
scores = opmat.scoresT;
ind = scores < cost_thr;
populationT = populationT(ind,:);
scores = scores(ind);

Num_partotal = size(populationT,1);
lb = ones(Num_select,1);
ub = repmat(Num_partotal,Num_select,1);
intcon = 1:1:Num_select;

if ~exist(pathload_ind_opmat_maxcv, 'file')
    optionsga = optimoptions('ga','PopulationSize',PopulationSize);

    num_run = 100;
    ind_optmat_maxcv = zeros(num_run,Num_select);
    Percentage_min_all = zeros(num_run,1);
    Percentage_min_total = -inf;
    for i = 1:num_run
        disp(i)
        ind_opt = ga(@(x)child_max(x,populationT,mse_error,args.groupparall,flag_showfval),...
                                   Num_select,[],[],[],[],lb,ub,[],intcon,optionsga);
        ind_optmat_maxcv(i,:) = ind_opt;
        population_select = populationT(ind_opt,args.groupparall);
        meanPAR = mean(population_select);
        varPAR = var(population_select);
        Percentage = sqrt(varPAR)./meanPAR * 100;
        Percentage_min = min(Percentage);
        Percentage_min_all(i) = Percentage_min;
        if Percentage_min > Percentage_min_total
            Percentage_min_total = Percentage_min;
        end
        disp(Percentage_min_total)
    end
    save(pathload_ind_opmat_maxcv,'ind_optmat_maxcv','Percentage_min_all')
end

ind_optmat_maxcv = load(pathload_ind_opmat_maxcv).ind_optmat_maxcv;
Percentage_min_all = load(pathload_ind_opmat_maxcv).Percentage_min_all;
[~, pos] = max(Percentage_min_all);
ind_opt = ind_optmat_maxcv(pos,:);
population_select = populationT(ind_opt,:);
scores_select = scores(ind_opt);
if ~ismember(PAR',population_select,'rows')
    [~, pos] = max(scores_select);
    population_select(pos,:) = [];
    population_select = [PAR';population_select];
else
    [~,Locb] = ismember(PAR',population_select,'rows');
    if Locb ~= 1
        population_select([1 Locb],:) = population_select([Locb 1],:);
    end
end
% save parcohort population_select scores_select

meanPAR = mean(population_select(:,args.groupparall));
varPAR = var(population_select(:,args.groupparall));
Coefficient_Variation = sqrt(varPAR)./meanPAR * 100;

% plot coefficient variation
figure
plot(Coefficient_Variation,'r','linewidth',2);
xlabel('Parameters');
ylabel('Coeff.var.')
set(gca,'Fontsize',20,'linewidth',2)
set(gcf,'color','w');grid on
xlim([0,numel(Coefficient_Variation)+1])
ylim([0,max(Coefficient_Variation)+1])
set(gcf,'Position',[633,466,750,535])
print(gcf,[pathsavefig,'Coeffvar.pdf'],'-dpdf','-bestfit')
close gcf

% plot histogram of mse
figure
xx = min(scores_select)-1:1.5:max(scores_select)+1;
h = histogram(scores_select,xx,'EdgeColor','none','FaceColor','b');hold on
xlabel('MSE');
ylabel({'Histogram of MSE on parameters set'})
set(gca,'Fontsize',20,'linewidth',2)
set(gcf,'color','w')
set(gcf,'Position',[633,466,750,535])
ylim([0,max(h.Values)+1]);
grid on
print(gcf,[pathsavefig,'HistogramMSE.pdf'],'-dpdf','-bestfit')
close gcf

Num_protein = 4;
Num_months = 12;
Num_days = 28;
Num_E2days = 11;
Num_ICI500nMdays = 21;
Num_palbo500nMdays = 28;
Num_palbo1uMdays = 21;
Num_hours = 24;

cyclinE1 = zeros(Num_select,Num_protein);
cdk6 = zeros(Num_select,Num_protein);
synergy = zeros(Num_select,Num_protein);
cellnumE2 = zeros(Num_E2days*Num_hours+1,Num_select);
cellnumICI500nM = zeros(Num_ICI500nMdays*Num_hours+1,Num_select);
cellnumpalbo500nM = zeros(Num_palbo500nMdays*Num_hours+1,Num_select);
cellnumpalbo1uM  = zeros(Num_palbo1uMdays*Num_hours+1,Num_select);

% Restart each month, so the total number of timepoints equals Num_months * Num_days * Num_hours + Num_months.
cellnumpalbo750nM_12m = zeros(Num_months*Num_days*Num_hours+Num_months,Num_select);
cdk6palbo750nM_12m = zeros(Num_months*Num_days*Num_hours+Num_months,Num_select);
cyclinE1palbo750nM_12m = zeros(Num_months*Num_days*Num_hours+Num_months,Num_select);

cellnumICI750nM_12m = zeros(Num_months*Num_days*Num_hours+Num_months,Num_select);
cdk6ICI750nM_12m = zeros(Num_months*Num_days*Num_hours+Num_months,Num_select);
cyclinE1ICI750nM_12m = zeros(Num_months*Num_days*Num_hours+Num_months,Num_select);

cellnumAlter_palbo_ICI = zeros(Num_months*Num_days*Num_hours+Num_months,Num_select);
cdk6Alter_palbo_ICI = zeros(Num_months*Num_days*Num_hours+Num_months,Num_select);
cyclinE1Alter_palbo_ICI = zeros(Num_months*Num_days*Num_hours+Num_months,Num_select);

cellnumAlter_palbo_ICIAZD = zeros(Num_months*Num_days*Num_hours+Num_months,Num_select);
cdk6Alter_palbo_ICIAZD = zeros(Num_months*Num_days*Num_hours+Num_months,Num_select);
cyclinE1Alter_palbo_ICIAZD = zeros(Num_months*Num_days*Num_hours+Num_months,Num_select);

cellnumAZD = zeros(Num_days*Num_hours+1,Num_select);
cellnumICIAZD = zeros(Num_days*Num_hours+1,Num_select);
for i = 1:size(population_select,1)
    disp(i)
    i_data = E2ICIpalboAZD_result(population_select(i,:));

    tE2 = i_data.tE2;
    tICI500nM = i_data.tICI500nM;
    tpalbo500nM = i_data.tpalbo500nM;
    tpalbo1uM = i_data.tpalbo1uM;
    tpalbo750nM_12m = i_data.tpalbo750nM_12m;
    tICI750nM_12m = i_data.tICI750nM_12m;
    tAlter_palbo_ICI = i_data.tAlter_palbo_ICI;
    tAlter_palbo_ICIAZD = i_data.tAlter_palbo_ICIAZD;
    tAZD = i_data.tAZD250nM;
    tICIAZD = i_data.tICIAZD;

    i_cyclinE1_palbo_w1 = i_data.cyclinE1_palbo_w1;
    i_cyclinE1_palbo_w2 = i_data.cyclinE1_palbo_w2;
    i_cyclinE1_palbo_m12 = i_data.cyclinE1_palbo_m12;
    i_cyclinE1_alter_m12 = i_data.cyclinE1_alter_m12;

    i_cdk6_ICI_w1 = i_data.cdk6_ICI_w1;
    i_cdk6_ICI_w2 = i_data.cdk6_ICI_w2;
    i_cdk6_ICI_m12 = i_data.cdk6_ICI_m12;
    i_cdk6_ICI_alter_m12 = i_data.cdk6_alter_m12;
    cyclinE1(i,:) = [i_cyclinE1_palbo_w1,i_cyclinE1_palbo_w2,i_cyclinE1_palbo_m12,i_cyclinE1_alter_m12];
    cdk6(i,:) = [i_cdk6_ICI_w1,i_cdk6_ICI_w2,i_cdk6_ICI_m12,i_cdk6_ICI_alter_m12];

    i_cellnumICI200nM_d17 = i_data.cellnumICI200nM_d17;
    i_cellnumICI200nM_palbo50nM_d17 = i_data.cellnumICI200nM_palbo50nM_d17;
    i_cellnumICI200nM_palbo100nM_d17 = i_data.cellnumICI200nM_palbo100nM_d17;
    i_cellnumICI200nM_palbo300nM_d17 = i_data.cellnumICI200nM_palbo300nM_d17;
    i_synergy = [i_cellnumICI200nM_d17,...
                 i_cellnumICI200nM_palbo50nM_d17,...
                 i_cellnumICI200nM_palbo100nM_d17,...
                 i_cellnumICI200nM_palbo300nM_d17];
    synergy(i,:) = i_synergy;
    
    cellnumE2(:,i) = i_data.cellnumE2;
    cellnumICI500nM(:,i) = i_data.cellnumICI500nM;
    cellnumpalbo500nM(:,i) = i_data.cellnumpalbo500nM;
    cellnumpalbo1uM(:,i) = i_data.cellnumpalbo1uM;

    cellnumpalbo750nM_12m(:,i) = i_data.cellnumpalbo750nM_12m;
    cdk6palbo750nM_12m(:,i) = i_data.cdk6palbo750nM_12m;
    cyclinE1palbo750nM_12m(:,i) = i_data.cyclinE1palbo750nM_12m;

    cellnumICI750nM_12m(:,i) = i_data.cellnumICI750nM_12m;
    cdk6ICI750nM_12m(:,i) = i_data.cdk6ICI750nM_12m;
    cyclinE1ICI750nM_12m(:,i) = i_data.cyclinE1ICI750nM_12m;

    cellnumAlter_palbo_ICI(:,i) = i_data.cellnumAlter_palbo_ICI;
    cdk6Alter_palbo_ICI(:,i) = i_data.cdk6Alter_palbo_ICI;
    cyclinE1Alter_palbo_ICI(:,i) = i_data.cyclinE1Alter_palbo_ICI;

    cellnumAlter_palbo_ICIAZD(:,i) = i_data.cellnumAlter_palbo_ICIAZD;
    cdk6Alter_palbo_ICIAZD(:,i) = i_data.cdk6Alter_palbo_ICIAZD;
    cyclinE1Alter_palbo_ICIAZD(:,i) = i_data.cyclinE1Alter_palbo_ICIAZD;

    cellnumAZD(:,i) = i_data.cellnumAZD;
    cellnumICIAZD(:,i) = i_data.cellnumICIAZD;
end

writematrix(tE2,[pathsavexls,'tE2.xls'])
writematrix(tICI500nM,[pathsavexls,'tICI500nM.xls'])
writematrix(tpalbo500nM,[pathsavexls,'tpalbo500nM.xls'])
writematrix(tpalbo1uM,[pathsavexls,'tpalbo1uM.xls'])
writematrix(tpalbo750nM_12m,[pathsavexls,'tpalbo750nM_12m.xls'])
writematrix(tICI750nM_12m,[pathsavexls,'tICI750nM_12m.xls'])
writematrix(tAlter_palbo_ICI,[pathsavexls,'tAlter_palbo_ICI_12m.xls'])
writematrix(tAlter_palbo_ICIAZD,[pathsavexls,'tAlter_palbo_ICIAZD_12m.xls'])
writematrix(tAZD,[pathsavexls,'tAZD.xls'])
writematrix(tICIAZD,[pathsavexls,'tICIAZD.xls'])
writematrix(cyclinE1,[pathsavexls,'cyclinE1.xls']);
writematrix(cdk6,[pathsavexls,'cdk6.xls']);
writematrix(synergy,[pathsavexls,'synergy.xls']);

cellnumE2_minmax = child_minmax(cellnumE2);
cellnumE2 = [tE2,cellnumE2_minmax,cellnumE2(:,1)];
cellnumE2 = child_unique(cellnumE2);

cellnumICI500nM_minmax = child_minmax(cellnumICI500nM);
cellnumICI500nM = [tICI500nM,cellnumICI500nM_minmax,cellnumICI500nM(:,1)];
cellnumICI500nM = child_unique(cellnumICI500nM);

cellnumpalbo500nM_minmax = child_minmax(cellnumpalbo500nM);
cellnumpalbo500nM = [tpalbo500nM,cellnumpalbo500nM_minmax,cellnumpalbo500nM(:,1)];
cellnumpalbo500nM = child_unique(cellnumpalbo500nM);

cellnumpalbo1uM_minmax = child_minmax(cellnumpalbo1uM);
cellnumpalbo1uM = [tpalbo1uM,cellnumpalbo1uM_minmax,cellnumpalbo1uM(:,1)];
cellnumpalbo1uM = child_unique(cellnumpalbo1uM);

cellnumpalbo750nM_12m_minmax = child_minmax(cellnumpalbo750nM_12m);
cellnumpalbo750nM_12m = [tpalbo750nM_12m,cellnumpalbo750nM_12m_minmax,cellnumpalbo750nM_12m(:,1)];
cellnumpalbo750nM_12m = child_unique(cellnumpalbo750nM_12m);

cellnumICI750nM_12m_minmax = child_minmax(cellnumICI750nM_12m);
cellnumICI750nM_12m = [tICI750nM_12m,cellnumICI750nM_12m_minmax,cellnumICI750nM_12m(:,1)];
cellnumICI750nM_12m = child_unique(cellnumICI750nM_12m);

cellnumAlter_palbo_ICI_minmax = child_minmax(cellnumAlter_palbo_ICI);
cellnumAlter_palbo_ICI = [tAlter_palbo_ICI,cellnumAlter_palbo_ICI_minmax,cellnumAlter_palbo_ICI(:,1)];
cellnumAlter_palbo_ICI = child_unique(cellnumAlter_palbo_ICI);

cellnumAlter_palbo_ICIAZD_minmax = child_minmax(cellnumAlter_palbo_ICIAZD);
cellnumAlter_palbo_ICIAZD = [tAlter_palbo_ICIAZD,cellnumAlter_palbo_ICIAZD_minmax,cellnumAlter_palbo_ICIAZD(:,1)];
cellnumAlter_palbo_ICIAZD = child_unique(cellnumAlter_palbo_ICIAZD);

cellnumAZD_minmax = child_minmax(cellnumAZD);
cellnumAZD =[tAZD,cellnumAZD_minmax,cellnumAZD(:,1)];
cellnumAZD = child_unique(cellnumAZD);

cellnumICIAZD_minmax = child_minmax(cellnumICIAZD);
cellnumICIAZD = [tICIAZD,cellnumICIAZD_minmax,cellnumICIAZD(:,1)];
cellnumICIAZD = child_unique(cellnumICIAZD);

cdk6palbo750nM_12m_minmax = child_minmax(cdk6palbo750nM_12m);
cdk6palbo750nM_12m = [tpalbo750nM_12m,cdk6palbo750nM_12m_minmax,cdk6palbo750nM_12m(:,1)];
cdk6palbo750nM_12m = child_unique(cdk6palbo750nM_12m);

cyclinE1palbo750nM_12m_minmax = child_minmax(cyclinE1palbo750nM_12m);
cyclinE1palbo750nM_12m = [tpalbo750nM_12m,cyclinE1palbo750nM_12m_minmax,cyclinE1palbo750nM_12m(:,1)];
cyclinE1palbo750nM_12m = child_unique(cyclinE1palbo750nM_12m);

cdk6ICI750nM_12m_minmax = child_minmax(cdk6ICI750nM_12m);
cdk6ICI750nM_12m = [tICI750nM_12m,cdk6ICI750nM_12m_minmax,cdk6ICI750nM_12m(:,1)];
cdk6ICI750nM_12m = child_unique(cdk6ICI750nM_12m);

cyclinE1ICI750nM_12m_minmax = child_minmax(cyclinE1ICI750nM_12m);
cyclinE1ICI750nM_12m = [tICI750nM_12m,cyclinE1ICI750nM_12m_minmax,cyclinE1ICI750nM_12m(:,1)];
cyclinE1ICI750nM_12m = child_unique(cyclinE1ICI750nM_12m);

cdk6Alter_palbo_ICI_minmax = child_minmax(cdk6Alter_palbo_ICI);
cdk6Alter_palbo_ICI = [tAlter_palbo_ICI,cdk6Alter_palbo_ICI_minmax,cdk6Alter_palbo_ICI(:,1)];
cdk6Alter_palbo_ICI = child_unique(cdk6Alter_palbo_ICI);

cyclinE1Alter_palbo_ICI_minmax = child_minmax(cyclinE1Alter_palbo_ICI);
cyclinE1Alter_palbo_ICI = [tAlter_palbo_ICI,cyclinE1Alter_palbo_ICI_minmax,cyclinE1Alter_palbo_ICI(:,1)];
cyclinE1Alter_palbo_ICI = child_unique(cyclinE1Alter_palbo_ICI);

cdk6Alter_palbo_ICIAZD_minmax = child_minmax(cdk6Alter_palbo_ICIAZD);
cdk6Alter_palbo_ICIAZD = [tAlter_palbo_ICIAZD,cdk6Alter_palbo_ICIAZD_minmax,cdk6Alter_palbo_ICIAZD(:,1)];
cdk6Alter_palbo_ICIAZD  = child_unique(cdk6Alter_palbo_ICIAZD);

cyclinE1Alter_palbo_ICIAZD_minmax = child_minmax(cyclinE1Alter_palbo_ICIAZD);
cyclinE1Alter_palbo_ICIAZD = [tAlter_palbo_ICIAZD,cyclinE1Alter_palbo_ICIAZD_minmax,cyclinE1Alter_palbo_ICIAZD(:,1)];
cyclinE1Alter_palbo_ICIAZD = child_unique(cyclinE1Alter_palbo_ICIAZD);

writematrix(cellnumE2,[pathsavexls,'cellnumE2.xls']);
writematrix(cellnumICI500nM,[pathsavexls,'cellnumICI500nM.xls']);
writematrix(cellnumpalbo500nM,[pathsavexls,'cellnumpalbo500nM.xls']);   
writematrix(cellnumpalbo1uM,[pathsavexls,'cellnumpalbo1uM.xls']);  

writematrix(cellnumpalbo750nM_12m,[pathsavexls,'cellnumpalbo750nM_12m.xls']);
writematrix(cdk6palbo750nM_12m,[pathsavexls,'cdk6palbo750nM_12m.xls']);
writematrix(cyclinE1palbo750nM_12m,[pathsavexls,'cylinE1palbo750nM_12m.xls']);

writematrix(cellnumICI750nM_12m,[pathsavexls,'cellnumICI750nM_12m.xls']);
writematrix(cdk6ICI750nM_12m,[pathsavexls,'cdk6ICI750nM_12m.xls']);
writematrix(cyclinE1ICI750nM_12m,[pathsavexls,'cylinE1ICI750nM_12m.xls']);

writematrix(cellnumAlter_palbo_ICI,[pathsavexls,'cellnumAlter_palbo_ICI.xls'])
writematrix(cdk6Alter_palbo_ICI,[pathsavexls,'cdk6Alter_palbo_ICI.xls']);
writematrix(cyclinE1Alter_palbo_ICI,[pathsavexls,'cyclinE1Alter_palbo_ICI.xls']);

writematrix(cellnumAlter_palbo_ICIAZD,[pathsavexls,'cellnumAlter_palbo_ICIAZD.xls'])
writematrix(cdk6Alter_palbo_ICIAZD,[pathsavexls,'cdk6Alter_palbo_ICIAZD.xls']);
writematrix(cyclinE1Alter_palbo_ICIAZD,[pathsavexls,'cyclinE1Alter_palbo_ICIAZD.xls']);

writematrix(cellnumAZD,[pathsavexls,'cellnumAZD.xls'])
writematrix(cellnumICIAZD,[pathsavexls,'cellnumICIAZD.xls'])
end

function fval = child_max(ind_opt,populationT,mse_error,groupparall,flag_showfval)
flag_integer = arrayfun(@(x)mod(x,1) == 0, ind_opt);
if ~all(flag_integer)
    fval = mse_error;
    return
end

population_select = populationT(ind_opt,groupparall);
meanPAR = mean(population_select);
varPAR = var(population_select);
Percentage = sqrt(varPAR)./meanPAR * 100;
Percentage = -log10(Percentage);
fval = max(Percentage);
if flag_showfval
    disp(fval)
end
end

function out = child_minmax(data)
data_min = min(data,[],2);
data_max = max(data,[],2);
out = [data_min,data_max];
end

function out = child_unique(data)
[C,ia] = unique(data(:,1));
assert(all(diff(C) == 1))
out = data(ia,:);
end
