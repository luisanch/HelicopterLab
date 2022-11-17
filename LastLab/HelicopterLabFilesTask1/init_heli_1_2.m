clear all
% FOR HELICOPTER NR 1-2
% This file contains the initialization for the helicopter assignment in
% the course TTK4115. Run this file before you execute QuaRC_ -> Build 
% to build the file heli_q8.mdl.

% Oppdatert høsten 2006 av Jostein Bakkeheim
% Oppdatert høsten 2008 av Arnfinn Aas Eielsen
% Oppdatert høsten 2009 av Jonathan Ronen
% Updated fall 2010, Dominik Breu
% Updated fall 2013, Mark Haring
% Updated spring 2015, Mark Haring


%%%%%%%%%%% Calibration of the encoder and the hardware for the specific
%%%%%%%%%%% helicopter
Joystick_gain_x = pi/5;
Joystick_gain_y = -pi/5;

Elevation_offset = 295;

%% Set IMU port
PORT = 3;

%%%%%%%%%%% Physical constants
g = 9.81; % gravitational constant [m/s^2]
l_c = 0.40; % distance elevation axis to counterweight [m]
l_h = 0.66; % distance elevation axis to helicopter head [m]
l_p = 0.175; % distance pitch axis to motor [m]
m_c = 1.92; % Counterweight mass [kg]
m_p = 0.65; % Motor mass [kg]

%%%%%%%%%% Experimental Variables 
vs0 = 5.7;
k_vd = -0.108; %gain for vd is -0,108
k_f = (-g*(m_c*l_c - 2*m_p*l_h))/(l_h*vs0); %intrinsic motor gain

%%%%%%%%%% K computed gains
k1 = k_f / (2*m_p*l_p);
k2 = (k_f * l_h )/ ((m_c * l_c^2) + (2*m_p*l_h^2));
k3 = (g*((m_c*l_c)-(2*m_p*l_h)))/((m_c*l_c^2) + (2*m_p*(l_h^2 + l_p^2)));

% Smart changes
% w0 = 2;
% zeta = 5;
% 
% k_pp = (w0)^2/k1;
% k_pd = 2*w0/k1;
% k_pd = 2*zeta*sqrt(k_pp/k1);
%%%%
%k_pp = 3;
%k_pd = 2;
% %% Pole placement in terms of wo z
% 
[k_pd, k_pp, w0, zeta] = polePlacement2(pi, 1);%high wo -> fast responce, zeta=1 -> critical damped
% sys = tf([k1*k_pp], [1 k1*k_pd k1*k_pp]);
% pole(sys)

% sys = tf([k1*k_pp],[1 k1*k_pd k1*k_pp]);
% polynomial=[1 k1*k_pd k1*k_pp];
% root=roots(polynomial);
% rlocus(sys)

%plot(ans(1,:),ans(4,:),ans(1,:),ans(8,:))

% Pole placement in terms of K

% [k_pd, k_pp, w0, zeta] = polePlacement(-1,-10); %polePlacement(-1,-10) -> slow responce, (-10,-100) fast responce
% sys = tf([k1*k_pp], [1 k1*k_pd k1*k_pp]);
% pole(sys)

%% Task 2.2.1 - State space formulation
A = [0 1 0; 0 0 0; 0 0 0];
B = [0 0; 0 k1; k2 0];
C = [1 0 0; 0 0 1];
D = 0;

system = ss(A, B, C, D);

%% Task 2.2.3
Q = [100 0 0; % Penalize p
    0 100 0;  % penalize pdot
    0 0 1]; % penalize edot
R = [1 0;   % Pitch control -- Lower values gives higher power output
    0 1];   % Elevation speed

K = lqr(A,B,Q,R); 
F = inv(C*inv(B*K-A)*B);

%% Task 2.2.5 - Integral action

A_I = [0 1 0 0 0; 0 0 0 0 0; 0 0 0 0 0; -1 0 0 0 0; 0 0 -1 0 0];
B_I = [0 0; 0 k1; k2 0; 0 0; 0 0];
C_I = [1 0 0 0 0; 0 0 1 0 0];
G_I = [0,0;0,0;0,0;1,0;0,1];

%Q_I = diag([10, 10, 100, 10, 10]);
Q_I = diag([100, 100, 1, 100, 50]); % Aggressive Tuning
R_I = R;
K_I = lqr(A_I,B_I,Q_I,R_I);  



% K_I_P =K_I(1:2,1:3);
% F_I = inv(C*inv(B*K_I_P-A)*B);

%% Task 2.3.1 Luenberg observer // IMU characteristics
A_e = zeros(5);
A_e(1,2) = 1;
A_e(3,4) = 1;
A_e(5,1) = k3;
B_e = zeros(5,2);
B_e(2,2) = k1;
B_e(4,1) = k2;
% C_e = [0 0 1 0 0; 0 0 0 0 1]; %(e ld) ;,mimimum states for observability
% C_e = [1 0 0 0 0; 0 0 1 0 0; 0 0 0 0 1];%(p e ld) mimimun states that work
C_e = eye(5) % all states
system_poles = eig(A_I-B_I*K_I);
r = -(1) * real(max(abs(system_poles)));
span = pi/10;
theta = linspace(-span/2,span/2,5);  
p = r*exp(1i*theta); % Eigenvalues observer
% p = [-98.4808-17.3648i;
%      -98.4808-10.3648i;
%      -98.4808-3.3648i;
%      -98.4808+10.3648i;
%      -98.4808+17.3648i];
L = real(place(A_e',C_e',p))';
%  figure()
% plot(real(system_poles),imag(system_poles),'sb',real(p), ...
%     imag(p),'rx');grid on; axis equal

%% Task 2.4 Kalman filter
A_k = zeros(6);
A_k(1,2) = 1;
A_k(3,4) = 1;
A_k(5,6) = 1;
A_k(5,1) = k3;

B_k = zeros(6,2);
B_k(4,1) = k2;
B_k(3,2) = k1;

% C_k = zeros(3,6);
% C_k(1,1) = 1;
% C_k(2,3) = 1;
% C_k(3,6) = 1;
C_k = eye(6);

D_k = 0;

sys_k = ss(A_k, B_k, C_k, D_k);
sys_kd = c2d(sys_k, 0.002);

A_kd = sys_kd.A;
B_kd = sys_kd.B;
C_kd = sys_kd.C;
D_kd = sys_kd.D;

eq_ts = load("equil_ts.mat").ans;
Qd = eye(6);
Qd(1,1) = 1e-5;%p
Qd(2,2) = 1e-5;%pd
Qd(3,3) = 1e-9;%e
Qd(4,4) = 1e-4;%ed
Qd(5,5) = 1e-5;%l
Qd(6,6) = 1e-5;%ld
Rd = cov(eq_ts(2:7,:)');




