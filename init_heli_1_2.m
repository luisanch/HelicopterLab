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
Joystick_gain_x = pi/2;
Joystick_gain_y = -10;

Elevation_offset = 295;


k_pp = 3;
k_pd = 1;


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
k_f = (g*(m_c*l_c - 2*m_p*l_h))/(l_h*vs0); %intrinsic motor gain

%%%%%%%%%% K computed gains
k1 = k_f / 2*m_p*l_p;
k2 = (k_f * l_h )/ ((m_c * l_c^2) + (2*m_p*l_h^2));
k3 = (g*((m_c*l_c)-(2*m_p*l_h)))/((m_c*l_c^2) + (2*m_p*(l_h^2 + l_p^2)));





