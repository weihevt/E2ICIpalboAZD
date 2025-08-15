function args = E2ICIpalboAZD_modelpar()
% This function generates the necessary parameters for the model simulation.
pathload = './mat/';
[~,lb,ub,grouppar,groupparall,power_ind] = E2ICIpalboAZD_par();
PAR = load([pathload, 'PAR.mat']).PAR;

% protein name
proteinname = ["cMyc","cyclinD1","ppRb","Rbt"];
modelvariable = ["E2media",...                  %(1)
                 "E2cell",...                   %(2)
                 "ER",...                       %(3)
                 "E2ER",...                     %(4)
                 "ICIER",...                    %(5)
                 "res_cyclinEpalbo",...         %(6)
                 "res_cdk6ICI",...              %(7) 
                 "cyclinD1",...                 %(8)
                 "cdk4",...                     %(9)
                 "cdk6",...                     %(10)
                 "cyclinD1/cdk4",...            %(11)
                 "cyclinD1/cdk6",...            %(12)
                 "cyclinD1/cdk4/p21",...        %(13)
                 "cyclinD1/cdk6/p21",...        %(14)
                 "cyclinD1/cdk4/palbo",...      %(15)
                 "cyclinD1/cdk6/palbo",...      %(16)
                 "cyclinD1/cdk4/p21/palbo",...  %(17)
                 "cyclinD1/cdk6/p21/palbo",...  %(18)
                 "cMyc",...                     %(19)
                 "p21",...                      %(20)
                 "cyclinE",...                  %(21)
                 "Rb",...                       %(22)
                 "pRb",...                      %(23)
                 "ppRb",...                     %(24)
                 "alive cells",...              %(25)
                 "dead cells"];                 %(26)

timepoint_protein = [0,3,5,6,7]; % day
timepoint_pro = [0,1,3,6,7,14,21,28]; % day
daypermonth = 28;
Numvariable = numel(modelvariable);
RelTolval = 1e-3;
AbsTolval = 1e-6;
mse_error = 1e400;
penalty = 1e4;
maxconcentration = 9e3; % maximum concentration of all state variables
ind_max = 1:Numvariable;
ind_max(ismember(ind_max,[25,...  % alive cell
                          26]...  % dead cell
                          )) = [];
minconcentration = -1e-2; % minimum concentration of all state variables
similartolerance = 2e-3;
ind_apopratioT0 = 94;

E2mediaindex = 1;
odefun = @ode23tb; %ode23s, ode23t, ode23tb
ValE2normal = 10;  % E2(10nM)
ValICI100nM = 100; % ICI(100nM)
ValICI200nM = 200; % ICI(200nM)
ValICI400nM = 400; % ICI(200nM)
ValICI500nM = 500; % ICI(500nM)
ValICI750nM = 750; % ICI(500nM)
Valpalbo50nM = 50; % palbo(50nM)
Valpalbo100nM = 100; % palbo(100nM)
Valpalbo200nM = 200; % palbo(200nM)
Valpalbo250nM = 250; % palbo(250nM)
Valpalbo300nM = 300; % palbo(300nM)
Valpalbo500nM = 500; % palbo(500nM)
Valpalbo750nM = 750; % palbo(750nM)
Valpalbo1uM = 1000; % palbo(1uM)
ValAZD250nM = 250; % AZD(250nM)
% index of protein in simresult (E2depICIpalbo_assignval), calculate in fitting westernblot
ind_protein = [1,... % cMyc
               2,... % cyclinD1
               3,... % ppRb
               4];   % Rbtotal
% index of cell num in simresult (E2depICIpalbo_assignval), calculate in fitting cell num
ind_cellnum = 6;

% index of cMyc in variable x
ind_containcMyc = 20; % cMyc
% index of variable in x containing cyclinD1
ind_containcyclinD1 = [8,...  % cyclinD1
                       11,...  % cyclinD1/cdk4
                       12,...  % cyclinD1/cdk6
                       13,...  % cyclinD1/cdk4/p21
                       14,...  % cyclinD1/cdk6/p21
                       15,...  % cyclinD1/cdk4/palbo
                       16,...  % cyclinD1/cdk6/palbo
                       17,...  % cyclinD1/cdk4/p21/palbo
                       18];... % cyclinD1/cdk6/p21/palbo    
% index of variable in x containing cyclinE1
ind_containcyclinE1 = 21;  % cyclinE1
% index of variable in x containing cdk46
ind_containcdk46 = [9,...  % cdk4
                    10,...  % cdk6
                    11,...  % cyclinD1/cdk4
                    12,...  % cyclinD1/cdk6
                    13,...  % cyclinD1/cdk4/p21
                    14,...  % cyclinD1/cdk6/p21
                    15,...  % cyclinD1/cdk4/palbo
                    16,...  % cyclinD1/cdk6/palbo
                    17,...  % cyclinD1/cdk4/p21/palbo
                    18];... % cyclinD1/cdk6/p21/palbo
% index of variable in x containing cdk4
ind_containcdk4 = [9,...  % cdk4
                   11,...  % cyclinD1/cdk4
                   13,...  % cyclinD1/cdk4/p21
                   15,...  % cyclinD1/cdk4/palbo
                   17];    % cyclinD1/cdk4/p21/palbo
% index of variable in x containing cdk6
ind_containcdk6 = [10,...  % cdk6
                   12,...  % cyclinD1/cdk6
                   14,...  % cyclinD1/cdk6/p21
                   16,...  % cyclinD1/cdk6/palbo
                   18];... % cyclinD1/cdk6/p21/palbo
% index of variable in x containing cyclinD1/cdk46
ind_containcyclinD1cdk46 = [11,... % cyclinD1/cdk4
                            12];   % cyclinD1/cdk6
% index of cyclinD1/cdk4 in x
ind_containcyclinD1cdk4 = 11;  % cyclinD1/cdk4
% index of cyclinD1/cdk6 in x
ind_containcyclinD1cdk6 = 12;  % cyclinD1/cdk6
% index of ppRb in variable x
ind_containppRb = 24;
% index of variable x containing total RB1
ind_containRb1 = [22,...  % Rb
                  23,...  % pRb
                  24];    % ppRb
% index of alive cell in variable x
ind_containalivecell = 25;
% index of dead cell in variable x
ind_containdeadcell = 26;

% index reset
ind_reset = [5,...   % ICIER
             6,...   % res_cyclinEpalbo
             7,...   % res_cdk6ICI
             15,...  % cyclinD1/cdk4/palbo
             16,...  % cyclinD1/cdk6/palbo
             17,...  % cyclinD1/cdk4/p21/palbo
             18,...  % cyclinD1/cdk6/p21/palbo
             Numvariable-1,... % alive cells
             Numvariable]; % dead cells

% treat
% no treatment
treat_non.E2in = ValE2normal;
treat_non.ICI = 0;
treat_non.palbo = 0;
treat_non.AZD = 0;
% E2(10nM)+ICI(100nM)
treat_ICI100nM.E2in = ValE2normal;
treat_ICI100nM.ICI = ValICI100nM;
treat_ICI100nM.palbo = 0;
treat_ICI100nM.AZD = 0;
% E2(10nM)+ICI(200nM)
treat_ICI200nM.E2in = ValE2normal;
treat_ICI200nM.ICI = ValICI200nM;
treat_ICI200nM.palbo = 0;
treat_ICI200nM.AZD = 0;
% E2(10nM)+ICI(500nM)
treat_ICI500nM.E2in = ValE2normal;
treat_ICI500nM.ICI = ValICI500nM;
treat_ICI500nM.palbo = 0;
treat_ICI500nM.AZD = 0;
% E2(10nM)+ICI(750nM)
treat_ICI750nM.E2in = ValE2normal;
treat_ICI750nM.ICI = ValICI750nM;
treat_ICI750nM.palbo = 0;
treat_ICI750nM.AZD = 0;
% E2(10nM)+palbo(250nM)
treat_palbo250nM.E2in = ValE2normal;
treat_palbo250nM.ICI = 0;
treat_palbo250nM.palbo = Valpalbo250nM;
treat_palbo250nM.AZD = 0;
% E2(10nM)+palbo(500nM)
treat_palbo500nM.E2in = ValE2normal;
treat_palbo500nM.ICI = 0;
treat_palbo500nM.palbo = Valpalbo500nM;
treat_palbo500nM.AZD = 0;
% E2(10nM)+palbo(750nM)
treat_palbo750nM.E2in = ValE2normal;
treat_palbo750nM.ICI = 0;
treat_palbo750nM.palbo = Valpalbo750nM;
treat_palbo750nM.AZD = 0;
% E2(10nM)+palbo(1uM)
treat_palbo1uM.E2in = ValE2normal;
treat_palbo1uM.ICI = 0;
treat_palbo1uM.palbo = Valpalbo1uM;
treat_palbo1uM.AZD = 0;
% E2(10nM)+AZD(250nM)
treat_AZD250nM.E2in = ValE2normal;
treat_AZD250nM.ICI = 0;
treat_AZD250nM.palbo = 0;
treat_AZD250nM.AZD = ValAZD250nM;
% E2(10nM)+ICI(400nM)+palbo(200nM)
treat_ICI400nM_palbo200nM.E2in = ValE2normal;
treat_ICI400nM_palbo200nM.ICI = ValICI400nM;
treat_ICI400nM_palbo200nM.palbo = Valpalbo200nM;
treat_ICI400nM_palbo200nM.AZD = 0;
% E2(10nM)+ICI(500nM)+palbo(750nM)
treat_ICI500nM_palbo750nM.E2in = ValE2normal;
treat_ICI500nM_palbo750nM.ICI = ValICI500nM;
treat_ICI500nM_palbo750nM.palbo = Valpalbo750nM;
treat_ICI500nM_palbo750nM.AZD = 0;
% E2(10nM)+ICI(200nM)+palbo(50nM)
treat_ICI200nM_palbo50nM.E2in = ValE2normal;
treat_ICI200nM_palbo50nM.ICI = ValICI200nM;
treat_ICI200nM_palbo50nM.palbo = Valpalbo50nM;
treat_ICI200nM_palbo50nM.AZD = 0;
% E2(10nM)+ICI(200nM)+palbo(100nM)
treat_ICI200nM_palbo100nM.E2in = ValE2normal;
treat_ICI200nM_palbo100nM.ICI = ValICI200nM;
treat_ICI200nM_palbo100nM.palbo = Valpalbo100nM;
treat_ICI200nM_palbo100nM.AZD = 0;
% E2(10nM)+ICI(200nM)+palbo(300nM)
treat_ICI200nM_palbo300nM.E2in = ValE2normal;
treat_ICI200nM_palbo300nM.ICI = ValICI200nM;
treat_ICI200nM_palbo300nM.palbo = Valpalbo300nM;
treat_ICI200nM_palbo300nM.AZD = 0;
% E2(10nM)+ICI(750nM)+AZD(250nM)
treat_ICI750nM_AZD250nM.E2in = ValE2normal;
treat_ICI750nM_AZD250nM.ICI = ValICI750nM;
treat_ICI750nM_AZD250nM.palbo = 0;
treat_ICI750nM_AZD250nM.AZD = ValAZD250nM;

args.proteinname = proteinname; clearvars proteinname
args.modelvariable = modelvariable; clearvars modelvariable
args.timepoint_protein = timepoint_protein; clearvars timepoint_protein
args.timepoint_pro = timepoint_pro;clearvars timepoint_pro;
args.daypermonth = daypermonth; clearvars daypermonth;
args.Numvariable = Numvariable; clearvars Numvariable
args.RelTolval = RelTolval; clearvars RelTolval
args.AbsTolval = AbsTolval; clearvars AbsTolval
args.mse_error = mse_error; clearvars mse_error
args.penalty = penalty; clearvars penalty
args.maxconcentration = maxconcentration; clearvars maxconcentration
args.minconcentration = minconcentration; clearvars minconcentration
args.similartolerance= similartolerance; clearvars similartolerance
args.ind_max = ind_max; clearvars ind_max
args.ind_apopratioT0 = ind_apopratioT0; clearvars ind_apopratioT0
args.E2mediaindex = E2mediaindex; clearvars E2mediaindex
args.odefun = odefun; clearvars odefun
args.ValE2normal = ValE2normal; clearvars ValE2normal
args.ValICI100nM = ValICI100nM; clearvars ValICI100nM
args.ValICI200nM = ValICI200nM; clearvars ValICI200nM
args.ValICI500nM = ValICI500nM; clearvars ValICI500nM
args.ValICI750nM = ValICI750nM; clearvars ValICI750nM
args.ValPalbo100nM = Valpalbo100nM; clearvars ValPalbo100nM 
args.ValPalbo250nM = Valpalbo250nM; clearvars ValPalbo250nM
args.ValPalbo500nM = Valpalbo500nM; clearvars ValPalbo500nM
args.ValPalbo750nM = Valpalbo750nM; clearvars ValPalbo750nM
args.ValPalbo1uM = Valpalbo1uM; clearvars ValPalbo1uM
args.ind_protein = ind_protein; clearvars ind_protein
args.ind_cellnum = ind_cellnum; clearvars ind_cellalive

args.ind_containcMyc = ind_containcMyc; clearvars ind_containcMyc
args.ind_containcyclinD1 = ind_containcyclinD1; clearvars ind_containcyclinD1
args.ind_containcyclinE1 = ind_containcyclinE1; clearvars ind_containcyclinE1
args.ind_containcdk46 = ind_containcdk46; clearvars ind_containcdk46
args.ind_containcdk4 = ind_containcdk4; clearvars ind_containcdk4
args.ind_containcdk6 = ind_containcdk6; clearvars ind_containcdk6
args.ind_containcyclinD1cdk4 = ind_containcyclinD1cdk4; clearvars ind_containcyclinD1cdk4
args.ind_containcyclinD1cdk6 = ind_containcyclinD1cdk6; clearvars ind_containcyclinD1cdk6
args.ind_containcyclinD1cdk46 = ind_containcyclinD1cdk46; clearvars ind_containcyclinD1cdk46
args.ind_containppRb = ind_containppRb; clearvars ind_containppRb
args.ind_containRb1 = ind_containRb1; clearvars ind_containRB1
args.ind_containalivecell = ind_containalivecell; clearvars ind_containalivecell
args.ind_containdeadcell = ind_containdeadcell; clearvars ind_containdeadcell

args.ind_reset = ind_reset; clearvars ind_reset
args.PAR = PAR; clearvars PAR
args.lb = lb; clearvars lb
args.ub = ub; clearvars ub
args.grouppar = grouppar; clearvars grouppar
args.groupparall = groupparall; clearvars groupparall
args.power_ind = power_ind; clearvars power_ind
args.treat_non = treat_non; clearvars treat_non
args.treat_ICI100nM = treat_ICI100nM; clearvars treat_ICI100nM
args.treat_ICI500nM = treat_ICI500nM; clearvars treat_ICI500nM
args.treat_ICI200nM = treat_ICI200nM; clearvars treat_ICI200nM
args.treat_ICI750nM = treat_ICI750nM; clearvars treat_ICI750nM
args.treat_palbo250nM = treat_palbo250nM; clearvars treat_palbo250nM
args.treat_palbo500nM = treat_palbo500nM; clearvars treat_palbo500nM
args.treat_palbo750nM = treat_palbo750nM; clearvars treat_palbo750nM
args.treat_palbo1uM = treat_palbo1uM; clearvars treat_palbo750nM
args.treat_AZD250nM = treat_AZD250nM; clearvars treat_AZD250nM
args.treat_ICI200nM_palbo50nM = treat_ICI200nM_palbo50nM; clearvars treat_ICI200nM_palbo50nM
args.treat_ICI200nM_palbo100nM = treat_ICI200nM_palbo100nM; clearvars treat_ICI200nM_palbo100nM
args.treat_ICI200nM_palbo300nM = treat_ICI200nM_palbo300nM; clearvars treat_ICI200nM_palbo300nM
args.treat_ICI400nM_palbo200nM = treat_ICI400nM_palbo200nM; clearvars treat_ICI400nM_palbo200nM
args.treat_ICI500nM_palbo750nM = treat_ICI500nM_palbo750nM; clearvars treat_ICI500nM_palbo750nM
args.treat_ICI750nM_AZD250nM = treat_ICI750nM_AZD250nM; clearvars treat_ICI500nM_AZD250nM
end