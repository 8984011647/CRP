% Plot Average Standard Deviation of Residual Energy as a function of
% product (m * a)
% File - Fraction_StdRes.mat, m = 0.1, alpha = 1:1:10
load ('Fraction_StdRes.mat');
figure('Units', 'pixels', 'Position', [100 100 500 375]);
% axis([0 4000 0 100]);
hold on;


protocol = 1;
% Simple_LEACH = line (Average_Std_Dev_Residual_Energy (protocol, :, 1), Average_Std_Dev_Residual_Energy (protocol, :, 2));
protocol =  protocol  + 1;
LEACH = line (Average_Std_Dev_Residual_Energy (protocol, :, 1), Average_Std_Dev_Residual_Energy (protocol, :, 2));
protocol =  protocol  + 1;
SEP = line (Average_Std_Dev_Residual_Energy (protocol, :, 1), Average_Std_Dev_Residual_Energy (protocol, :, 2));
protocol =  protocol  + 1;
% FAIR = line (Average_Std_Dev_Residual_Energy (protocol, :, 1), Average_Std_Dev_Residual_Energy (protocol, :, 2));
protocol =  protocol  + 1;
CRP = line (Average_Std_Dev_Residual_Energy (protocol, :, 1), Average_Std_Dev_Residual_Energy (protocol, :, 2));

% Adjust Line Properties (Functional)
% set (Simple_LEACH, 'Color', 'Blue');
set (LEACH, 'Color', 'Red', 'Marker', 's');
set (SEP, 'Color', 'Blue', 'Marker' , 'd');
% set (FAIR, 'Color', 'Black', 'LineStyle' , '--');
set (CRP, 'Color', 'Black', 'Marker', '+');

% Add Legend and Labels
hTitle  = title ('Standard Deviation of Residual Energy as a function of m*\alpha');
hXLabel = xlabel('Product(m*\alpha)'                     );
hYLabel = ylabel('Standard Deviation of Residual Energy'                      );

hLegend = legend( ...
  [LEACH,  SEP, CRP], ...
  'LEACH' , ...  
  'SEP'       , ...  
  'CRP'                , ...
  'location', 'NorthWest' );


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
print -depsc2 plot_std_product.eps
close;
