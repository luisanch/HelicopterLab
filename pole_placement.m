clc
clearvars
init_heli_1_2

syms k_pp k_pd s xi 

%Natural frequency
om_n = pi;

%Damping Ratio
xi = 1; 
%Resulting k_pp k_pd
k_pp = om_n^2 / k1;
k_pd = 2*xi*om_n / k1;

%Tranfer function
sys = tf([k1*k_pp],[1 k1*k_pd k1*k_pp]);

%Plots
f = figure;
ax = axes('Parent',f,'position',[0.13 0.39  0.77 0.54]);
h = stepplot(ax,sys);
setoptions(h,'XLim',[0,10],'YLim',[0,2]);

b = uicontrol('Parent',f,'Style','slider','Position',[81,54,419,23],...
              'value',xi, 'min',0, 'max',2);
bgcolor = f.Color;
bl1 = uicontrol('Parent',f,'Style','text','Position',[50,54,23,23],...
                'String','0','BackgroundColor',bgcolor);
bl2 = uicontrol('Parent',f,'Style','text','Position',[500,54,23,23],...
                'String','1','BackgroundColor',bgcolor);
bl3 = uicontrol('Parent',f,'Style','text','Position',[240,25,100,23],...
                'String','Damping Ratio','BackgroundColor',bgcolor);



c = uicontrol('Parent',f,'Style','slider','Position',[81,100,419,23],...
              'value',om_n, 'min',0, 'max',4*pi); 
cl1 = uicontrol('Parent',f,'Style','text','Position',[50,100,23,23],...
                'String','0','BackgroundColor',bgcolor);
cl2 = uicontrol('Parent',f,'Style','text','Position',[500,100,23,23],...
                'String','4 pi','BackgroundColor',bgcolor);
cl3 = uicontrol('Parent',f,'Style','text','Position',[240,75,100,23],...
                'String','Natural Frequency','BackgroundColor',bgcolor);

c.Callback = @(ces,ced) updateSystem(h,tf([k1*((c.Value)^2 / k1)],[1 k1*(2*b.Value*(c.Value) / k1) k1*((c.Value)^2 / k1)])); 
b.Callback = @(ces,ced) updateSystem(h,tf([k1*((c.Value)^2 / k1)],[1 k1*(2*b.Value*(c.Value) / k1) k1*((c.Value)^2 / k1)]));
 
