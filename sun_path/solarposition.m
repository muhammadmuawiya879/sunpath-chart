function PSAplus = solarposition(TS, Lat, Long)

% Evaluate Julian Date and Elapsed Julian Days
[EJD, DecimalHours] = ElapsedJulianDays(TS);

%---------------------------------------------------------%
% % % Sun's Position to High Accuracy [PSA Algorithm] % % %
%---------------------------------------------------------%

% Ecliptic Coordinates
dOmega =  2.267127827e+00 - 9.300339267e-04*EJD;
dMeanLongitude = 4.895036035e+00 + 1.720279602e-02*EJD; 
dMeanAnomaly = 6.239468336e+00 + 1.720200135e-02*EJD;

% Ecliptic longitude
PSAplus.ELong = dMeanLongitude + 3.338320972e-02*sin( dMeanAnomaly ) ...
    + 3.497596876e-04 * sin( 2*dMeanAnomaly ) - 1.544353226e-04 ...
    - 8.689729360e-06*sin( dOmega );
PSAplus.ELong_deg = PSAplus.ELong * 180/pi;

% Ecliptic Obliquity
PSAplus.EObl = 4.090904909e-01 - 6.213605399e-09*EJD + ...
    4.418094944e-05*cos(dOmega);
PSAplus.EObl_deg = PSAplus.EObl * 180/pi;

% Celestial coordinates
% Right ascension and declination
dY1 = cos( PSAplus.EObl ) .* sin( PSAplus.ELong );
dX1 = cos( PSAplus.ELong );
PSAplus.RightAscension = atan2( dY1, dX1);
ind = find(PSAplus.RightAscension < 0);
PSAplus.RightAscension(ind) = PSAplus.RightAscension(ind) + 2*pi;
PSAplus.Declination = asin( sin( PSAplus.EObl ) .* sin( PSAplus.ELong ) );

% Topocentric coordinates
% Greenwich and Local sidereal time, Hour angle
dGreenwichMeanSiderealTime = 6.697096103e+00 + 6.570984737e-02*EJD + DecimalHours;
dLocalMeanSiderealTime = ( dGreenwichMeanSiderealTime*15+Long )*pi/180;
PSAplus.HourAngle = dLocalMeanSiderealTime - PSAplus.RightAscension;

% Local coordinates
PSAplus.Zenith_rad = (acos( cos(Lat*pi/180)*cos( PSAplus.HourAngle ).*cos( PSAplus.Declination ) + ...
    sin( PSAplus.Declination )*sin(Lat*pi/180)));
dY2 = -sin(PSAplus.HourAngle);
dX2 = tan( PSAplus.Declination) * cos( Lat*pi/180 ) - sin(Lat*pi/180)*cos(PSAplus.HourAngle);
PSAplus.Azimuth_rad = atan2(dY2, dX2);
ind = find(PSAplus.Azimuth_rad < 0);
PSAplus.Azimuth_rad(ind) = PSAplus.Azimuth_rad(ind) + 2*pi;

% Parallax correction
PSAplus.Zenith_rad = PSAplus.Zenith_rad + 6371.01/149597870.7 * sin(PSAplus.Zenith_rad);

% convert to degrees
PSAplus.Zenith = rad2deg(PSAplus.Zenith_rad);
PSAplus.Azimuth = rad2deg(PSAplus.Azimuth_rad);

end
