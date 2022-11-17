function[Kpd, Kpp, w0, zeta] = polePlacement2(w0, zeta)
K1 = 1.031599978968401;


Kpp = ((w0)^2)/K1;
Kpd = (2*zeta*w0)/K1;
sys = tf([K1*Kpp],[1 K1*Kpd K1*Kpp]);
% stepplot(sys);
end