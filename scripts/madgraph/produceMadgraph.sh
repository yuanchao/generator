#!/bin/sh

if [ -z $3 ] ; then
    echo "Usage: $0 [JOB] [XQCUT] [NEVENTS]"
    exit 1
fi

let k=$RANDOM
echo $k
#i=`date '+%s'`
#echo $i
#let SEED=$i+$k
let SEED=$k
echo $SEED

JOB=$1
XQCUT=$2
NEVENTS=$3


echo "JOB index:" $JOB
echo "SEED: " $SEED
echo "xqcut cut: " $XQCUT" GeV"
echo "Number of events generated for each job: " $NEVENTS

cp -r Template Zjet_$JOB

FILENAME_RUN_CARD=Zjet_$JOB/Cards/run_card.dat

cat > ${FILENAME_RUN_CARD} << EOF

#*********************************************************************
#                       MadGraph/MadEvent                            *
#                  http://madgraph.hep.uiuc.edu                      *
#                                                                    *
#                        run_card.dat                                *
#                                                                    *
#  This file is used to set the parameters of the run.               *
#                                                                    *
#  Some notation/conventions:                                        *
#                                                                    *
#   Lines starting with a '# ' are info or comments                  *
#                                                                    *
#   mind the format:   value    = variable     ! comment             *
#*********************************************************************
#
#*******************                                                 
# Running parameters
#*******************                                                 
#                                                                    
#*********************************************************************
# Tag name for the run (one word)                                    *
#*********************************************************************
  'Zjets'     = run_tag ! name of the run 
#*********************************************************************
# Run to generate the grid pack                                      *
#*********************************************************************
  .false.     = gridpack  !True = setting up the grid pack
#*********************************************************************
# Number of events and rnd seed                                      *
#*********************************************************************
  ${NEVENTS}  = nevents ! Number of unweighted events requested 
     ${SEED}  = iseed   ! rnd seed (0=assigned automatically=default))
#*********************************************************************
# Collider type and energy                                           *
#*********************************************************************
        1     = lpp1  ! beam 1 type (0=NO PDF)
        1     = lpp2  ! beam 2 type (0=NO PDF)
     3500     = ebeam1  ! beam 1 energy in GeV
     3500     = ebeam2  ! beam 2 energy in GeV
#*********************************************************************
# Beam polarization from -100 (left-handed) to 100 (right-handed)    *
#*********************************************************************
        0     = polbeam1 ! beam polarization for beam 1
        0     = polbeam2 ! beam polarization for beam 2
#*********************************************************************
# PDF CHOICE: this automatically fixes also alpha_s and its evol.    *
#*********************************************************************
 'cteq6l1'    = pdlabel     ! PDF set                                     
#*********************************************************************
# Renormalization and factorization scales                           *
#*********************************************************************
 F        = fixed_ren_scale  ! if .true. use fixed ren scale
 F        = fixed_fac_scale  ! if .true. use fixed fac scale
 91.1880  = scale            ! fixed ren scale
 91.1880  = dsqrt_q2fact1    ! fixed fact scale for pdf1
 91.1880  = dsqrt_q2fact2    ! fixed fact scale for pdf2
 1        = scalefact        ! scale factor for event-by-event scales
#*********************************************************************
# Matching - Warning! ickkw > 0 is still beta
#*********************************************************************
 1        = ickkw            ! 0 no matching, 1 MLM, 2 CKKW matching
 1        = highestmult      ! for ickkw=2, highest mult group
 1        = ktscheme         ! for ickkw=1, 1 Durham kT, 2 Pythia pTE
 1        = alpsfact         ! scale factor for QCD emission vx
 F        = chcluster        ! cluster only according to channel diag
 T        = pdfwgt           ! for ickkw=1, perform pdf reweighting

#*********************************************************************
#                                                                    
#**********************************
# BW cutoff (M+/-bwcutoff*Gamma)
#**********************************
 15  = bwcutoff

F = cut_decays ! Apply decays to products

#*******************                                                 
# Standard Cuts
#*******************                                                 
#                                                                    
#*********************************************************************
# Minimum and maximum pt's                                           *
#*********************************************************************
 10  = ptj       ! minimum pt for the jets 
  0  = ptb       ! minimum pt for the b 
 10  = pta       ! minimum pt for the photons 
 0  = ptl       ! minimum pt for the charged leptons 
  0  = misset    ! minimum missing Et (sum of neutrino's momenta)
  0  = ptheavy   ! minimum pt for one heavy final state
 1d5 = ptjmax    ! maximum pt for the jets
 1d5 = ptbmax    ! maximum pt for the b
 1d5 = ptamax    ! maximum pt for the photons
 1d5 = ptlmax    ! maximum pt for the charged leptons
 1d5 = missetmax ! maximum missing Et (sum of neutrino's momenta)
#*********************************************************************
# Minimum and maximum E's (in the lab frame)                         *
#*********************************************************************
  0  = ej     ! minimum E for the jets 
  0  = eb     ! minimum E for the b 
  0  = ea     ! minimum E for the photons 
  0  = el     ! minimum E for the charged leptons 
 1d5  = ejmax ! maximum E for the jets
 1d5  = ebmax ! maximum E for the b
 1d5  = eamax ! maximum E for the photons
 1d5  = elmax ! maximum E for the charged leptons
#*********************************************************************
# Maximum and minimum rapidity                                       *
#*********************************************************************
 5  = etaj    ! max rap for the jets 
 1d2  = etab    ! max rap for the b 
 2.5  = etaa    ! max rap for the photons 
 1d2  = etal    ! max rap for the charged leptons 
 0d0  = etajmin ! min rap for the jets
 0d0  = etabmin ! min rap for the b
 0d0  = etaamin ! min rap for the photons
 0d0  = etalmin ! main rap for the charged leptons
#*********************************************************************
# Minimum and maximum DeltaR distance                                *
#*********************************************************************
 0.001 = drjj    ! min distance between jets 
 0   = drbb    ! min distance between b's 
 0 = drll    ! min distance between leptons 
 0.4 = draa    ! min distance between gammas 
 0   = drbj    ! min distance between b and jet 
 0.4 = draj    ! min distance between gamma and jet 
 0   = drjl    ! min distance between jet and lepton 
 0   = drab    ! min distance between gamma and b 
 0   = drbl    ! min distance between b and lepton 
 0.4 = dral    ! min distance between gamma and lepton 
 1d2 = drjjmax ! max distance between jets
 1d2 = drbbmax ! max distance between b's
 1d2 = drllmax ! max distance between leptons
 1d2 = draamax ! max distance between gammas
 1d2 = drbjmax ! max distance between b and jet
 1d2 = drajmax ! max distance between gamma and jet
 1d2 = drjlmax ! max distance between jet and lepton
 1d2 = drabmax ! max distance between gamma and b
 1d2 = drblmax ! max distance between b and lepton
 1d2 = dralmax ! maxdistance between gamma and lepton
#*********************************************************************
# Minimum and maximum invariant mass for pairs                       *
#*********************************************************************
 0   = mmjj    ! min invariant mass of a jet pair 
 0   = mmbb    ! min invariant mass of a b pair 
 0   = mmaa    ! min invariant mass of gamma gamma pair
 50   = mmll    ! min invariant mass of l+l- (same flavour) lepton pair
 1d5 = mmjjmax ! max invariant mass of a jet pair
 1d5 = mmbbmax ! max invariant mass of a b pair
 1d5 = mmaamax ! max invariant mass of gamma gamma pair
 1d5 = mmllmax ! max invariant mass of l+l- (same flavour) lepton pair
#*********************************************************************
# Minimum and maximum invariant mass for all letpons                 *
#*********************************************************************
 0   = mmnl    ! min invariant mass for all letpons (l+- and vl) 
 1d5 = mmnlmax ! max invariant mass for all letpons (l+- and vl) 
#*********************************************************************
# Inclusive cuts                                                     *
#*********************************************************************
 0  = xptj ! minimum pt for at least one jet  
 0  = xptb ! minimum pt for at least one b 
 0  = xpta ! minimum pt for at least one photon 
 0  = xptl ! minimum pt for at least one charged lepton 
#*********************************************************************
# Control the pt's of the jets sorted by pt                          *
#*********************************************************************
 0   = ptj1min ! minimum pt for the leading jet in pt
 0   = ptj2min ! minimum pt for the second jet in pt
 0   = ptj3min ! minimum pt for the third jet in pt
 0   = ptj4min ! minimum pt for the fourth jet in pt
 1d5 = ptj1max ! maximum pt for the leading jet in pt 
 1d5 = ptj2max ! maximum pt for the second jet in pt
 1d5 = ptj3max ! maximum pt for the third jet in pt
 1d5 = ptj4max ! maximum pt for the fourth jet in pt
 0   = cutuse  ! reject event if fails any (0) / all (1) jet pt cuts
#*********************************************************************
# Control the Ht(k)=Sum of k leading jets                            *
#*********************************************************************
 0  = htjmin ! minimum jet HT=Sum(jet pt)
 1d5 = htjmax ! maximum jet HT=Sum(jet pt)
 0   = ht2min ! minimum Ht for the two leading jets
 0   = ht3min ! minimum Ht for the three leading jets
 0   = ht4min ! minimum Ht for the four leading jets
 1d5 = ht2max ! maximum Ht for the two leading jets
 1d5 = ht3max ! maximum Ht for the three leading jets
 1d5 = ht4max ! maximum Ht for the four leading jets
#*********************************************************************
# WBF cuts                                                           *
#*********************************************************************
 0   = xetamin ! minimum rapidity for two jets in the WBF case  
 0   = deltaeta ! minimum rapidity for two jets in the WBF case 
#*********************************************************************
# maximal pdg code for quark to be considered as a jet               *
# otherwise b cuts are applied                                       *
#*********************************************************************
 5 = maxjetflavor ! Apply b cuts
#*********************************************************************
# Jet measure cuts                                                   *
#*********************************************************************
 ${XQCUT}   = xqcut   ! minimum kt jet measure between partons
#*********************************************************************



EOF

cd Zjet_$JOB
echo $PWD
./bin/newprocess_mg5 >& Log_$JOB 

mkdir TEST

#mv madevent.tar.gz TEST/.

cd TEST

#tar -xjf madevent.tar.gz

echo $PWD
ls /afs/cern.ch/work/s/syu/madgraph/MG5v1.1/Zjet_$JOB/madevent.tar.gz
tar -xvzf /afs/cern.ch/work/s/syu/madgraph/MG5v1.1/Zjet_$JOB/madevent.tar.gz

echo "Generating events" 

./bin/generate_events 0 1 zjet$JOB

rm -rf /afs/cern.ch/work/s/syu/madgraph/MG5v1.1/Zjet_$JOB/TEST/SubProcesses
exit
