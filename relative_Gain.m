% Analyze Stability Period 
% load ('stability_period.mat', 'Stability_Period');
% load ('stability_period2.mat', 'Stability_Period2');
File_Id = fopen ('./Data/finalStability.txt', 'r');
Max_Protocol = 3;
total_iterations = 11;
m = 0.1;

% Calculating the average Stability Period
average_Stability_Period = zeros (Max_Protocol, total_iterations,  2);
A = fscanf(File_Id, '%f %f %f %f', [4 inf]);
% A= A';
fclose (File_Id);

for iteration = 1 : total_iterations
    product = m * (iteration-1);    
    for protocol = 1 : Max_Protocol        
        average_Stability_Period (protocol, iteration, 1) = product; 
        average_Stability_Period (protocol, iteration, 2) = A(protocol+1, iteration);        
    end        
end


% % Getting Percentage Gain
% Gain_File_Id = fopen ('Gain_file.txt', 'w');
% Gain = zeros (Max_Protocol, total_iterations, 2);
% for iteration = 1 : total_iterations 
%     product = m * iteration;
%     fprintf (Gain_File_Id, '%f\t', product);
%     for protocol = 1 : Max_Protocol 
%         Gain (protocol, iteration, 1) = product;
%         Gain (protocol, iteration, 2) =  100 * (average_Stability_Period (protocol, iteration, 2)- average_Stability_Period (protocol, 1, 2)) /   (average_Stability_Period (protocol, total_iterations, 2)-average_Stability_Period (protocol, 1, 2));
%         fprintf (Gain_File_Id, '%f\t',  Gain (protocol, iteration, 2));
%     end
%      fprintf (Gain_File_Id, '\r\n');
% end
% fclose (Gain_File_Id);


% Calculting Gain Over (1) SEP, FAIR (2) CRP, FAIR, (3) CRP,SEP

% Relative_Gain_File_Id = fopen ('Relative_Gain_file.txt', 'w');
Gain = zeros (Max_Protocol, total_iterations, 2);
for iteration = 1 : total_iterations 
    product = m * (iteration-1);
%     fprintf (Gain_File_Id, '%g\t', product);
    for protocol = 1 : Max_Protocol 
        Gain (protocol, iteration, 1) = product;
        if (protocol == 1)
            Gain (protocol, iteration, 2) =  100 * (average_Stability_Period (1, iteration, 2)- average_Stability_Period (2, iteration, 2)) /   average_Stability_Period (2, iteration, 2);
        else if (protocol == 2)
                Gain (protocol, iteration, 2) =  100 * (average_Stability_Period (3, iteration, 2)- average_Stability_Period (2, iteration, 2)) /   average_Stability_Period (2, iteration, 2);
            else
                Gain (protocol, iteration, 2) =  100 * (average_Stability_Period (3, iteration, 2)- average_Stability_Period (1, iteration, 2)) /   average_Stability_Period (1, iteration, 2);
            end
        end
%         fprintf (Gain_File_Id, '%f\t',  Gain (protocol, iteration, 2));
    end
%      fprintf (Gain_File_Id, '\r\n');
end
% fclose (Gain_File_Id);



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
SEP = line (Gain (protocol, :, 1), Gain (protocol, :, 2));
protocol =  protocol  + 1;
FAIR = line (Gain (protocol, :, 1), Gain (protocol, :, 2));
protocol =  protocol  + 1;
CRP = line (Gain (protocol, :, 1), Gain (protocol, :, 2));

% Adjust Line Properties (Functional)
% set (Simple_LEACH, 'Color', 'Blue');
% set (LEACH, 'Color', 'Red');
set (SEP, 'Color', 'Red', 'Marker', 'o');
set (FAIR, 'Color', 'Black', 'Marker' , 's');
set (CRP, 'Color', 'Blue', 'Marker', 'd');

% Add Legend and Labels
hTitle  = title ('Percentage of Stable Region Gain between two protocols for different values of heterogeneity');
hXLabel = xlabel('relative total extra energy (\alpha � m)'                     );
hYLabel = ylabel('Percentage of Stable Region Gain between two protocols (in rounds)'                      );

hLegend = legend( ...
  [SEP, FAIR, CRP], ...
  '%Gain(SEP,FAIR)'     , ...
  '%Gain(CRP,FAIR)'    , ...
  '%Gain(CRP,SEP)'                , ...
  'location', 'SouthWest' );


% Adjusting font and axis properties 
set([hTitle, hXLabel, hYLabel], ...
    'FontName'   , 'AvantGarde');
set([hYLabel, hTitle]  , ...
    'FontSize'   , 7          );
set(hXLabel  , ...
    'FontSize'   , 10          );
set(gca  , ...
    'FontSize'   , 8          );
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
  'YTick'       , -50:10:50, ...
  'XTick'       , 0:0.1:1, ...
  'LineWidth'   , 1         );

% Conversion to .eps
set(gcf, 'PaperPositionMode', 'auto');
print -depsc2 relativeGain.eps
close;

