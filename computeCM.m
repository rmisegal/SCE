function CM = computeCM(Y,predictY)

if ~all(isvector(Y),isvector(predictY))
    errordlg('one of the inputs, or maybe boths, is not vector', 'error 1');
    return;
end
if ~all(size(Y) == size(predictY))
    errordlg('the two inputs are not equal', 'error 2');
    return;
end
numoflabels = max(Y);
s=max(size(Y));
CM = zeros(numoflabels);
for i=1:s
   CM(Y(i),predictY(i)) = CM(Y(i),predictY(i)) +1;
end
end