function E2ICIpalboAZD_doseresponse()
%% (23) Function index in the GitHub repository
% This function loads data from the ./data/dose response/ folder and generates the raw plots for Fig. 3A–F.

pathload = '../mat/';
pathsave = './rawfig/';
if ~isfolder(pathsave)
    mkdir(pathsave);
end
filename = [pathload, '20220623 Bill Longterm cells_Palbo sensitivity check coulter counter 6days_12 month cells on palbo.xlsx'];
data = importdata(filename);                  

t0 = 50e3;
MCF7veh = data.data(1:3,5);
MCF7_500nM = data.data(1:3,12);
MCF7_750nM = data.data(1:3,19);
MCF7 = [MCF7veh,MCF7_500nM,MCF7_750nM];
MCF7 = [repmat(t0,size(MCF7,1),1),MCF7];

palbomono_veh = data.data(9:11,5);
palbomono_500nM = data.data(9:11,12);
palbomono_750nM = data.data(9:11,19);
palbomono = [palbomono_veh,palbomono_500nM,palbomono_750nM];
palbomono = [repmat(t0,size(palbomono,1),1),palbomono];

ICIAlt_veh = data.data(25:27,5);
ICIAlt_500nM = data.data(25:27,12);
ICIAlt_750nM = data.data(25:27,19);
ICIAlt = [ICIAlt_veh,ICIAlt_500nM,ICIAlt_750nM];
ICIAlt = [repmat(t0,size(ICIAlt,1),1),ICIAlt];

AZDAlt_veh = data.data(33:35,5);
AZDAlt_500nM = data.data(33:35,12);
AZDAlt_750nM = data.data(33:35,19);
AZDAlt = [AZDAlt_veh,AZDAlt_500nM,AZDAlt_750nM];
AZDAlt = [repmat(t0,size(AZDAlt,1),1),AZDAlt];

GR_MCF7 = zeros(size(MCF7));
GR_palbomono = zeros(size(palbomono));
GR_ICIAlt = zeros(size(ICIAlt));
GR_AZDAlt = zeros(size(AZDAlt));
for i = 1:size(MCF7,1)
    GR_MCF7(i,:) = E2depICIpalbo_doseresponse_child(MCF7(i,:));
    GR_palbomono(i,:) = E2depICIpalbo_doseresponse_child(palbomono(i,:));
    GR_ICIAlt(i,:) = E2depICIpalbo_doseresponse_child(ICIAlt(i,:));
    GR_AZDAlt(i,:) = E2depICIpalbo_doseresponse_child(AZDAlt(i,:));
end
GR_MCF7 = GR_MCF7(:,2:end);
GR_palbomono = GR_palbomono(:,2:end);
GR_ICIAlt = GR_ICIAlt(:,2:end);
GR_AZDAlt = GR_AZDAlt(:,2:end);

t0_MCF7 = MCF7./MCF7(:,1);
t0_palbomono = palbomono./palbomono(:,1);
t0_ICIAlt = ICIAlt./ICIAlt(:,1);
t0_AZDAlt = AZDAlt./AZDAlt(:,1);

Veh_MCF7 = t0_MCF7(:,2:end)./t0_MCF7(:,2);
Veh_palbomono = t0_palbomono(:,2:end)./t0_palbomono(:,2);
Veh_ICIAlt = t0_ICIAlt(:,2:end)./t0_ICIAlt(:,2);
Veh_AZDAlt = t0_AZDAlt(:,2:end)./t0_AZDAlt(:,2);
%% average
n = size(t0_MCF7,1);
% Normalized to T = 0
t0_MCF7_mean = mean(t0_MCF7,1);
t0_MCF7_sem = std(t0_MCF7,[],1)/sqrt(n);

t0_palbomono_mean = mean(t0_palbomono,1);
t0_palbomono_sem = std(t0_palbomono,[],1)/sqrt(n);

t0_ICIAlt_mean = mean(t0_ICIAlt,1);
t0_ICIAlt_sem = std(t0_ICIAlt,[],1)/sqrt(n);

t0_AZDAlt_mean = mean(t0_AZDAlt,1);
t0_AZDAlt_sem = std(t0_AZDAlt,[],1)/sqrt(n);

data = [t0_MCF7_mean',t0_palbomono_mean',t0_ICIAlt_mean',t0_AZDAlt_mean'];
err = [t0_MCF7_sem',t0_palbomono_sem',t0_ICIAlt_sem',t0_AZDAlt_sem'];

x = 1:size(data,1);
figure;hold on
h = bar(x,data,0.8,'LineWidth',2);
h(1).FaceColor = 'b';
h(1).EdgeColor = 'b';
h(2).FaceColor = 'm';
h(2).EdgeColor = 'm';
h(3).FaceColor = 'k';
h(3).EdgeColor = 'k';
h(4).FaceColor = 'g';
h(4).EdgeColor = 'g';

ngroups = size(data,1);
nbars = size(data,2);
groupwidth = min(0.8,nbars/(nbars + 1.5));
for i = 1:nbars
    x = (1:ngroups) - groupwidth/2 + (2*i-1) * groupwidth / (2*nbars);
    errorbar(x,data(:,i),err(:,i), 'k', 'linestyle', 'none','linewidth',2);
end
xlim([0.5,size(data,1)+0.5])
ylim([0.0,15])
title('Palbo dose response')
ylabel('Normalized to t=0')
legend({'MCF7','palbo mono','palbo ICI alter','palbo ICI+AZD alter'},'box','off')
grid on
box on
set(gca,'xtick',1:length(t0_MCF7_mean),'XTickLabel',{'t=0','Veh','500nM','750nM'},...
    'fontsize',20,'linewidth',2)
set(gcf,'position',[220,347,907,704],'color','w')
print(gcf,[pathsave,'FIG3B.pdf'],'-dpdf','-bestfit')
close gcf
%% average
% Normalized to Veh
Veh_MCF7_mean = mean(Veh_MCF7,1);
Veh_MCF7_sem = std(Veh_MCF7,[],1)/sqrt(n);

Veh_palbomono_mean = mean(Veh_palbomono,1);
Veh_palbomono_sem = std(Veh_palbomono,[],1)/sqrt(n);

Veh_ICIAlt_mean = mean(Veh_ICIAlt,1);
Veh_ICIAlt_sem = std(Veh_ICIAlt,[],1)/sqrt(n);

Veh_AZDAlt_mean = mean(Veh_AZDAlt,1);
Veh_AZDAlt_sem = std(Veh_AZDAlt,[],1)/sqrt(n);

data = [Veh_MCF7_mean',Veh_palbomono_mean',Veh_ICIAlt_mean',Veh_AZDAlt_mean'];
err = [Veh_MCF7_sem',Veh_palbomono_sem',Veh_ICIAlt_sem',Veh_AZDAlt_sem'];

x = 1:size(data,1);
figure;hold on
h = bar(x,data,0.8,'LineWidth',2);
h(1).FaceColor = 'b';
h(1).EdgeColor = 'b';
h(2).FaceColor = 'm';
h(2).EdgeColor = 'm';
h(3).FaceColor = 'k';
h(3).EdgeColor = 'k';
h(4).FaceColor = 'g';
h(4).EdgeColor = 'g';

ngroups = size(data,1);
nbars = size(data,2);
groupwidth = min(0.8,nbars/(nbars + 1.5));
for i = 1:nbars
    x = (1:ngroups) - groupwidth/2 + (2*i-1) * groupwidth / (2*nbars);
    errorbar(x,data(:,i),err(:,i), 'k', 'linestyle', 'none','linewidth',2);
end
xlim([0.5,size(data,1)+0.5])
ylim([0.0,1.3])
title('Palbo dose response')
ylabel('Normalized to Veh')
legend({'MCF7','palbo mono','palbo ICI alter','palbo ICI+AZD alter'},'box','off')
grid on
box on
set(gca,'xtick',1:length(Veh_MCF7_mean),'XTickLabel',{'Veh','500nM','750nM'},'fontsize',20,'linewidth',2)
set(gcf,'position',[220,347,907,704],'color','w')
print(gcf,[pathsave,'FIG3A.pdf'],'-dpdf','-bestfit')
close gcf
%% average
% Normalized to GR
close all
GR_MCF7_mean = mean(GR_MCF7,1);
GR_MCF7_sem = std(GR_MCF7,[],1)/sqrt(n);

GR_palbomono_mean = mean(GR_palbomono,1);
GR_palbomono_sem = std(GR_palbomono,[],1)/sqrt(n);

GR_ICIAlt_mean = mean(GR_ICIAlt,1);
GR_ICIAlt_sem = std(GR_ICIAlt,[],1)/sqrt(n);

GR_AZDAlt_mean = mean(GR_AZDAlt,1);
GR_AZDAlt_sem = std(GR_AZDAlt,[],1)/sqrt(n);

data = [GR_MCF7_mean',GR_palbomono_mean',GR_ICIAlt_mean',GR_AZDAlt_mean'];
err = [GR_MCF7_sem',GR_palbomono_sem',GR_ICIAlt_sem',GR_AZDAlt_sem'];

x = 1:size(data,1);
figure;hold on
h = bar(x,data,0.8,'LineWidth',2);
h(1).FaceColor = 'b';
h(1).EdgeColor = 'b';
h(2).FaceColor = 'm';
h(2).EdgeColor = 'm';
h(3).FaceColor = 'k';
h(3).EdgeColor = 'k';
h(4).FaceColor = 'g';
h(4).EdgeColor = 'g';

ngroups = size(data,1);
nbars = size(data,2);
groupwidth = min(0.8,nbars/(nbars + 1.5));
for i = 1:nbars
    x = (1:ngroups) - groupwidth/2 + (2*i-1) * groupwidth / (2*nbars);
    errorbar(x,data(:,i),err(:,i), 'k', 'linestyle', 'none','linewidth',2);
end
xlim([0.5,size(data,1)+0.5])
ylim([0,1.4])
title('Palbo dose response')
ylabel('GR value')
legend({'MCF7','palbo mono','palbo ICI alter','palbo ICI+AZD alter'},'box','off')

grid on
box on
set(gca,'xtick',1:length(GR_MCF7_mean),'XTickLabel',{'Veh','500nM','750nM'},'fontsize',20,'linewidth',2)
set(gcf,'position',[220,347,907,704],'color','w')
print(gcf,[pathsave,'FIG3C.pdf'],'-dpdf','-bestfit')
close gcf
%% Two way Anova
% two way anova
%% Normalized to T = 0
% MCF7
t0_MCF7 = t0_MCF7(:,2:end);
t0_MCF7 = t0_MCF7(:);
treat_label = [repmat("Veh",3,1);repmat("500nM",3,1);repmat("750nM",3,1)];
MCF7_label = repmat("MCF7",numel(t0_MCF7),1);
% palbo mono
t0_palbomono = t0_palbomono(:,2:end);
t0_palbomono = t0_palbomono(:);
palbomono_label = repmat("palbomono",numel(t0_palbomono),1);
% ICI palbo alt
t0_ICIAlt = t0_ICIAlt(:,2:end);
t0_ICIAlt = t0_ICIAlt(:);
ICIAlt_label = repmat("ICIAlt",numel(t0_ICIAlt),1);
% ICI AZD alt
t0_AZDAlt = t0_AZDAlt(:,2:end);
t0_AZDAlt = t0_AZDAlt(:);
AZDAlt_label = repmat("AZDAlt",numel(t0_AZDAlt),1);

y = [t0_MCF7;t0_palbomono;t0_ICIAlt;t0_AZDAlt];
g1 = [treat_label;treat_label;treat_label;treat_label];
g2 = [MCF7_label;palbomono_label;ICIAlt_label;AZDAlt_label];

[~,~,stats] = anovan(y,{g2 g1},'model','interaction','varnames',{'cell type','dose'});
[c,~,~,gnames] = multcompare(stats,'Dimension',[1,2]);
pval_t0 = child_anovan(c,gnames);

clearvars t0_MCF7 t0_palbomono t0_ICIAlt t0_AZDAlt treat_label...
    MCF7_label palbomono_label ICIAlt_label AZDAlt_label
%% Normalized to Veh
% MCF7
Veh_MCF7 = Veh_MCF7(:,2:end);
Veh_MCF7 = Veh_MCF7(:);
treat_label = [repmat("500nM",3,1);repmat("750nM",3,1)];
MCF7_label = repmat("MCF7",numel(Veh_MCF7),1);
% palbo mono
Veh_palbomono = Veh_palbomono(:,2:end);
Veh_palbomono = Veh_palbomono(:);
palbomono_label = repmat("palbomono",numel(Veh_palbomono),1);
% ICI palbo alt
Veh_ICIAlt = Veh_ICIAlt(:,2:end);
Veh_ICIAlt = Veh_ICIAlt(:);
ICIAlt_label = repmat("ICIAlt",numel(Veh_ICIAlt),1);
% ICI AZD alt
Veh_AZDAlt = Veh_AZDAlt(:,2:end);
Veh_AZDAlt = Veh_AZDAlt(:);
AZDAlt_label = repmat("AZDAlt",numel(Veh_AZDAlt),1);

y = [Veh_MCF7;Veh_palbomono;Veh_ICIAlt;Veh_AZDAlt];
g1 = [treat_label;treat_label;treat_label;treat_label];
g2 = [MCF7_label;palbomono_label;ICIAlt_label;AZDAlt_label];

[~,~,stats] = anovan(y,{g2 g1},'model','interaction','varnames',{'cell type','dose'});
[c,~,~,gnames] = multcompare(stats,'Dimension',[1,2]);
pval_Veh = child_anovan(c,gnames);

clearvars Veh_MCF7 Veh_palbomono Veh_ICIAlt Veh_AZDAlt treat_label...
    MCF7_label palbomono_label ICIAlt_label AZDAlt_label
%% Normalized to GR
% MCF7
GR_MCF7 = GR_MCF7(:,2:end);
GR_MCF7 = GR_MCF7(:);
treat_label = [repmat("500nM",3,1);repmat("750nM",3,1)];
MCF7_label = repmat("MCF7",numel(GR_MCF7),1);
% palbo mono
GR_palbomono = GR_palbomono(:,2:end);
GR_palbomono = GR_palbomono(:);
palbomono_label = repmat("palbomono",numel(GR_palbomono),1);
% ICI palbo alt
GR_ICIAlt = GR_ICIAlt(:,2:end);
GR_ICIAlt = GR_ICIAlt(:);
ICIAlt_label = repmat("ICIAlt",numel(GR_ICIAlt),1);
% ICI AZD alt
GR_AZDAlt = GR_AZDAlt(:,2:end);
GR_AZDAlt = GR_AZDAlt(:);
AZDAlt_label = repmat("AZDAlt",numel(GR_AZDAlt),1);

y = [GR_MCF7;GR_palbomono;GR_ICIAlt;GR_AZDAlt];
g1 = [treat_label;treat_label;treat_label;treat_label];
g2 = [MCF7_label;palbomono_label;ICIAlt_label;AZDAlt_label];

[~,~,stats] = anovan(y,{g2 g1},'model','interaction','varnames',{'cell type','dose'});
[c,~,~,gnames] = multcompare(stats,'Dimension',[1,2]);
pval_GR = child_anovan(c,gnames);

clearvars GR_MCF7 GR_palbomono GR_ICIAlt GR_AZDAlt treat_label...
    MCF7_label palbomono_label ICIAlt_label AZDAlt_label
%% AZD dose response 6 days
close all
filename = [pathload,'20220728 Bill Palbo Mono vs MCF7p_AZD1775 6day coulter counter dose response.xlsx'];
data = importdata(filename);

MCF7_t0 = data.data(1:3,4);
MCF7_veh = data.data(10:12,4);
MCF7_100nM = data.data(10:12,11);
MCF7_250nM = data.data(10:12,18);
MCF7_500nM = data.data(10:12,25);
MCF7 = [MCF7_t0,MCF7_veh,MCF7_100nM,MCF7_250nM,MCF7_500nM];

palbomono_t0 = data.data(1:3,11);
palbomono_veh = data.data(18:20,4);
palbomono_100nM = data.data(18:20,11);
palbomono_250nM = data.data(18:20,18);
palbomono_500nM = data.data(18:20,25);
palbomono = [palbomono_t0,palbomono_veh,palbomono_100nM,palbomono_250nM,palbomono_500nM];

GR_MCF7 = zeros(size(MCF7));
GR_palbomono = zeros(size(palbomono));
for i = 1:size(MCF7,1)
    GR_MCF7(i,:) = E2depICIpalbo_doseresponse_child(MCF7(i,:));
    GR_palbomono(i,:) = E2depICIpalbo_doseresponse_child(palbomono(i,:));
end
GR_MCF7 = GR_MCF7(:,2:end);
GR_palbomono = GR_palbomono(:,2:end);

t0_MCF7 = MCF7./MCF7(:,1);
t0_palbomono = palbomono./palbomono(:,1);

Veh_MCF7 = t0_MCF7(:,2:end)./t0_MCF7(:,2);
Veh_palbomono = t0_palbomono(:,2:end)./t0_palbomono(:,2);
%% average
n = size(t0_MCF7,1);
% Normalized to T = 0
t0_MCF7_mean = mean(t0_MCF7,1);
t0_MCF7_sem = std(t0_MCF7,[],1)/sqrt(n);

t0_palbomono_mean = mean(t0_palbomono,1);
t0_palbomono_sem = std(t0_palbomono,[],1)/sqrt(n);

data = [t0_MCF7_mean',t0_palbomono_mean'];
err = [t0_MCF7_sem',t0_palbomono_sem'];

x = 1:size(data,1);
figure;hold on
h = bar(x,data,0.8,'LineWidth',2);
h(1).FaceColor = 'b';
h(1).EdgeColor = 'b';
h(2).FaceColor = 'm';
h(2).EdgeColor = 'm';

ngroups = size(data,1);
nbars = size(data,2);
groupwidth = min(0.8,nbars/(nbars + 1.5));
for i = 1:nbars
    x = (1:ngroups) - groupwidth/2 + (2*i-1) * groupwidth / (2*nbars);
    errorbar(x,data(:,i),err(:,i), 'k', 'linestyle', 'none','linewidth',2);
end
xlim([0.5,size(data,1)+0.5])
ylim([0,15])
title('AZD dose response')
ylabel('Normalized to t=0')
legend({'MCF7','palbo mono'},'box','off')
grid on
box on
set(gca,'xtick',1:length(t0_MCF7_mean),'XTickLabel',{'t=0','Veh','100nM','250nM','500nM'},...
    'fontsize',20,'linewidth',2)
set(gcf,'position',[220,347,907,704],'color','w')
print(gcf,[pathsave,'FIG3E.pdf'],'-dpdf','-bestfit')
close gcf
%% average
% Normalized to Veh
Veh_MCF7_mean = mean(Veh_MCF7,1);
Veh_MCF7_sem = std(Veh_MCF7,[],1)/sqrt(n);

Veh_palbomono_mean = mean(Veh_palbomono,1);
Veh_palbomono_sem = std(Veh_palbomono,[],1)/sqrt(n);

data = [Veh_MCF7_mean',Veh_palbomono_mean'];
err = [Veh_MCF7_sem',Veh_palbomono_sem'];

x = 1:size(data,1);
figure;hold on
h = bar(x,data,0.8,'LineWidth',2);
h(1).FaceColor = 'b';
h(1).EdgeColor = 'b';
h(2).FaceColor = 'm';
h(2).EdgeColor = 'm';

ngroups = size(data,1);
nbars = size(data,2);
groupwidth = min(0.8,nbars/(nbars + 1.5));
for i = 1:nbars
    x = (1:ngroups) - groupwidth/2 + (2*i-1) * groupwidth / (2*nbars);
    errorbar(x,data(:,i),err(:,i), 'k', 'linestyle', 'none','linewidth',2);
end
xlim([0.5,size(data,1)+0.5])
ylim([0.0,1.3])
title('AZD dose response')
ylabel('Normalized to Veh')
legend({'MCF7','palbo mono'},'box','off')
grid on
box on
set(gca,'xtick',1:length(Veh_MCF7_mean),'XTickLabel',{'Veh','100nM','250nM','500nM'},...
    'fontsize',20,'linewidth',2)
set(gcf,'position',[220,347,907,704],'color','w')
print(gcf,[pathsave,'FIG3D.pdf'],'-dpdf','-bestfit')
close gcf
%% average
% Normalized to GR
GR_MCF7_mean = mean(GR_MCF7,1);
GR_MCF7_sem = std(GR_MCF7,[],1)/sqrt(n);

GR_palbomono_mean = mean(GR_palbomono,1);
GR_palbomono_sem = std(GR_palbomono,[],1)/sqrt(n);

data = [GR_MCF7_mean',GR_palbomono_mean'];
err = [GR_MCF7_sem',GR_palbomono_sem'];

x = 1:size(data,1);
figure;hold on
h = bar(x,data,0.8,'LineWidth',2);
h(1).FaceColor = 'b';
h(1).EdgeColor = 'b';
h(2).FaceColor = 'm';
h(2).EdgeColor = 'm';

ngroups = size(data,1);
nbars = size(data,2);
groupwidth = min(0.8,nbars/(nbars + 1.5));
for i = 1:nbars
    x = (1:ngroups) - groupwidth/2 + (2*i-1) * groupwidth / (2*nbars);
    errorbar(x,data(:,i),err(:,i), 'k', 'linestyle', 'none','linewidth',2);
end
xlim([0.5,size(data,1)+0.5])
ylim([-0.2,1.2])
title('AZD dose response')
ylabel('GR value')
legend({'MCF7','palbo mono'},'box','off')

grid on
box on
set(gca,'xtick',1:length(GR_MCF7_mean),'XTickLabel',{'Veh','100nM','250nM','500nM'},'fontsize',20,'linewidth',2)
set(gcf,'position',[220,347,907,704],'color','w')
print(gcf,[pathsave,'FIG3F.pdf'],'-dpdf','-bestfit')
close gcf
%% Two way Anova
% two way anova
%% Normalized to T = 0
% MCF7
t0_MCF7 = t0_MCF7(:,2:end);
t0_MCF7 = t0_MCF7(:);
treat_label = [repmat("Veh",3,1);repmat("100nM",3,1);repmat("250nM",3,1);repmat("500nM",3,1)];
MCF7_label = repmat("MCF7",numel(t0_MCF7),1);
% palbo mono
t0_palbomono = t0_palbomono(:,2:end);
t0_palbomono = t0_palbomono(:);
palbomono_label = repmat("palbomono",numel(t0_palbomono),1);

y = [t0_MCF7;t0_palbomono];
g1 = [treat_label;treat_label;];
g2 = [MCF7_label;palbomono_label];

[~,~,stats] = anovan(y,{g2 g1},'model','interaction','varnames',{'cell type','dose'});
[c,~,~,gnames] = multcompare(stats,'Dimension',[1,2]);
% pval = [gnames(c(:,1)), gnames(c(:,2)), num2cell(c(:,3:6))];
pval_t0 = child_anovan(c,gnames);

clearvars t0_MCF7 t0_palbomono treat_label MCF7_label palbomono_label
%% Normalized to Veh
% MCF7
Veh_MCF7 = Veh_MCF7(:,2:end);
Veh_MCF7 = Veh_MCF7(:);
treat_label = [repmat("100nM",3,1);repmat("250nM",3,1);repmat("500nM",3,1)];
MCF7_label = repmat("MCF7",numel(Veh_MCF7),1);
% palbo mono
Veh_palbomono = Veh_palbomono(:,2:end);
Veh_palbomono = Veh_palbomono(:);
palbomono_label = repmat("palbomono",numel(Veh_palbomono),1);

y = [Veh_MCF7;Veh_palbomono;];
g1 = [treat_label;treat_label;];
g2 = [MCF7_label;palbomono_label;];

[~,~,stats] = anovan(y,{g2 g1},'model','interaction','varnames',{'cell type','dose'});
[c,~,~,gnames] = multcompare(stats,'Dimension',[1,2]);
pval_Veh = child_anovan(c,gnames);

clearvars Veh_MCF7 Veh_palbomono treat_label MCF7_label palbomono_label
%% Normalized to GR
% MCF7
GR_MCF7 = GR_MCF7(:,2:end);
GR_MCF7 = GR_MCF7(:);
treat_label = [repmat("100nM",3,1);repmat("250nM",3,1);repmat("500nM",3,1)];
MCF7_label = repmat("MCF7",numel(GR_MCF7),1);
% palbo mono
GR_palbomono = GR_palbomono(:,2:end);
GR_palbomono = GR_palbomono(:);
palbomono_label = repmat("palbomono",numel(GR_palbomono),1);

y = [GR_MCF7;GR_palbomono];
g1 = [treat_label;treat_label];
g2 = [MCF7_label;palbomono_label];

[~,~,stats] = anovan(y,{g2 g1},'model','interaction','varnames',{'cell type','dose'});
[c,~,~,gnames] = multcompare(stats,'Dimension',[1,2]);
pval_GR = child_anovan(c,gnames);

clearvars GR_MCF7 GR_palbomono treat_label MCF7_label palbomono_label
end

function GR = E2depICIpalbo_doseresponse_child(data)
GR = 2.^(log2(data./data(1)) ./ log2(data(2)./data(1))) - 1;
end

function pval = child_anovan(c,gnames)
ind = zeros(size(c,1),1);
for i = 1:size(c,1)
    pval1 = c(i,end);
    name1 = gnames(c(i,1));
    name1 = name1{:};
    name2 = gnames(c(i,2));
    name2 = name2{:};
    pos1 = strfind(name1,'=');
    name1 = name1(pos1(end)+1:end);
    pos2 = strfind(name2,'=');
    name2 = name2(pos2(end)+1:end);
    if strcmp(name1,name2) && pval1 < 0.05
        ind(i) = 1;
    end
end
pval = [gnames(c(logical(ind),1)), gnames(c(logical(ind),2)), num2cell(c(logical(ind),6))];
end