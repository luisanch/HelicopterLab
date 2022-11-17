xbar = [0 0 0 0 0 0]';
y = [0 0 0 0 0 0]';

Pbar = eye(6);
newdata=1;
L = Pbar * C_kd'/(C_kd*Pbar*C_kd' + Rd);
if newdata == 1
xhat = xbar + L*( y - C_kd * xbar)
I = eye(size(L));
Phat = (I - L* C_kd)* Pbar*(I-L*C_kd)' + L*Rd*L'
else     
xhat = xbar;
Phat = Pbar;
end
