% Plot Average Cluster Head Energy and Average Standard Deviation of Residual Energy 
% File - Energy.mat, m = 0.2, alpha = 3
load ('Energy.mat');
figure('Units', 'pixels', 'Position', [100 100 500 375]);
axis([0 2000 0 1]);
hold on;


protocol = 1;
% Simple_LEACH = line (Std_Energy (protocol, 1:100:2000, 1), Std_Energy (protocol, 1:100:4000, 2));
protocol =  protocol  + 1;
% LEACH = line (Std_Energy (protocol, 1:100:4000, 1), Std_Energy (protocol, 1:100:4000, 2));
protocol =  protocol  + 1;
SEP = line (Std_Energy (protocol, 1:100:4000, 1), Std_Energy (protocol, 1:100:4000, 2));
protocol =  protocol  + 1;
% FAIR = line (Std_Energy (protocol, 1:100:4000, 1), Std_Energy (protocol, 1:100:4000, 2));
protocol =  protocol  + 1;
CRP = line (Std_Energy (protocol, 1:100:4000, 1), Std_Energy (protocol, 1:100:4000, 2));

% Adjust Line Properties (Functional)
% set (Simple_LEACH, 'Color', 'Blue');
% set (LEACH, 'Color', 'Red');
set (SEP, 'Color', 'Blue');
% set (FAIR, 'Color', 'Black', 'LineStyle' , '--');
set (CRP, 'Color', 'Black', 'LineStyle' , '-.');

% Add Legend and Labels
hTitle  = title ('Standard Deviation of Residual Energy');
hXLabel = xlabel('number of rounds'                     );
hYLabel = ylabel('Standard Deviation of Residual Energy'                      );

hLegend = legend( ...
  [SEP, CRP], ...
  'SEP         m = 0.2 \alpha= 1'       , ...  
  'CRP         m = 0.2 \alpha= 1'                , ...
  'location', 'NorthEast' );


% Adjusting font and axis properties 
set([hTitle, hXLabel, hYLabel], ...
    'FontName'   , 'AvantGarde');
set([hXLabel, hYLabel]  , ...
    'FontSize'   , 10          );
set(gca  , ...
    'FontSize'   , 10          );
set(gca, ...
  'Box'         , 'on'     , ...
  'TickDir'     , 'out'     , ...
  'TickLength'  , [.02 .02] , ...
  'XMinorTick'  , 'off'      , ...
  'YMinorTick'  , 'off'      , ...
  'YGrid'       , 'on'      , ...
  'XGrid'       , 'off', ...
  'XColor'      , [.3 .3 .3], ...
  'YColor'      , [.3 .3 .3], ...
  'LineWidth'   , 1         );

% Conversion to .eps
set(gcf, 'PaperPositionMode', 'auto');
print -depsc2 stdDevResEnergy.eps
close;
