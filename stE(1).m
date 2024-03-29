%
%  Gabbiani & Cox, Mathematics for Neuroscientists
%
% stE.m,  
%
% staggered Euler on the HH isopotential cell
%
% usage:  [t,v] = stE(dt,stim)
%
% where:   dt = timestep (ms)
%          stim = struct('amp',    amplitude (micro A)
%                        't1',     stim start time (ms)
%                        't2',     stim stop time (ms)
%                        'Tfin',   solve until Tfin (ms)
%
% and      t = vector of times at which v is computed
%          v = associated potentials
%
% example:  dt = 0.01;   stim = struct('amp',10e-6,'t1',1,'t2',2,'Tfin',10);
%

function [t,V] = stE(dt,stim)

A = 4*pi*(1e-6);	% surface area  (cm)^2
Cm = 1;  		% membrane capacitance  (microFarad/cm^2)

E = struct('K', -77, 'Na', 56, 'Cl', -68); % reversal potentials, mV

G = struct('K', 36, 'Na', 120, 'Cl', 0.3);  % channel conductances, mS/cm^2

Vr = fsolve(@(V) Iss(V,E,G),-71);   % find rest potential 

Nt = ceil(stim.Tfin/dt);   % initialize
t = zeros(Nt,1); V = t;
t(1) = 0;
V(1) = Vr;
n = an(Vr)/(an(Vr)+bn(Vr));  
m = am(Vr)/(am(Vr)+bm(Vr));  
h = ah(Vr)/(ah(Vr)+bh(Vr));  

td = 1/dt;

for j = 2:Nt,			% march

      t(j) = (j-1)*dt;

      Istim = stim.amp*(t(j)-dt/2>stim.t1)*(t(j)-dt/2<stim.t2);
      
      a = an(V(j-1));  b = bn(V(j-1)); c = (a+b)/2;
      n = ( (td-c)*n + a ) / (td + c);
      
      cK = G.K*n^4;
      
      a = am(V(j-1));  b = bm(V(j-1)); c = (a+b)/2;
      m = ( (td-c)*m + a ) / (td + c);
      
      a = ah(V(j-1));  b = bh(V(j-1)); c = (a+b)/2;
      h = ( (td-c)*h + a ) / (td + c);
      
      cNa = G.Na*m^3*h;
      
      top = 2*Cm*V(j-1)*td + cK*E.K + cNa*E.Na + G.Cl*E.Cl + Istim/A;
      
      bot = 2*Cm*td + cK + cNa + G.Cl;
      
      Vmid = top/bot;

      V(j) = 2*Vmid - V(j-1); 

end

function val = Iss(V,E,G)
val = G.Na*(am(V)/(am(V)+bm(V)))^3*(ah(V)/(ah(V)+bh(V)))*(V-E.Na) + ...
      G.K*(an(V)/(an(V)+bn(V)))^4*(V-E.K) + G.Cl*(V-E.Cl);

function val = an(V)
val = .01*(10-(V+71))./(exp(1-(V+71)/10)-1);

function val = bn(V)
val = .125*exp(-(V+71)/80);

function val = am(V)
val = .1*(25-(V+71))./(exp(2.5-(V+71)/10)-1);

function val = bm(V)
val = 4*exp(-(V+71)/18);

function val = ah(V)
val = 0.07*exp(-(V+71)/20);

function val = bh(V)
val = 1./(exp(3-(V+71)/10)+1);
