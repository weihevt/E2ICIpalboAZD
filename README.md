## WEE1 inhibition delays resistance in ER+ MCF7 breast cancer
[08/07/2025] This repository contains the MATLAB (R2023a) code, which does not use external packages, for the paper titled
"**WEE1 inhibition delays resistance to CDK4/6 inhibitor and antiestrogen treatment in estrogen receptor-positive MCF7 breast cancer cells: experiments and mathematical modeling**"

The **_code_** folder contains the functions used in the work.\
The **_fig_** folder contains the figures used in the paper.\
**Functions:**\
***(1).E2ICIpalboAZD_main()***\
This function runs the simulation. Generates plots for Figures 5A-F, 6E-F, Supplementary Figures 1A-D, and 2 using the single optimized parameter. These are primary simulation results, compared directly with experimental data.\
***(2).E2ICIpalboAZD_test()***\
This function estimates model parameters based on experimental data.\
***(3).E2ICIpalboAZD_modelpar()***\
This function generates the necessary given parameters for the model simulation.\
***(4).E2ICIpalboAZD_evlcost()***\
This function is for parameter estimation during optimization.\
***(5).E2ICIpalboAZD_1steadystate()***\
This function checks whether two initial values—zero and a positive one 
result in the same steady state rather than distinct ones.\
***(6).E2ICIpalboAZD_replating()***\
This function resets the initial cell number each month, simulating the replating done in the experiment.



