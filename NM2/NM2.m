%B10812054_陳昱憲_NM2
clc;
clear;


%
f1 = @(x) x+sin(x)-3;
f2 = @(x) x^2-tanh(x)-x*log(x)-2;

%
g1=@(x) 3-sin(x);
g2=@(x) (tanh(x)+2)/(x-log(x));

%
[f1_fzero,f1val]=fzero(f1,2);
[f1_bisection,f1val_bis]=bisection(f1,0,pi,0.00001);
[f1_false,f1val_false]=false_Position(f1,0,pi,0.00001);
[f1_fixed,f1val_fixed] =fixed_Point(f1,g1,0,0.00001);

%fprintf("x+sin(x)-3=0 \n");
%fprintf("bisection:\n x=%f \n number of iterations:%d\n",f1_bisection(length(f1_bisection)),length(f1_bisection));
%fprintf("false Position:\n x=%f \n number of iterations:%d\n",f1_false(length(f1_false)),length(f1_false));
%fprintf("fixed Point:\n x=%f \n number of iterations:%d\n\n",f1_fixed(length(f1_fixed)),length(f1_fixed));


disp('=================== x+sin(x)-3=0 ====================================');
disp(['method','             Final x','        Final f(x)','    number of iterations'])
disp(['fzero','              ',num2str(f1_fzero,'%.5f'),'        ',num2str(f1val)]);
disp(['bisection','          ',num2str(f1_bisection(length(f1_bisection)),'%.5f'),'        ',num2str(f1val_bis(length(f1_bisection)),'%.3e'),'            ',num2str(length(f1_bisection))]);
disp(['false Position','     ',num2str(f1_false(length(f1_false)),'%.5f'),'        ',num2str(f1val_false(length(f1_false)),'%.3e'),'            ',num2str(length(f1_false))]);
disp(['fixed Point','        ',num2str(f1_fixed(length(f1_fixed)),'%.5f'),'        ',num2str(f1val_fixed(length(f1_fixed)),'%.3e'),'            ',num2str(length(f1_fixed))]);
disp('======================================================================');

%
[f2_fzero,f2val]=fzero(f2,2);
[f2_bisection,f2val_bis]=bisection(f2,0.001,pi,0.00001);
[f2_false,f2val_false]=false_Position(f2,0.001,pi,0.00001);
[f2_fixed,f2val_fixed] =fixed_Point(f2,g2,0.001,0.00001);

%fprintf("x^2-tanh(x)-x*log(x)-2=0 \n");
%fprintf("bisection:\n x=%f \n number of iterations:%d\n",f2_bisection(length(f2_bisection)),length(f2_bisection));
%fprintf("false Position:\n x=%f \n number of iterations:%d\n",f2_false(length(f2_false)),length(f2_false));
%fprintf("fixed Point:\n x=%f \n number of iterations:%d\n\n",f2_fixed(length(f2_fixed)),length(f2_fixed));

disp('================== x^2-tanh(x)-x*log(x)-2=0 =========================');
disp(['method','             Final x','        Final f(x)','    number of iterations'])
disp(['fzero','              ',num2str(f2_fzero,'%.5f'),'        ',num2str(f2val)]);
disp(['bisection','          ',num2str(f2_bisection(length(f2_bisection)),'%.5f'),'        ',num2str(f2val_bis(length(f2_bisection)),'%.3e'),'            ',num2str(length(f2_bisection))]);
disp(['false Position','     ',num2str(f2_false(length(f2_false)),'%.5f'),'        ',num2str(f2val_false(length(f2_false)),'%.3e'),'            ',num2str(length(f2_false))]);
disp(['fixed Point','        ',num2str(f2_fixed(length(f2_fixed)),'%.5f'),'        ',num2str(f2val_fixed(length(f2_fixed)),'%.3e'),'            ',num2str(length(f2_fixed))]);
disp('====================================================================');

%
figure(1);
subplot(2,2,1);
plot(f1_bisection,'--r','LineWidth',0.8);
hold on;
plot(f1_false,'-.k','LineWidth',0.8);
hold on;
plot(f1_fixed,':b','LineWidth',1.2);
hold on;
grid on;
xlabel(' interation count ') ;
ylabel('solution x') ;
legend('bisection','false position','fixedpoint')
title('how x changes with respect to the number of iterations:y=x+sin(x)-3');
%
subplot(2,2,2);
plot(f2_bisection,'--r','LineWidth',0.8);
hold on;
plot(f2_false,'-.k','LineWidth',0.8);
hold on;
plot(f2_fixed,':b','LineWidth',1.2);
hold on;
grid on;
xlabel(' interation count ') ;
ylabel('solution x') ;
legend('bisection','false position','fixedpoint')
title('how x changes with respect to the number of iterations:y=x^2-tanh(x)-x*log(x)-2');

%
subplot(2,2,3);
plot(f1val_bis,'--r','LineWidth',0.8);
hold on;
plot(f1val_false,'-.k','LineWidth',0.8);
hold on;
plot(f1val_fixed,':b','LineWidth',1.2);
hold on;
grid on;
xlabel(' interation count ') ;
ylabel('solution f(x)') ;
legend('bisection','false position','fixedpoint')
title('how f(x) changes with respect to the number of iterations:y=x+sin(x)-3');
%
subplot(2,2,4);
plot(f2val_bis,'--r','LineWidth',0.8);
hold on;
plot(f2val_false,'-.k','LineWidth',0.8);
hold on;
plot(f2val_fixed,':b','LineWidth',1.2);
hold on;
grid on;
xlabel(' interation count ') ;
ylabel('solution f(x)') ;
legend('bisection','false position','fixedpoint')
title('how f(x) changes with respect to the number of iterations:y=x^2-tanh(x)-x*log(x)-2');

%
function [value,fval]= false_Position(func,xl,xu,es)
    flag=0;
    times=0;
    xold=xu;
    if func(xu)*func(xl) >=0
        if abs(func(xu))<=es
            value(1)=xu;
            fval(1)=func(xu);
            flag=1;
        elseif abs(func(xl))<=es
            value(1)=xl;
            fval(1)=func(xl);
            flag=1;
        else
            error("範圍內無正確答案")
        end
    end


    while(flag==0)
        %fprintf("執行第%d次\n",times);
       
        temp_x=xu-((func(xu)*(xl-xu))/(func(xl)-func(xu)));
        %fprintf("x=%f\n",temp_x);
        temp_f=func(temp_x);
        %fprintf("f(x)=%f\n",temp_f);
        times=times+1  ;
        if  abs((temp_x-xold)/temp_x)<=es 
            value(times)=temp_x;
            fval(times)=temp_f;
            break;
        else
            if((temp_f)*func(xl)>0)
                xl=temp_x;
            elseif((temp_f)*func(xl)<0)
                xu=temp_x;
            end
            value(times)=temp_x;
            fval(times)=temp_f;
        end
        xold=temp_x;
    end

end

function [value,fval]= fixed_Point(func,func_g,xg,es)
    %%g=@(x) x+func(x);
    count=0;

    while(1)
        temp_y0=func_g(xg);
        temp_x1=temp_y0;
        count=count+1;
        fval(count)=func(temp_x1);
        if abs((temp_x1-xg)/temp_x1)<=es
            value(count)=temp_x1;
            
            break;
        else
            xg=temp_x1;
            value(count)=temp_x1;
        end

    end

end

function [root,fval] = bisection(func,xl,xu,es)

test = func(xl)*func(xu);
if test > 0
    error('no sign change');
end
iter = 0; xr = xl;


    while (1)
      xrold = xr;
      xr = (xl + xu)/2;
      iter = iter + 1;
      root(iter) = xr;
      fval(iter)=func(xr);
      if xr ~= 0
         ea = abs((xr-xrold)/xr) ;
      end
      test = func(xl)*func(xr);
      if test < 0
        xu = xr;
      elseif test > 0
        xl = xr;
      else
        ea = 0;
      end
      if ea <= es 
          break;
      end
    end

end
