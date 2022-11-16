figure

data = load('D:\Projects\Git\HelicopterLab\Stored Data\Heli_Lab_Task1_Day2\w0_pi_zeta_0.7.mat');
data = data.ans;
x =data(1,:);
for i = 6:size(data,1)
    y = data(i,:);
    plot(x,y)
    hold on
end