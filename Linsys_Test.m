clc, clear, close all

k1=1.0316;
k2=0.1773;
k3=-0.9667;
D=0;

A=[0, 1 0; 0, 0, 0; 0, 0, 0];
B=[0, 0; 0, k1; k2, 0];
% Controll=ctrb(A,B);
Q=[1, 0, 0; 0, 1, 0; 0, 0, 1];
R=[1, 0; 0, 1];

K=lqr(A, B, Q, R);
C=zeros(1,3);
C(1,1)=1;

sys1 = ss(A-B*K,B,C,D);
step(sys1(1,2))