f=input("Enter the frequency ");
D=input("Enter the Directivity of the Antenna in dB:");
d=10^(D/10);
% Since the losses in the horn are negligible,we can assume the gain of 
% the horn to be the same as the directivity.

G=d; % Gain of Horn Antenna
aw=input("Enter the Height of waveGuide:");
bw=input("Enter the width of waveGuide:");
AspectRatio=input("Enter the aspect ratio a/b :");

% To calculate the wavelength

c = 3*(10^(8)); 
lambda = c/f; 

% To calculate a , b : Height and width of apperture of Horn Antenna
ab=(G*((lambda)^2))/(0.5*4*pi);
a=sqrt(ab*AspectRatio);
b=a/AspectRatio;

% To calculate rox,roy

% The optimum flare angle is different in the E and H planes because the amplitude distributions are different.
% In the H-plane the optimum flare angle is obtained when the maximum phase error (at the edge of the aperture 
% in the H-plane) is equal to 3π/4 and in the E-plane it occurs when the maximum phase error is π/2.

% MPH max phase error H plane for rox , MPE max phase error E plane for roy

MPH=(3*pi)/4;
MPE=pi/2;

k=(2*pi)/lambda;
rox=(((0.5*a)^2)-((MPH/k)^2))/(2*(MPH/k));
roy=(((0.5*b)^2)-((MPE/k)^2))/(2*(MPE/k));

% To calculate Flare Angle

psiH=2*atan(sqrt((3*lambda)/(4*rox)));
psiE=2*atan(sqrt((lambda)/(2*roy)));

% To calculate length of Horn Antenna , consider Maximum of L1 and L2.
% recalculate psiH and psiE.
L1=(a-aw)/(2*tan(psiH/2));
L2=(b-bw)/(2*tan(psiE/2));

L=max(L1,L2);

psiH=2*atan((a-aw)/(2*L));
psiH=psiH*(180/pi);
psiE=2*atan((b-bw)/(2*L));
psiE=psiE*(180/pi);

disp("Horn Antenna Gain:")
disp(G)

disp("Parameters of Horn Antenna:")
disp("Height and width of apperture of Horn Antenna in m")
A=[a b];
disp(A)

disp("rox")
disp(rox)
disp("roy")
disp(roy)

disp("Length of Horn Antenna:")
disp(L)

disp("Flare Angles:")
disp("psiH")
disp(psiH)
disp("psiE")
disp(psiE)

Lw = 0.05; % length of waveguide

FO=[0.01 0];

% to show Horn Antenna
ant1 = horn('FlareLength',L,'FlareWidth',b,'FlareHeight',a,'Length',Lw,...
             'Width',bw,'Height',aw,'FeedOffset',FO);
figure(1)
show(ant1);

% to show current distribution
figure(2)
current(ant1,f)

% to show impedance of Horn Antenna
figure(3)
freqRange = (8100:90:9900)*1e6;
impedance(ant1,freqRange)

% to show radiation pattern
figure(4)
pattern(ant1,f) 

% to show elevation pattern
figure(5)
patternElevation(ant1,f)

%to show Azimuthal pattern
figure(6)
patternAzimuth(ant1,f)  