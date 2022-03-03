function [EJD, DecimalHours] = ElapsedJulianDays(TS)

    Year = TS(:,1); Month = TS(:,2); Day = TS(:,3);
    Hour = TS(:,4); Minute = TS(:,5); Second = TS(:,6);
    DecimalHours = Hour + Minute/60 + Second/3600;
    
    JulianDate = fix( (1461*( Year +4800+ fix(( Month-14)/12) ))/4 ) + ...
        fix( (367 * (Month-2-12*fix((Month-14)/12)))/12 ) - ...
        fix( 3*( fix((Year+4900 + fix((Month-14)/12))/100))/4 ) + ...
        Day - 32075.5 + DecimalHours/24;
    
    % Elapsed Julian Days, since 2000 January 1 at 1200h
    EJD = JulianDate - 2451545.0;
    
end