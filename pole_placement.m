clc
clearvars
init_heli_1_2

syms k_pp k_pd s xi

%Natural frequency
om_n = pi;

%Damping Ratio
xi = 1; 
%Resulting k_pp k_pd
k_pp = om_n^2 / k1;
k_pd = 2*xi*om_n / k1;

%Tranfer function
sys = tf([k1*k_pp],[1 k1*k_pd k1*k_pp]);

%Plots
subplot(2,1,1)
step(sys)
subplot(2,1,2)
impulse(sys)
