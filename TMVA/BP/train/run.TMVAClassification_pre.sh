#!/bin/bash
##
ptmin=$3; ptmax=$4 ;


inputs="../sample/BPMC_5_60_pre.root"
inputb="../sample/BPData_5_60_pre.root"

output=rootfiles/TMVA_B_s ;

inputm=$inputs ;
# outputmva=/mnt/hadoop/cms/store/user/gwangjun/tmva ;
outputmva=mva

# prefilter
#OLD CUTS


# to match the skim cut
# cut="(pPAprimaryVertexFilter == 1 && pBeamScrapingFilter == 1 && HLT_HIL1DoubleMu0_v1 == 1)  &&  (Bmu1isTriggered == 1 && Bmu2isTriggered == 1 ) && (Btrk1Pt > 0.5 && Bchi2cl > 0.05 && BsvpvDistance/BsvpvDisErr > 2.0 && Bpt > 2 && abs(Btrk1Eta-0.0) < 2.4  && (TMath::Abs(By)<2.4&&TMath::Abs(Bmumumass-3.096916)<0.15&&((abs(Bmu1eta)<1.2&&Bmu1pt>3.5)||(abs(Bmu1eta)>1.2&&abs(Bmu1eta)<2.1&&Bmu1pt>(5.47-1.89*abs(Bmu1eta)))||(abs(Bmu1eta)>2.1&&abs(Bmu1eta)<2.4&&Bmu1pt>1.5))&&((abs(Bmu2eta)<1.2&&Bmu2pt>3.5)||(abs(Bmu2eta)>1.2&&abs(Bmu2eta)<2.1&&Bmu2pt>(5.47-1.89*abs(Bmu2eta)))||(abs(Bmu2eta)>2.1&&abs(Bmu2eta)<2.4&&Bmu2pt>1.5))&&Bmu1TMOneStationTight&&Bmu2TMOneStationTight&&Bmu1InPixelLayer>0&&(Bmu1InPixelLayer+Bmu1InStripLayer)>5&&Bmu2InPixelLayer>0&&(Bmu2InPixelLayer+Bmu2InStripLayer)>5&&Bmu1dxyPV<0.3&&Bmu2dxyPV<0.3&&Bmu1dzPV<20&&Bmu2dzPV<20&&Bmu1isTrackerMuon&&Bmu2isTrackerMuon&&Bmu1isGlobalMuon&&Bmu2isGlobalMuon&&Btrk1highPurity&&abs(Btrk1Eta)<2.4&&Btrk1Pt>0.5)  && (Btrk1PixelHit + Btrk1StripHit > 10) &&  (Btrk1PtErr/Btrk1Pt < 0.1)&& Btrk1Chi2ndf/(Btrk1nStripLayer+Btrk1nPixelLayer) < 0.18   && (abs(PVz)<15))"

cut="(pPAprimaryVertexFilter == 1 && pBeamScrapingFilter == 1 && HLT_HIL1DoubleMu0_v1 == 1)  &&  (Bmu1isTriggered == 1 && Bmu2isTriggered == 1 ) && (Btrk1Pt > 0.5 && Bpt > 2 && abs(Btrk1Eta-0.0) < 2.4  && (TMath::Abs(By)<2.4 && ((abs(Bmu1eta)<1.2&&Bmu1pt>3.5)||(abs(Bmu1eta)>1.2&&abs(Bmu1eta)<2.1&&Bmu1pt>(5.47-1.89*abs(Bmu1eta)))||(abs(Bmu1eta)>2.1&&abs(Bmu1eta)<2.4&&Bmu1pt>1.5))&&((abs(Bmu2eta)<1.2&&Bmu2pt>3.5)||(abs(Bmu2eta)>1.2&&abs(Bmu2eta)<2.1&&Bmu2pt>(5.47-1.89*abs(Bmu2eta)))||(abs(Bmu2eta)>2.1&&abs(Bmu2eta)<2.4&&Bmu2pt>1.5))&&Bmu1TMOneStationTight&&Bmu2TMOneStationTight&&Bmu1InPixelLayer>0&&(Bmu1InPixelLayer+Bmu1InStripLayer)>5&&Bmu2InPixelLayer>0&&(Bmu2InPixelLayer+Bmu2InStripLayer)>5&&Bmu1dxyPV<0.3&&Bmu2dxyPV<0.3&&Bmu1dzPV<20&&Bmu2dzPV<20&&Bmu1isTrackerMuon&&Bmu2isTrackerMuon&&Bmu1isGlobalMuon&&Bmu2isGlobalMuon&&Btrk1highPurity&&abs(Btrk1Eta)<2.4&&Btrk1Pt>0.5)  && (Btrk1PixelHit + Btrk1StripHit > 10) &&  (Btrk1PtErr/Btrk1Pt < 0.1)&& Btrk1Chi2ndf/(Btrk1nStripLayer+Btrk1nPixelLayer) < 0.18   && (abs(PVz)<15))"


#algo="CutsGA,CutsSA"
#algo="BDT,BDTG,CutsGA,CutsSA"

# algo="BDT,DNN,DNN2,MLP,CutsGA,MLPBNN,MLPBNN2"

algo="BDTs,BDTh"


#stages="0,1,2,3,4,5,6,7,8,9,10,11,12,13" # see definition below

#stages="0,1,2,3,4,5,6,7,8,10,11,14,15,16,17,18"
#stages="14,15,16,17,18,19,20"
#stages="14,15,16,17,18"   #sPlot show
#stages="0,1,2,3,4,5,6,7,8,9,10,11,12,13"

#stages="14,19,20,21,22,23"


stages="0,2,4,7,8,11"

sequence=0 # if it's on, remove stages 1 by 1. 

## ===== do not change the lines below =====

varlist=(
    '#  0  :  ("Btrk1Pt"  , "Btrk1Pt"                                                                                        , "FMax")  #' 
	'#  2  :  ("Trk1DCAz" , "Trk1DCAz := abs(Btrk1Dz1/Btrk1DzError1)"                                                                                       , "FMin")  #' 
	'#  4  :  ("Trk1DCAxy"  , "Trk1DCAxy := abs(Btrk1Dxy1/Btrk1DxyError1)"                                                                 , "FMin")  #' 
    '#  7  :  ("dls"      , "dls := BsvpvDistance/BsvpvDisErr"                                                                 , "FMax")  #' 
    '#  8  :  ("Balpha"   , "Balpha"                                                                                          , "FMax")  #' 
    '#  9  :  ("dls2D"    , "dls2D := Bd0"                                                                             , "FMin")  #' 
    '#  10 :  ("cos(Bdtheta)", "cos(Bdtheta)"                                                                                 , "FMax")  #' 
    '#  11 :  ("Bchi2cl",    "Bchi2cl"                                                                                             , ""    )  #'
	'#  12 :  ("Btrk1Eta", "Btrk1Eta"                                                                                 , "FMin")  #' 
)


cuts="${cut} && Bgen==23333"
#cutb="${cut} &&  (abs(Bmass - 5.36682 ) > 0.20 &&  abs(Bmass - 5.36682) < 0.30)" # Bmass_pdg=5.28GeV, sideband 0.2 ~ 0.3 for each side.

cutb="${cut} &&  ((Bmass - 5.27929 ) > 0.25 &&  (Bmass - 5.27929) < 0.30)"
#cutb="${cut} &&  (abs(Bmass - 5.36682 ) > 0.18 &&  abs(Bmass - 5.36682) < 0.36)" # Bmass_pdg=5.28GeV, sideband 0.2 ~ 0.3 for each side.
#cutb="${cut} &&  (abs(Bmass - 5.36682 ) > 0.22 &&  abs(Bmass - 5.36682) < 0.28)"

# rootfiles=rootfiles

## ===== do not do not do not change the lines below =====
IFS=','; allstages=($stages); unset IFS;
echo -e '

####################################################################################################################################
#                                                Variables \e[1;32m(To be used)\e[0m                                                            #
####################################################################################################################################
#                                                                                                                                  #'
vv=0
while(( $vv < ${#varlist[@]})) ; do
    for ss in ${allstages[@]} ; do [[ $ss == $vv ]] && { echo -en "\e[1;32m" ; break ; } ; done ;
    echo -e "${varlist[vv]}\e[0m"
    vv=$((vv+1))
done
echo '#                                                                                                                                  #
####################################################################################################################################

'
##
mkdir -p $output ; rm -r $output ;
tmp=$(date +%y%m%d%H%M%S)

##
[[ $# -eq 0 ]] && echo "usage: ./run_TMVAClassification.sh [train] [draw curves] [create BDT tree]"

g++ TMVAClassification.C $(root-config --libs --cflags) -lTMVA -lTMVAGui -g -o TMVAClassification_${tmp}.exe || exit 1
g++ guivariables.C $(root-config --libs --cflags) -lTMVA -lTMVAGui -g -o guivariables_${tmp}.exe || { rm *_${tmp}.exe ; exit 1 ; }
g++ guiefficiencies.C $(root-config --libs --cflags) -lTMVA -lTMVAGui -g -o guiefficiencies_${tmp}.exe || { rm *_${tmp}.exe ; exit 1 ; }
g++ guieffvar.C $(root-config --libs --cflags) -lTMVA -lTMVAGui -g -o guieffvar_${tmp}.exe || { rm *_${tmp}.exe ; exit 1 ; }
g++ mvaprod.C $(root-config --libs --cflags) -lTMVA -lTMVAGui -g -o mvaprod_${tmp}.exe || { rm *_${tmp}.exe ; exit 1 ; }

#[[ ${1:-0} -eq 1 ]] && {
#    conf=
#    echo -e "\e[2m==> Do you really want to run\e[0m \e[1mTMVAClassification.C\e[0m \e[2m(it might be very slow)?\e[0m [y/n]"
#    read conf
#    while [[ $conf != 'y' && $conf != 'n' ]] ; do { echo "warning: input [y/n]" ; read conf ; } ; done ;
#    [[ $conf == 'n' ]] && { rm *_${tmp}.exe ; exit ; }
#}

stage=$stages
while [[ $stage == *,* ]]
do
# train
    [[ ${1:-0} -eq 1 ]] && { ./TMVAClassification_${tmp}.exe $inputs $inputb "$cuts" "$cutb" $output $ptmin $ptmax "$algo" "$stage"; } &
    [[ $sequence -eq 0 ]] && break;
    while [[ $stage != *, ]] ; do stage=${stage%%[0-9]} ; done ;
    stage=${stage%%,}
done
wait

# draw curves
[[ ${2:-0} -eq 1 ]] && { 
    ./guivariables_${tmp}.exe $output $ptmin $ptmax "$algo" "$stages"
    ./guiefficiencies_${tmp}.exe $output $ptmin $ptmax "$algo" "$stages"
}

# draw curve vs. var
[[ ${2:-0} -eq 1 && $sequence -eq 1 ]] && ./guieffvar_${tmp}.exe $output $ptmin $ptmax "$algo" "$stages"

# produce mva values
[[ ${3:-0} -eq 1 ]] && ./mvaprod_${tmp}.exe $inputm "Bfinder/ntphi" $output $outputmva $ptmin $ptmax "$algo" "${stages}"

##
rm *_${tmp}.exe
