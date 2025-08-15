function [PAR,lb,ub,grouppar,groupparall,power_ind] = E2ICIpalboAZD_par()
% Parameters used in the ODE model.
PAR = nan(200,1);
lb = nan(200,1);
ub = nan(200,1);
%% E2, ER
% (1).Diffusion rate of E2
k_diff = 3.65941800299408;
lbi = 3.8;
ubi = 5;
[PAR,lb,ub] = child_assign(k_diff,lbi,ubi,PAR,lb,ub);
clearvars k_diff lbi ubi

% (2).Volume of MCF7 cell
Volcell = 8e-5;
lbi = 7e-5;
ubi = 9e-4;
[PAR,lb,ub] = child_assign(Volcell,lbi,ubi,PAR,lb,ub);
clearvars Volcell lbi ubi

% (3).Volume of media
Volmedia = 10;
lbi = 4.5;
ubi = 10;
[PAR,lb,ub] = child_assign(Volmedia,lbi,ubi,PAR,lb,ub);
clearvars Volmedia lbi ubi

% (4).Translation rate of ER
k_ER = 316.843730544889;
lbi = 280;
ubi = 350;
[PAR,lb,ub] = child_assign(k_ER,lbi,ubi,PAR,lb,ub);
clearvars k_ER lbi ubi

% (5).Degradation rate of ER
kd_ER = 0.1;
lbi = 0.09;
ubi = 0.12;
[PAR,lb,ub] = child_assign(kd_ER,lbi,ubi,PAR,lb,ub);
clearvars kd_ER lbi ubi

% (6).Degradation rate of E2ER
kd_E2ER = 0.3;
lbi = 0.28;
ubi = 0.32;
[PAR,lb,ub] = child_assign(kd_E2ER,lbi,ubi,PAR,lb,ub);
clearvars kd_E2ER lbi ubi

% (7).Degradation rate of ICIER
kd_ICIER = 5.35569389835067;
lbi = 4;
ubi = 7;
[PAR,lb,ub] = child_assign(kd_ICIER,lbi,ubi,PAR,lb,ub);
clearvars kd_ICIER lbi ubi

% (8).Binding rate between ER and E2cell
kb_E2ER = 142.979081681680;
lbi = 120;
ubi = 160;
[PAR,lb,ub] = child_assign(kb_E2ER,lbi,ubi,PAR,lb,ub);
clearvars kb_E2ER lbi ubi

% (9).Unbinding rate between ER and E2cell
kub_E2ER = 1;
lbi = 1;
ubi = 1;
[PAR,lb,ub] = child_assign(kub_E2ER,lbi,ubi,PAR,lb,ub);
clearvars kub_E2ER lbi ubi

% (10).Binding rate between ICI and ER
kb_ICIER = 0.300130471497988;
lbi = 0.2;
ubi = 0.4;
[PAR,lb,ub] = child_assign(kb_ICIER,lbi,ubi,PAR,lb,ub);
clearvars kb_ICIER lbi ubi

% (11).Unbinding rate between ICI and ER
kub_ICIER = 1;
lbi = 0.1;
ubi = 2;
[PAR,lb,ub] = child_assign(kub_ICIER,lbi,ubi,PAR,lb,ub);
clearvars kub_ICIER lbi ubi
%% cyclinD1
% (12).Translation rate of cyclinD1
k_cyclinD1 = 11.4046546573762;
lbi = 8;
ubi = 14;
[PAR,lb,ub] = child_assign(k_cyclinD1,lbi,ubi,PAR,lb,ub);
clearvars k_cyclinD1 lbi ubi

% (13).Degradation rate of cyclinD1
kd_cyclinD1 = 1.4;
lbi = 1.3;
ubi = 1.5;
[PAR,lb,ub] = child_assign(kd_cyclinD1,lbi,ubi,PAR,lb,ub);
clearvars kd_cyclinD1 lbi ubi

% (14).Binding rate between cyclinD1 and cdk46
kb_cyclinD1cdk46 = 7079.91406250000;
lbi = 1.8e4;
ubi = 2.2e4;
[PAR,lb,ub] = child_assign(kb_cyclinD1cdk46,lbi,ubi,PAR,lb,ub);
clearvars kb_cyclinD1cdk46 lbi ubi

% (15).Unbinding rate between cyclinD1 and cdk46
kub_cyclinD1cdk46 = 1;
lbi = 1;
ubi = 1;
[PAR,lb,ub] = child_assign(kub_cyclinD1cdk46,lbi,ubi,PAR,lb,ub);
clearvars kub_cyclinD1cdk46 lbi ubi

% (16).Increasing rate of cyclinD1 by E2ER
k_cyclinD1_E2ER = 253.438595820573;
lbi = 320;
ubi = 400;
[PAR,lb,ub] = child_assign(k_cyclinD1_E2ER,lbi,ubi,PAR,lb,ub);
clearvars k_cyclinD1_E2ER lbi ubi

% (17).Parameter 1 of cyclinD1 increased by E2ER
p_cyclinD1_E2ER_1 = 1595.33094807459;
lbi = 1300;
ubi = 2000;
[PAR,lb,ub] = child_assign(p_cyclinD1_E2ER_1,lbi,ubi,PAR,lb,ub);
clearvars p_cyclinD1_E2ER_1 lbi ubi

% (18).Parameter 2 of cyclinD1 increased by E2ER
p_cyclinD1_E2ER_2 = 8.37404722411972;
lbi = 7;
ubi = 10;
[PAR,lb,ub] = child_assign(p_cyclinD1_E2ER_2,lbi,ubi,PAR,lb,ub);
clearvars p_cyclinD1_E2ER_2 lbi ubi
%% rescdk6ICI
% (19).Increasing rate of rescdk6ICI
k_rescdk6ICI = 7.14325893363815e-05;
lbi = 5e-5;
ubi = 9e-5;
[PAR,lb,ub] = child_assign(k_rescdk6ICI,lbi,ubi,PAR,lb,ub);
clearvars k_rescdk6ICI lbi ubi

% (20).Parameter 1 of rescdk6ICI increased by ICI
p_rescdk6ICI_1 = 1377.72854330534;
lbi = 1200;
ubi = 1600;
[PAR,lb,ub] = child_assign(p_rescdk6ICI_1,lbi,ubi,PAR,lb,ub);
clearvars p_rescdk6ICI_1 lbi ubi

% (21).Parameter 2 of rescdk6ICI increased by ICI
p_rescdk6ICI_2 = 3.24875047719161;
lbi = 2;
ubi = 4;
[PAR,lb,ub] = child_assign(p_rescdk6ICI_2,lbi,ubi,PAR,lb,ub);
clearvars p_rescdk6ICI_2 lbi ubi

% (22).Decreasing rate of rescdk6ICI
kd_rescdk6ICI = 2.67460169984767e-05;
lbi = 1e-5;
ubi = 3e-5;
[PAR,lb,ub] = child_assign(kd_rescdk6ICI,lbi,ubi,PAR,lb,ub);
clearvars kd_rescdk6ICI lbi ubi

% (23).Parameter 1 of rescdk6ICI decreasing
p_kdrescdk6ICI_1 = 0.0255293536186219;
lbi = 0.02;
ubi = 0.04;
[PAR,lb,ub] = child_assign(p_kdrescdk6ICI_1,lbi,ubi,PAR,lb,ub);
clearvars p_kdrescdk6ICI_1 lbi ubi

% (24).Parameter 2 of rescdk6ICI decreasing
p_kdrescdk6ICI_2 = 2.36166704479715;
lbi = 1;
ubi = 3;
[PAR,lb,ub] = child_assign(p_kdrescdk6ICI_2,lbi,ubi,PAR,lb,ub);
clearvars p_kdrescdk6ICI_2 lbi ubi

% (25).Decreasing rate of rescdk6ICI by AZD
kd_rescdkICI_AZD = 0.000799258342652820;
lbi = 7e-4;
ubi = 1.1e-3;
[PAR,lb,ub] = child_assign(kd_rescdkICI_AZD,lbi,ubi,PAR,lb,ub);
clearvars kd_rescdk6ICI_AZD lbi ubi
%% cdk4
% (26).Translation rate of cdk4
k_cdk4 = 18.3039943058393;
lbi = 16;
ubi = 21;
[PAR,lb,ub] = child_assign(k_cdk4,lbi,ubi,PAR,lb,ub);
clearvars k_cdk4 lbi ubi

% (27).Degradation rate of cdk46
kd_cdk46 = 0.1155;
lbi = 0.1;
ubi = 0.12;
[PAR,lb,ub] = child_assign(kd_cdk46,lbi,ubi,PAR,lb,ub);
clearvars kd_cdk46 lbi ubi
%% cdk6
% (28).Translation rate of cdk6
k_cdk6 = 0.199806801558004;
lbi = 0.1;
ubi = 0.3;
[PAR,lb,ub] = child_assign(k_cdk6,lbi,ubi,PAR,lb,ub);
clearvars k_cdk6 lbi ubi

% (29).Increasing rate of cdk6 by rescdk6ICI
k_cdk6rescdk6ICI = 3.51798698210301;
lbi = 1;
ubi = 3;
[PAR,lb,ub] = child_assign(k_cdk6rescdk6ICI,lbi,ubi,PAR,lb,ub);
clearvars k_cdk6rescdk6ICI lbi ubi

% (30).Parameter 1 of cdk6 increased by rescdk6ICI
p_cdk6rescdk6ICI_1 = 0.0328732501003683;
lbi = 0.02;
ubi = 0.04;
[PAR,lb,ub] = child_assign(p_cdk6rescdk6ICI_1,lbi,ubi,PAR,lb,ub);
clearvars p_cdk6rescdk6ICI_1 lbi ubi

% (31).Parameter 2 of cdk6 increased by rescdk6ICI
p_cdk6rescdk6ICI_2 = 3.14099751166884;
lbi = 1;
ubi = 3;
[PAR,lb,ub] = child_assign(p_cdk6rescdk6ICI_2,lbi,ubi,PAR,lb,ub);
clearvars p_cdk6rescdk6ICI_2 lbi ubi
%% cyclinD1/cdk46
% (32).Degradation rate of cyclinD1cdk46
kd_cyclinD1cdk46 = 0.192052867889404;
lbi = 0.16;
ubi = 0.22;
[PAR,lb,ub] = child_assign(kd_cyclinD1cdk46,lbi,ubi,PAR,lb,ub);
clearvars kd_cyclinD1cdk46 lbi ubi

% (33).Binding rate between cyclinD1cdk46 and palbo
kb_cyclinD1cdk46palbo = 0.00952439945854186;
lbi = 7e-3;
ubi = 12e-3;
[PAR,lb,ub] = child_assign(kb_cyclinD1cdk46palbo,lbi,ubi,PAR,lb,ub);
clearvars kb_cyclinD1cdk46palbo lbi ubi

% (34).Unbinding rate between cyclinD1cdk46 and palbo
kub_cyclinD1cdk46palbo = 1;
lbi = 1e-2;
ubi = 0.5;
[PAR,lb,ub] = child_assign(kub_cyclinD1cdk46palbo,lbi,ubi,PAR,lb,ub);
clearvars kub_cyclinD1cdk46palbo lbi ubi

% (35).Binding rate between cyclinD1cdk46 and p21
kb_cyclinD1cdk46p21 = 40.0062357669930;
lbi = 3;
ubi = 7;
[PAR,lb,ub] = child_assign(kb_cyclinD1cdk46p21,lbi,ubi,PAR,lb,ub);
clearvars kb_cyclinD1cdk46p21 lbi ubi

% (36).Unbinding rate between cyclinD1cdk46 and p21
kub_cyclinD1cdk46p21 = 1;
lbi = 1;
ubi = 1;
[PAR,lb,ub] = child_assign(kub_cyclinD1cdk46p21,lbi,ubi,PAR,lb,ub);
clearvars kub_cyclinD1cdk46p21 lbi ubi

% (37).Binding rate between cyclinD1cdk46p21 and palbo
kb_cyclinD1cdk46p21palbo = 0.112513615789783;
lbi = 19;
ubi = 25;
[PAR,lb,ub] = child_assign(kb_cyclinD1cdk46p21palbo,lbi,ubi,PAR,lb,ub);
clearvars kb_cyclinD1cdk46p21palbo lbi ubi

% (38).Unbinding rate between cyclinD1cdk46p21 and palbo
kub_cyclinD1cdk46p21palbo = 1;
lbi = 1;
ubi = 1;
[PAR,lb,ub] = child_assign(kub_cyclinD1cdk46p21palbo,lbi,ubi,PAR,lb,ub);
clearvars kub_cyclinD1cdk46p21palbo lbi ubi
%% cMyc
% (39).Translation rate of cMyc
k_cMyc = 13.3353192921405;
lbi = 10;
ubi = 15;
[PAR,lb,ub] = child_assign(k_cMyc,lbi,ubi,PAR,lb,ub);
clearvars k_cMyc lbi ubi

% (40).Degradation rate of cMyc
kd_cMyc = 2.31;
lbi = 2.2;
ubi = 2.4;
[PAR,lb,ub] = child_assign(kd_cMyc,lbi,ubi,PAR,lb,ub);
clearvars kd_cMyc lbi ubi

% (41).Increasing rate of cMyc by E2ER
k_cMycE2ER = 362.423760142138;
lbi = 370;
ubi = 480;
[PAR,lb,ub] = child_assign(k_cMycE2ER,lbi,ubi,PAR,lb,ub);
clearvars k_cMycE2ER lbi ubi

% (42).Parameter 1 of cMyc increased by E2ER
p_cMycE2ER_1 = 1810.53346123137;
lbi = 1600;
ubi = 2100;
[PAR,lb,ub] = child_assign(p_cMycE2ER_1,lbi,ubi,PAR,lb,ub);
clearvars p_cMycE2ER_1 lbi ubi

% (43).Parameter 2 of cMyc increased by E2ER
p_cMy_E2ER_2 = 5.57172083950341;
lbi = 4;
ubi = 7;
[PAR,lb,ub] = child_assign(p_cMy_E2ER_2,lbi,ubi,PAR,lb,ub);
clearvars p_cMycE2ER_2 lbi ubi

% (44).Increasing rate of cMyc by ppRb
k_cMycppRb = 107.426995267884;
lbi = 60;
ubi = 80;
[PAR,lb,ub] = child_assign(k_cMycppRb,lbi,ubi,PAR,lb,ub);
clearvars k_cMycppRb lbi ubi

% (45).Parameter 1 of cMyc increased by ppRb
p_cMycppRb_1 = 13.0047726406011;
lbi = 12;
ubi = 20;
[PAR,lb,ub] = child_assign(p_cMycppRb_1,lbi,ubi,PAR,lb,ub);
clearvars p_cMycppRb_1 lbi ubi

% (46).Parameter 2 of cMyc increased by ppRb
p_cMycppRb_2 = 3.46370441034343;
lbi = 4;
ubi = 6;
[PAR,lb,ub] = child_assign(p_cMycppRb_2,lbi,ubi,PAR,lb,ub);
clearvars p_cMycppRb_2 lbi ubi
%% p21
% (47).Translation rate of p21 inhibited by cMyc
k_p21cMyc = 11.2234355828639;
lbi = 10;
ubi = 15;
[PAR,lb,ub] = child_assign(k_p21cMyc,lbi,ubi,PAR,lb,ub);
clearvars k_p21cMyc lbi ubi

% (48).Parameter 1 of p21 inhibited by cMyc
p_p21cMyc_1 = 6.85220881790168;
lbi = 4;
ubi = 8;
[PAR,lb,ub] = child_assign(p_p21cMyc_1,lbi,ubi,PAR,lb,ub);
clearvars p_p21cMyc_1 lbi ubi

% (49).Parameter 2 of p21 inhibited by cMyc
p_p21cMyc_2 = 4.67984238680879;
lbi = 3;
ubi = 5;
[PAR,lb,ub] = child_assign(p_p21cMyc_2,lbi,ubi,PAR,lb,ub);
clearvars p_p21cMyc_2 lbi ubi

% (50).Degradation rate of p21
kd_p21 = 1.39;
lbi = 1.3;
ubi = 1.5;
[PAR,lb,ub] = child_assign(kd_p21,lbi,ubi,PAR,lb,ub);
clearvars kd_p21 lbi ubi
%% res_cyclinEpalbo
% (51).Increasing rate of rescyclinE1palbo
k_rescyclinE1palbo = 0.000447782352409407;
lbi = 3e-4;
ubi = 5e-4;
[PAR,lb,ub] = child_assign(k_rescyclinE1palbo,lbi,ubi,PAR,lb,ub);
clearvars k_rescyclinE1palbo lbi ubi

% (52).Parameter 1 of rescyclinE1palbo increased by palbo
p_rescyclinE1palbo_1 = 158.065045913620;
lbi = 170;
ubi = 220;
[PAR,lb,ub] = child_assign(p_rescyclinE1palbo_1,lbi,ubi,PAR,lb,ub);
clearvars p_rescyclinE1palbo_1 lbi ubi

% (53).Parameter 2 of rescyclinE1palbo increased by palbo
p_rescyclinE1palbo_2 = 0.760452120949580;
lbi = 0.6;
ubi = 1.5;
[PAR,lb,ub] = child_assign(p_rescyclinE1palbo_2,lbi,ubi,PAR,lb,ub);
clearvars p_rescyclinE1palbo_2 lbi ubi

% (54).Decreasing rate of rescyclinE1palbo
kd_rescyclinEpalbo = 0.000309319700568569;
lbi = 2e-4;
ubi = 4e-4;
[PAR,lb,ub] = child_assign(kd_rescyclinEpalbo,lbi,ubi,PAR,lb,ub);
clearvars kd_rescyclinEpalbo lbi ubi

% (55).Parameter 1 of rescyclinE1palbo decreasing
p_kdrescyclinEpalbo_1 = 0.123730802417439;
lbi = 0.11;
ubi = 0.18;
[PAR,lb,ub] = child_assign(p_kdrescyclinEpalbo_1,lbi,ubi,PAR,lb,ub);
clearvars p_kdrescyclinEpalbo_1 lbi ubi

% (56).Parameter 2 of rescyclinE1palbo decreasing
p_kdrescyclinEpalbo_2 = 8.99963989257813;
lbi = 11;
ubi = 15;
[PAR,lb,ub] = child_assign(p_kdrescyclinEpalbo_2,lbi,ubi,PAR,lb,ub);
clearvars p_kdrescyclinEpalbo_2 lbi ubi

% (57).Decreasing rate of rescyclinE1palbo by AZD
kd_rescyclinEpalboAZD = 10.5417039282837;
lbi = 8;
ubi = 12;
[PAR,lb,ub] = child_assign(kd_rescyclinEpalboAZD,lbi,ubi,PAR,lb,ub);
clearvars kd_rescyclinEpalboAZD lbi ubi
%% cyclinE
% (58).Translation rate of cyclinE1
k_cyclinE1 = 0.383271227237012;
lbi = 0.2;
ubi = 0.5;
[PAR,lb,ub] = child_assign(k_cyclinE1,lbi,ubi,PAR,lb,ub);
clearvars k_cyclinE1 lbi ubi

% (59).Degradation rate of cyclinE1
kd_cyclinE1 = 1.39;
lbi = 1.3;
ubi = 1.5;
[PAR,lb,ub] = child_assign(kd_cyclinE1,lbi,ubi,PAR,lb,ub);
clearvars kd_cyclinE1 lbi ubi

% (60).Decreasing rate of cyclinE1 by AZD
kd_cyclinE1_AZD = 0.727702619006140;
lbi = 0.5;
ubi = 0.8;
[PAR,lb,ub] = child_assign(kd_cyclinE1_AZD,lbi,ubi,PAR,lb,ub);
clearvars kd_cyclinE1_AZD lbi ubi

% (61).Increasing rate of cyclinE1 by E2ER
k_cyclinE1E2ER = 1.38098729704705;
lbi = 1.2;
ubi = 1.6;
[PAR,lb,ub] = child_assign(k_cyclinE1E2ER,lbi,ubi,PAR,lb,ub);
clearvars k_cyclinE1E2ER lbi ubi

% (62).Parameter 1 of cyclinE1 increased by E2ER
p_cyclinE1E2ER_1 = 892.533336851410;
lbi = 800;
ubi = 1000;
[PAR,lb,ub] = child_assign(p_cyclinE1E2ER_1,lbi,ubi,PAR,lb,ub);
clearvars p_cyclinE1E2ER_1 lbi ubi

% (63).Parameter 2 of cyclinE1 increased by E2ER
p_cyclinE1E2ER_2 = 2.89181475684720;
lbi = 2;
ubi = 4;
[PAR,lb,ub] = child_assign(p_cyclinE1E2ER_2,lbi,ubi,PAR,lb,ub);
clearvars p_cyclinE1E2ER_2 lbi ubi

% (64).Increasing rate of cyclinE1 by rescyclinE1palbo
k_cyclinE1rescyclinEpalbo = 5.82952880859375;
lbi = 5;
ubi = 7;
[PAR,lb,ub] = child_assign(k_cyclinE1rescyclinEpalbo,lbi,ubi,PAR,lb,ub);
clearvars k_cyclinE1rescyclinEpalbo lbi ubi

% (65).Parameter 1 of cyclinE1 increase by rescyclinE1palbo
p_cyclinE1rescyclinEpalbo_1 = 0.948922044661066;
lbi = 0.9;
ubi = 1.3;
[PAR,lb,ub] = child_assign(p_cyclinE1rescyclinEpalbo_1,lbi,ubi,PAR,lb,ub);
clearvars p_cyclinE1rescyclinEpalbo_1 lbi ubi

% (66).Parameter 2 of cyclinE1 increase by rescyclinE1palbo
p_cyclinErescyclinEpalbo_2 = 1.34577009342578;
lbi = 1;
ubi = 2;
[PAR,lb,ub] = child_assign(p_cyclinErescyclinEpalbo_2,lbi,ubi,PAR,lb,ub);
clearvars p_cyclinErescyclinEpalbo_2 lbi ubi
%% Rb
% (67).Translation rate of Rb
k_Rb = 12.0428640498101;
lbi = 9;
ubi = 13;
[PAR,lb,ub] = child_assign(k_Rb,lbi,ubi,PAR,lb,ub);
clearvars k_Rb lbi ubi

% (68).Degradation rate of Rb
kd_Rb = 0.35;
lbi = 0.32;
ubi = 0.38;
[PAR,lb,ub] = child_assign(kd_Rb,lbi,ubi,PAR,lb,ub);
clearvars kd_Rb lbi ubi

% (69).Increasing rate of Rb by ppRb
k_RbppRb = 2.73375580852231;
lbi = 5;
ubi = 8;
[PAR,lb,ub] = child_assign(k_RbppRb,lbi,ubi,PAR,lb,ub);
clearvars k_RbppRb lbi ubi

% (70).Parameter 1 of Rb increased by ppRb
p_RbppRb_1 = 1.61737522896733;
lbi = 0.5;
ubi = 3;
[PAR,lb,ub] = child_assign(p_RbppRb_1,lbi,ubi,PAR,lb,ub);
clearvars p_RbppRb_1 lbi ubi

% (71).Parameter 2 of Rb increased by ppRb
p_RbppRb_2 = 8.99853354363644;
lbi = 7;
ubi = 10;
[PAR,lb,ub] = child_assign(p_RbppRb_2,lbi,ubi,PAR,lb,ub);
clearvars p_RbppRb_2 lbi ubi

% (72).Phosphorylation rate of Rb by cyclinD1cdk4
k_RbcyclinD1cdk4 = 0.343571328295210;
lbi = 0.2;
ubi = 0.4;
[PAR,lb,ub] = child_assign(k_RbcyclinD1cdk4,lbi,ubi,PAR,lb,ub);
clearvars k_RbcyclinD1cdk4 lbi ubi

% (73).Parameter 1 of cyclinD1cdk4 kinase activity
p_cyclinD1cdk4_1 = 119.992275942816;
lbi = 800;
ubi = 1050;
[PAR,lb,ub] = child_assign(p_cyclinD1cdk4_1,lbi,ubi,PAR,lb,ub);
clearvars p_cyclinD1cdk4_1 lbi ubi

% (74).Parameter 2 of cyclinD1cdk4 kinase activity
p_cyclinD1cdk4_2 = 0.391893029603382;
lbi = 0.1;
ubi = 0.4;
[PAR,lb,ub] = child_assign(p_cyclinD1cdk4_2,lbi,ubi,PAR,lb,ub);
clearvars p_cyclinD1cdk4_2 lbi ubi

% (75).Phosphorylation rate of Rb by cyclinD1cdk6
k_RbcyclinD1cdk6 = 1.34722666118703;
lbi = 1;
ubi = 2;
[PAR,lb,ub] = child_assign(k_RbcyclinD1cdk6,lbi,ubi,PAR,lb,ub);
clearvars k_RbcyclinD1cdk6 lbi ubi

% (76).Parameter 1 of cyclinD1cdk6 kinase activity
p_cyclinD1cdk6_1 = 1.74111724451757;
lbi = 1.5;
ubi = 2.2;
[PAR,lb,ub] = child_assign(p_cyclinD1cdk6_1,lbi,ubi,PAR,lb,ub);
clearvars p_cyclinD1cdk6_1 lbi ubi

% (77).Parameter 2 of cyclinD1cdk6 kinase activity
p_cyclinD1cdk6_2 = 1.44107468525366;
lbi = 1;
ubi = 2;
[PAR,lb,ub] = child_assign(p_cyclinD1cdk6_2,lbi,ubi,PAR,lb,ub);
clearvars p_cyclinD1cdk6_2 lbi ubi
%% pRb
% (78).Phosphorylation rate of pRb by cyclinE1
k_pRbcyclinE1 = 84.4920144914642;
lbi = 70;
ubi = 100;
[PAR,lb,ub] = child_assign(k_pRbcyclinE1,lbi,ubi,PAR,lb,ub);
clearvars k_pRbcyclinE1 lbi ubi

% (79).Parameter 1 of cyclinE1 kinase activity
p_cyclinE1_1 = 1.22450951543343;
lbi = 1;
ubi = 1.4;
[PAR,lb,ub] = child_assign(p_cyclinE1_1,lbi,ubi,PAR,lb,ub);
clearvars p_cyclinE1_1 lbi ubi

% (80).Parameter 2 of cyclinE1 kinase activity
p_cyclinE1_2 = 1.97124398614875;
lbi = 1;
ubi = 3;
[PAR,lb,ub] = child_assign(p_cyclinE1_2,lbi,ubi,PAR,lb,ub);
clearvars p_cyclinE1_2 lbi ubi

% (81).Dephosphorylation rate of pRb
k_pRbdepho = 5.54280933260202;
lbi = 5;
ubi = 8;
[PAR,lb,ub] = child_assign(k_pRbdepho,lbi,ubi,PAR,lb,ub);
clearvars k_pRbdepho lbi ubi
%% ppRb
% (82).Degradation rate of ppRb
kd_ppRb = 0.05;
lbi = 0.03;
ubi = 0.07;
[PAR,lb,ub] = child_assign(kd_ppRb,lbi,ubi,PAR,lb,ub);
clearvars kd_ppRb lbi ubi

% (83).Dephosphorylation rate of ppRb
k_ppRbdepho = 21.6041933227614;
lbi = 18;
ubi = 25;
[PAR,lb,ub] = child_assign(k_ppRbdepho,lbi,ubi,PAR,lb,ub);
clearvars k_ppRbdepho lbi ubi
%% proliferation
% (84).Basal proliferation rate
k_pro = 0.00142453168594449;
lbi = 1e-3;
ubi = 2e-3;
[PAR,lb,ub] = child_assign(k_pro,lbi,ubi,PAR,lb,ub);
clearvars k_pro lbi ubi

% (85).Proliferation rate increased by ppRb
k_proppRb = 0.0362398290318529; 
lbi = 0.02;
ubi = 0.05;
[PAR,lb,ub] = child_assign(k_proppRb,lbi,ubi,PAR,lb,ub);
clearvars k_proppRb lbi ubi

% (86).Parameter 1 of proliferation rate increased by ppRb
p_proppRb_1 = 4.76412605810882;
lbi = 3;
ubi = 6;
[PAR,lb,ub] = child_assign(p_proppRb_1,lbi,ubi,PAR,lb,ub);
clearvars p_proppRb_1 lbi ubi

% (87).Parameter 2 of proliferation rate increased by ppRb
p_proppRb_2 = 3.06578035133135;
lbi = 2;
ubi = 4;
[PAR,lb,ub] = child_assign(p_proppRb_2,lbi,ubi,PAR,lb,ub);
clearvars p_proppRb_2 lbi ubi

% (88).Proliferation rate increased by cyclinE1
k_procyclinE1 = 0.634724462350517; 
lbi = 6;
ubi = 10;
[PAR,lb,ub] = child_assign(k_procyclinE1,lbi,ubi,PAR,lb,ub);
clearvars k_procyclinE1 lbi ubi

% (89).Parameter 1 of proliferation rate increased by cyclinE1
p_procyclinE1_1 = 6.94259570998761;
lbi = 4;
ubi = 7;
[PAR,lb,ub] = child_assign(p_procyclinE1_1,lbi,ubi,PAR,lb,ub);
clearvars p_procyclinE1_1 lbi ubi

% (90).Parameter 2 of proliferation rate increased by cyclinE1
p_procyclinE1_2 = 3.90959465378683;
lbi = 6;
ubi = 8.5;
[PAR,lb,ub] = child_assign(p_procyclinE1_2,lbi,ubi,PAR,lb,ub);
clearvars p_procyclinE1_2 lbi ubi

% (91).Carrying capacity
k_carrying = 179.534944453159;
lbi = 140;
ubi = 200;
[PAR,lb,ub] = child_assign(k_carrying,lbi,ubi,PAR,lb,ub);
clearvars k_carrying lbi ubi

% (92).Death rate
k_death = 0.000199950218200684;
lbi = 2e-4;
ubi = 4e-4;
[PAR,lb,ub] = child_assign(k_death,lbi,ubi,PAR,lb,ub);
clearvars k_death lbi ubi

% (93).Lysis rate of dead cell
k_lysing = 0.00592092974785044;
lbi = 0.0003;
ubi = 0.0005;
[PAR,lb,ub] = child_assign(k_lysing,lbi,ubi,PAR,lb,ub);
clearvars k_lysing lbi ubi

% (94).Dead cell at T = 0
deadT0 = 0.00;
lbi = 0.00;
ubi = 0.00; 
[PAR,lb,ub] = child_assign(deadT0,lbi,ubi,PAR,lb,ub);
clearvars deadT0 lbi ubi

clearvars -except PAR lb ub
PAR = rmmissing(PAR);
lb = rmmissing(lb);
ub = rmmissing(ub);

grouppar{1} = [1, 4, 7,  8,10,12,14,16,17,18,19,20]; % E2 in medium
grouppar{2} = [22,23,24,25,26,28,29,30,31,32,33,35]; % cyclinD1,cdk4,cdk6
grouppar{3} = [37,39,41,42,43,44,45,46,47,48,49,51,52]; % cMyc
grouppar{4} = [53,54,55,56,57,58,60,61,62,63,64,65,66]; % cyclinE
grouppar{5} = [67,69,70,71,72,73,74,75,76,77,78,79,81]; % Rb
grouppar{6} = [81,83,84,85,86,87,88,89,90,91,92,93];

groupparall = cell2mat(grouppar(1:length(grouppar)));
groupparall = sort(groupparall)';

power_ind = [18,    7,        10;...  % Parameter 2 of cyclinD1 increased by E2ER
             21,    2,        4;...   % Parameter 2 of rescdk6ICI increased by ICI
             24,    1,        3;...   % Parameter 2 of rescdk6ICI decreasing
             31,    1,        3;...   % Parameter 2 of cdk6 increased by rescdk6ICI
             43,    4,        7;...   % Parameter 2 of cMyc increased by E2ER
             46,    4         6;...   % Parameter 2 of cMyc increased by ppRb
             49,    3         5;...   % Parameter 2 of p21 inhibited by cMyc
             53,    0.5,      1.5;... % Parameter 2 of rescyclinE1palbo increased by palbo
             56,    11,       15;...  % Parameter 2 of rescyclinE1palbo decreasing
             63,    2,        4;...   % Parameter 2 of cyclinE1 increased by E2ER
             66,    1,        2;...   % Parameter 2 of cyclinE1 increase by rescyclinE1palbo
             71,    7,        10;...  % Parameter 2 of Rb increased translation by ppRb
             74,    0.1,      0.5;... % Parameter 2 of cyclinD1cdk4 kinase activity
             77,    1,        2;...   % Parameter 2 of cyclinD1cdk6 kinase activity
             80,    1,        3;...   % Parameter 2 of cyclinE1 kinase activity
             87,    2,        4;...   % Parameter 2 of proliferation rate increased by ppRb
             90,    6,        8.5];     % Parameter 2 of proliferation rate increased by cyclinE1

% groupparfix = [2,...    % Volume of MCF7 cell
%                3,...    % Volume of media
%                5,...    % Degradation rate of ER
%                6,...    % Degradation rate of E2ER
%                15,...   % Degradation rate of cyclinD1
%                30,...   % Translation rate of cdk6
%                42,...   % Degradation rate of cMyc
%                52,...   % Degradation rate of p21
%                61,...   % Degradation rate of cyclinE1
%                70,...   % Degradation rate of Rb
%                84];...  % Degradation rate of ppRb
end

function [PAR, lb, ub] = child_assign(PARi,lbi,ubi,PAR,lb,ub)
ind = find(isnan(PAR),1,'first');
PAR(ind) = PARi;
lb(ind) = lbi;
ub(ind) = ubi;
end
