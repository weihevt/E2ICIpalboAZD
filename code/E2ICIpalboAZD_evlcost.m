function cost = E2ICIpalboAZD_evlcost(parop,args,ind,i_group,opt)
% Function for parameter estimation during optimization.
if opt
   args.PAR(ind) = parop;
end

ind = E2ICIpalboAZD_1steadystate(args);
if ind
    cost = args.mse_error;return;
end

% initial value of variables
x0 = zeros(args.Numvariable,1);
x0(args.E2mediaindex) = args.ValE2normal;
x0 = E2ICIpalboAZD_replating(x0,args);

tspan = [0,24 * 30];
[~,~,xinitial,mse_use] = E2ICIpalboAZD_sim(x0,tspan,args.treat_non,args);
if ~isnan(mse_use)
    cost = args.mse_error;return;
end
%% set the initial state
x0 = xinitial(end,:);
%% --------different treatment---------%%
%% (1)E2(10nM)
tspan = [0,720];
x0(args.ind_reset) = 0;
x0 = E2ICIpalboAZD_replating(x0,args);
[tE2,simE2,~,mse_use] = E2ICIpalboAZD_sim(x0,tspan,args.treat_non,args);
if ~isnan(mse_use);cost = args.mse_error;return;end
%% (2)E2(10nM)+ICI(500nM)
[tICI500nM,simICI500nM,~,mse_use] = E2ICIpalboAZD_sim(x0,tspan,args.treat_ICI500nM,args);
if ~isnan(mse_use);cost = args.mse_error;return;end
%% (3)E2(10nM)+palbo(250nM)
[tpalbo250nM,simpalbo250nM,~,mse_use] = E2ICIpalboAZD_sim(x0,tspan,args.treat_palbo250nM,args);
if ~isnan(mse_use);cost = args.mse_error;return;end
%% (4)E2(10nM)+palbo(500nM)
[tpalbo500nM,simpalbo500nM,~,mse_use] = E2ICIpalboAZD_sim(x0,tspan,args.treat_palbo500nM,args);
if ~isnan(mse_use);cost = args.mse_error;return;end
%% (4)E2(10nM)+palbo(1uM)
[tpalbo1uM,simpalbo1uM,~,mse_use] = E2ICIpalboAZD_sim(x0,tspan,args.treat_palbo1uM,args);
if ~isnan(mse_use);cost = args.mse_error;return;end
%% (5)Alternating treatment over 12 months
x0 = xinitial(end,:);
x0(args.ind_reset) = 0;
x0 = E2ICIpalboAZD_replating(x0,args);
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
[tpalbo750nM_13m,...
 simpalbo750nM_13m,...
 xpalbo750nM_13m,...
 mse_use] = E2ICIpalboAZD_simalternation(x0,tspan,treatalter,cycletime,replate,args);
if ~isnan(mse_use);cost = args.mse_error;return;end
clearvars treatalter

% E2(10nM)+ICI(750nM) mono
for i = 1: Num_month
    treatalter{i}.treat = args.treat_ICI750nM;
    treatalter{i}.duration = args.daypermonth;
end
[tICI750nM_13m,...
 simICI750nM_13m,...
 xICI750nM_13m,...
 mse_use] = E2ICIpalboAZD_simalternation(x0,tspan,treatalter,cycletime,replate,args);
if ~isnan(mse_use);cost = args.mse_error;return;end

% E2(10nM)+AZD(250nM) mono
for i = 1:Num_month
    treatalter{i}.treat = args.treat_AZD250nM;
    treatalter{i}.duration = args.daypermonth;
end
[tAZD250nM_13m,...
 simAZD250nM_13m,~,...
 mse_use] = E2ICIpalboAZD_simalternation(x0,tspan,treatalter,cycletime,replate,args);
if ~isnan(mse_use);cost = args.mse_error;return;end

% E2(10nM)+AZD(250nM)+ICI(750nM) mono
for i = 1:Num_month
    treatalter{i}.treat = args.treat_ICI750nM_AZD250nM;
    treatalter{i}.duration = args.daypermonth;
end
[tICI750nMAZD250nM_13m,...
 simICI750nMAZD250nM_13m,~,...
 mse_use] = E2ICIpalboAZD_simalternation(x0,tspan,treatalter,cycletime,replate,args);
if ~isnan(mse_use);cost = args.mse_error;return;end

% Alter: E2(10nM)+palbo(750nM) -> E2(10nM)+ICI(750nM)
for i = 1:Num_month
    if mod(i,2) == 1
        treatalter{i}.treat = args.treat_palbo750nM;
    else
        treatalter{i}.treat = args.treat_ICI750nM;
    end
    treatalter{i}.duration = args.daypermonth;
end
[tAlter_palbo750nM_ICI750nM_13m,...
 simAlter_palbo750nM_ICI750nM_13m,...
 xAlter_palbo750nM_ICI750nM,...
 mse_use] = E2ICIpalboAZD_simalternation(x0,tspan,treatalter,cycletime,replate,args);
if ~isnan(mse_use);cost = args.mse_error;return;end

% Alter: E2(10nM)+palbo(750nM) -> E2(10nM)+ICI(750nM)+AZD(250nM)
for i = 1: Num_month
    if mod(i,2) == 1
        treatalter{i}.treat = args.treat_palbo750nM;
    else
        treatalter{i}.treat = args.treat_ICI750nM_AZD250nM;
    end
    treatalter{i}.duration = args.daypermonth;
end
[tAlter_palbo750nM_ICI750nMAZD250nM_13m,...
 simAlter_palbo750nM_ICI750nMAZD250nM_13m,...
 xAlter_palbo750nM_ICI750nMAZD250nM_13m,...
 mse_use] = E2ICIpalboAZD_simalternation(x0,tspan,treatalter,cycletime,replate,args);
if ~isnan(mse_use);cost = args.mse_error;return;end
%% synergy
tspan = [0, 17 * 24];
% E2(10nM)+ICI(200nM)
x0(args.E2mediaindex) = xinitial(args.E2mediaindex);
[tICI200nM_d17,simICI200nM_d17,~,mse_use] = E2ICIpalboAZD_sim(x0,tspan,args.treat_ICI200nM,args);
if ~isnan(mse_use);cost = args.mse_error;return;end
pos = find(tICI200nM_d17 == tspan(end), 1, 'last');
cellnum_ICI200nM_d17 = simICI200nM_d17(end,pos);

% E2(10nM)+ICI(200nM)+palbo(50nM)
[tICI200nM_palbo50nM_d17,simICI200nM_palbo50nM_d17,~,mse_use] = E2ICIpalboAZD_sim(x0,tspan,args.treat_ICI200nM_palbo50nM,args);
if ~isnan(mse_use);cost = args.mse_error;return;end
pos = find(tICI200nM_palbo50nM_d17 == tspan(end), 1, 'last');
cellnum_ICI200nM_palbo50nM_d17 = simICI200nM_palbo50nM_d17(end,pos);

% ICI(200nM)+palbo(100nM)
[tICI200nM_palbo100nM_d17,simICI200nM_palbo100nM_d17,~,mse_use] = E2ICIpalboAZD_sim(x0,tspan,args.treat_ICI200nM_palbo100nM,args);
if ~isnan(mse_use);cost = args.mse_error;return;end
pos = find(tICI200nM_palbo100nM_d17 == tspan(end), 1, 'last');
cellnum_ICI200nM_palbo100nM_d17 = simICI200nM_palbo100nM_d17(end,pos);

% ICI(200nM)+palbo(300nM)
[tICI200nM_palbo300nM_d17,simICI200nM_palbo300nM_d17,~,mse_use] = E2ICIpalboAZD_sim(x0,tspan,args.treat_ICI200nM_palbo300nM,args);
if ~isnan(mse_use);cost = args.mse_error;return;end
pos = find(tICI200nM_palbo300nM_d17 == tspan(end), 1, 'last');
cellnum_ICI200nM_palbo300nM_d17 = simICI200nM_palbo300nM_d17(end,pos);
%% Cost
cost = E2ICIpalboAZD_cost(args,...                                     (1)
                          tE2,...                                      (3)
                          tICI500nM,...                                (4)
                          tpalbo250nM,...                              (5)
                          tpalbo500nM,...                              (6)
                          tpalbo1uM,...                                (7)
                          tpalbo750nM_13m,...                          (8)
                          tICI750nM_13m,...                            (9)
                          tAZD250nM_13m,...                            (10)
                          tICI750nMAZD250nM_13m,...                    (11)
                          tAlter_palbo750nM_ICI750nM_13m,...           (12)
                          tAlter_palbo750nM_ICI750nMAZD250nM_13m,...   (13)
                          simE2,...                                    (14)
                          simICI500nM,...                              (15)
                          simpalbo250nM,...                            (16)
                          simpalbo500nM,...                            (17)
                          simpalbo1uM,...                              (18)
                          simpalbo750nM_13m,...                        (19)
                          simICI750nM_13m,...                          (20)
                          simAZD250nM_13m,...                          (21)
                          simICI750nMAZD250nM_13m,...                  (22)   
                          simAlter_palbo750nM_ICI750nM_13m,...         (23)
                          simAlter_palbo750nM_ICI750nMAZD250nM_13m,... (24)
                          xpalbo750nM_13m,...                          (25)
                          xICI750nM_13m,...                            (26)
                          xAlter_palbo750nM_ICI750nM,...               (27)
                          xAlter_palbo750nM_ICI750nMAZD250nM_13m,...   (28)
                          cellnum_ICI200nM_d17,...                     (29)
                          cellnum_ICI200nM_palbo50nM_d17,...           (30)
                          cellnum_ICI200nM_palbo100nM_d17,...          (31)
                          cellnum_ICI200nM_palbo300nM_d17 ...          (32)
                          );            

if opt
   % fprintf('%d, %d\n',i_group,uint32(cost))
end
end