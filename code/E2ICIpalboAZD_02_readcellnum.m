function E2ICIpalboAZD_02_readcellnum()
% This function loads cell count data from the ./data/coulter counter directory and saves it as a .mat file 
% in ./code/mat/Outcellnum.mat for use in model parameter fitting.

% Read and save data ./mat/Outcellnum_12m.mat, used in Supp. Fig.1 A-D and Supp. Fig.2 A and B.
pathload = '../data/coulter counter/';
pathsave = './mat/';
if ~isfolder(pathsave)
    mkdir(pathsave);
end
%% Rep1,Rep2,Rep3, E2+palbo(1uM)
filename = [pathload,'20181107MCF7f +,- E2 and Palbo Time Courses Reps1-3-2.xls'];
data = importdata(filename);
datause = data.data.Sheet1(7:9,13:17);
% Rep1
E2palbo1uMproCounter_10cm2(1,:) = datause(2,:);
datause = data.data.Sheet2(7:9,13:17);
% Rep2
E2palbo1uMproCounter_10cm2(2,:) = datause(2,:);
% Rep3
datause = data.data.Sheet3(7:9,13:17);
E2palbo1uMproCounter_10cm2(3,:) = datause(2,:);
%% Rep1,Rep2,Rep3, E2+palbo(1uM)
filename = [pathload, '20190214 MCF7 +,- E2 Palbo and ICI 1-3weeks Reps1-3.xlsx'];
data = importdata(filename);
% Rep1
datause = data.data.Sheet1(7:11,19:22);
E2palbo1uM3wproCounter_10cm2(1,:) = datause(3,:);
% Rep2
datause = data.data.Sheet2(7:11,19:22);
E2palbo1uM3wproCounter_10cm2(2,:) = datause(3,:);
% Rep3
datause = data.data.Sheet3(7:11,19:22);
E2palbo1uM3wproCounter_10cm2(3,:) = datause(3,:);
%% Rep1, E2+ICI(500nM), E2+palbo(250nM) 3w
filename = [pathload,'/20190621 MCF7 +250nMPalbo, 500nM ICI, -E2+100nMPalbo 3week.xlsx'];
data = importdata(filename);
datause = data.data.Sheet1(7:10,13:16);

OutE2ICI500nM3wCounter_2nd_60mm2 = datause(2,:);
OutE2palbo250nM3wCounter_1st_60mm2 = datause(3,:);
%% Rep2, E2+ICI(500nM), E2+palbo(500nM) 3w
filename = [pathload,'20190621 MCF7 Palbo+-E2, 500nM ICI, 10pM E2_3 week Reps 1-3.xlsx'];
data = importdata(filename);
datause = data.data.Sheet2(7:10,13:16);

OutE2ICI500nM3wCounter_3nd_60mm2 = datause(2,:);
OutE2palbo500nM3wCounter_1st_60mm2 = datause(3,:);
%% Rep3, E2+ICI(500nM), E2+palbo(500nM) 3w
filename = [pathload,'20190621 MCF7 Palbo+-E2, 500nM ICI, 10pM E2_3 week Reps 1-3.xlsx'];
data = importdata(filename);
datause = data.data.Sheet3(7:10,13:16);

OutE2ICI500nM3wCounter_4nd_60mm2 = datause(2,:);
OutE2palbo500nM3wCounter_2st_60mm2 = datause(3,:);
%% Rep4 -E2+E2(10pM), E2+ICI(500nM), E2+palbo(500nM), -E2+palbo(100nM) 3w
filename = [pathload,'20190621 MCF7 Palbo+-E2, 500nM ICI, 10pM E2_3 week Reps 1-3.xlsx'];
data = importdata(filename);
datause = data.data.Sheet4(7:10,13:16);

OutE2ICI500nM3wCounter_5nd_60mm2 = datause(2,:);
OutE2palbo500nM3wCounter_3st_60mm2 = datause(3,:);
%% Rep1-3 E2+palbo(250nM) 4w
filename = [pathload,'20191115 MCF7 4week Alternating 250nM Palbo+E2&-E2 Reps1-3.xlsx'];
data = importdata(filename);
% Rep1
datause = data.data.Sheet1(1:2,10:14);
OutE2palbo250nM4wCounter_1st_60mm2 = datause(1,:);
% Rep2
datause = data.data.Sheet2(1:2,10:14);
OutE2palbo250nM4wCounter_2st_60mm2 = datause(1,:);
% Rep3
datause = data.data.Sheet3(1:2,10:14);
OutE2palbo250nM4wCounter_3st_60mm2 = datause(1,:);
%% Rep1-3 E2+palbo(500nM) 4w
filename = [pathload,'20191217 MCF7 4week Alternating 500nM Palbo+E2&500nM ICI+E2 Reps1-3.xlsx'];
data = importdata(filename);
datause = data.data.Sheet1(1:2,10:14);
% Rep1
OutE2palbo500nM4wCounter_1st_60mm2 = datause(1,:);
% Rep2
datause = data.data.Sheet2(1:2,10:14);
OutE2palbo500nM4wCounter_2st_60mm2 = datause(1,:);
% Rep3
datause = data.data.Sheet3(1:2,10:14);
OutE2palbo500nM4wCounter_3st_60mm2 = datause(1,:);
%% Rep1-3 E2+Abema(500nM) 7 day
filename = [pathload,'20201026 MCF7 500nM Abema 7day Timecourse_coulter counter.xlsx'];
% Rep1
data = readmatrix(filename,'Sheet','Rep11');
datause = data(2:3,13:17);
E2proCounter_60mm2(1,:) = datause(1,:);
% Rep2
data = readmatrix(filename,'Sheet','Rep22');
datause = data(2:3,13:17);
E2proCounter_60mm2(2,:) = datause(1,:);
% Rep3
data = readmatrix(filename,'Sheet','Rep33');
datause = data(2:3,13:17);
E2proCounter_60mm2(3,:) = datause(1,:);
%% Rep1-3 Control proliferation 11 day
filename = [pathload,'20210517 MCF7 Control Proliferation Day 7,14,21_Reps 1-3.xlsx'];
data = readmatrix(filename,'Sheet','Rep1');
datause = data(2,6:9);
E2pro11d_60mm2(1,:) = datause;

data = readmatrix(filename,'Sheet','Rep2');
datause = data(2,6:9);
E2pro11d_60mm2(2,:) = datause;

data = readmatrix(filename,'Sheet','Rep3');
datause = data(2,6:9);
E2pro11d_60mm2(3,:) = datause;
%% Rep1-3 ICI+palbo synergy 3 weeks or 2.5 weeks
filename = [pathload,'20201016 MCF7 200nM ICI+Palbo combo 3weeks.xlsx'];

data = importdata(filename);

Rep1 = data.data.Rep220x2E5w(1:3,8);
Rep2 = data.data.Rep320x2E5w(1:3,8);
Rep3 = data.data.Rep420x2E5w(1:3,8);

data0 = [mean(data.data.Rep220x2E5w(1:3,1)),...
         mean(data.data.Rep320x2E5w(1:3,1)),...
         mean(data.data.Rep420x2E5w(1:3,1))];

data = [mean(data0./mean(data0)),...
        mean([Rep1(1),Rep2(1),Rep3(1)]),...
        mean([Rep1(2),Rep2(2),Rep3(2)]),...
        mean([Rep1(3),Rep2(3),Rep3(3)])];
err = [std(data0./mean(data0),0),...
       std([Rep1(1),Rep2(1),Rep3(1)]),...
       std([Rep1(2),Rep2(2),Rep3(2)]),...
       std([Rep1(3),Rep2(3),Rep3(3)])];
x = 1:4;
bar(x,data,0.5,'LineWidth',2,'facecolor',[0.6350 0.0780 0.1840])
hold on
er = errorbar(x,data,err,err,'linewidth',2);
er.Color = [0 0 0];
er.LineStyle = 'none';
ylim([0,50])
grid on
set(gca,'linewidth',2,'ytick',[0,20,40,60,80],'fontsize',13,...
    'xticklabel',{'t=0','ICI(200nM)','ICI(200nM)+\newline palbo(50nM)', ...
                 'ICI(200nM)+\newline palbo(100nM)'})
set(gcf,'position',[143,286,1068,810],'color','white')
ylabel('normalized cell number','fontsize',13)

data = importdata(filename);
Synergy_ICIpalbo_ICI200nM_17day = [data.data.Rep220x2E5w(9:11,4);...
                                   data.data.Rep320x2E5w(9:11,4);...
                                   data.data.Rep420x2E5w(9:11,4)];
Synergy_ICIpalbo_palbo50nM_17day = [data.data.Rep220x2E5w(16:18,4);...
                                    data.data.Rep320x2E5w(16:18,4);...
                                    data.data.Rep420x2E5w(16:18,4)];
Synergy_ICIpalbo_palbo100nM_17day = [data.data.Rep220x2E5w(24:26,4);...
                                     data.data.Rep320x2E5w(24:26,4);...
                                     data.data.Rep420x2E5w(24:26,4)];

filename = [pathload,'20220325 MCF7 Combo 200nM ICI+300nM PALBO_7 and 17 days_Reps1-3.xlsx'];
data = importdata(filename);

Synergy_ICIpalbo_palbo300nM_17day =...
    [data.data.Rep117days([22,25,28],11);...
     data.data.Rep217days([22,25,28],11);...
     data.data.Rep317days([22,25,28],11)];
%% Total data
clearvars E2pro E2palbo1000pro E2ICI500pro
%% 7 day data
E210nM_pro = [E2proCounter_60mm2,nan(size(E2proCounter_60mm2,1),3)];
clearvars E2proCounter_10cm2
E210nM_dish(1:3) = {'60cm2'};
E210nM_cellnum = repmat(275e3,1,3);

E210nM_palbo1uM_pro(1:3,:) = [E2palbo1uMproCounter_10cm2,nan(3,3)];
clearvars E2palbo1uMproCounter_10cm2
E210nM_palbo1uM_dish(1:3) = {'10cm2'};
E210nM_palbo1uM_cellnum = repmat(500e3,1,3);
%% combine all data
%% (1) E2(10nM)
% didn't use 14 day data because confluence
E210nM_pro(size(E210nM_pro,1) + 1:size(E210nM_pro,1) + size(E2pro11d_60mm2,1),:) =...
    [E2pro11d_60mm2(:,1),nan(size(E2pro11d_60mm2,1),3),E2pro11d_60mm2(:,2),nan(size(E2pro11d_60mm2,1),3)];
E210nM_cellnum(numel(E210nM_dish)+1:numel(E210nM_dish)+size(E2pro11d_60mm2,1)) = 45e3;
E210nM_dish(numel(E210nM_dish)+1:numel(E210nM_dish)+size(E2pro11d_60mm2,1)) = {'60mm'};
E210nM_pro = [E210nM_pro(1:3,1:4),E210nM_pro(4:6,5:end)];
%% (5) E2(10nM)+ICI(500nM)
E210nM_ICI500nM_pro =...
   [OutE2ICI500nM3wCounter_2nd_60mm2(1),nan(1,3),OutE2ICI500nM3wCounter_2nd_60mm2(2:end),nan(1,1);...
    OutE2ICI500nM3wCounter_3nd_60mm2(1),nan(1,3),OutE2ICI500nM3wCounter_3nd_60mm2(2:end),nan(1,1);...
    OutE2ICI500nM3wCounter_4nd_60mm2(1),nan(1,3),OutE2ICI500nM3wCounter_4nd_60mm2(2:end),nan(1,1);...
    OutE2ICI500nM3wCounter_5nd_60mm2(1),nan(1,3),OutE2ICI500nM3wCounter_5nd_60mm2(2:end),nan(1,1);];
E210nM_ICI500nM_cellnum = [70e3,45e3,45e3,45e3,45e3];
E210nM_ICI500nM_dish(1:5) = {'60mm'};
clearvars OutE2ICI500nM3wCounter_2nd_60mm2
clearvars OutE2ICI500nM3wCounter_3nd_60mm2
clearvars OutE2ICI500nM3wCounter_4nd_60mm2
clearvars OutE2ICI500nM3wCounter_5nd_60mm2
%% (7) E2(10nM)+palbo(250nM)
E210nM_palbo250nM_pro =...
   [OutE2palbo250nM3wCounter_1st_60mm2(1),nan(1,3),OutE2palbo250nM3wCounter_1st_60mm2(2:end),nan(1,1);...
    OutE2palbo250nM4wCounter_1st_60mm2(1),nan(1,3),OutE2palbo250nM4wCounter_1st_60mm2(2:end);...
    OutE2palbo250nM4wCounter_2st_60mm2(1),nan(1,3),OutE2palbo250nM4wCounter_2st_60mm2(2:end);...
    OutE2palbo250nM4wCounter_3st_60mm2(1),nan(1,3),OutE2palbo250nM4wCounter_3st_60mm2(2:end)];
E210nM_palbo250nM_cellnum(1:4) = 45e3;
E210nM_palbo250nM_dish(1:4) = {'60mm'};
clearvars OutE2palbo250nM3wCounter_1st_60mm2
clearvars OutE2palbo250nM4wCounter_1st_60mm2
clearvars OutE2palbo250nM4wCounter_2st_60mm2
clearvars OutE2palbo250nM4wCounter_3st_60mm2
%% (8) E2(10nM)+palbo(500nM)
E210nM_palbo500nM_pro =...
   [OutE2palbo500nM3wCounter_1st_60mm2(1),nan(1,3),OutE2palbo500nM3wCounter_1st_60mm2(2:end),nan(1,1);...
    OutE2palbo500nM3wCounter_2st_60mm2(1),nan(1,3),OutE2palbo500nM3wCounter_2st_60mm2(2:end),nan(1,1);...
    OutE2palbo500nM3wCounter_3st_60mm2(1),nan(1,3),OutE2palbo500nM3wCounter_3st_60mm2(2:end),nan(1,1);...
    OutE2palbo500nM4wCounter_1st_60mm2(1),nan(1,3),OutE2palbo500nM4wCounter_1st_60mm2(2:end);...
    OutE2palbo500nM4wCounter_2st_60mm2(1),nan(1,3),OutE2palbo500nM4wCounter_2st_60mm2(2:end);...
    OutE2palbo500nM4wCounter_3st_60mm2(1),nan(1,3),OutE2palbo500nM4wCounter_3st_60mm2(2:end)];
E210nM_palbo500nM_cellnum(1:4) = 45e3;
E210nM_palbo500nM_dish(1:4) = {'60mm'};
clearvars OutE2palbo500nM3wCounter_1st_60mm2
clearvars OutE2palbo500nM3wCounter_2st_60mm2
clearvars OutE2palbo500nM3wCounter_3st_60mm2
clearvars OutE2palbo500nM4wCounter_1st_60mm2
%% (9) E2(10nM)+palbo(1uM)
E210nM_palbo1uM_pro(size(E210nM_palbo1uM_pro,1) + 1:size(E210nM_palbo1uM_pro,1) + size(E2palbo1uM3wproCounter_10cm2,1),:)...
    = [E2palbo1uM3wproCounter_10cm2(:,1),nan(3,3),E2palbo1uM3wproCounter_10cm2(:,2:end),nan(3,1)];
E210nM_palbo1uM_cellnum(numel(E210nM_palbo1uM_dish)+1:numel(E210nM_palbo1uM_dish)+size(E2palbo1uM3wproCounter_10cm2,1)) = 250e3;
E210nM_palbo1uM_dish(numel(E210nM_palbo1uM_dish)+1:numel(E210nM_palbo1uM_dish)+size(E2palbo1uM3wproCounter_10cm2,1)) = {'10cm2'};
% delete 7 day
E210nM_palbo1uM_pro(1:3,:) = [];
E210nM_palbo1uM_cellnum(1:3) = [];
E210nM_palbo1uM_dish(1:3) = [];
clearvars E2palbo1uM3wproCounter_10cm2
%% Mean and Std
% (1) E2(10nM)
if ~isequal(size(E210nM_pro,1),numel(E210nM_dish)) || ~isequal(numel(E210nM_dish),numel(E210nM_cellnum))
    error('');
end
E210nM_promean = mean(E210nM_pro);
E210nM_prosem = std(E210nM_pro);%/sqrt(size(E210nM_pro,1));

% (5) E2(10nM)+ICI(500nM)
if ~isequal(size(E210nM_ICI500nM_pro,1),numel(E210nM_ICI500nM_dish)) || ~isequal(numel(E210nM_ICI500nM_dish),numel(E210nM_ICI500nM_cellnum))
    error('');
end
E210nM_ICI500nM_promean = mean(E210nM_ICI500nM_pro,1);
E210nM_ICI500nM_prosem = std(E210nM_ICI500nM_pro,[],1);%/sqrt(size(E210nM_ICI500nM_pro,1));

% (7) E2(10nM)+palbo(250nM)
if ~isequal(size(E210nM_palbo250nM_pro,1),numel(E210nM_palbo250nM_dish)) || (~isequal(numel(E210nM_palbo250nM_dish),numel(E210nM_palbo250nM_cellnum)))
    error('');
end
E210nM_palbo250nM_promean = mean(E210nM_palbo250nM_pro,1);
E210nM_palbo250nM_prosem = std(E210nM_palbo250nM_pro,[],1);%/sqrt(size(E210nM_palbo250nM_pro,1));

% (8) E2(100nM)+palbo(500nM)
if ~isequal(size(E210nM_palbo500nM_pro,1),numel(E210nM_palbo500nM_dish)) || ~isequal(numel(E210nM_palbo500nM_dish),numel(E210nM_palbo500nM_cellnum))
    error('');
end
E210nM_palbo500nM_promean = mean(E210nM_palbo500nM_pro,1);
E210nM_palbo500nM_prosem = std(E210nM_palbo500nM_pro,[],1);%/sqrt(size(E210nM_palbo500nM_pro,1));

% (9) E2(100nM)+palbo(1uM)
if ~isequal(size(E210nM_palbo1uM_pro,1),numel(E210nM_palbo1uM_dish)) || ~isequal(numel(E210nM_palbo1uM_dish),numel(E210nM_palbo1uM_cellnum))
    error('');
end
E210nM_palbo1uM_promean = mean(E210nM_palbo1uM_pro,1);
E210nM_palbo1uM_prosem = std(E210nM_palbo1uM_pro,[],1);%/sqrt(size(E210nM_palbo1uM_pro,1));

%% plot
close all
figure(1);hold on;
time = [0,1,3,6,7,14,21,28];
%% (1) E2(10nM)
errorbar(time(~isnan(E210nM_promean)),E210nM_promean(~isnan(E210nM_promean)),...
    E210nM_prosem(~isnan(E210nM_promean)),'-go','linewidth',2);
ylim([0,50]);xlim([0,8]);title('E2(10nM)');set(gca,'Fontsize',19);grid on
%% (5) E2(10nM)+ICI(500nM)
errorbar(time(~isnan(E210nM_ICI500nM_promean)),E210nM_ICI500nM_promean(~isnan(E210nM_ICI500nM_promean)),...
    E210nM_ICI500nM_prosem(~isnan(E210nM_ICI500nM_promean)),'-ko','linewidth',2);
ylim([0,20]);xlim([0,28]);title('E2+ICI(500nM)');set(gca,'Fontsize',19);grid on
%% (7) E2(10nM)+palbo(250nM)
hline = errorbar(time(~isnan(E210nM_palbo250nM_promean)),E210nM_palbo250nM_promean(~isnan(E210nM_palbo250nM_promean)),...
    E210nM_palbo250nM_prosem(~isnan(E210nM_palbo250nM_promean)),'co','linestyle',':','linewidth',2);
hline.Bar.LineStyle = 'dotted';
ylim([0,120]);xlim([0,30]);title('E2+palbo(250nM)');set(gca,'Fontsize',19);grid on
%% (8) E2(10nM)+palbo(500nM)
hline = errorbar(time(~isnan(E210nM_palbo500nM_promean)),E210nM_palbo500nM_promean(~isnan(E210nM_palbo500nM_promean)),...
    E210nM_palbo500nM_prosem(~isnan(E210nM_palbo500nM_promean)),'co','linestyle','-.','linewidth',2);
hline.Bar.LineStyle = 'dashed';
ylim([0,30]);xlim([0,30]);title('E2+palbo(500nM)');set(gca,'Fontsize',19);grid on
%% (9) E2(10nM)+palbo(1uM)
errorbar(time(~isnan(E210nM_palbo1uM_promean)),E210nM_palbo1uM_promean(~isnan(E210nM_palbo1uM_promean)),...
    E210nM_palbo1uM_prosem(~isnan(E210nM_palbo1uM_promean)),'-co','linewidth',2);
ylim([0,5]);xlim([0,25]);title('E2+palbo(1uM)');set(gca,'Fontsize',19);grid on
%% (1) E2(10nM)
figure(2);hold on
for i = 1:size(E210nM_pro,1)
    if strcmpi(E210nM_dish{i},'10cm2')
        plot(time(~isnan(E210nM_pro(i,:))),E210nM_pro(i,~isnan(E210nM_pro(i,:))),'-o','color','b','Markersize',10,'linewidth',2);
    else
        plot(time(~isnan(E210nM_pro(i,:))),E210nM_pro(i,~isnan(E210nM_pro(i,:))),'-*','color','b','Markersize',20,'linewidth',2);
    end
end
% disp(E210nM_pro_dish)
timetotal = [0,1,3,6,7,14,21,28];
set(gca,'fontsize',20,'xtick',timetotal,'xticklabel',...
    {'0h','day1','day3','day6','day7','day14','day21','day28'},'linewidth',2)
xtickangle(60);xlim([-1,29]);title('E2(10nM)')
ylabel('Proliferation coulter counter');
L1(1) = plot(nan,nan,'-o','color','b','Markersize',10,'linewidth',2);
L1(2) = plot(nan,nan,'-*','color','b','Markersize',10,'linewidth',2);
legend(L1, {'E2(10nM) 10cm^2','E2(10nM) 60mm'},'location','NE','box','off','Fontsize',25)
set(gcf,'position',[286 367 941 725])
grid on
%% (5) E2(10nM)+ICI(500nM)
figure(6);hold on
for i = 1:size(E210nM_ICI500nM_pro,1)
    plot(time(~isnan(E210nM_ICI500nM_pro(i,:))),E210nM_ICI500nM_pro(i,~isnan(E210nM_ICI500nM_pro(i,:))),'-*','color','b','Markersize',20,'linewidth',2);
end
% disp(E210nM_ICI500nM_dish(1:4))
timetotal = [0,1,3,6,7,14,21,28];
set(gca,'fontsize',20,'xtick',timetotal,'xticklabel',...
    {'0h','day1','day3','day6','day7','day14','day21','day28'},'linewidth',2)
xtickangle(60);xlim([-1,29])

L1 = plot(nan,nan,'-*','color','b','Markersize',20,'linewidth',2);
ylabel('Normalized cell number');title('E2(10nM)+ICI(500nM)')
legend(L1,'E2(10nM)+ICI(500nM) 60mm','location','NW','box','off','Fontsize',25)
set(gcf,'position',[286 367 941 725])
ylim([0,120])
grid on
%% (7) E2(10nM)+palbo(250nM)
figure(8);hold on
for i = 1:size(E210nM_palbo250nM_pro,1)
    plot(time(~isnan(E210nM_palbo250nM_pro(i,:))),E210nM_palbo250nM_pro(i,~isnan(E210nM_palbo250nM_pro(i,:))),'-*','color','b','Markersize',20,'linewidth',2);
end
% disp(E210nM_palbo250nM_dish)
timetotal = [0,1,3,6,7,14,21,28];
set(gca,'fontsize',20,'xtick',timetotal,'xticklabel',...
    {'0h','day1','day3','day6','day7','day14','day21','day28'},'linewidth',2)
xtickangle(60);xlim([-1,29])
ylabel('Proliferation coulter counter');title('E2(10nM)+palbo(250nM)')
legend({'E2(10nM)+palbo(250nM) 60mm'},'location','NW','box','off','Fontsize',25)
set(gcf,'position',[286 367 941 725])
grid on
%% (8) E2(10nM)+palbo(500nM)
figure(9);hold on
for i = 1:size(E210nM_palbo500nM_pro,1)
    plot(time(~isnan(E210nM_palbo500nM_pro(i,:))),E210nM_palbo500nM_pro(i,~isnan(E210nM_palbo500nM_pro(i,:))),'-*','color','b','Markersize',20,'linewidth',2);
end
% disp(E210nM_palbo500nM_dish)
timetotal = [0,1,3,6,7,14,21,28];
set(gca,'fontsize',20,'xtick',timetotal,'xticklabel',...
    {'0h','day1','day3','day6','day7','day14','day21','day28'},'linewidth',2)
xtickangle(60);xlim([-1,29])
ylabel('Proliferation coulter counter');title('E2(10nM)+palbo(500nM)')
legend({'E2(10nM)+palbo(500nM) 60mm'},'location','NW','box','off','Fontsize',25)
set(gcf,'position',[286 367 941 725])
ylim([0,120])
grid on
%% (9) E2(10nM)+palbo(1uM)
figure(10);hold on
for i = 1:size(E210nM_palbo1uM_pro,1)
    plot(time(~isnan(E210nM_palbo1uM_pro(i,:))),E210nM_palbo1uM_pro(i,~isnan(E210nM_palbo1uM_pro(i,:))),'-o','color','b','Markersize',10,'linewidth',2);
end
% disp(E210nM_palbo1000nM_dish)
timetotal = [0,1,3,6,7,14,21,28];
set(gca,'fontsize',20,'xtick',timetotal,'xticklabel',...
    {'0h','day1','day3','day6','day7','day14','day21','day28'},'linewidth',2)
xtickangle(60);xlim([-1,29])
ylabel('Proliferation coulter counter');title('E2(10nM)+palbo(1uM)')
legend({'E2(10nM)+palbo(1uM) 10cm^2'},'location','SE','box','off','Fontsize',25)
set(gcf,'position',[286 367 941 725])
grid on
%% save
close all
% (1) E2(10nM)
E210nM.pro = E210nM_pro;
E210nM.dish = E210nM_dish;
E210nM.cellinitial = E210nM_cellnum;
Outcellnum.E210nM = E210nM;
clearvars E210nM_dish E210nM_cellnum E210nM
% (5) E2(10nM)+ICI(500nM)
pvalue = child_pvalue(E210nM_pro,E210nM_ICI500nM_pro);
E210nM_ICI500nM.pro = E210nM_ICI500nM_pro;
E210nM_ICI500nM.dish = E210nM_ICI500nM_dish;
E210nM_ICI500nM.cellinitial = E210nM_ICI500nM_cellnum;
E210nM_ICI500nM.pvalue = pvalue;
Outcellnum.E210nM_ICI500nM = E210nM_ICI500nM;
clearvars E210nM_ICI500nM_pro E210nM_ICI500nM_dish E210nM_ICI500nM_cellnum E210nM_ICI500nM
% (7) E2(10nM)+palbo(250nM)
pvalue = child_pvalue(E210nM_pro,E210nM_palbo250nM_pro);
E210nM_palbo250nM.pro = E210nM_palbo250nM_pro;
E210nM_palbo250nM.dish = E210nM_palbo250nM_dish;
E210nM_palbo250nM.cellinitial = E210nM_palbo250nM_cellnum;
E210nM_palbo250nM.pvalue = pvalue;
Outcellnum.E210nM_palbo250nM = E210nM_palbo250nM;
clearvars E210nM_palbo250nM_pro E210nM_palbo250nM_dish E210nM_palbo250nM_cellnum E210nM_palbo250nM
% (8) E2(10nM)+palbo(500nM)
pvalue = child_pvalue(E210nM_pro,E210nM_palbo500nM_pro);
E210nM_palbo500nM.pro = E210nM_palbo500nM_pro;
E210nM_palbo500nM.dish = E210nM_palbo500nM_dish;
E210nM_palbo500nM.cellinitial = E210nM_palbo500nM_cellnum;
E210nM_palbo500nM.pvalue = pvalue;
Outcellnum.E210nM_palbo500nM = E210nM_palbo500nM;
clearvars E210nM_palbo500nM_pro E210nM_palbo500nM_dish E210nM_palbo500nM_cellnum E210nM_palbo500nM
% (9) E2(10nM)+palbo(1uM)
pvalue = child_pvalue(E210nM_pro,E210nM_palbo1uM_pro);
E210nM_palbo1uM.pro = E210nM_palbo1uM_pro;
E210nM_palbo1uM.dish = E210nM_palbo1uM_dish;
E210nM_palbo1uM.cellinitial = E210nM_palbo1uM_cellnum;
E210nM_palbo1uM.pvalue = pvalue;
Outcellnum.E210nM_palbo1uM = E210nM_palbo1uM;
clearvars E210nM_palbo1uM_pro E210nM_palbo1uM_dish E210nM_palbo1uM_cellnum E210nM_palbo1uM

Outcellnum.Synergy_ICIpalbo_ICI200nM_17day = Synergy_ICIpalbo_ICI200nM_17day;
Outcellnum.Synergy_ICIpalbo_palbo50nM_17day = Synergy_ICIpalbo_palbo50nM_17day;
Outcellnum.Synergy_ICIpalbo_palbo100nM_17day = Synergy_ICIpalbo_palbo100nM_17day;
Outcellnum.Synergy_ICIpalbo_palbo300nM_17day = Synergy_ICIpalbo_palbo300nM_17day;

% (23) Rep1-3 Control Proliferation 11day
Outcellnum.E210nM_day11.pro = E2pro11d_60mm2(:,3);
Outcellnum.E210nM_day11.dish = Outcellnum.E210nM.dish(end-2:end);
Outcellnum.E210nM_day11.cellinitial = Outcellnum.E210nM.cellinitial(end-2:end);
save([pathsave, 'Outcellnum.mat'],'Outcellnum')
end

function pvalue = child_pvalue(E210nM_pro,treat)
pvalue = zeros(1,size(E210nM_pro,2));
for i = 1:numel(pvalue)
    E210nM_pro_1 = E210nM_pro(:,i);E210nM_pro_1(isnan(E210nM_pro_1)) = [];
    treat_1 = treat(:,i);treat_1(isnan(treat_1)) = [];
    if ~isempty(E210nM_pro_1) && ~isempty(treat_1)
        pvalue(i) = ranksum(E210nM_pro_1,treat_1,'tail','right');
    else
        pvalue(i) = nan;
    end
end
end