function x_output = E2ICIpalbowee1_model(t,x,treat,PAR)
%% treat
ICI = treat.ICI;
palbo = treat.palbo;
AZD = treat.AZD;
%% variables
x(x < 0) = 0;

E2media = x(1);
E2cell = x(2);
ER = x(3);
E2ER = x(4);
ICIER = x(5);
rescyclinE1palbo = x(6);
rescdk6ICI = x(7);
cyclinD1 = x(8);
cdk4 = x(9);
cdk6 = x(10);
cyclinD1cdk4 = x(11);
cyclinD1cdk6 = x(12);
cyclinD1cdk4p21 = x(13);
cyclinD1cdk6p21 = x(14);
cyclinD1cdk4palbo = x(15);
cyclinD1cdk6palbo = x(16);
cyclinD1cdk4p21palbo = x(17);
cyclinD1cdk6p21palbo = x(18);
cMyc = x(19);
p21 = x(20);
cyclinE1 = x(21);
Rb = x(22);
pRb = x(23);
ppRb = x(24);
Nalive = x(25);
Ndead = x(26);

if isnan(t)
    disp(t/24)
end
%% parameter
i = 1;
%% E2, ER
% (1).Diffusion rate of E2
[k_diff, i] = child_par(PAR, i);
% (2).Volume of MCF7 cell
[Volcell, i] = child_par(PAR, i);
% (3).Volume of media
[Volmedia, i] = child_par(PAR, i);
% (4).Translation rate of ER
[k_ER, i] = child_par(PAR, i);
% (5).Degradation rate of ER
[kd_ER, i] = child_par(PAR, i);
% (6).Degradation rate of E2ER
[kd_E2ER, i] = child_par(PAR, i);
% (7).Degradation rate of ICIER
[kd_ICIER, i] = child_par(PAR, i);
% (10).Binding rate between ER and E2cell
[kb_E2ER, i] = child_par(PAR, i);
% (11).Unbinding rate between ER and E2cell
[kub_E2ER, i] = child_par(PAR, i);
% (12).Binding rate between ICI and ER
[kb_ICIER, i] = child_par(PAR, i);
% (13).Unbinding rate between ICI and ER
[kub_ICIER, i] = child_par(PAR, i);
%% cyclinD1
% (14).Translation rate of cyclinD1
[k_cyclinD1, i] = child_par(PAR, i);
% (15).Degradation rate of cyclinD1
[kd_cyclinD1, i] = child_par(PAR, i);
% (16).Binding rate between cyclinD1 and cdk46
[kb_cyclinD1cdk46, i] = child_par(PAR, i);
% (17).Unbinding rate between cyclinD1 and cdk46
[kub_cyclinD1cdk46, i] = child_par(PAR, i);
% (18).Increasing rate of cyclinD1 by E2ER
[k_cyclinD1E2ER, i] = child_par(PAR, i);
% (19).Parameter 1 of cyclinD1 increased by E2ER
[p_cyclinD1E2ER_1, i] = child_par(PAR, i);
% (20).Parameter 2 of cyclinD1 increased by E2ER
[p_cyclinD1E2ER_2, i] = child_par(PAR, i);
%% rescdk6ICI
% (21).Increasing rate of rescdk6ICI
[k_rescdk6ICI, i] = child_par(PAR, i);
% (22).Parameter 1 of rescdk6ICI increased by ICI
[p_rescdk6ICI_1, i] = child_par(PAR, i);
% (23).Parameter 2 of rescdk6ICI increased by ICI
[p_rescdk6ICI_2, i] = child_par(PAR, i);
% (24).Decreasing rate of rescdk6ICI
[kd_rescdk6ICI,i] = child_par(PAR, i);
% (25).Parameter 1 of rescdk6ICI decreasing
[p_kdrescdk6ICI_1,i] = child_par(PAR, i);
% (26).Parameter 2 of rescdk6ICI decreasing
[p_kdrescdk6ICI_2,i] = child_par(PAR, i);
% (27).Decreasing rate of rescdk6ICI by AZD
[kd_rescdk6ICI_AZD, i] = child_par(PAR, i);
%% cdk4
% (28).Translation rate of cdk4
[k_cdk4, i] = child_par(PAR, i);
% (29).Degradation rate of cdk46
[kd_cdk46, i] = child_par(PAR, i);
%% cdk6
% (30).Translation rate of cdk6
[k_cdk6, i] = child_par(PAR, i);
% (31).Increasing rate of cdk6 by rescdk6ICI
[k_cdk6rescdk6ICI, i] = child_par(PAR, i);
% (32).Parameter 1 of cdk6 increased by rescdk6ICI
[p_cdk6rescdk6ICI_1, i] = child_par(PAR, i);
% (33).Parameter 2 of cdk6 increased by rescdk6ICI
[p_cdk6rescdk6ICI_2, i] = child_par(PAR, i);
%% cyclinD1/cdk46
% (34).Degradation rate of cyclinD1cdk46
[kd_cyclinD1cdk46, i] = child_par(PAR, i);
% (35).Binding rate between cyclinD1cdk46 and palbo
[kb_cyclinD1cdk46palbo, i] = child_par(PAR, i);
% (36).Unbinding rate between cyclinD1cdk46 and palbo
[kub_cyclinD1cdk46palbo, i] = child_par(PAR, i);
% (37).Binding rate between cyclinD1cdk46 and p21
[kb_cyclinD1cdk46p21, i] = child_par(PAR, i);
% (38).Unbinding rate between cyclinD1cdk46 and p21
[kub_cyclinD1cdk46p21, i] = child_par(PAR, i);
% (39).Binding rate between cyclinD1cdk46p21 and palbo
[kb_cyclinD1cdk46p21palbo, i] = child_par(PAR, i);
% (40).Unbinding rate between cyclinD1cdk46p21 and palbo
[kub_cyclinD1cdk46p21palbo, i] = child_par(PAR, i);
%% cMyc
% (41).Translation rate of cMyc
[k_cMyc, i] = child_par(PAR, i);
% (42).Degradation rate of cMyc
[kd_cMyc, i] = child_par(PAR, i);
% (43).Increasing rate of cMyc by E2ER
[k_cMycE2ER, i] = child_par(PAR, i);
% (44).Parameter 1 of cMyc increased by E2ER
[p_cMycE2ER_1, i] = child_par(PAR, i);
% (45).Parameter 2 of cMyc increased by E2ER
[p_cMycE2ER_2, i] = child_par(PAR, i);
% (46).Increasing rate of cMyc by ppRb
[k_cMycppRb, i] = child_par(PAR, i);
% (47).Parameter 1 of cMyc increased by ppRb
[p_cMycppRb_1, i] = child_par(PAR, i);
% (48).Parameter 2 of cMyc increased by ppRb
[p_cMycppRb_2, i] = child_par(PAR, i);
%% p21
% (49).Translation rate of p21 inhibited by cMyc
[k_p21cMyc, i] = child_par(PAR, i);
% (50).Parameter 1 of p21 inhibited by cMyc
[p_p21cMyc_1, i] = child_par(PAR, i);
% (51).Parameter 2 of p21 inhibited by cMyc
[p_p21cMyc_2, i] = child_par(PAR, i);
% (52).Degradation rate of p21
[kd_p21, i] = child_par(PAR, i);
%% rescyclinE1palbo
% (53).Increasing rate of rescyclinE1palbo
[k_rescyclinE1palbo, i] = child_par(PAR, i);
% (54).Parameter 1 of rescyclinE1palbo increased by palbo
[p_rescyclinE1palbo_1, i] = child_par(PAR, i);
% (55).Parameter 2 of rescyclinE1palbo increased by palbo
[p_rescyclinE1palbo_2, i] = child_par(PAR, i);
% (56).Decreasing rate of rescyclinE1palbo
[kd_rescyclinE1palbo, i] = child_par(PAR, i);
% (57).Parameter 1 of rescyclinE1palbo decreasing
[p_kdrescyclinE1palbo_1, i] = child_par(PAR, i);
% (58).Parameter 2 of rescyclinE1palbo decreasing
[p_kdrescyclinE1palbo_2, i] = child_par(PAR, i);
% (59).Decreasing rate of rescyclinE1palbo by AZD
[kd_rescyclinE1palbo_AZD, i] = child_par(PAR, i);
%% cyclinE1
% (60).Translation rate of cyclinE1
[k_cyclinE1, i] = child_par(PAR, i);
% (61).Degradation rate of cyclinE1
[kd_cyclinE1, i] = child_par(PAR, i);
% (62).Decreasing rate of cyclinE1 by AZD
[kd_cyclinE1_AZD, i] = child_par(PAR, i);
% (63).Increasing rate of cyclinE1 by E2ER
[k_cyclinE1E2ER, i] = child_par(PAR, i);
% (64).Parameter 1 of cyclinE1 increased by E2ER
[p_cyclinE1E2ER_1, i] = child_par(PAR, i);
% (65).Parameter 2 of cyclinE1 increased by E2ER
[p_cyclinE1E2ER_2, i] = child_par(PAR, i);
% (66).Increasing rate of cyclinE1 by rescyclinE1palbo
[k_cyclinE1rescyclinE1palbo, i] = child_par(PAR, i);
% (67).Parameter 1 of cyclinE1 increase by rescyclinE1palbo
[p_cyclinE1rescyclinE1palbo_1, i] = child_par(PAR, i);
% (68).Parameter 2 of cyclinE1 increase by rescyclinE1palbo
[p_cyclinE1rescyclinE1palbo_2, i] = child_par(PAR, i);
%% Rb protein
% (69).Translation rate of Rb
[k_Rb, i] = child_par(PAR, i);
% (70).Degradation rate of Rb
[kd_Rb, i] = child_par(PAR, i);
% (71).Increasing rate of Rb by ppRb
[k_RbppRb, i] = child_par(PAR, i);
% (72).Parameter 1 of Rb increased by ppRb
[p_RbppRb_1, i] = child_par(PAR, i);
% (73).Parameter 2 of Rb increased by ppRb
[p_RbppRb_2, i] = child_par(PAR, i);
% (74).Phosphorylation rate of Rb by cyclinD1cdk4
[k_RbcyclinD1cdk4, i] = child_par(PAR, i);
% (75).Parameter 1 of cyclinD1cdk4 kinase activity
[p_cyclinD1cdk4_1, i] = child_par(PAR, i);
% (76).Parameter 2 of cyclinD1cdk4 kinase activity
[p_cyclinD1cdk4_2, i] = child_par(PAR, i);
% (77).Phosphorylation rate of Rb by cyclinD1cdk6
[k_RbcyclinD1cdk6, i] = child_par(PAR, i);
% (78).Parameter 1 of cyclinD1cdk6 kinase activity
[p_cyclinD1cdk6_1, i] = child_par(PAR, i);
% (79).Parameter 2 of cyclinD1cdk6 kinase activity
[p_cyclinD1cdk6_2, i] = child_par(PAR, i);
%% pRb
% (80).Phosphorylation rate of pRb by cyclinE1
[k_pRbcyclinE1, i] = child_par(PAR, i);
% (81).Parameter 1 of cyclinE1 kinase activity
[p_cyclinE1_1, i] = child_par(PAR, i);
% (82).Parameter 2 of cyclinE1 kinase activity
[p_cyclinE1_2, i] = child_par(PAR, i);
% (83).Dephosphorylation rate of pRb
[k_pRbdepho, i] = child_par(PAR, i);
%% ppRb
% (84).Degradation rate of ppRb
[kd_ppRb, i] = child_par(PAR, i);
% (85).Dephosphorylation rate of ppRb
[k_ppRbdepho, i] = child_par(PAR, i);
%% proliferation
% (86).Basal proliferation rate
[k_pro, i] = child_par(PAR, i);
% (87).Proliferation rate increased by ppRb
[k_proppRb, i] = child_par(PAR, i);
% (88).Parameter 1 of proliferation rate increased by ppRb
[p_proppRb_1, i] = child_par(PAR, i);
% (89).Parameter 2 of proliferation rate increased by ppRb
[p_proppRb_2, i] = child_par(PAR, i);
% (90).Proliferation rate increased by cyclinE1
[k_procyclinE1, i] = child_par(PAR, i);
% (91).Parameter 1 of proliferation rate increased by cyclinE1
[p_procyclinE1_1, i] = child_par(PAR, i);
% (92).Parameter 2 of proliferation rate increased by cyclinE1
[p_procyclinE1_2, i] = child_par(PAR, i);
% (93).Carrying capacity
[k_carrying, i] = child_par(PAR, i);
% (94).Death rate
[k_death, i] = child_par(PAR, i);
% (95).Lysis rate of dead cell
[k_lysing, ~] = child_par(PAR, i);
%% Model
%% N
N = Nalive + Ndead;
%% Nalive
% Hillfun for increased proliferation by ppRb
HF_proppRb = ppRb^p_proppRb_2/(p_proppRb_1^p_proppRb_2 + ppRb^p_proppRb_2);
% Hillfun for increased proliferation by cyclinE1
HF_procyclinE1 = cyclinE1^p_procyclinE1_2/(p_procyclinE1_1^p_procyclinE1_2 + cyclinE1^p_procyclinE1_2);

dNalive =...
    (k_pro...                                        % basal proliferation
   + k_proppRb * HF_proppRb...                       % ppRb proliferation
   + k_procyclinE1 * HF_procyclinE1)...              % cyclinE1 proliferation
   * Nalive * (1 - Nalive/k_carrying)...             % carrying capacity
   - k_death * Nalive;                               % cell death
%% Ndead
dNdead =...
    k_death * Nalive...       % cell death
  - k_lysing * Ndead;         % dead cell lysing
%% E2media
dE2media =...
    k_diff * (N * Volcell)/Volmedia * (E2cell - E2media);
%% E2cell
dE2cell =...
    - k_diff * (E2cell - E2media)...               % diffusion of E2 between cell and media
    - (dNalive + dNdead)/N * E2cell...
    - kb_E2ER * E2cell * ER + kub_E2ER * E2ER...   % binding unbinding between E2 and ER
    + kd_E2ER * E2ER;
%% ER
dER =...
    k_ER...                                        % translation
  - kd_ER * ER...                                  % degradation
  - kb_E2ER * E2cell * ER + kub_E2ER * E2ER...     % binding unbinding of E2 and ER
  - kb_ICIER * ICI * ER + kub_ICIER * ICIER;       % binding unbinding of ICI and ER
%% E2ER
dE2ER =...
    - kd_E2ER * E2ER...                            % degradation
    + kb_E2ER * E2cell * ER - kub_E2ER * E2ER;     % binding unbinding between E2 and ER
%% ICIER
dICIER =...
    - kd_ICIER * ICIER...
    + kb_ICIER * ICI * ER - kub_ICIER * ICIER;     % binding unbinding between ICI and ER
%% cyclinD1
HF_cyclinD1E2ER =...
    E2ER^p_cyclinD1E2ER_2/...
    (p_cyclinD1E2ER_1^p_cyclinD1E2ER_2 + E2ER^p_cyclinD1E2ER_2);

dcyclinD1 =...
      k_cyclinD1...                              % basal translation
    - kd_cyclinD1 * cyclinD1...                  % degradation
    - kb_cyclinD1cdk46 * cyclinD1 * cdk4...      % binding between cyclinD1 and cdk4
    + kub_cyclinD1cdk46 * cyclinD1cdk4...        % unbinding between cyclinD1 and cdk4
    - kb_cyclinD1cdk46 * cyclinD1 * cdk6...      % binding between cyclinD1 and cdk6
    + kub_cyclinD1cdk46 * cyclinD1cdk6...        % unbinding between cyclinD1 and cdk6
    + k_cyclinD1E2ER * HF_cyclinD1E2ER;          % translation by E2ER
%% rescdk6ICI
% Hillfun for increased rescdk6ICI by ICI
HF_rescdk6ICI =...
    ICI^p_rescdk6ICI_2/(ICI^p_rescdk6ICI_2 + p_rescdk6ICI_1^p_rescdk6ICI_2);
% Hillfun for degradation of rescdk6ICI
HF_kdrescdk6ICI =...
    rescdk6ICI^p_kdrescdk6ICI_2/(p_kdrescdk6ICI_1^p_kdrescdk6ICI_2+rescdk6ICI^p_kdrescdk6ICI_2);

drescdk6ICI =...
    k_rescdk6ICI * HF_rescdk6ICI...
  - kd_rescdk6ICI * HF_kdrescdk6ICI...
  - kd_rescdk6ICI_AZD * rescdk6ICI * sign(AZD);
%% cdk4
dcdk4 =...
    k_cdk4...                                 % translation 
  - kd_cdk46 * cdk4...                        % degradation
  - kb_cyclinD1cdk46 * cyclinD1 * cdk4...     % binding between cyclinD1 and cdk4
  + kub_cyclinD1cdk46 * cyclinD1cdk4;         % unbinding between cyclinD1 and cdk4

% Hillfun for increased cdk6 by rescdk6ICI
HF_cdk6rescdk6ICI =...
   rescdk6ICI^p_cdk6rescdk6ICI_2/...
   (p_cdk6rescdk6ICI_1^p_cdk6rescdk6ICI_2 + rescdk6ICI^p_cdk6rescdk6ICI_2);

dcdk6 =...
    k_cdk6...                                 % translation 
  - kd_cdk46 * cdk6...                        % degradation
  - kb_cyclinD1cdk46 * cyclinD1 * cdk6...     % binding between cyclinD1 and cdk6
  + kub_cyclinD1cdk46 * cyclinD1cdk6...       % unbinding between cyclinD1 and cdk6
  + k_cdk6rescdk6ICI * HF_cdk6rescdk6ICI;     % translation by rescdk6ICI
%% cyclinD1cdk4
dcyclinD1cdk4 =...
    - kd_cyclinD1cdk46 * cyclinD1cdk4...                % degradation
    + kb_cyclinD1cdk46 * cyclinD1 * cdk4...             % binding between cyclinD1 and cdk46
    - kub_cyclinD1cdk46 * cyclinD1cdk4...               % unbinding between cyclinD1 and cdk46
    - kb_cyclinD1cdk46p21 * cyclinD1cdk4 * p21...       % binding between cyclinD1/cdk46 and p21
    + kub_cyclinD1cdk46p21 * cyclinD1cdk4p21...         % unbindng between cyclinD1/cdk46 and p21
    - kb_cyclinD1cdk46palbo * cyclinD1cdk4 * palbo...   % binding between cyclinD1/cdk46 and palbo
    + kub_cyclinD1cdk46palbo * cyclinD1cdk4palbo;       % unbindng between cyclinD1/cdk46 and palbo
%% cyclinD1cdk6
dcyclinD1cdk6 =...
    - kd_cyclinD1cdk46 * cyclinD1cdk6...                % degradation
    + kb_cyclinD1cdk46 * cyclinD1 * cdk6...             % binding between cyclinD1 and cdk46
    - kub_cyclinD1cdk46 * cyclinD1cdk6...               % unbinding between cyclinD1 and cdk46
    - kb_cyclinD1cdk46p21 * cyclinD1cdk6 * p21...       % binding between cyclinD1/cdk46 and p21
    + kub_cyclinD1cdk46p21 * cyclinD1cdk6p21...         % unbindng between cyclinD1/cdk46 and p21
    - kb_cyclinD1cdk46palbo * cyclinD1cdk6 * palbo...   % binding between cyclinD1/cdk6 and palbo
    + kub_cyclinD1cdk46palbo * cyclinD1cdk6palbo;       % unbindng between cyclinD1/cdk46 and palbo
 %% cyclinD1cdk4p21
dcyclinD1cdk4p21 =...
    - kd_cdk46 * cyclinD1cdk4p21...                         % degradation
    + kb_cyclinD1cdk46p21 * cyclinD1cdk4 * p21...           % binding between cyclinD1/cdk4 and p21
    - kub_cyclinD1cdk46p21 * cyclinD1cdk4p21...             % unbindng between cyclinD1/cdk4 and p21
    - kb_cyclinD1cdk46p21palbo * cyclinD1cdk4p21 * palbo... % binding between cyclinD1cdk4p21 and palbo
    + kub_cyclinD1cdk46p21palbo * cyclinD1cdk4p21palbo;     % unbindng between cyclinD1cdk4p21 and palbo
 %% cyclinD1cdk6p21
dcyclinD1cdk6p21 =...
    - kd_cdk46 * cyclinD1cdk6p21...                         % degradation
    + kb_cyclinD1cdk46p21 * cyclinD1cdk6 * p21...           % binding between cyclinD1/cdk6 and p21
    - kub_cyclinD1cdk46p21 * cyclinD1cdk6p21...             % unbindng between cyclinD1/cdk6 and p21
    - kb_cyclinD1cdk46p21palbo * cyclinD1cdk6p21 * palbo... % binding between cyclinD1cdk6p21 and palbo
    + kub_cyclinD1cdk46p21palbo * cyclinD1cdk6p21palbo;     % unbindng between cyclinD1cdk6p21 and palbo
 %% cyclinD1cdk4palbo
dcyclinD1cdk4palbo = ...
    - kd_cyclinD1cdk46 * cyclinD1cdk4palbo...               % degradation
    + kb_cyclinD1cdk46palbo * cyclinD1cdk4 * palbo...       % binding between cyclinD1/cdk46 and palbo
    - kub_cyclinD1cdk46palbo * cyclinD1cdk4palbo;           % unbindng between cyclinD1/cdk46 and palbo
 %% cyclinD1cdk6palbo
dcyclinD1cdk6palbo = ...
    - kd_cyclinD1cdk46 * cyclinD1cdk6palbo...               % degradation
    + kb_cyclinD1cdk46palbo * cyclinD1cdk6 * palbo...       % binding between cyclinD1/cdk6 and palbo
    - kub_cyclinD1cdk46palbo * cyclinD1cdk6palbo;           % unbindng between cyclinD1/cdk46 and palbo
 %% cyclinD1cdk4p21palbo
dcyclinD1cdk4p21palbo =...
    - kd_cdk46 * cyclinD1cdk4p21palbo...                    % degradation
    + kb_cyclinD1cdk46p21palbo * cyclinD1cdk4p21 * palbo... % binding between cyclinD1cdk4p21 and palbo
    - kub_cyclinD1cdk46p21palbo * cyclinD1cdk4p21palbo;     % unbindng between cyclinD1cdk4p21 and palbo
 %% cyclinD1cdk6p21palbo
dcyclinD1cdk6p21palbo =...
    - kd_cdk46 * cyclinD1cdk6p21palbo...                    % degradation
    + kb_cyclinD1cdk46p21palbo * cyclinD1cdk6p21 * palbo... % binding between cyclinD1cdk6p21 and palbo
    - kub_cyclinD1cdk46p21palbo * cyclinD1cdk6p21palbo;     % unbindng between cyclinD1cdk6p21 and palbo
%% cMyc
% Hillfun for increased cMyc by E2ER
HF_cMycE2ER = E2ER^p_cMycE2ER_2/(p_cMycE2ER_1^p_cMycE2ER_2 + E2ER^p_cMycE2ER_2);
% Hillfun for increased cMyc by ppRb
HF_cMycppRb = ppRb^p_cMycppRb_2/(p_cMycppRb_1^p_cMycppRb_2 + ppRb^p_cMycppRb_2);

dcMyc =...
    + k_cMyc...                        % basal translation
    - kd_cMyc * cMyc...                % degradation
    + k_cMycE2ER * HF_cMycE2ER...    % translation by E2ER
    + k_cMycppRb * HF_cMycppRb;      % translation by ppRb
%% p21
% Hillfun for decreased p21 by cMyc
HF_p21cMyc = p_p21cMyc_1^p_p21cMyc_2/(p_p21cMyc_1^p_p21cMyc_2 + cMyc^p_p21cMyc_2);

dp21 =...
    k_p21cMyc * HF_p21cMyc...                       % translation inhibited by cMyc
  - kd_p21 * p21...                                 % degradation
  - kb_cyclinD1cdk46p21 * cyclinD1cdk4 * p21...     % binding bewteen cyclinD1/cdk4 and p21
  + kub_cyclinD1cdk46p21 * cyclinD1cdk4p21...       % unbinding bewteen cyclinD1/cdk4 and p21
  - kb_cyclinD1cdk46p21 * cyclinD1cdk6 * p21...     % binding bewteen cyclinD1/cdk6 and p21
  + kub_cyclinD1cdk46p21 * cyclinD1cdk6p21;         % unbinding bewteen cyclinD1/cdk6 and p21
%% rescyclinE1palbo
% Hillfun for increase rescyclinE1palbo by palbo
HF_rescyclinE1palbo =...
    palbo^p_rescyclinE1palbo_2/(palbo^p_rescyclinE1palbo_2 + p_rescyclinE1palbo_1^p_rescyclinE1palbo_2);
% Hillfun for degradation of rescyclinE1palbo
HF_kdrescyclinE1palbo =...
    rescyclinE1palbo^p_kdrescyclinE1palbo_2...
    /(p_kdrescyclinE1palbo_1^p_kdrescyclinE1palbo_2+rescyclinE1palbo^p_kdrescyclinE1palbo_2);

drescyclinE1palbo =...
    k_rescyclinE1palbo * HF_rescyclinE1palbo...
  - kd_rescyclinE1palbo * HF_kdrescyclinE1palbo...
  - kd_rescyclinE1palbo_AZD * rescyclinE1palbo * sign(AZD);       % degradation by AZD
%% cyclinE1
% Hillfun for increase cyclinE1 by E2ER
HF_cyclinE1E2ER = E2ER^p_cyclinE1E2ER_2/(p_cyclinE1E2ER_1^p_cyclinE1E2ER_2 + E2ER^p_cyclinE1E2ER_2);
% Hillfun for increase cyclinE1 by translation by rescyclinE1palbo
HF_cyclinE1rescyclinE1palbo =...
    rescyclinE1palbo^p_cyclinE1rescyclinE1palbo_2/...
    (p_cyclinE1rescyclinE1palbo_1^p_cyclinE1rescyclinE1palbo_2 + rescyclinE1palbo^p_cyclinE1rescyclinE1palbo_2);

dcyclinE1 =...
    + k_cyclinE1...                                                 basal translation
    - kd_cyclinE1 * cyclinE1...                                     degradation
    + k_cyclinE1E2ER * HF_cyclinE1E2ER...                           translation by E2ER
    + k_cyclinE1rescyclinE1palbo * HF_cyclinE1rescyclinE1palbo...   translation by rescyclinE1palbo
    - kd_cyclinE1_AZD * cyclinE1 * sign(AZD);                     % degradation by AZD
%% Rb
% Hillfun for increase Rb by ppRb
HF_RbppRb = ppRb^p_RbppRb_2/(p_RbppRb_1^p_RbppRb_2 + ppRb^p_RbppRb_2);
% Hillfun for Rb phosphorylation by cyclinD1/cdk4
HF_RbcyclinD1cdk4_1 =...
    cyclinD1cdk4^p_cyclinD1cdk4_2/...
    (p_cyclinD1cdk4_1^p_cyclinD1cdk4_2 + cyclinD1cdk4^p_cyclinD1cdk4_2);
% Hillfun for Rb phosphorylation by cyclinD1/cdk6
HF_RbcyclinD1cdk6_1 =...
    cyclinD1cdk6^p_cyclinD1cdk6_2/...
    (p_cyclinD1cdk6_1^p_cyclinD1cdk6_2 + cyclinD1cdk6^p_cyclinD1cdk6_2);

dRb =...                                                                       
    k_Rb...                                           % basal translation
  - kd_Rb * Rb...                                     % degradation
  + k_RbppRb * HF_RbppRb...                           % transcription by ppRb
  - k_RbcyclinD1cdk4 * HF_RbcyclinD1cdk4_1 * Rb...    % phosphorylation by cyclinD1/cdk4
  - k_RbcyclinD1cdk6 * HF_RbcyclinD1cdk6_1 * Rb...    % phosphorylation by cyclinD1/cdk6       
  + k_pRbdepho * pRb;                                 % dephosphorylation of pRb
%% pRb
% Hillfun for pRb phosphorylation by cyclinE1
HF_RbcyclinE1 =...
    cyclinE1^p_cyclinE1_2/...
    (p_cyclinE1_1^p_cyclinE1_2 + cyclinE1^p_cyclinE1_2);

dpRb =...
    - kd_Rb * pRb...                                  % degradation
    + k_RbcyclinD1cdk4 * HF_RbcyclinD1cdk4_1 * Rb...  % phosphorylation by cyclinD1/cdk4
    + k_RbcyclinD1cdk6 * HF_RbcyclinD1cdk6_1 * Rb...  % phosphorylation by cyclinD1/cdk6
    - k_pRbdepho * pRb...                             % dephosphorylation of pRb
    - k_pRbcyclinE1 * HF_RbcyclinE1 * pRb...          % phophorylation by cyclinE1
    + k_ppRbdepho * ppRb;                             % dephosphorylation of ppRb
%% ppRb
dppRb =...
    - kd_ppRb * ppRb...                               % degradation
    + k_pRbcyclinE1 * HF_RbcyclinE1 * pRb...          % phophorylation by cyclinE1
    - k_ppRbdepho * ppRb;                             % dephosphorylation of ppRb

x_output(1) = dE2media;
x_output(2) = dE2cell;
x_output(3) = dER;
x_output(4) = dE2ER;
x_output(5) = dICIER;
x_output(6) = drescyclinE1palbo;
x_output(7) = drescdk6ICI;
x_output(8) = dcyclinD1;
x_output(9) = dcdk4;
x_output(10) = dcdk6;
x_output(11) = dcyclinD1cdk4;
x_output(12) = dcyclinD1cdk6;
x_output(13) = dcyclinD1cdk4p21;
x_output(14) = dcyclinD1cdk6p21;
x_output(15) = dcyclinD1cdk4palbo;
x_output(16) = dcyclinD1cdk6palbo;
x_output(17) = dcyclinD1cdk4p21palbo;
x_output(18) = dcyclinD1cdk6p21palbo;
x_output(19) = dcMyc;
x_output(20) = dp21;
x_output(21) = dcyclinE1;
x_output(22) = dRb;
x_output(23) = dpRb;
x_output(24) = dppRb;
x_output(25) = dNalive;
x_output(26) = dNdead;
x_output = x_output(:);
end

function [i_par, i] = child_par(PAR, i)
i_par = PAR(i);
i = i+1;
end