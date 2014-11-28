load ('Data_m1_p1.mat', 'Fraction_Nodes_Cluster_Heads');
figure('Units', 'pixels', 'Position', [100 100 500 375]);
axis([0 1000 0 2]);
hold on;
Norm_value = zeros (1, 7000, 4);
Norm_value (1, :, 2) = Fraction_Nodes_Cluster_Heads (1, :, 1);
count = 0;
for i = 1 : 7000
    if (Fraction_Nodes_Cluster_Heads (3, i, 2) == 0)
        continue;
    end
    count = count + 1;
    Norm_value (1, count, 3) = Fraction_Nodes_Cluster_Heads (5, i, 2) / Fraction_Nodes_Cluster_Heads (3, i, 2);
    Norm_value (1, count, 1) = 1;
end

% Norm_SEP_CRP = line (Norm_value (1, :, 1), Norm_value (1, :, 2));
% Norm_CRP_CRP = line (Norm_value (1, :, 1), Norm_value (1, :, 3));



load ('Data_m1_p3.mat', 'Fraction_Nodes_Cluster_Heads');
count =0;
for i = 1 : 7000
    if (Fraction_Nodes_Cluster_Heads (3, i, 2) == 0)
        continue;
    end
    count = count + 1;
    Norm_value (1, count, 4) = Fraction_Nodes_Cluster_Heads (5, i, 2) / Fraction_Nodes_Cluster_Heads (3, i, 2);   
end

Norm_SEP_CRP_m1_a1 = line (Norm_value (1, :, 2), Norm_value (1, :, 3));
Norm_SEP_CRP_m1_a3 = line (Norm_value (1, :, 2), Norm_value (1, :, 4));
Norm_CRP_CRP = line (Norm_value (1, :, 2), Norm_value (1, :, 1));



protocol = 1;
% Simple_LEACH = line (Fraction_Nodes_Cluster_Heads (protocol, :, 1), Fraction_Nodes_Cluster_Heads (protocol, :, 2));
% Simple_LEACH_2 = scatter (Fraction_Nodes_Cluster_Heads (protocol, 500:1000:7000, 1), Fraction_Nodes_Cluster_Heads (protocol, 500:1000:7000, 2),'Marker', 'o', 'MarkerEdgeColor', 'Blue');

protocol =  protocol  + 1;
% LEACH = line (Fraction_Nodes_Cluster_Heads (protocol, :, 1), Fraction_Nodes_Cluster_Heads (protocol, :, 2));
% LEACH_2 = scatter (Fraction_Nodes_Cluster_Heads (protocol, 500:1000:7000, 1), Fraction_Nodes_Cluster_Heads (protocol, 500:1000:7000, 2),'Marker', '+', 'MarkerEdgeColor', 'Red');

protocol =  protocol  + 1;
% SEP = line (Fraction_Nodes_Cluster_Heads (protocol, :, 1), Fraction_Nodes_Cluster_Heads (protocol, :, 2));
% SEP_2 = line (Fraction_Nodes_Cluster_Heads (protocol, 1:50:7000, 1), Fraction_Nodes_Cluster_Heads (protocol, 1:50:7000, 2), 'Color', 'Red');

protocol =  protocol  + 1;
% FAIR = line (Fraction_Nodes_Cluster_Heads (protocol, :, 1), Fraction_Nodes_Cluster_Heads (protocol, :, 2));
% FAIR_2 = scatter (Fraction_Nodes_Cluster_Heads (protocol, 500:1000:7000, 1), Fraction_Nodes_Cluster_Heads (protocol, 500:1000:7000, 2),'Marker', 's', 'MarkerEdgeColor', 'Black');

protocol =  protocol  + 1;
% CRP = line (Fraction_Nodes_Cluster_Heads (protocol, :, 1), Fraction_Nodes_Cluster_Heads (protocol, :, 2));
% CRP_2 = line (Fraction_Nodes_Cluster_Heads (protocol, 1:10:7000, 1), Fraction_Nodes_Cluster_Heads (protocol, 1:10:7000, 2), 'Color', 'Black');
% 
% Adjust Line Properties (Functional)
set (Norm_SEP_CRP_m1_a1, 'Color', 'Blue', 'LineStyle' , '-');
set (Norm_SEP_CRP_m1_a3, 'Color', 'Black', 'LineStyle' , '-.');
set (Norm_CRP_CRP, 'Color', 'Red', 'LineStyle' , '-.');
% set (SEP, 'Color', 'Green');
% % set (SEP_2, 'CData', 'Green');
% set (FAIR, 'Color', 'Black', 'LineStyle' , '--');
% set (CRP, 'Color', 'Black');

% Add Legend and Labels
% hTitle  = title ('Comparison of Standard Deviation of Residual Energy');
hXLabel = xlabel('Number of Rounds'                     );
hYLabel = ylabel('Normalized Cluster Head Energy'                      );

hLegend = legend( ...
  [Norm_SEP_CRP_m1_a1, Norm_SEP_CRP_m1_a3, Norm_CRP_CRP], ...
  'CRP:SEP    m=1, \alpha=1   ' , ...
  'CRP:SEP    m=1, \alpha=3   ' , ...
  'SEP       '      , ...
  'location', 'NorthEast');
%   'SEP         m = 0.2 \alpha= 1'       , ...
%   'FAIR'    , ...
%   'CRP         m = 0.2 \alpha= 1'                , ...
%   'location', 'NorthEast' );
% 

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
  'LineWidth'   , 1         );

  
%     'YTick'       , 0:10:100, ...
%   'XTick'       , 0:1000:7000, ...
% Conversion to .eps
% set(gcf, 'PaperPositionMode', 'auto');
% print -depsc2 ./SEP_plots/SEP_Normalized_CRP.eps
% close;
