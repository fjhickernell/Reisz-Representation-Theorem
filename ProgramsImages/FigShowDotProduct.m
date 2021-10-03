%% Figure to show dot product

gail.InitializeDisplay

hl = 20;
hw = 20;
lw = 7;
fs = 40;

fvec = annotation('arrow',[0.1 0.9],[0.1,0.9], ...
    'linewidth',lw,'color',MATLABBlue, ...
    'headlength',hl,'headwidth',hw);
flab = text(0.45,0.6,'\(\textbf{\textit{f}}\)', ...
    'color',MATLABBlue,'FontSize',fs);

hvec = annotation('arrow',[0.1 0.7],[0.1,0.35], ...
    'linewidth',lw,'color',MATLABBlue, ...
    'headlength',hl,'headwidth',hw);
hlab = text(0.4,0.07,'\(\textbf{\textit{h}}\)', ...
    'color',MATLABBlue,'FontSize',fs);

fmhvec = annotation('arrow',[0.7 0.9],[0.35,0.9], ...
    'linewidth',lw,'color',MATLABBlue, ...
    'headlength',hl,'headwidth',hw);
fmhlab = text(0.85,0.5,'\(\textbf{\textit{f}} - \textbf{\textit{h}}\)', ...
    'color',MATLABBlue,'FontSize',fs);

axis off

print('-depsc','fhfmh.eps')


