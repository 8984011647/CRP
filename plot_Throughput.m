% Code to plot Throughput - From Leaf To Cluster Heads
load ('Throughput.mat');
figure('Units', 'pixels', 'Position', [100 100 500 375]);
axis([0 6000 0 410]);
hold on;

protocol = 1;
Simple_LEACH = line (Throughput (protocol, :, 1), Throughput (protocol, :, 2) + Throughput (protocol, :, 3));
protocol =  protocol  + 1;
LEACH = line (Throughput (protocol, :, 1), Throughput (protocol, :, 2) +Throughput (protocol, :, 3));
protocol =  protocol  + 1;
SEP = line (Throughput (protocol, :, 1), Throughput (protocol, :, 2) +Throughput (protocol, :, 3));
protocol =  protocol  + 1;
FAIR = line (Throughput (protocol, :, 1), Throughput (protocol, :, 2) +Throughput (protocol, :, 3));
protocol =  protocol  + 1;
CRP = line (Throughput (protocol, :, 1), Throughput (protocol, :, 2) +Throughput (protocol, :, 3));

% Adjust Line Properties (Functional)
set (Simple_LEACH, 'Color', 'Blue');
set (LEACH, 'Color', 'Red');
set (SEP, 'Color',  'Magenta', 'LineStyle', '-.');
set (FAIR, 'Color', 'Black', 'LineStyle' , '--');
set (CRP, 'Color', 'Black');

% Add Legend and Labels
hTitle  = title ('Throughput of the Network');
hXLabel = xlabel('number of rounds'                     );
hYLabel = ylabel('Throughput in Kbits'                      );

hLegend = legend( ...
  [Simple_LEACH, LEACH, SEP, FAIR, CRP], ...
  'LEACH       m = 0 \alpha= 0' , ...
  'LEACH       m = 0.2 \alpha= 1'      , ...
  'SEP         m = 0.2 \alpha= 1'       , ...
  'FAIR'    , ...
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
  'YTick'       , 0:100:500, ...
  'XTick'       , 0:1000:6000, ...
  'LineWidth'   , 1         );

% Conversion to .eps
set(gcf, 'PaperPositionMode', 'auto');
print -depsc2 Throughput.eps
close;
