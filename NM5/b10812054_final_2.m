clc
clear

syms x(t)
syms m

eqn = diff(x,t,2) == 9.81-2.73./m.*x-13.08./m.*diff(x,t,1);
Dx = diff(x,t);
cond = [x(0)==0, Dx(0)==0]; %initial conditions
xSol(t) = dsolve(eqn,cond);
firstDerivative = diff(xSol(t));


ht = matlabFunction(xSol(t));
ht1 = matlabFunction(firstDerivative);


g = 0:0.1:150;
y6 = ht(g,6);
y61 = ht1(g,6);
y9 = ht(g,9);
y91 = ht1(g,9);
newfunc=@(m)  ht1(m,9)-ht1(m,6);

plot(g,real(y9-y6),'--b',g,real(y91-y61),'r')
grid
title("Differences of physical quantities at time t=6 and t=9 versus m")
legend('Displacemant','Velocity')
xlabel('{\itmass} (kg.)');
ylabel('Difference of strctch x and velocity v'); 


[mVmin,f1]=fminbnd(newfunc,0,150);

str1=fprintf("jumper weiahing %f kg determines the minimum of change in velocity during 6 to 9 second.\n",mVmin);
str2=fprintf(" Velocity at t=6 :   %f  (m/s)\n",ht1(mVmin,6));
str3=fprintf(" Velocity at t=9 :   %f  (m/s)\n",ht1(mVmin,9));
str4=fprintf(" strctch at t=6 :   %f  (m/s)\n",ht(mVmin,6));
str5=fprintf(" strctch at t=9 :   %f  (m/s)\n",ht(mVmin,9));

newfunc_for_v =@(t)  ht1(mVmin,t);
str6=fprintf("cross-validation by integral(newfunc_for_v,6,9)= %f \n",integral(newfunc_for_v,6,9));







