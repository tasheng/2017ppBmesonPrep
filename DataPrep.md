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

To perform TMVA training, first make sure you have the CMSSW ready. Here we use the version CMSSW_9_4_10. Follow the instructions to setup CMSSW_9_4_10:

https://twiki.cern.ch/twiki/bin/viewauth/CMS/HiForestSetup

Then put the TMVA part inside the folder CMSSW_9_4_10/src

Now, open the TMVA folder. We find that there are BP and Bs subfolders. Open the BP folder

cd TMVA/BP

Now we see two folders:


GetWorkingPoint  train


To perform TMVA training, we open the train folder:

cd train

The training variable are defined at TMVAClassification.h


  const std::vector<mytmva::tmvavar> varlist = {
 
    mytmva::tmvavar("Btrk1Pt"  , "Btrk1Pt"                                                                                        , "FMax", "#pi_{1} p_{T} (GeV/c)"                , 0   , 10) , // 8
    mytmva::tmvavar("Btrk2Pt"  , "Btrk2Pt"                                                                                        , "FMax", "#pi_{2} p_{T} (GeV/c)"                , 0   , 10) , // 9    
        mytmva::tmvavar("Trk1DCAz"  , "Trk1DCAz := abs(Btrk1Dz1/Btrk1DzError1)"                                                                                        , "FMax", "#Eta_{1} "                , -3   , 3) , // 8
    mytmva::tmvavar("Trk2DCAz"  , "Trk2DCAz := abs(Btrk2Dz1/Btrk2DzError1)"                                                                                        , "FMax", "#Eta_{2}"                , -3   , 3) , // 9        
    mytmva::tmvavar("Trk1DCAxy"   , "Trk1DCAxy := abs(Btrk1Dxy1/Btrk1DxyError1)",                                                                 "FMin", "#DeltaR(#pi_{1},J/#psi)"              , 0   , 0.5), // 1           
    mytmva::tmvavar("Trk2DCAxy"   , "Trk2DCAxy := abs(Btrk2Dxy1/Btrk2DxyError1)"              ,                                    "FMin",      "#DeltaR(#pi_{2},J/#psi)"                     , 0   , 0.5), // 2
    mytmva::tmvavar("MassDis"   , "MassDis := abs(Btktkmass-1.019455)"                                                           , "FMin", "Q (GeV/c^{2})"                        , -0.2   , 0.2), // 3
        mytmva::tmvavar("dls"    , "dls := BsvpvDistance/BsvpvDisErr"                                                 , "FMax", "l_{xyz}/#sigma(l_{xyz})"              , 0   , 10) , // 6
        mytmva::tmvavar("Balpha"   , "Balpha"                                                                                         , "FMin", "#alpha"                               , 0   , 3.2), // 4
    mytmva::tmvavar("dls2D"    , "dls2D := Bd0"                                                                            , "FMax", "l_{xy}/#sigma(l_{xy})"                , 0   , 10) , // 7
        mytmva::tmvavar("cos(Bdtheta)" , "cos(Bdtheta)"                                                                , "FMax", "cos(#theta)"                          , -1  , 1)  ,
        mytmva::tmvavar("Bchi2cl"  , "Bchi2cl"                                                                                        , "FMax", "vertex #chi^{2} prob"                 , 0   , 1),   // 0
        mytmva::tmvavar("Btrk1Eta" , "Btrk1Eta"                                                                , "", "Trak1 Eta"                          , -2.4  , 2.4)  ,
        mytmva::tmvavar("Btrk2Eta"  , "Btrk2Eta"                                                                                        , "", "Trak 2 Eta"                 , 0   , 2.4),   // 0
        mytmva::tmvavar("Bmass"  , "Bmass"                                                                                        , "", "B+ mass"                 , 5.0   , 6.0),   // 0
        
        mytmva::tmvavar("BDT_pt_1_2"  , "BDT_pt_1_2"                                                                                        , "", "BDT 1 - 2 GeV/c"                 , -1.0   , 1.0),   // 0
        mytmva::tmvavar("BDT_pt_2_3"  , "BDT_pt_2_3"                                                                                        , "", "BDT 2 - 3 GeV/c"                 , -1.0   , 1.0),   // 0
        mytmva::tmvavar("BDT_pt_3_5"  , "BDT_pt_3_5"                                                                                        , "", "BDT 3 - 5 GeV/c"                 , -1.0   , 1.0),   // 0
        mytmva::tmvavar("BDT_pt_5_7"  , "BDT_pt_5_7"                                                                                        , "", "BDT 5 - 7 GeV/c"                 , -1.0   , 1.0),   // 0
        mytmva::tmvavar("BDT_pt_7_10"  , "BDT_pt_7_10"                                                                                        , "", "BDT 7 - 10 GeV/c"                 , -1.0   , 1.0),   // 0
        mytmva::tmvavar("BDT_pt_10_15"  , "BDT_pt_10_15"                                                                                        , "", "BDT 10 - 15 GeV/c"                 , -1.0   , 1.0),   // 0
        mytmva::tmvavar("BDT_pt_15_20"  , "BDT_pt_15_20"                                                                                        , "", "BDT 15 - 20 GeV/c"                 , -1.0   , 1.0),   // 0
        mytmva::tmvavar("BDT_pt_20_50"  , "BDT_pt_20_50"                                                                                        , "", "BDT 20 - 50 GeV/c"                 , -1.0   , 1.0),   // 0       
        mytmva::tmvavar("Btktkmass"  , "Btktkmass"                                                                                        , "", "BDT 20 - 50 GeV/c"                 , 1.004455   , 1.034455),   // 0    
        mytmva::tmvavar("2*Btktkmass"  , "2*Btktkmass"                                                                                        , "", "BDT 20 - 50 GeV/c"                 , 2.008910   , 2.068910),   // 0
        mytmva::tmvavar("-1*Btktkmass"  , "-1*Btktkmass"                                                                                        , "", "BDT 20 - 50 GeV/c"           , -2.068910       , -2.008910  ),  //0      
        mytmva::tmvavar("abs(Btktkmass-1.019455)"  , "abs(Btktkmass-1.019455)"                                                                                        , "", "BDT 20 - 50 GeV/c"                 , -0.015   , 0.015),   // 0     
        mytmva::tmvavar("2*abs(Btktkmass-1.019455)"  , "2*abs(Btktkmass-1.019455)"                                                                                        , "", "BDT 20 - 50 GeV/c"                 , -0.030   , 0.030)   // 0  
  };



To Run TMVA, first make sure to do 

cmsenv

Then run it by 

source run.TMVAClassification.sh 1 1 10 15

Here the first two arguments 1 1 are to make sure that the TMVA runs 

Here 10 and 15 are stands for the pt range 10 - 15.

Then the training will start to perform. When the training is finished, we can check the performance plots saved at 


dataset/plots/

Which include the correlation matrices and over-training test. 

The analyzer can inspect the performance and tune the training parameters, which are defined inside the code: TMVAClassification.C, to retrain and improve the training results

## Additional Cut Skim
