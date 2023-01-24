%Author: Chrysa Episkopou

%%Preliminary Design
%System Configuration
clc;
clear;
a2d_res = 12;
a2d_maxv = 3.3;
BW = 10 * 10^6;
[Pinmin_a2d, Pinmax_a2d] = a2dpower(a2d_res, a2d_maxv);
%F,G values for our configuration
G = [25.5, -1.5, -8, -2.4, 36, -6.05, - 0.85]; %in DB
NF = [0.95, 1.5 , 8 , 2.4 , 0.65 , 6.05 , 0.85];%in dB

G_real = DBToReal(G);
NF_real = DBToReal(NF);
 
NF_system =  calculateNF(G_real, NF_real);
NF_dB = realToDB(NF_system);
MDS_dB = calculateMDS(BW,NF_dB);

Gtot = sum(G); %after the antenna, in dB

%What is the output power for signal = MDS;
P = MDS_dB + Gtot; %logw enisxyshs

%What is the output minimum power for the A2D configuration;
Pinmin_RX = Pinmin_a2d - Gtot;

%What is the maximum power allowed?

%First checking the
%threshold caused by 1-dB compression point
%p1dB in point (A) - after G2
P1dB_A = 21; %in dBm
Gtot_A = sum(G(1:5));
Pinmax_A = P1dB_A - Gtot_A; %bottleneck1

%Then, threshold by threshold of A2D
Pinmax_B = Pinmax_a2d - Gtot; %bottleneck2

%Final bottleneck: The minumum of the two Pmax
Pinmax = min(Pinmax_A, Pinmax_B);

%Dynamic Range
DR = Pinmax - Pinmin_RX; %in dB

%IP3 analysis of our system
IP3 = [36.5, Inf, 27, Inf, 38.5,18, Inf];
%IP3-equivalent values
IP3eq = IP3equivalent(IP3, G); %dB
IP3eq_real = DBToReal(IP3eq);
temp = 1./IP3eq_real; %1/IP3_eq for each element
IP3sys = 1/sum(temp); %real
IP3sys_dB = realToDB(IP3sys);

%Maximum signal to insert to our system due to IP3 capablilities
Pin_max_IP3  = IP3sys_dB - Gtot;
DR_IP3 = Pin_max_IP3 - Pinmin_RX; %in dB 

%Spurious Free Dynamic Range (SFDR)
SFDR = (2/3) *(IP3sys_dB - Gtot - MDS_dB) %dB


