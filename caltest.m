clear;
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
% take the sky calibration
D=load('skycal.csv');
[nr nc] = size(D);

%average all the traces in the sky cal excluding the start and end ones
%because weird things always happen at the start and end of a dataset
average_cal = mean(D(10:nr-10,:))';
D=D'; % transpose due to collection in row vectors


%% now a profile
D=load('data2.csv');
D=D'; % transpose due to collection in row vectors
D=D(:,1:2000);
[nr,nc]=size(D);

%% Calibration scheme
%marker to prealign cal 
%D(37,:)=10e9;   %just used to figure out where the cal should be
%considered
PCAL = D;
TCAL = zeros(size(D)); % changed to remove the original from the average (HPM)

%tunable threshould
threshold = 5e9;

%apply a sliding normalization point copy of the skycal
for calpoint = 3:20
  for i = 1:nc
  fact = D(calpoint,i)./average_cal(calpoint);
  PCAL(:,i) = D(:,i) - average_cal .* fact;
  end
TCAL=TCAL+PCAL;
end

%smoothing if you want it
TCAL=imgaussfilt(TCAL,0.5); 

%threshold the sliding cal
map = TCAL<threshold;
TCAL(map)=0;





ix=1:nc; iy=1:nr; d2=d(1:nr);
ix = linspace(1,20,nc);
figure(3);clf
%subplot(1,5,1:3)
%imagesc(ix,d2,TCAL,[0 2e10]); colorbar
imagesc(ix,d2,TCAL,[0 2e10]); colorbar
axis([1 20 0 2.5])
grid on;
%hold on; plot([1500 1500],[0 4],'k-','linewidth',3)
%hold on; plot([700 700],[0 4],'r-','linewidth',4)
%hold on; plot([100 100],[0 4],'g-','linewidth',4)


text(14,1.45,'snow surface','fontsize',24,'fontweight','bold','color','w')
text(5,1.45,'snow surface','fontsize',24,'fontweight','bold','color','w')
text(4,2.15,'ground','fontsize',24,'fontweight','bold','color','w')
text(15,2.37,'ground','fontsize',24,'fontweight','bold','color','w')
%text(400,2.4,'low ground return - off nadir?','fontsize',14,'fontweight','bold','color','w')
%text(1600,1,'up-down','fontsize',18,'fontweight','bold','color','w')
%text(500,1,'~20 meter profile','fontsize',18,'fontweight','bold','color','w')
xlabel('Position [m]'); ylabel('distance from radar in air [m]')
set(gca,'FontSize',30,'LineWidth',3,'FontWeight','bold')
M1=median(D(:,90:110),2); % get median at low point calibration
M2=median(D(:,690:710),2); % get median at high point calibration
%subplot(1,5,4:5)
%plot(M1,d2,'r-','linewidth',3); hold on
%plot(M2,d2,'g-','linewidth',3)
%plot(S,d2,'c-','linewidth',1.5)
%h=legend('high ground return','low ground return','sky calibration')
%set(gca, 'ydir','reverse')
%axis([0 5e9 0 3])
set(gca,'linewidth',2,'fontsize',14)
%title('Median of traces')
%xlabel('power spectral density')
ylabel('distance from radar in air [m]')
set(gca,'FontSize',30,'LineWidth',3,'FontWeight','bold')
text(0.5e9,1.2,'snow surface','fontsize',14,'fontweight','bold','color','g')
text(3e9,1.65,'snow surface','fontsize',14,'fontweight','bold','color','g')
%text(0.5e9,2.3,'ground?','fontsize',14,'fontweight','bold','color','g')
text(0.6e9,1.75,'snow surface','fontsize',14,'fontweight','bold','color','r')
text(3e9,2.1,'ground','fontsize',14,'fontweight','bold','color','r')
