# CMS 2017 pp Bs and B+ Data Preparation Codes

## Basic Organization of the Analysis Codes

These codes are made to analyze the CMS 2017 pp datasets and obtain the cross section of the B+ and Bs. Therefore, the organization of the codes is BP, Bs, and BsBP. They consist of raw yield extraction, efficiency correction, and cross section calculations. There are also folders named SkimmedSamples and UnskimmedSamples. These are the folders where you put your input files to perform the analysis

To obtain the codes, do:

git clone https://github.com/MYOMAO/2017ppBmesonAna.git

## Geneeral Process Flow

For Data: AOD -> Bfinder -> Bntuple -> Branch Skim -> Cut Skim 

For MC: (GEN-SIM -> DIGI -> RECO) -> AOD -> Bfinder -> Bntuple -> Branch Skim -> Cut Skim 

The process in the parenthesis is done when we request for official MC generation. Basically, we start from AOD files and run the Bfinder to ntuplized the samples.

## CMS DAS Link of The 2017 pp Data

The datasets we use for B meson analysis is the 2017 CMS pp dimuon triggered data. They can be found in the CMS DAS:

These are stored as the AOD file

To access the CMS DAS, simply do:


## Official Monte Carlo

Currently, we use the official MC. The 

## Bfinder 


## Branching Skimming 


## TMVA Cut Optimization 

We use BDT cuts to optimize the selections after all pre-filter selections are applied. We use the TMVA framework to perform the training. 

## Additional Cut Skim
