% exploreWY23_UAVradar
ddir='UAVRadarSurveys2023/';
ddir2='2023-04-05_MCSLOWER/';
dfile=[ddir ddir2 'data4.csv'];
% lets test the new procJPLradar function
mrho=349; % from snowpit
dsmooth=2; thresh=2e9; crange=[20 50]; % inputs to procJPLradar.m
skyfile=[ddir ddir2 'skycal.csv']; % sky calibration file
[Z,Zp,x,dist]=procJPLradar(dfile,skyfile,mrho,dsmooth,thresh,crange); % load and process data with skycal
% plot processing comparison
figure(1);clf
subplot(121); imagesc(x,dist,Z,crange); colorbar; title('original')
subplot(122); imagesc(x,dist,Zp,[0 2e10]); colorbar; title('sky cal, smooth, threshold')
% plot Up-Down test
figure(2);clf
subplot(1,5,1:4)
imagesc(x,dist,10*log10(Zp/thresh),[0 15]); colorbar; title('Ku-band MTS radar [dB above noise floor]')
set(gca,'FontSize',14,'FontWeight','bold','LineWidth',2)
xlabel('trace number'); ylabel('distance in snow, \rho=349 [kg/m^3]')
hold on; plot([2105 2105],[0 14.8],'r','linewidth',2)
text(2000,2.5,'snow surface','fontsize',12,'fontweight','bold','color','w')
text(975,8,'snow surface','fontsize',12,'fontweight','bold','color','w')
text(2050,5.75,'ground','fontsize',12,'fontweight','bold','color','w')
text(800,9,'ground','fontsize',12,'fontweight','bold','color','w')
text(2073,3.5,'ice layer','fontsize',12,'fontweight','bold','color','w')
text(2068,4.1,'ice layer','fontsize',12,'fontweight','bold','color','w')
AX=axis;
subplot(1,5,5)
plot(Zp(:,2105),dist,'linewidth',3); set(gca,'Ydir','reverse')
axis([0 3e10 AX(3) AX(4)])
set(gca,'FontSize',14,'FontWeight','bold','LineWidth',2)
xlabel('amplitude'); ylabel('distance in snow, \rho=349 [kg/m^3]')
text(1.2e10,2.7,'snow surface','fontsize',12,'fontweight','bold','color','k')
text(0.5e10,5.23,'ground','fontsize',12,'fontweight','bold','color','k')
text(1.07e10,3.59,'ice layer','fontsize',12,'fontweight','bold','color','k')
text(1.07e10,4.18,'ice layer','fontsize',12,'fontweight','bold','color','k')

%% Now plot a profile - Mores Creek 2023-04-05
dfile=[ddir ddir2 'data5.csv'];
% lets test the new procJPLradar function
mrho=349; % from snowpit
dsmooth=2; thresh=0.7e9; crange=[20 50]; % inputs to procJPLradar.m
skyfile=[ddir ddir2 'skycal.csv']; % sky calibration file
[Z,Zp,x,dist]=procJPLradar(dfile,skyfile,mrho,dsmooth,thresh,crange); % load and process data with skycal
figure(3);clf
subplot(1,5,1:4)
imagesc(x,dist-3,10*log10(Zp/thresh),[0 20]); colorbar; title('Ku-band MTS radar [dB above noise floor]')
axis([600 2200 -1 4.2])
set(gca,'FontSize',14,'FontWeight','bold','LineWidth',2)
hold on; plot([787 787],[-1 4.2],'k','linewidth',2)
plot([2134 2134],[-1 4.2],'r','linewidth',2)
AX=axis;
text(1600,0,'snow surface','fontsize',12,'fontweight','bold','color','w')
text(1600,3,'ground','fontsize',12,'fontweight','bold','color','w')
xlabel('trace number'); ylabel('distance in snow [m], using \rho=349 [kg/m^3]')
subplot(155)
plot(Zp(:,787),dist-3,'k','linewidth',3); set(gca,'Ydir','reverse')
hold on
plot(Zp(:,2134),dist-3,'r','linewidth',3); set(gca,'Ydir','reverse')
axis([0 7e10 AX(3) AX(4)])
set(gca,'FontSize',14,'FontWeight','bold','LineWidth',2)
mdepth=mean([2.65 2.64 2.65 2.68 2.69 2.60 2.79 2.61 2.64 2.76 2.78]);
plot([0 7e10],[mdepth mdepth],'g','linewidth',3)
text(1.5e10,mdepth,'mean manual depth','fontsize',12,'fontweight','bold','color','k')
%text(1e10,2.8,'ground','fontsize',12,'fontweight','bold','color','k')
text(3e10,0,'snow surface','fontsize',12,'fontweight','bold','color','k')
text(4e10,1,'ice layers','fontsize',12,'fontweight','bold','color','k')
xlabel('amplitude'); ylabel('distance in snow [m], using \rho=349 [kg/m^3]')
%% Now lets compare the 3 different averaging settings.  While more averaging will help,
% this radar acquires slowly, so might be too much movement to see
% improvement, and it may make it worse.
dfile=[ddir ddir2 'data5.csv'];
% lets test the new procJPLradar function
mrho=349; % from snowpit
dsmooth=2; thresh=0.7e9; crange=[20 50]; % inputs to procJPLradar.m
skyfile=[ddir ddir2 'skycal.csv']; % sky calibration file
[Z,Zp,x,dist]=procJPLradar(dfile,skyfile,mrho,dsmooth,thresh,crange); % load and process data with skycal
figure(4);clf
subplot(3,1,1)
imagesc(x,dist-3,10*log10(Zp/thresh),[0 20]); colorbar; title('fast\_avg=1')
axis([600 2200 -2 4.2])
set(gca,'FontSize',14,'FontWeight','bold','LineWidth',2)
xlabel('trace number'); ylabel('distance in snow [m]')

dfile=[ddir ddir2 'data7.csv'];
% lets test the new procJPLradar function
mrho=349; % from snowpit
dsmooth=2; thresh=0.2e8; crange=[20 50]; % inputs to procJPLradar.m
skyfile=[ddir ddir2 'skycal.csv']; % sky calibration file
[Z,Zp,x,dist]=procJPLradar(dfile,skyfile,mrho,dsmooth,thresh,crange); % load and process data with skycal
subplot(3,1,2)
imagesc(x,dist-3,10*log10(Zp/thresh)); colorbar; title('fast\_avg=10')
axis([200 800 -2 4.2])
set(gca,'FontSize',14,'FontWeight','bold','LineWidth',2)
xlabel('trace number'); ylabel('distance in snow [m]')

dfile=[ddir ddir2 'data9.csv'];
% lets test the new procJPLradar function
mrho=349; % from snowpit
dsmooth=2; thresh=0.2e8; crange=[20 50]; % inputs to procJPLradar.m
skyfile=[ddir ddir2 'skycal.csv']; % sky calibration file
[Z,Zp,x,dist]=procJPLradar(dfile,skyfile,mrho,dsmooth,thresh,crange); % load and process data with skycal
subplot(3,1,3)
imagesc(x,dist-3,10*log10(Zp/thresh)); colorbar; title('fast\_avg=25')
axis([10 500 -2 4.2])
set(gca,'FontSize',14,'FontWeight','bold','LineWidth',2)
xlabel('trace number'); ylabel('distance in snow [m]')
%% Now lets try a much shallower snowpack
ddir2='2023-02-15_CATCREEK/';
dfile=[ddir ddir2 'data1.csv'];
ddir2='2023-04-05_MCSLOWER/';
skyfile=[ddir ddir2 'skycal.csv']; % sky calibration file
% lets test the new procJPLradar function
mrho=349; % from snowpit
dsmooth=2; thresh=0.7e9; crange=[20 50]; % inputs to procJPLradar.m
[Z,Zp,x,dist]=procJPLradar(dfile,skyfile,mrho,dsmooth,thresh,crange); % load and process data with skycal
figure(5);clf
subplot(1,5,1:4)
imagesc(x,dist-3,10*log10(Zp/thresh)); colorbar; title('Cat Creek Summit, 2023-02-15')
set(gca,'FontSize',14,'FontWeight','bold','LineWidth',2)
xlabel('trace number'); ylabel('distance in snow [m]')
axis([500 2700 5 11.7])
hold on; plot([822 822],[5 11.7],'k','linewidth',3)
plot([1693 1693],[5 11.7],'r','linewidth',3)
text(1100,7.8,'snow surface','fontsize',12,'fontweight','bold','color','w')
text(1000,9,'ground','fontsize',12,'fontweight','bold','color','w')

subplot(155)
plot(Zp(:,822),dist-3,'k','linewidth',3); set(gca,'Ydir','reverse')
hold on
plot(Zp(:,1693),dist-3,'r','linewidth',3); set(gca,'Ydir','reverse')
axis([0 7e10 5 11.7])
set(gca,'FontSize',14,'FontWeight','bold','LineWidth',2)
mD=load('UAVRadarSurveys2023/2023-02-15_CATCREEK/depths.csv');
mdepth=mean(mD)/100;
stdDepth=std(mD)/100;
text(1.5e10,6.38,'snow surface','fontsize',12,'fontweight','bold','color','k')
plot([0 7e10],[6.38+mdepth 6.38+mdepth],'g','linewidth',3)
text(0.1e10,6.97,'mean meas. depth','fontsize',12,'fontweight','bold','color','k')
text(1.9e10,10.61,'snow surface','fontsize',12,'fontweight','bold','color','k')
plot([0 7e10],[10.61+mdepth 10.61+mdepth],'g','linewidth',3)
%text(2e10,7.5,'ground','fontsize',12,'fontweight','bold','color','k')
%text(2e10,11.5,'ground','fontsize',12,'fontweight','bold','color','k')
text(0.1e10,11.2,'mean meas. depth','fontsize',12,'fontweight','bold','color','k')
xlabel('amplitude'); ylabel('distance in snow [m]')

%% Now try Mores Creek in February, approx 150cm snowpack
ddir2='2023-02-09_MCSLower/';
dfile=[ddir ddir2 'data1.csv'];
ddir2='2023-04-05_MCSLOWER/';
skyfile=[ddir ddir2 'skycal.csv']; % sky calibration file
% lets test the new procJPLradar function
mrho=349; % from snowpit
dsmooth=1; thresh=2e9; crange=[20 50]; % inputs to procJPLradar.m
[Z,Zp,x,dist]=procJPLradar(dfile,skyfile,mrho,dsmooth,thresh,crange); % load and process data with skycal
figure(6);clf
subplot(1,5,1:4)
imagesc(x,dist-3,10*log10(Zp/thresh)); colorbar; title('Mores Creek Summit, 2023-02-15')
set(gca,'FontSize',14,'FontWeight','bold','LineWidth',2)
xlabel('trace number'); ylabel('distance in snow [m]')
axis([1 1800 0 10])
hold on; plot([720 720],[0 10],'k','linewidth',3)
plot([1369 1369],[0 10],'r','linewidth',3)
text(1000,3.5,'snow surface','fontsize',12,'fontweight','bold','color','w')
text(900,5.5,'ground','fontsize',12,'fontweight','bold','color','w')

subplot(155)
plot(Zp(:,720),dist-3,'k','linewidth',3); set(gca,'Ydir','reverse')
hold on
plot(Zp(:,1369),dist-3,'r','linewidth',3); set(gca,'Ydir','reverse')
axis([5e9 6e10 0 10])
set(gca,'FontSize',14,'FontWeight','bold','LineWidth',2)
mD=load('UAVRadarSurveys2023/2023-02-09_MCSLower/depths.csv');
mdepth=mean(mD)/100;
stdDepth=std(mD)/100;
text(2.5e10,3.29,'snow surface','fontsize',12,'fontweight','bold','color','k')
plot([0 6e10],[3.29+mdepth 3.29+mdepth],'g','linewidth',3)
text(1e10,4.85,'mean meas. depth','fontsize',12,'fontweight','bold','color','k')
text(3.5e10,8.03,'snow surface','fontsize',12,'fontweight','bold','color','k')
plot([0 6e10],[8.03+mdepth 8.03+mdepth],'g','linewidth',3)
text(1e10,9.6,'mean meas. depth','fontsize',12,'fontweight','bold','color','k')













