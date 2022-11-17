function[Kpd, Kpp, w0, zeta] = polePlacement(pole1,pole2)

pol = [pole1, pole2]; % Desired poles
K1 = 1.0316; % Constant value from linearization

f = poly(pol);

Kpd = f(2)/K1;
Kpp = f(3)/K1;

w0 = sqrt(Kpp*K1);
zeta = (K1*Kpd) / (2*sqrt(Kpp/K1));

sys = tf([K1*Kpp],[1 K1*Kpd K1*Kpp]);
% stepplot(sys);

end