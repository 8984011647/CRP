load ('Data_Per_Iteration_m2_a1.mat');
figure('Units', 'pixels', 'Position', [100 100 500 375]);
axis([0 1000 0 2]);
hold on;
Norm_value = zeros (1, 7000, 4);
Norm_value (1, :, 2) = Std_Energy (1, :, 1);
count = 0;
for i = 1 : 7000
    if (Std_Energy (3, i, 2) == 0)
        continue;
    end
    count = count + 1;
    Norm_value (1, count, 3) = Std_Energy (5, i, 2) / Std_Energy (3, i, 2);
    Norm_value (1, count, 1) = 1;
end


load ('Data_Per_Iteration_m2_a3.mat');
count =0;
for i = 1 : 7000
    if (Std_Energy (3, i, 2) == 0)
        continue;
    end
    count = count + 1;
    Norm_value (1, count, 4) = Std_Energy (5, i, 2) / Std_Energy (3, i, 2);   
end

Norm_SEP_CRP_m1_a1 = line (Norm_value (1, :, 2), Norm_value (1, :, 3));
Norm_SEP_CRP_m1_a3 = line (Norm_value (1, :, 2), Norm_value (1, :, 4));
Norm_CRP_CRP = line (Norm_value (1, :, 2), Norm_value (1, :, 1));


protocol = 1;
% Simple_LEACH = line (Std_Energy (protocol, :, 1), Std_Energy (protocol, :, 2));
% Simple_LEACH_2 = scatter (Std_Energy (protocol, 500:1000:7000, 1), Std_Energy (protocol, 500:1000:7000, 2),'Marker', 'o', 'MarkerEdgeColor', 'Blue');

protocol =  protocol  + 1;
% LEACH = line (Std_Energy (protocol, :, 1), Std_Energy (protocol, :, 2));
% LEACH_2 = scatter (Std_Energy (protocol, 500:1000:7000, 1), Std_Energy (protocol, 500:1000:7000, 2),'Marker', '+', 'MarkerEdgeColor', 'Red');

protocol =  protocol  + 1;
% SEP = line (Std_Energy (protocol, :, 1), Std_Energy (protocol, :, 2));
% SEP_2 = line (Std_Energy (protocol, 1:50:7000, 1), Std_Energy (protocol, 1:50:7000, 2), 'Color', 'Red');

protocol =  protocol  + 1;
% FAIR = line (Std_Energy (protocol, :, 1), Std_Energy (protocol, :, 2));
% FAIR_2 = scatter (Std_Energy (protocol, 500:1000:7000, 1), Std_Energy (protocol, 500:1000:7000, 2),'Marker', 's', 'MarkerEdgeColor', 'Black');

protocol =  protocol  + 1;
% CRP = line (Std_Energy (protocol, :, 1), Std_Energy (protocol, :, 2));
% CRP_2 = line (Std_Energy (protocol, 1:10:7000, 1), Std_Energy (protocol, 1:10:7000, 2), 'Color', 'Black');
% 
% Adjust Line Properties (Functional)
% set (Simple_LEACH, 'Color', 'Blue', 'LineStyle' , ':');
% set (LEACH, 'Color', 'Red', 'LineStyle' , '-.');
% set (SEP, 'Color', 'Green');
% % set (SEP_2, 'CData', 'Green');
% set (FAIR, 'Color', 'Black', 'LineStyle' , '--');
% set (CRP, 'Color', 'Black');

% Add Legend and Labels
hTitle  = title ('number of alive nodes per round');
hXLabel = xlabel('number of rounds'                     );
hYLabel = ylabel('number of alive nodes'                      );

% hLegend = legend( ...
%   [Simple_LEACH, LEACH, SEP, FAIR, CRP], ...
%   'LEACH       m = 0 \alpha= 0' , ...
%   'LEACH       m = 0.2 \alpha= 1'      , ...
%   'SEP         m = 0.2 \alpha= 1'       , ...
%   'FAIR'    , ...
%   'CRP         m = 0.2 \alpha= 1'                , ...
%   'location', 'NorthEast' );
% 

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

  
%     'YTick'       , 0:10:100, ...
%   'XTick'       , 0:1000:7000, ...
% Conversion to .eps
% set(gcf, 'PaperPositionMode', 'auto');
% print -depsc2 plot_p2_1.eps
% close;
