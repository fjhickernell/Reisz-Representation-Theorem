%% Figure for Riesz Representation Theorm Proof

% kernel(L)

gail.InitializeDisplay

hl = 20;
hw = 20;
lw = 7;
fs = 30;
a = [-3 4 -6];
kernelcoef = a(1:2)/(-a(3));

xx = 0:0.01:1;
[xplot,yplot] = meshgrid(xx);
zplot = xplot*kernelcoef(1) + yplot*kernelcoef(2);

surf(xplot,yplot,zplot)
shading interp
hold on
axis equal

kernallab = text(-0.2,0.5,-0.4,'ker(LINEAR)', ...
    'color','black','FontSize',fs);

set(gca,'LooseInset',get(gca,'TightInset'));
set(gcf,'OuterPosition',[-659 488 420 470])
axis off

print('-depsc','kernelLinear.eps')


sc = -0.1;
sch = 0.15;
arrowstart = [0.5 0.5 0.5*kernelcoef(1) + 0.5*kernelcoef(2)];
garrowext = sc*a;
arrowend = arrowstart + sc*a;
arrowx = 0.5 + [0; sc*a(1)];
arrowy = 0.5 + [0; sc*a(2)];
arrowz = 0.5*kernelcoef(1) + 0.5*kernelcoef(2) + [0; sc*a(3)];
harrowext = sch*[2 3 1];
%h = arrow3(arrowstart,arrowend,'color',MATLABBlue)
gperparrow = quiver3(arrowstart(1),arrowstart(2),arrowstart(3), ...
    garrowext(1), garrowext(2), garrowext(3), ...
    'color',MATLABBlue,'linewidth',5, MaxHeadSize = 0.5);
gperparrowlab = text(0.5,0.2,0.7,'\(\textbf{\textit{g}}_\perp\)','FontSize',30);

print('-depsc','kernelgperp.eps')

harrow = quiver3(arrowstart(1),arrowstart(2),arrowstart(3), ...
    harrowext(1), harrowext(2), harrowext(3), ...
    'color',MATLABOrange,'linewidth',5, MaxHeadSize = 0.5);
hperparrowlab = text(0,0.1,0.7,'\(\textbf{\textit{h}}\)','FontSize',30);

print('-depsc','RieszRepThm.eps')
%exportgraphics(gca,'RieszRepThm.eps')
