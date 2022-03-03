clc;
clear;
close all;

% Define location
Lat = 45.3;            % [degrees]
Long = -75.7;          % [degrees]

Month = [12 1 11 2 10 3 9 4 8 5 7 6];
Day = [10 17 14 16 15 16 15 15 16 15 17 11];

for i=1:12
    
hour = (0:0.5:24)'; % hours in a Day
temp = ones(size(hour));
% Time vector in the order Year,Month, Day, hour, minute, second
TS = [2020*temp, Month(i)*temp, Day(i)*temp, hour, 0*temp, 0*temp];
SP = solarposition(TS, Lat, Long);
% Plot elevation angle = 90-Zenith Angle
plot(SP.Azimuth-180, 90-SP.Zenith,'k'); 
hold on;

end

xlabel('Solar Azimuth Angle');
ylabel('Solar Altitude Angle');
title('Solar Position Chart');
ylim([0 90]);
grid on;

%END