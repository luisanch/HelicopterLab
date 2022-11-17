close all
clc
clearvars
init_heli_1_2 

%Natural frequency
om_n = 4*pi;

%Damping Ratio
xi = 1; 
%Resulting k_pp k_pd
global k_pp k_pd c b h bl4 cl4
k_pp = om_n^2 / k1;
k_pd = 2*xi*om_n / k1;

%Tranfer function
sys = tf([k1*k_pp],[1 k1*k_pd k1*k_pp]);

%Plots 
% in order to retieve kpp and kpd, do: disp(b.Value) disp(c.Value)
f = figure;
ax = axes('Parent',f,'position',[0.13 0.39  0.77 0.54]);
h = stepplot(ax,sys);
setoptions(h,'XLim',[0,10],'YLim',[0,2]);

b = uicontrol('Parent',f,'Style','slider','Position',[81,44,419,23],...
              'value',xi, 'min',0, 'max',2);
bgcolor = f.Color;
bl1 = uicontrol('Parent',f,'Style','text','Position',[50,44,23,23],...
                'String','0','BackgroundColor',bgcolor);
bl2 = uicontrol('Parent',f,'Style','text','Position',[500,44,23,23],...
                'String','2','BackgroundColor',bgcolor);
bl3 = uicontrol('Parent',f,'Style','text','Position',[240,15,100,23],...
                'String','Damping Ratio','BackgroundColor',bgcolor);
bl4 = uicontrol('Parent',f,'Style','text','Position',[340,15,100,23],...
                'String',xi,'BackgroundColor',bgcolor);

c = uicontrol('Parent',f,'Style','slider','Position',[81,90,419,23],...
              'value',om_n, 'min',0, 'max',4*pi); 
cl1 = uicontrol('Parent',f,'Style','text','Position',[50,90,23,23],...
                'String','0','BackgroundColor',bgcolor);
cl2 = uicontrol('Parent',f,'Style','text','Position',[500,90,23,23],...
                'String','4 pi','BackgroundColor',bgcolor);
cl3 = uicontrol('Parent',f,'Style','text','Position',[240,67,100,23],...
                'String','Natural Frequency','BackgroundColor',bgcolor);
cl4 = uicontrol('Parent',f,'Style','text','Position',[340,67,100,23],...
                'String',om_n,'BackgroundColor',bgcolor);
%c.Value is kpp
%b.value is kpd
c.Callback = @myCallback;
b.Callback = @myCallback;

function a = myCallback(elem,event)
global k_pp k_pd c b k1 h bl4 cl4
k_pp = c.Value^2 / k1;
k_pd = 2*b.Value*c.Value / k1;
cl4.String = c.Value;
bl4.String = b.Value;

updateSystem(h,tf([k1*k_pp],[1 k1*k_pd k1*k_pp]));
end
