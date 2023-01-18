%Functions that are being used
function [Pmin, Pmax] = a2dpower(bits, Vmax)
R = 50; %Nominal Resistance    
Pmax= (Vmax^2)/(2 *R)
Vmin = (Vmax)/ (2^bits)
Pmin = (Vmin^2)/(2 *R)
Pmax = 10 *log10(Pmax/(1e-3))
Pmin = 10 *log10(Pmin/(1e-3))
end





    