clear all
% FOR HELICOPTER NR 1-2
% This file contains the initialization for the helicopter assignment in
% the course TTK4115. Run this file before you execute QuaRC_ -> Build 
% to build the file heli_q8.mdl.

% Oppdatert h?sten 2006 av Jostein Bakkeheim
% Oppdatert h?sten 2008 av Arnfinn Aas Eielsen
% Oppdatert h?sten 2009 av Jonathan Ronen
% Updated fall 2010, Dominik Breu
% Updated fall 2013, Mark Haring
% Updated spring 2015, Mark Haring


%%%%%%%%%%% Calibration of the encoder and the hardware for the specific
%%%%%%%%%%% helicopter
Joystick_gain_x = pi;
Joystick_gain_y = -pi;

Elevation_offset = 295;

%%%%%%%%%%% Physical constants
g = 9.81; % gravitational constant [m/s^2]
l_c = 0.40; % distance elevation axis to counterweight [m]
l_h = 0.66; % distance elevation axis to helicopter head [m]
l_p = 0.175; % distance pitch axis to motor [m]
m_c = 1.92; % Counterweight mass [kg]
m_p = 0.65; % Motor mass [kg]

%%%%%%%%%% Experimental VAriables 
vs0 = 5.7;
k_vd = -0.108; %gain for vd is -0,108
k_f = (-g*(m_c*l_c - 2*m_p*l_h))/(l_h*vs0); %intrinsic motor gain

%%%%%%%%%% K computed gains
k1 = k_f / (2*m_p*l_p);
k2 = (k_f * l_h )/ ((m_c * l_c^2) + (2*m_p*l_h^2));
k3 = (g*((m_c*l_c)-(2*m_p*l_h)))/((m_c*l_c^2) + (2*m_p*(l_h^2 + l_p^2)));

% Smart changes
w0 = 2;
zeta = 5;

k_pp = (w0)^2/k1;
k_pd = 2*zeta*w0/k1;
% k_pd = 2*zeta*sqrt(k_pp/k1);
%%%%
%k_pp = 3;
%k_pd = 2;

% sys = tf([k1*k_pp],[1 k1*k_pd k1*k_pp]);
% polynomial=[1 k1*k_pd k1*k_pp];
% root=roots(polynomial);
% rlocus(sys)

% plot(ans(1,:),ans(4,:))

%% Task 2.2.1 - State space formulation
A = [0 1 0; 0 0 0; 0 0 0];
B = [0 0; 0 k1; k2 0];
C = [1 0 0; 0 0 1];
D = 0;

system = ss(A, B, C, D);

%% Task 2.2.3
Q = [100 0 0; % Penalize p
    0 100 0;  % penalize pdot
    0 0 1];   % penalize edot
R = [0.1 0;   % Pitch control -- Lower values gives higher power output
    0 0.1];   % Elevation speed

K = lqr(A,B,Q,R); 
F = inv(C*inv(B*K-A)*B);

%% Task 2.2.5 - Integral action

A_I = [0 1 0 0 0; 0 0 0 0 0; 0 0 0 0 0; -1 0 0 0 0; 0 0 -1 0 0];
B_I = [0 0; 0 k1; k2 0; 0 0; 0 0];
C_I = [1 0 0 0 0; 0 0 1 0 0];
G_I = [0,0;0,0;0,0;1,0;0,1];

Q_I = diag([100, 100, 1, 10, 10]);
R_I = diag([1, 10]);
K_I = lqr(A_I,B_I,Q_I,R_I);  



