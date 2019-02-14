function [F] = newton(X,Y)
    if length(Y) == 2
      F = (Y(2)-Y(1))/(X(2)-X(1));
    else
      F = (newton(X(2:end),Y(2:end))-newton(X(1:end-1),Y(1:end-1)))/(X(end)-X(1));
    end
end

    
    

