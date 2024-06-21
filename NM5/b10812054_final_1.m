clc;
clear;
%%%%參數初始化
rng('shuffle'); 
T1=10;
a=0.88;
N=100;

f=@(x) sin(x)+sin(10/3*x) +log(x)-0.84*x+3

x=2.5;
x_star=x% 起始以及最佳;

T=ones(N,1);T(1)=T1;

All_y=zeros(N,1);All_y(1)=f(x_star);
y_temp=[0 0];

All_x=zeros(N,1);All_x(1)=x;
min_y=f(x_star);

aa=zeros(N,1);aa(1)=0;
delta=zeros(N,1);delta(1)=2.5;
%%%%參數初始化


for n=2:N
    xOld = x;
    y_temp(1)=f(xOld);
    new_x=2.5+(7.5-2.5).*rand(1,1) ;
    All_y(n)=f(new_x);
    x=new_x;
    T(n)=T(n-1)*a;
    delta(n)= All_y(n)-All_y(n-1);
    
    aa(n)=-delta(n)/(T(n));
    if delta(n)>=0&&rand()> exp(-delta(n)/(T(n)))
        x=xOld ;
        All_y(n) = All_y(n-1);    
    end
    All_x(n)=x;
    if All_y(n)-min_y<0
            x_star=x;
            
            min_y=All_y(n);
    end
end

times=1:N;

times=times';

X=sprintf('%f',x_star);
Table = table( times,All_x,All_y,T,'VariableNames', ...
    {'Times','x','y','Temperature'}) 
disp("best x using Simulated annealing:");
disp(X);
disp("and the y using Simulated annealing:");
disp(num2str(min_y));

[xmin,f1]=fminbnd(f,2.7,7.5);

str5=fprintf(" the global minimum using fminbnd is %f ,at x = %f\n",f1,xmin);


str=sprintf('The initial temperature T: %d  , The cooling rate a: %f',T1,a);

t=2.5:0.001:7.5;
figure(1)
subplot(2,2,1)
plot(t,f(t),All_x(1:N/4),All_y(1:N/4),'kx',All_x(N/4+1:N/2),All_y(N/4+1:N/2),'r*',All_x(N/2+1:N*3/4),All_y(N/2+1:N*3/4),'g+',All_x(N*3/4+1:N),All_y(N*3/4+1:N),'bd','MarkerSize',10);
legend('function value','0~N/4','N/4~N/2','N/2~3/4','3*N/4~N')
title('The distribution of the result on the curve');

subplot(2,2,2)
plot(1:N,All_y); grid on;
xlabel('Number of Iterations');
ylabel('function value');
title('The iteration result versus Number of Iterations');

subplot(2,2,4)

plot(1:N,aa,1:N,zeros(N,1),'r');
xlabel('Number of Iterations');
ylabel('-delta/T');
title('The power of  probability  (-delta/T) versus Number of Iterations');

grid on;

subplot(2,2,3)


plot(1:N,delta,1:N,zeros(N,1),'r');
xlabel('Number of Iterations');
ylabel('delta');
title('delta versus Number of Iterations');
grid on;

sgtitle(str) 
set(gcf,'position',[100 50 1280 720])

