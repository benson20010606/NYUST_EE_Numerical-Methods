clc;
clear;
rng('shuffle'); 
T1=1000;
a=0.5;
N=5000;
x_n=[1 2 3 4 5 6 7 8 1];
x_star=x_n;%最佳解
x_n1=x_n;% 用於與新X比較
distance_temp=[0 0];
delta=0;
T=ones(N,1);
T(1)=T1;
All_distance=zeros(N,1);% 紀錄距離
All_distance(1)=distance(x_n);
All_x=zeros(N,9);% 紀錄新的X
All_x(1,:)=x_n;
min_distance=distance(x_n1);

for n=2:N
    
    distance_temp(1)=distance(x_n1);
    new_x=swap(x_n1);
    distance_temp(2)=distance(new_x);
    delta=distance_temp(2)-distance_temp(1);
    All_x(n,:)=new_x;
    All_distance(n)= distance_temp(2);
    
    if delta>=0
       
        if rand()<= exp(-delta/T(n))
            x_n1=new_x;

        end
    
    elseif delta<0
        x_n1=new_x;

        if distance(x_n1)-min_distance<0
            x_star=x_n1;
            min_distance=distance(x_n1);
        end
    end 
    T(n)=T(n-1)*a;

end

times=1:N;
times=times';
X=sprintf('%d >> %d >> %d >> %d >> %d >> %d >> %d >> %d >> %d',x_star(:));
Table = table( times,All_x(:,1),All_x(:,2),All_x(:,3),All_x(:,4),All_x(:,5),All_x(:,6),All_x(:,7),All_x(:,8),All_x(:,9),All_distance,T,'VariableNames', ...
    {'Times','city_First','city_Second','city_Third','city_Fourth','city_Fifth','city_Sixth','city_Seventh','city_Eighth',',city_end','Distance','Temperature'}) 
disp("best path is:");
disp(X);
disp("and the distence :");
disp(num2str(min_distance));

function value=distance(x)
    
    sum=0;
    D=[0     91.8  105.2 89.9  189.9 76.2  278.3 54.4 ;
       91.8  0     187.2 38.9  271.3 162.9 363.3 88.4 ;
       105.2 187.2 0     194.1 182.3 31.4  176.1 153.8;
       89.9  38.9  194.1 0     249.4 166.1 368.3 63.6 ;
       189.9 271.3 182.3 249.4 0     168.0 243.0 185.9;
       76.2  162.9 31.4  166.1 168.0 0     202.2 122.8;
       278.3 363.3 176.1 368.3 243.0 202.2 0     320.0;
       54.4  88.4  153.8 63.6  185.9 122.8 320.0 0     ];
    for i =1:8
    sum=sum+D(x(i),x(i+1));


    end
value=sum;
end

function value=swap(x)
    while 1
        index=randi([2,8],2);
        index1=index(1);
        index2=index(2);
        if index1 ~= index2
            break
        end
    end
    temp=x(index1);
    x(index1)=x(index2);
    x(index2)=temp;
    value=x;
end
