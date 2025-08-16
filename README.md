## WEE1 inhibition delays resistance in ER+ MCF7 breast cancer
[08/07/2025] This repository contains the MATLAB (R2023a) code, which does not use external packages, for the paper titled
"**WEE1 inhibition delays resistance to CDK4/6 inhibitor and antiestrogen treatment in estrogen receptor-positive MCF7 breast cancer cells: experiments and mathematical modeling**"

The **code** folder contains the functions used in the work.\
The **fig** folder contains the figures used in the paper.\
**Functions:**\
***(1).E2ICIpalboAZD_main()***\
This function runs the simulation. Generates plots for Figures 5A-F, 6E-F, Supplementary Figures 1A-D, and 2 using the single optimized parameter. These are primary simulation results, compared directly with experimental data.\
***(2).E2ICIpalboAZD_test()***\
This function estimates model parameters based on experimental data.\
***(3).E2ICIpalboAZD_modelpar()***\
This function generates the necessary given parameters for the model simulation.\
***(4).E2ICIpalboAZD_evlcost()***\
This function is for parameter estimation during optimization. It calls the function _E2ICIpalboAZD_cost()_.\
***(5).E2ICIpalboAZD_1steadystate()***\
This function checks whether two initial values—zero and a positive one 
result in the same steady state rather than distinct ones.\
***(6).E2ICIpalboAZD_replating()***\
This function resets the initial cell number each month, simulating the replating done in the experiment.\
***(7).E2ICIpalboAZD_par()***\
This function provides the parameter values used in the ODE model, 
corresponding to Supplementary Table 2. It also relates to the _./code/mat/PAR.mat_ file, 
which saves the current fitted parameter values. The values listed here
may not always be updated using the values in the _./code/mat/PAR.mat_, but they correspond one-to-one, 
and the parameters from _./code/mat/PAR.mat_ are the ones actually used.\
***(8).E2ICIpalboAZD_model()***\
This function implements the ODE model, with its equations detailed in Supplementary Note 2 of the paper.\
***(9).E2ICIpalboAZD_loaddata()***\
This function loads the data from the ./code/mat/ folder needed for parameter calibration in the model.\
***(10).E2ICIpalboAZD_processdata()***\
This function processes the experimental data.\
***(11).E2ICIpalboAZD_cost()***\
This function calculates the cost (error) between model simulation and experimental data.\
***(12).E2ICIpalboAZD_sim()***\
This function simulates various treatment conditions.\
***(13).E2ICIpalboAZD_simalternation()***\
This function simulates alternating treatments.\
***(14).E2ICIpalboAZD_simplotcheck()***\
This function plots the dynamics of certain compounds in the model for inspection.\
***(15).E2ICIpalboAZD_plotpro()***\
This function plots the simulation results alongside the experimental data.\
***(16).E2ICIpalboAZD_plotalterpro()***\
This function plots the proliferation simulation results for the alternating treatment.\
***(17).E2ICIpalboAZD_mutation()***\
This self-modifying function is used as the mutation function within the genetic algorithm (ga).\
***(18).E2ICIpalboAZD_minimumAZD_2treat()***\
This function generates the treatment options shown in Fig.7A-C, selecting from three possible treatment choices.\
***(19).E2ICIpalboAZD_minimumAZD_3treat()***\
This function generates the treatment options shown in Fig. 7E–F, selecting from three possible treatment choices.\
***(20).E2ICIpalboAZD_genparcohort()***\
This function generates _./code/mat/opmat.mat_, the first step is to create the parameter cohort.\
***(21).E2ICIpalboAZD_gaoutput()***\
This function is output function in the GA algorithm saves the parameter cohort to ./code/mat/opmat.mat.\
***(22).E2ICIpalboAZD_findcohort()***\
This function generates the parameter cohort and is called by _E2ICIpalboAZD_parcohort()_.\
***(23).E2ICIpalboAZD_doseresponse()***\
This function loads data from the ./data/dose response/ folder and generates the raw plots for Fig. 3A–F.
***(24). E2ICIpalboAZD_color()***\
This function generates a set of colors that can potentially be used.\






