function PAR = E2ICIpalbowee1_par
PAR = nan(100,1);
%% E2, ER
% (1).Diffusion rate of E2
k_diff = 3.369775669009705;
PAR = child_assign(k_diff,PAR);
clearvars k_diff

% (2).Volume of MCF7 cell
Volcell = 8e-5;
PAR = child_assign(Volcell,PAR);
clearvars Volcell

% (3).Volume of media
Volmedia = 10;
PAR = child_assign(Volmedia,PAR);
clearvars Volmedia

% (4).Translation rate of ER
k_ER = 316.277324294889;
PAR = child_assign(k_ER,PAR);
clearvars k_ER

% (5).Degradation rate of ER
kd_ER = 0.1;
PAR = child_assign(kd_ER,PAR);
clearvars kd_ER

% (6).Degradation rate of E2ER
kd_E2ER = 0.3;
PAR = child_assign(kd_E2ER,PAR);
clearvars kd_E2ER

% (7).Degradation rate of ICIER
kd_ICIER = 4.81043632999130;
PAR = child_assign(kd_ICIER,PAR);
clearvars kd_ICIER

% (8).Binding rate between ER and E2cell
kb_E2ER = 143.729325822305;
PAR = child_assign(kb_E2ER,PAR);
clearvars kb_E2ER

% (9).Unbinding rate between ER and E2cell
kub_E2ER = 1;
PAR = child_assign(kub_E2ER,PAR);
clearvars kub_E2ER

% (10).Binding rate between ICI and ER
kb_ICIER = 0.294959172517275;
PAR = child_assign(kb_ICIER,PAR);
clearvars kb_ICIER

% (11).Unbinding rate between ICI and ER
kub_ICIER = 1;
PAR = child_assign(kub_ICIER,PAR);
clearvars kub_ICIER
%% cyclinD1
% (12).Translation rate of cyclinD1
k_cyclinD1 = 11.3299171085481;
PAR = child_assign(k_cyclinD1,PAR);
clearvars k_cyclinD1

% (13).Degradation rate of cyclinD1
kd_cyclinD1 = 1.4;
PAR = child_assign(kd_cyclinD1,PAR);
clearvars kd_cyclinD1

% (14).Binding rate between cyclinD1 and cdk46
kb_cyclinD1cdk46 = 17065.5390625;
PAR = child_assign(kb_cyclinD1cdk46,PAR);
clearvars kb_cyclinD1cdk46

% (15).Unbinding rate between cyclinD1 and cdk46
kub_cyclinD1cdk46 = 1;
PAR = child_assign(kub_cyclinD1cdk46,PAR);
clearvars kub_cyclinD1cdk46

% (16).Increasing rate of cyclinD1 by E2ER
k_cyclinD1_E2ER = 349.118771601823;
PAR = child_assign(k_cyclinD1_E2ER,PAR);
clearvars k_cyclinD1_E2ER

% (17).Parameter 1 of cyclinD1 increased by E2ER
p_cyclinD1_E2ER_1 = 1592.05360432459;
PAR = child_assign(p_cyclinD1_E2ER_1,PAR);
clearvars p_cyclinD1_E2ER_1

% (18).Parameter 2 of cyclinD1 increased by E2ER
p_cyclinD1_E2ER_2 = 9.02759641845566;
PAR = child_assign(p_cyclinD1_E2ER_2,PAR);
clearvars p_cyclinD1_E2ER_2
%% rescdk6ICI
% (19).Increasing rate of rescdk6ICI
k_rescdk6ICI = 6.97577221012574e-05;
PAR = child_assign(k_rescdk6ICI,PAR);
clearvars k_rescdk6ICI

% (20).Parameter 1 of rescdk6ICI increased by ICI
p_rescdk6ICI_1 = 1380.79104330534;
PAR = child_assign(p_rescdk6ICI_1,PAR);
clearvars p_rescdk6ICI_1

% (21).Parameter 2 of rescdk6ICI increased by ICI
p_rescdk6ICI_2 = 3.24875047719161;
PAR = child_assign(p_rescdk6ICI_2,PAR);
clearvars p_rescdk6ICI_2

% (22).Decreasing rate of rescdk6ICI
kd_rescdk6ICI = 1.65990829250583e-05;
PAR = child_assign(kd_rescdk6ICI,PAR);
clearvars kd_rescdk6ICI

% (23).Parameter 1 of rescdk6ICI decreasing
p_kdrescdk6ICI_1 = 0.0274123835563660;
PAR = child_assign(p_kdrescdk6ICI_1,PAR);
clearvars p_kdrescdk6ICI_1

% (24).Parameter 2 of rescdk6ICI decreasing
p_kdrescdk6ICI_2 = 1.29394090954324;
PAR = child_assign(p_kdrescdk6ICI_2,PAR);
clearvars p_kdrescdk6ICI_2

% (25).Decreasing rate of rescdk6ICI by AZD
kd_rescdkICI_AZD = 0.000901966458826564;
PAR = child_assign(kd_rescdkICI_AZD,PAR);
clearvars kd_rescdk6ICI_AZD
%% cdk4
% (26).Translation rate of cdk4
k_cdk4 = 18.2257472355268;
PAR = child_assign(k_cdk4,PAR);
clearvars k_cdk4

% (27).Degradation rate of cdk46
kd_cdk46 = 0.1155;
PAR = child_assign(kd_cdk46,PAR);
clearvars kd_cdk46
%% cdk6
% (28).Translation rate of cdk6
k_cdk6 = 0.19538938212441;
PAR = child_assign(k_cdk6,PAR);
clearvars k_cdk6

% (29).Increasing rate of cdk6 by rescdk6ICI
k_cdk6rescdk6ICI = 1.45463248991551;
PAR = child_assign(k_cdk6rescdk6ICI,PAR);
clearvars k_cdk6rescdk6ICI

% (30).Parameter 1 of cdk6 increased by rescdk6ICI
p_cdk6rescdk6ICI_1 = 0.0344581972095907;
PAR = child_assign(p_cdk6rescdk6ICI_1,PAR);
clearvars p_cdk6rescdk6ICI_1

% (31).Parameter 2 of cdk6 increased by rescdk6ICI
p_cdk6rescdk6ICI_2 = 1.93183003120009;
PAR = child_assign(p_cdk6rescdk6ICI_2,PAR);
clearvars p_cdk6rescdk6ICI_2
%% cyclinD1/cdk46
% (32).Degradation rate of cyclinD1cdk46
kd_cyclinD1cdk46 = 0.194807079315185;
PAR = child_assign(kd_cyclinD1cdk46,PAR);
clearvars kd_cyclinD1cdk46

% (33).Binding rate between cyclinD1cdk46 and palbo
kb_cyclinD1cdk46palbo = 0.00832035583175658;
PAR = child_assign(kb_cyclinD1cdk46palbo,PAR);
clearvars kb_cyclinD1cdk46palbo

% (34).Unbinding rate between cyclinD1cdk46 and palbo
kub_cyclinD1cdk46palbo = 1;
PAR = child_assign(kub_cyclinD1cdk46palbo,PAR);
clearvars kub_cyclinD1cdk46palbo

% (35).Binding rate between cyclinD1cdk46 and p21
kb_cyclinD1cdk46p21 = 4.13086955605550;
PAR = child_assign(kb_cyclinD1cdk46p21,PAR);
clearvars kb_cyclinD1cdk46p21

% (36).Unbinding rate between cyclinD1cdk46 and p21
kub_cyclinD1cdk46p21 = 1;
PAR = child_assign(kub_cyclinD1cdk46p21,PAR);
clearvars kub_cyclinD1cdk46p21

% (37).Binding rate between cyclinD1cdk46p21 and palbo
kb_cyclinD1cdk46p21palbo = 14.5089498302368;
PAR = child_assign(kb_cyclinD1cdk46p21palbo,PAR);
clearvars kb_cyclinD1cdk46p21palbo

% (38).Unbinding rate between cyclinD1cdk46p21 and palbo
kub_cyclinD1cdk46p21palbo = 1;
PAR = child_assign(kub_cyclinD1cdk46p21palbo,PAR);
clearvars kub_cyclinD1cdk46p21palbo
%% cMyc
% (39).Translation rate of cMyc
k_cMyc = 13.3314130421405;
PAR = child_assign(k_cMyc,PAR);
clearvars k_cMyc

% (40).Degradation rate of cMyc
kd_cMyc = 2.31;
PAR = child_assign(kd_cMyc,PAR);
clearvars kd_cMyc

% (41).Increasing rate of cMyc by E2ER
k_cMycE2ER = 417.361260142138;
PAR = child_assign(k_cMycE2ER,PAR);
clearvars k_cMycE2ER

% (42).Parameter 1 of cMyc increased by E2ER
p_cMycE2ER_1 = 1811.47877373137;
PAR = child_assign(p_cMycE2ER_1,PAR);
clearvars p_cMycE2ER_1

% (43).Parameter 2 of cMyc increased by E2ER
p_cMy_E2ER_2 = 5.58499598598779;
PAR = child_assign(p_cMy_E2ER_2,PAR);
clearvars p_cMycE2ER_2

% (44).Increasing rate of cMyc by ppRb
k_cMycppRb = 59.9283380413215;
PAR = child_assign(k_cMycppRb,PAR);
clearvars k_cMycppRb

% (45).Parameter 1 of cMyc increased by ppRb
p_cMycppRb_1 = 18.1297726406011;
PAR = child_assign(p_cMycppRb_1,PAR);
clearvars p_cMycppRb_1

% (46).Parameter 2 of cMyc increased by ppRb
p_cMycppRb_2 = 3.75789386346843;
PAR = child_assign(p_cMycppRb_2,PAR);
clearvars p_cMycppRb_2
%% p21
% (47).Translation rate of p21 inhibited by cMyc
k_p21cMyc = 11.2086955926295;
PAR = child_assign(k_p21cMyc,PAR);
clearvars k_p21cMyc

% (48).Parameter 1 of p21 inhibited by cMyc
p_p21cMyc_1 = 6.85257502883918;
PAR = child_assign(p_p21cMyc_1,PAR);
clearvars p_p21cMyc_1

% (49).Parameter 2 of p21 inhibited by cMyc
p_p21cMyc_2 = 4.23761216219942;
PAR = child_assign(p_p21cMyc_2,PAR);
clearvars p_p21cMyc_2

% (50).Degradation rate of p21
kd_p21 = 1.39;
PAR = child_assign(kd_p21,PAR);
clearvars kd_p21
%% res_cyclinEpalbo
% (51).Increasing rate of rescyclinE1palbo
k_rescyclinE1palbo = 0.000449506230495020;
PAR = child_assign(k_rescyclinE1palbo,PAR);
clearvars k_rescyclinE1palbo

% (52).Parameter 1 of rescyclinE1palbo increased by palbo
p_rescyclinE1palbo_1 = 197.662702163620;
PAR = child_assign(p_rescyclinE1palbo_1,PAR);
clearvars p_rescyclinE1palbo_1

% (53).Parameter 2 of rescyclinE1palbo increased by palbo
p_rescyclinE1palbo_2 = 1.18738731687243;
PAR = child_assign(p_rescyclinE1palbo_2,PAR);
clearvars p_rescyclinE1palbo_2

% (54).Decreasing rate of rescyclinE1palbo
kd_rescyclinEpalbo = 0.000333762261539352;
PAR = child_assign(kd_rescyclinEpalbo,PAR);
clearvars kd_rescyclinEpalbo

% (55).Parameter 1 of rescyclinE1palbo decreasing
p_kdrescyclinEpalbo_1 = 0.137015485644978;
PAR = child_assign(p_kdrescyclinEpalbo_1,PAR);
clearvars p_kdrescyclinEpalbo_1

% (56).Parameter 2 of rescyclinE1palbo decreasing
p_kdrescyclinEpalbo_2 = 9.99999084472657;
PAR = child_assign(p_kdrescyclinEpalbo_2,PAR);
clearvars p_kdrescyclinEpalbo_2

% (57).Decreasing rate of rescyclinE1palbo by AZD
kd_rescyclinEpalboAZD = 7.63720868902589;
PAR = child_assign(kd_rescyclinEpalboAZD,PAR);
clearvars kd_rescyclinEpalboAZD
%% cyclinE
% (58).Translation rate of cyclinE1
k_cyclinE1 = 0.388578424807813;
PAR = child_assign(k_cyclinE1,PAR);
clearvars k_cyclinE1

% (59).Degradation rate of cyclinE1
kd_cyclinE1 = 1.39;
PAR = child_assign(kd_cyclinE1,PAR);
clearvars kd_cyclinE1

% (60).Decreasing rate of cyclinE1 by AZD
kd_cyclinE1_AZD = 0.656045438220007;
PAR = child_assign(kd_cyclinE1_AZD,PAR);
clearvars kd_cyclinE1_AZD

% (61).Increasing rate of cyclinE1 by E2ER
k_cyclinE1E2ER = 1.39240087126580;
PAR = child_assign(k_cyclinE1E2ER,PAR);
clearvars k_cyclinE1E2ER

% (62).Parameter 1 of cyclinE1 increased by E2ER
p_cyclinE1E2ER_1 = 892.322399351410;
PAR = child_assign(p_cyclinE1E2ER_1,PAR);
clearvars p_cyclinE1E2ER_1

% (63).Parameter 2 of cyclinE1 increased by E2ER
p_cyclinE1E2ER_2 = 2.92324786231595;
PAR = child_assign(p_cyclinE1E2ER_2,PAR);
clearvars p_cyclinE1E2ER_2

% (64).Increasing rate of cyclinE1 by rescyclinE1palbo
k_cyclinE1rescyclinEpalbo = 5.76264953613281;
PAR = child_assign(k_cyclinE1rescyclinEpalbo,PAR);
clearvars k_cyclinE1rescyclinEpalbo

% (65).Parameter 1 of cyclinE1 increase by rescyclinE1palbo
p_cyclinE1rescyclinEpalbo_1 = 1.03637207212689;
PAR = child_assign(p_cyclinE1rescyclinEpalbo_1,PAR);
clearvars p_cyclinE1rescyclinEpalbo_1 lbi ubi

% (66).Parameter 2 of cyclinE1 increase by rescyclinE1palbo
p_cyclinErescyclinEpalbo_2 = 1.35704252384570;
PAR = child_assign(p_cyclinErescyclinEpalbo_2,PAR);
clearvars p_cyclinErescyclinEpalbo_2
%% Rb
% (67).Translation rate of Rb
k_Rb = 10.4418813837945;
PAR = child_assign(k_Rb,PAR);
clearvars k_Rb

% (68).Degradation rate of Rb
kd_Rb = 0.35;
PAR = child_assign(kd_Rb,PAR);
clearvars kd_Rb

% (69).Increasing rate of Rb by ppRb
k_RbppRb = 7.12682221477231;
PAR = child_assign(k_RbppRb,PAR);
clearvars k_RbppRb

% (70).Parameter 1 of Rb increased by ppRb
p_RbppRb_1 = 1.54806980904546;
PAR = child_assign(p_RbppRb_1,PAR);
clearvars p_RbppRb_1

% (71).Parameter 2 of Rb increased by ppRb
p_RbppRb_2 = 8.17675619988644;
PAR = child_assign(p_RbppRb_2,PAR);
clearvars p_RbppRb_2

% (72).Phosphorylation rate of Rb by cyclinD1cdk4
k_RbcyclinD1cdk4 = 0.244795464647749;
PAR = child_assign(k_RbcyclinD1cdk4,PAR);
clearvars k_RbcyclinD1cdk4

% (73).Parameter 1 of cyclinD1cdk4 kinase activity
p_cyclinD1cdk4_1 = 826.773525942816;
PAR = child_assign(p_cyclinD1cdk4_1,PAR);
clearvars p_cyclinD1cdk4_1

% (74).Parameter 2 of cyclinD1cdk4 kinase activity
p_cyclinD1cdk4_2 = 0.169286847504993;
PAR = child_assign(p_cyclinD1cdk4_2,PAR);
clearvars p_cyclinD1cdk4_2

% (75).Phosphorylation rate of Rb by cyclinD1cdk6
k_RbcyclinD1cdk6 = 1.27551035259328;
PAR = child_assign(k_RbcyclinD1cdk6,PAR);
clearvars k_RbcyclinD1cdk6

% (76).Parameter 1 of cyclinD1cdk6 kinase activity
p_cyclinD1cdk6_1 = 1.90854430750585;
PAR = child_assign(p_cyclinD1cdk6_1,PAR);
clearvars p_cyclinD1cdk6_1

% (77).Parameter 2 of cyclinD1cdk6 kinase activity
p_cyclinD1cdk6_2 = 1.26812394062475;
PAR = child_assign(p_cyclinD1cdk6_2,PAR);
clearvars p_cyclinD1cdk6_2
%% pRb
% (78).Phosphorylation rate of pRb by cyclinE1
k_pRbcyclinE1 = 84.1991678117767;
PAR = child_assign(k_pRbcyclinE1,PAR);
clearvars k_pRbcyclinE1

% (79).Parameter 1 of cyclinE1 kinase activity
p_cyclinE1_1 = 1.22602585759652;
PAR = child_assign(p_cyclinE1_1,PAR);
clearvars p_cyclinE1_1

% (80).Parameter 2 of cyclinE1 kinase activity
p_cyclinE1_2 = 1.97124398614875;
PAR = child_assign(p_cyclinE1_2,PAR);
clearvars p_cyclinE1_2

% (81).Dephosphorylation rate of pRb
k_pRbdepho = 6.49927600740671;
PAR = child_assign(k_pRbdepho,PAR);
clearvars k_pRbdepho
%% ppRb
% (82).Degradation rate of ppRb
kd_ppRb = 0.05;
PAR = child_assign(kd_ppRb,PAR);
clearvars kd_ppRb

% (83).Dephosphorylation rate of ppRb
k_ppRbdepho = 21.8903261352614;
PAR = child_assign(k_ppRbdepho,PAR);
clearvars k_ppRbdepho
%% proliferation
% (84).Basal proliferation rate
k_pro = 0.00158843328320592;
PAR = child_assign(k_pro,PAR);
clearvars k_pro

% (85).Proliferation rate increased by ppRb
k_proppRb = 0.0396623277348558; 
PAR = child_assign(k_proppRb,PAR);
clearvars k_proppRb

% (86).Parameter 1 of proliferation rate increased by ppRb
p_proppRb_1 = 4.27000069189788;
PAR = child_assign(p_proppRb_1,PAR);
clearvars p_proppRb_1

% (87).Parameter 2 of proliferation rate increased by ppRb
p_proppRb_2 = 3.29656190650713;
PAR = child_assign(p_proppRb_2,PAR);
clearvars p_proppRb_2

% (88).Proliferation rate increased by cyclinE1
k_procyclinE1 = 8.15865024360052; 
PAR = child_assign(k_procyclinE1,PAR);
clearvars k_procyclinE1

% (89).Parameter 1 of proliferation rate increased by cyclinE1
p_procyclinE1_1 = 5.27246021194074;
PAR = child_assign(p_procyclinE1_1,PAR);
clearvars p_procyclinE1_1

% (90).Parameter 2 of proliferation rate increased by cyclinE1
p_procyclinE1_2 = 7.40642082566183;
PAR = child_assign(p_procyclinE1_2,PAR);
clearvars p_procyclinE1_2 lbi ubi

% (91).Carrying capacity
k_carrying = 160.310335078159;
PAR = child_assign(k_carrying,PAR);
clearvars k_carrying

% (92).Death rate
k_death = 0.000265126500278712;
PAR = child_assign(k_death,PAR);
clearvars k_death

% (93).Lysis rate of dead cell
k_lysing = 0.000211516308815024;
PAR = child_assign(k_lysing,PAR);
clearvars k_lysing

% (94).Dead cell at T = 0
deadT0 = 0.00;
PAR = child_assign(deadT0,PAR);
clearvars deadT0

clearvars -except PAR lb ub
PAR = rmmissing(PAR);
end

function PAR = child_assign(PARi,PAR)
ind = find(isnan(PAR),1,'first');
PAR(ind) = PARi;
end
