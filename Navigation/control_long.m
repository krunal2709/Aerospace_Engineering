function Long = control_long(Long)

for i = 2:length(Long)
    
        if (i > 1) && ((Long(i)-Long(i - 1)) < -180)    % faccio salto da dx a sx
            Long(i)= NaN;
        elseif (i > 1) && ((Long(i)-Long(i - 1)) > 180) % faccio salto da dx a sx
            Long(i) = NaN;
        end
end
end