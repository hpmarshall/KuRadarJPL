% Radar test at Cat Creek Summit 12/23/2022
% HP Marshall
% Radar by Adrian Tang et al, JPL and UCLA, as part of NASA IIP20

flow=15e9; % [Hz] start freq
fhigh=15.996e9; % [Hz] stop freq
BW=fhigh-flow; % [Hz] bandwidth
Tpl=67.55e-6; % [s] pulse length
Fs=122.88e6; % [Hz] sample rate
v=3.0e8; % [m/s] speed in air

N=2^15; % number of points in FFT

w=(0:N/2-1)/(N)*Fs; % frequencies sampled

d=0.5*w*Tpl/(BW)*v;

%%

%%d=0.5*w*Tpl/(BW)*v;
% first plot sky calibration
D=load('skycal.csv');
D=D'; % transpose due to collection in row vectors
Fs=120e6; % sample frequency
[nr,nc]=size(D);
ix=1:nc; iy=1:nr; d2=d(1:nr)
figure(1);clf
subplot(1,5,1:3)
imagesc(ix,d2,D,[0 4e9]); colorbar
axis([200 700 0 d2(end)])
title('Sky calibration, antennas pointed to sky')
xlabel('trace #'); ylabel('distance from radar in air [m]')
set(gca,'linewidth',2,'fontsize',14)
S=median(D(:,200:700),2); % get median sky calibration
subplot(1,5,4:5)
plot(S,d2,'r-','linewidth',2)
set(gca, 'ydir','reverse')
axis([0 4e9 0 d2(end)])
set(gca,'linewidth',2,'fontsize',14)
title('Median of traces 200:700')
xlabel('power spectral density')
ylabel('distance from radar in air [m]')

%% 

%% now up-down experiment
D=load('data4.csv');
D=D'; % transpose due to collection in row vectors
[nr,nc]=size(D);
ix=1:nc; iy=1:nr; d2=d(1:nr)
figure(2);clf
subplot(1,5,1:3)
imagesc(ix,d2,D,[0 4e9]); colorbar
hold on; plot([400 400],[0 4],'r-','linewidth',4)
hold on; plot([600 600],[0 4],'g-','linewidth',4)
axis([1 nc 0 2.5])
text(1e3,2,'snow surface','fontsize',14,'fontweight','bold','color','w')
text(800,1.25,'snow surface','fontsize',14,'fontweight','bold','color','w')
M1=median(D(:,390:410),2); % get median at low point calibration
M2=median(D(:,590:610),2); % get median at high point calibration
subplot(1,5,4:5)
plot(M1,d2,'r-','linewidth',3); hold on
plot(M2,d2,'g-','linewidth',3)
plot(S,d2,'c-','linewidth',1.5)
h=legend('traces 375-425','traces 1-100','sky calibration')
set(gca, 'ydir','reverse')
axis([0 4e9 0 2.5])
set(gca,'linewidth',2,'fontsize',14)
title('Median of traces')
xlabel('power spectral density')
ylabel('distance from radar in air [m]')
text(3e9,1.6,'snow surface','fontsize',14,'fontweight','bold','color','g')
text(2.5e9,2,'snow surface','fontsize',14,'fontweight','bold','color','r')
%%

%% now a profile
D=load('data.csv');
D=D'; % transpose due to collection in row vectors
[nr,nc]=size(D);
ix=1:nc; iy=1:nr; d2=d(1:nr)
figure(3);clf
subplot(1,5,1:3)
imagesc(ix,d2,D,[0 5e9]); colorbar
axis([1 nc 0.5 3])
hold on; plot([1500 1500],[0 4],'k-','linewidth',3)
hold on; plot([700 700],[0 4],'r-','linewidth',4)
hold on; plot([100 100],[0 4],'g-','linewidth',4)
text(200,1.6,'snow surface','fontsize',14,'fontweight','bold','color','w')
text(1260,1.56,'snow surface','fontsize',14,'fontweight','bold','color','w')
text(20,2.2,'ground','fontsize',14,'fontweight','bold','color','w')
text(1200,2.17,'ground','fontsize',14,'fontweight','bold','color','w')
text(600,2.4,'low ground return - off nadir?','fontsize',14,'fontweight','bold','color','w')
text(1600,1,'up-down','fontsize',18,'fontweight','bold','color','w')
text(500,1,'~20 meter profile','fontsize',18,'fontweight','bold','color','w')
xlabel('trace #'); ylabel('distance from radar in air [m]')
set(gca,'linewidth',2,'fontsize',14)
M1=median(D(:,90:110),2); % get median at low point calibration
M2=median(D(:,690:710),2); % get median at high point calibration
subplot(1,5,4:5)
plot(M1,d2,'r-','linewidth',3); hold on
plot(M2,d2,'g-','linewidth',3)
plot(S,d2,'c-','linewidth',1.5)
h=legend('high ground return','low ground return','sky calibration')
set(gca, 'ydir','reverse')
axis([0 5e9 0 3])
set(gca,'linewidth',2,'fontsize',14)
title('Median of traces')
xlabel('power spectral density')
ylabel('distance from radar in air [m]')
%text(0.5e9,1.2,'snow surface','fontsize',14,'fontweight','bold','color','g')
text(3e9,1.65,'snow surface','fontsize',14,'fontweight','bold','color','g')
%text(0.5e9,2.3,'ground?','fontsize',14,'fontweight','bold','color','g')
text(0.6e9,1.75,'snow surface','fontsize',14,'fontweight','bold','color','r')
text(3e9,2.1,'ground','fontsize',14,'fontweight','bold','color','r')


%% compare 2 directions
D=load('data.csv');
D=D'; % transpose due to collection in row vectors
D=D(:,140:1400); % grab first 1400 traces
[nr,nc]=size(D);
ix=1:nc; iy=1:nr; d2=d(1:nr)
figure(4);clf
subplot(2,1,1)
imagesc(ix,d2,D,[0 5e9]); colorbar
axis([1 nc 0.5 3])
xlabel('trace #'); ylabel('distance from radar in air [m]')
set(gca,'linewidth',2,'fontsize',14)
text(200,1.5,'snow surface','fontsize',14,'fontweight','bold','color','w')
text(1100,1.5,'snow surface','fontsize',14,'fontweight','bold','color','w')
text(20,2.2,'ground','fontsize',14,'fontweight','bold','color','w')
text(1100,2.17,'ground','fontsize',14,'fontweight','bold','color','w')
text(500,2.4,'low ground return - off nadir?','fontsize',14,'fontweight','bold','color','w')
subplot(2,1,2)
D2=load('data1.csv');
D2=D2'; % transpose due to collection in row vectors
D2=fliplr(D2(:,140:1400)); % grab first 1400 traces, and reverse (profile performed opposite dir)
[nr,nc]=size(D2);
ix=1:nc; iy=1:nr; d2=d(1:nr)
imagesc(ix,d2,D2,[0 5e9]); colorbar
axis([1 nc 0.5 3])
xlabel('trace #'); ylabel('distance from radar in air [m]')
set(gca,'linewidth',2,'fontsize',14)
text(200,1.5,'snow surface','fontsize',14,'fontweight','bold','color','w')
text(1100,1.5,'snow surface','fontsize',14,'fontweight','bold','color','w')
text(20,2.2,'ground','fontsize',14,'fontweight','bold','color','w')
text(1100,2.17,'ground','fontsize',14,'fontweight','bold','color','w')
text(500,2.4,'low ground return - off nadir?','fontsize',14,'fontweight','bold','color','w')

%%
%% compare 2 directions
D=load('data2.csv');
D=D'; % transpose due to collection in row vectors
D=D(:,100:1900); % grab first 1400 traces
[nr,nc]=size(D);
ix=1:nc; iy=1:nr; d2=d(1:nr)
figure(5);clf
subplot(2,5,1:3)
imagesc(ix,d2,D,[0 5e9]); colorbar
axis([1 nc 0.5 3])
hold on; plot([840 840],[0 4],'r-','linewidth',3)
hold on; plot([940 940],[0 4],'r-','linewidth',3)
hold on; plot([1500 1500],[0 4],'g-','linewidth',3)
hold on; plot([1600 1600],[0 4],'g-','linewidth',3)

xlabel('trace #'); ylabel('distance from radar in air [m]')
set(gca,'linewidth',2,'fontsize',14)
text(200,1.45,'snow surface','fontsize',14,'fontweight','bold','color','w')
text(1100,1.45,'snow surface','fontsize',14,'fontweight','bold','color','w')
text(20,2.2,'ground','fontsize',14,'fontweight','bold','color','w')
text(1100,2.17,'ground','fontsize',14,'fontweight','bold','color','w')
M1=median(D(:,840:940),2); % get median at low point calibration
M2=median(D(:,1500:1600),2); % get median at high point calibration
subplot(2,5,4:5)
plot(M1,d2,'r-','linewidth',3); hold on
plot(M2,d2,'g-','linewidth',3)
%plot(S,d2,'c-','linewidth',1.5)
h=legend('shallow','deep')  %,'sky calibration')
set(gca, 'ydir','reverse')
axis([0 3e9 0 3])
set(gca,'linewidth',2,'fontsize',14)
title('Median of traces')
xlabel('power spectral density')
ylabel('distance from radar in air [m]')
text(2.45e9,1.65,'snow surface','fontsize',14,'fontweight','bold','color','r')
text(2.6e9,1.5,'snow surface','fontsize',14,'fontweight','bold','color','g')
text(0.75e9,1.9,'ground','fontsize',14,'fontweight','bold','color','r')
text(0.6e9,2.1,'ground','fontsize',14,'fontweight','bold','color','g')


%text(500,2.4,'low ground return - off nadir?','fontsize',14,'fontweight','bold','color','w')
subplot(2,5,6:8)
D2=load('data3.csv');
D2=D2'; % transpose due to collection in row vectors
D2=fliplr(D2(:,100:1900)); % grab first 1400 traces, and reverse (profile performed opposite dir)
[nr,nc]=size(D2);
ix=1:nc; iy=1:nr; d2=d(1:nr)
imagesc(ix,d2,D2,[0 5e9]); colorbar
axis([1 nc 0.5 3])
hold on; plot([840 840],[0 4],'r-','linewidth',3)
hold on; plot([940 940],[0 4],'r-','linewidth',3)
hold on; plot([1500 1500],[0 4],'g-','linewidth',3)
hold on; plot([1600 1600],[0 4],'g-','linewidth',3)
xlabel('trace #'); ylabel('distance from radar in air [m]')
set(gca,'linewidth',2,'fontsize',14)
text(200,1.45,'snow surface','fontsize',14,'fontweight','bold','color','w')
text(1100,1.45,'snow surface','fontsize',14,'fontweight','bold','color','w')
text(20,2.2,'ground','fontsize',14,'fontweight','bold','color','w')
text(1100,2.17,'ground','fontsize',14,'fontweight','bold','color','w')
M1=median(D2(:,840:940),2); % get median at low point calibration
M2=median(D2(:,1500:1600),2); % get median at high point calibration
subplot(2,5,9:10)
plot(M1,d2,'r-','linewidth',3); hold on
plot(M2,d2,'g-','linewidth',3)
%plot(S,d2,'c-','linewidth',1.5)
h=legend('shallow','deep') %,'sky calibration')
set(gca, 'ydir','reverse')
axis([0 3e9 0 3])
set(gca,'linewidth',2,'fontsize',14)
title('Median of traces')
xlabel('power spectral density')
ylabel('distance from radar in air [m]')
text(0.65e9,1.6,'snow surface','fontsize',14,'fontweight','bold','color','r')
text(1.4e9,1.55,'snow surface','fontsize',14,'fontweight','bold','color','g')
text(1.4e9,1.8,'ground','fontsize',14,'fontweight','bold','color','r')
text(0.75e9,1.95,'ground','fontsize',14,'fontweight','bold','color','g')

%% one figure comparing the long profile to the magnaprobe
%% densities
rho=[493, 401, 354, 254, 374];
mrho=mean(rho);
es=e_snowdry(mrho,15.5e9,-5);
vsnow=v./sqrt(real(es)); % snow velocity
d3=2*(d2*vsnow/v-1.18); % correct depth scale, set surface to ~0

figure(6); clf
subplot(2,5,1:3)
D2=load('data3.csv');
D2=D2'; % transpose due to collection in row vectors
D2=fliplr(D2(:,100:1900)); % grab first 1400 traces, and reverse (profile performed opposite dir)
[nr,nc]=size(D2);
ix=1:nc; iy=1:nr; d2=d(1:nr)
imagesc(ix,d3,D2,[0 5e9]); colorbar
axis([1 nc -0.5 1.25])
hold on; plot([1 1],[-0.5 4],'r-','linewidth',3)
hold on; plot([20 20],[-0.5 4],'r-','linewidth',3)
hold on; plot([1500 1500],[-0.5 4],'g-','linewidth',3)
hold on; plot([1600 1600],[-0.5 4],'g-','linewidth',3)
xlabel('trace #'); ylabel('distance from radar in snow [m]')
title('profile with depth in snow')
set(gca,'linewidth',2,'fontsize',14)
text(200,1.45,'snow surface','fontsize',14,'fontweight','bold','color','w')
text(1100,1.45,'snow surface','fontsize',14,'fontweight','bold','color','w')
text(20,2.2,'ground','fontsize',14,'fontweight','bold','color','w')
text(1100,2.17,'ground','fontsize',14,'fontweight','bold','color','w')
M1=median(D2(:,1:30),2); % get median at low point calibration
M2=median(D2(:,1500:1600),2); % get median at high point calibration
subplot(2,5,4:5)
plot(M1,d3,'r-','linewidth',3); hold on
plot(M2,d3,'g-','linewidth',3)
%plot(S,d2,'c-','linewidth',1.5)
h=legend('shallow','deep') %,'sky calibration')
set(gca, 'ydir','reverse')
axis([0 3e9 -0.5 1.25])
set(gca,'linewidth',2,'fontsize',14)
title('Median of traces')
xlabel('power spectral density')
ylabel('distance from radar in snow [m]')
text(1.5e9,0,'snow surface','fontsize',14,'fontweight','bold','color','r')
text(0.2e9,0,'snow surface','fontsize',14,'fontweight','bold','color','g')
text(2.1e9,0.4,'ground','fontsize',14,'fontweight','bold','color','r')
text(0.5e9,0.9,'ground','fontsize',14,'fontweight','bold','color','g')

subplot(2,5,6:8)
PD=readtable('ProbeDepths.csv');
P1=PD.Var4(2:89)/100; ix=1:88
plot(ix,P1,'kx-','linewidth',2)
hold on; plot([1 1],[0.30 1],'r-','linewidth',3)
hold on; plot([3 3],[.30 1],'r-','linewidth',3)
hold on; plot([68 68],[.30 1],'g-','linewidth',3)
hold on; plot([72 72],[.30 1],'g-','linewidth',3)
set(gca,'linewidth',2,'fontsize',14)
title('Manual probe depth')
xlabel('measurement #'); ylabel('depth [m]')
subplot(2,5,9:10)
boxplot(P1)
%axis([10 130 0 35])
set(gca,'linewidth',2,'fontsize',14)
xlabel(''); ylabel('depth [m]')

S={'skyCal.png','upDown.png','deepProfile.png','compareProfile.png,...' ...
    'compareProfile2.png','snowProfile.png'};
for n=1:6
    figure(n)
    print(S{n},'-dpng')
end





