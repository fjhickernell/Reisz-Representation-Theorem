%% Figure to show dot product

gail.InitializeDisplay

hl = 20;
hw = 20;
lw = 7;
fs = 40;
offx = 0;
offy = 0;
endfx = 1;
endfy = 1;
endhx = 0.7;
endhy = 0.35;

theta1 = atan((endfy-offy)/(endfx-offx));
theta2 = atan((endhy-offy)/(endhx-offx));
rotangle = 90*(theta1+theta2)/pi;
theta = theta1 + (0:0.001:1)'*(theta2-theta1);
r = 0.25;
arc = [offx offy] + r*[cos(theta) sin(theta)];
plot(arc(:,1),arc(:,2),'k','linewidth',4)
axis([0 1 0 1])
anglelab1 = text(0.2,0.2,char(8737),'interpreter','none', ...
    'color','black','FontSize',60,'rotation',25);
anglelab2 = text(0.275,0.21,'\((\textbf{\textit{f}},\textbf{\textit{h}})\)', ...
    'color','black','FontSize',25,'rotation',25);

fvec = annotation('arrow',[offx endfx],[offy endfy], ...
    'linewidth',lw,'color',MATLABBlue, ...
    'headlength',hl,'headwidth',hw);
fvec.Parent = gca;
flab = text(0.45,0.6,'\(\textbf{\textit{f}}\)', ...
    'color','black','FontSize',fs);

hvec = annotation('arrow',[offx endhx],[offy endhy], ...
    'linewidth',lw,'color',MATLABBlue, ...
    'headlength',hl,'headwidth',hw);
hvec.Parent = gca;
hlab = text(0.4,0.07,'\(\textbf{\textit{h}}\)', ...
    'color','black','FontSize',fs);

fmhvec = annotation('arrow',[endhx endfx],[endhy endfy], ...
    'linewidth',lw,'color',MATLABBlue, ...
    'headlength',hl,'headwidth',hw);
fmhvec.Parent = gca;
fmhlab = text(0.85,0.5,'\(\textbf{\textit{f}} - \textbf{\textit{h}}\)', ...
    'color','black','FontSize',fs);


axis off

print('-depsc','fhfmh.eps')


