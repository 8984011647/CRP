load ('Average_Standard_Deviation_CRP_SEP_LEACH.mat');
figure('Units', 'pixels', 'Position', [100 100 500 375]);
 axis([0 1 0 1.5]);
hold on;

protocol = 1;
% Simple_LEACH = line (Stability_Period (protocol, :, 1), Stability_Period (protocol, :, 2));
% protocol =  protocol  + 1;
LEACH = line (Average_Standard_Deviation (protocol, :, 1), Average_Standard_Deviation (protocol, :, 2));
protocol =  protocol  + 1;
SEP = line (Average_Standard_Deviation (protocol, :, 1), Average_Standard_Deviation (protocol, :, 2));
% protocol =  protocol  + 1;
% FAIR = line (Average_Standard_Deviation (protocol, :, 1), Average_Standard_Deviation (protocol, :, 2));
protocol =  protocol  + 1;
CRP = line (Average_Standard_Deviation (protocol, :, 1), Average_Standard_Deviation (protocol, :, 2));

% Adjust Line Properties (Functional)
% set (Simple_LEACH, 'Color', 'Blue', 'Marker', '');
set (LEACH, 'Color', 'Red', 'Marker', '+');
set (SEP, 'Color', 'Red', 'Marker', '*');
% set (FAIR, 'Color', 'Black', 'LineStyle' , '--', 'Marker', 's');
set (CRP, 'Color', 'Blue', 'Marker', 'o');

% Add Legend and Labels
% hTitle  = title ('number of alive nodes per round');
hXLabel = xlabel('Product (m*\alpha)'                     );
hYLabel = ylabel('Standard Deviation of Residual Energy'                      );

hLegend = legend( ...
  [LEACH, SEP, CRP], ...
  'LEACH    '        ,...
  'SEP      '       , ...
  'FAIR'    , ...
  'CRP      '                , ...
  'location', 'NorthWest' );


% Adjusting font and axis properties 
set([hXLabel, hYLabel], ...
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
  'YTick'       , 0:0.3:1.5, ...
  'XTick'       , 0:0.1:1, ...
  'LineWidth'   , 1         );

% Conversion to .eps
set(gcf, 'PaperPositionMode', 'auto');
print -depsc2 ./SEP_plots/Average_Standard_Deviation.eps
% close;
