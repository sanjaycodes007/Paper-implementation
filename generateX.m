function [X,stop] = generateX(Y,index,signz)
n = size(Y,1);
X = Y;
for i = 1:n
    z = Y(i,index{i});
    if isequal(sign(z),signz{i})
        if i == n
            stop = 1;
        end
    elseif isequal(-sign(z),signz{i})
        X(i,:) = -Y(i,:);
        if i == n
            stop = 1;
        end
    else
        stop = 0;
        break;
    end    
end
