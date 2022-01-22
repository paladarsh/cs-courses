eps = 1.e-14;
option = input(' ');

x = 1.5 + rand();

count = 0;
while (abs(x*x-3*x+2)>eps)
    if option == 1
        x = (x^2+2)/3;
    elseif option == 2
        x = sqrt(3*x-2); % g2(x) here
    elseif option == 3
        x = 3-2./x;% g3(x) here
    else
        x = (x*x-2)./(2*x-3)%g4(x) here
    end
    count = count + 1;
    error(count) = abs(x-2);
end

for j = 3:count
    p1(j) = error(count)/error(count-1);
    p2(j) = error(count)/(error(count-1))^2;
end

fprintf('\ne(m) =\n');
for j = 1:count
    fprintf('%.2g ',error(j));
end
fprintf('\n');

fprintf('|e(m+1)|/|e(m)| =\n ');
for j = 3:count
    fprintf('%.2g ',p1(j));
end
fprintf('\n');

fprintf('|e(m+1)|/|e(m)|^2 =\n ');
for j = 3:count
    fprintf('%.2g ',p2(j));
end
fprintf('\n');