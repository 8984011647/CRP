% Analyze Stability Period 
% load ('stability_period.mat', 'Stability_Period');
% load ('stability_period2.mat', 'Stability_Period2');
File_Id = fopen ('./Data/finalStability.txt', 'r');
Max_Protocol = 3;
total_iterations = 11;
m = 0.1;

% Calculating the average Stability Period
average_Stability_Period = zeros (total_iterations, Max_Protocol, 2);
A = fscanf(File_Id, '%f %f %f %f', [4 inf]);
A= A';
fclose (File_Id);

for iteration = 1 : total_iterations
    product = m * (iteration-1);    
    for protocol = 1 : Max_Protocol        
        average_Stability_Period (protocol, iteration, 1) = product; 
        average_Stability_Period (protocol, iteration, 2) = A(iteration, protocol+1);        
    end        
end


% % Getting Percentage Gain
% Gain_File_Id = fopen ('Gain_file.txt', 'w');
% Gain = zeros (Max_Protocol, total_iterations, 2);
% for iteration = 1 : total_iterations -1
%     product = m * iteration;
%     fprintf (Gain_File_Id, '%f\t', product);
%     for protocol = 1 : Max_Protocol 
%         Gain (protocol, iteration, 1) = product;
%         Gain (protocol, iteration, 2) =  100 * average_Stability_Period (protocol, iteration, 2) /   average_Stability_Period (protocol, total_iterations, 2);
%         fprintf (Gain_File_Id, '%f\t',  Gain (protocol, iteration, 2));
%     end
%      fprintf (Gain_File_Id, '\r\n');
% end
% fclose (Gain_File_Id);


% Calculting Gain Over Simple LEACH, LEACH, SEP, FAIR



% Code For Plotting The Graph
% load ('.mat');
figure('Units', 'pixels', 'Position', [100 100 500 375]);
% axis([0 4000 0 105]);
hold on;

protocol = 1;
% Simple_LEACH = line (average_Stability_Period (protocol, :, 1), average_Stability_Period (protocol, :, 2));
% protocol =  protocol  + 1;
% LEACH = line (average_Stability_Period (protocol, :, 1), average_Stability_Period (protocol, :, 2));
% protocol =  protocol  + 1;
SEP = line (average_Stability_Period (protocol, :, 1), average_Stability_Period (protocol, :, 2));
protocol =  protocol  + 1;
FAIR = line (average_Stability_Period (protocol, :, 1), average_Stability_Period (protocol, :, 2));
protocol =  protocol  + 1;
CRP = line (average_Stability_Period (protocol, :, 1), average_Stability_Period (protocol, :, 2));

% Adjust Line Properties (Functional)
% set (Simple_LEACH, 'Color', 'Blue');
% set (LEACH, 'Color', 'Red');
set (SEP, 'Color', 'Red', 'Marker', 'o');
set (FAIR, 'Color', 'Black', 'Marker' ,'s');
set (CRP, 'Color', 'Blue', 'Marker', 'd');

% Add Legend and Labels
hTitle  = title ('Length of stable region for different values of heterogeneity');
hXLabel = xlabel('relative total extra energy (\alpha × m)'                     );
hYLabel = ylabel('Length of stable region (in rounds)'                      );

hLegend = legend( ...
  [SEP, FAIR, CRP], ...
  'SEP         m = 0.2 \alpha= 1'     , ...
  'FAIR'    , ...
  'CRP         m = 0.2 \alpha= 1'                , ...
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
  'YTick'       , 0:200:2000, ...
  'XTick'       , 0:0.1:1, ...
  'LineWidth'   , 1         );

% Conversion to .eps
% set(gcf, 'PaperPositionMode', 'auto');
% print -depsc2 stability_period.eps
% close;

