% Deep-Water Wave Motion without the Stokes Drift
% Created by Yu-Lin Tsai (NCU, Taiwan)

clc; clear; fclose all; close all;

% Physical Parameters
Amplitude = 0.5;
WaveLength = 100.0;
WavePeriod = 10.0;
WaterDepth = 100.0;

% Wave Number
WaveNumber = 2*pi/WaveLength;

% Angular Frequency
Freq = 2*pi/WavePeriod;

% Time Setep
Delta_T = WavePeriod/10;

[Ini_ParcelX, Ini_ParcelZ] = meshgrid(-50:2:50, -10:2:0);

DomainX = -200:1:200;

X0 = Ini_ParcelX;
Z0 = Ini_ParcelZ;

for k = [0:1:300]
    
    % Time Step
    t = Delta_T*k;
    
    % Free Surface Elevation
    Surf_Elev = Amplitude*cos(WaveNumber.*DomainX-Freq*t);
    
    % Parcel Motion Distance from the Parcel Centers
    Delta_X = -Amplitude.*exp(WaveNumber.*Z0).*sin(WaveNumber.*X0-Freq.*t);
    Delta_Z = Amplitude.*exp(WaveNumber.*Z0).*cos(WaveNumber.*X0-Freq.*t);

    clf;
    set(gcf,'units','normalized','position',[0.1 0.1 0.8 0.4],'PaperPositionMode','auto'); hold on;
    plot(X0+Delta_X,Z0+Delta_Z,'ko','MarkerSize',3);
    plot(DomainX, Surf_Elev,'b-');
    quiver(X0+Delta_X,Z0+Delta_Z,Delta_X,Delta_Z,0.4,'k-','MaxHeadSize',10.0);
    
    xlim([-50 50]); ylim([-11 2]);
    
    title(['Time = ', num2str(t,'%7.2f'), '(s)'],'fontsize',12);
    xlabel('X (m)','fontsize',14);
    ylabel('Z (m)','fontsize',14);
    ax = gca; ax.FontSize = 12;
    box on; set(gca,'Layer','top');
    
    out_filename = ['dw-nostokes' num2str(k,'%06d') '.png'];
    
    print('-dpng',out_filename);
    
end
