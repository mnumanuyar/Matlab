%%

figHandles = findobj('Type', 'figure');
for i = 1: size(figHandles,1)
    saveas(figHandles(i), [int2str(i) '.jpg'])
end
close all