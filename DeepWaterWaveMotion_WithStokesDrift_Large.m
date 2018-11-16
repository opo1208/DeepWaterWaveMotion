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

[Ini_ParcelX, Ini_ParcelZ] = meshgrid(-100:2:100, -50:2:0);

DomainX = -200:1:200;

X0 = Ini_ParcelX;
Z0 = Ini_ParcelZ;

for k = [0:1:500]
    
    % Time Step
    t = Delta_T*k;
    
    % Free Surface Elevation
    Surf_Elev = Amplitude*cos(WaveNumber.*DomainX-Freq*t);
    
    % Update X0 and Z0
    X0 = X0 + WaveNumber.*Amplitude^2.*Freq.*t.*exp(2.*WaveNumber.*Z0);
    Z0 = Z0;
    
    % Parcel Motion Distance from the Parcel Centers
    Delta_X = -Amplitude.*exp(WaveNumber.*Z0).*sin(WaveNumber.*X0-Freq.*t) ...
            + WaveNumber.*Amplitude^2.*Freq.*t.*exp(2.*WaveNumber.*Z0);
    Delta_Z = Amplitude.*exp(WaveNumber.*Z0).*cos(WaveNumber.*X0-Freq.*t);

    clf;
    set(gcf,'units','normalized','position',[0.1 0.1 0.9 0.5],'PaperPositionMode','auto'); hold on;
    plot(X0+Delta_X,Z0+Delta_Z,'ko','MarkerSize',3);
    plot(DomainX, Surf_Elev,'b-');
    quiver(X0+Delta_X,Z0+Delta_Z,Delta_X,Delta_Z,0.4,'k-','MaxHeadSize',10.0);
    
    xlim([-100 100]); ylim([-50 2]);
    
    title(['Time = ', num2str(t,'%10.2f'), '(s)'],'fontsize',12);
    xlabel('X (m)','fontsize',14);
    ylabel('Z (m)','fontsize',14);
    ax = gca; ax.FontSize = 12;
    box on; set(gca,'Layer','top');
    
%     pause(1.0)
    
    out_filename = ['dw-stokes-large-' num2str(k,'%06d') '.png'];
    
    print('-dpng',out_filename);
    
end