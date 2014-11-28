% Plot Average Standard Deviation of Residual Energy as a function of
% product (m * a)
% File - Fraction_StdRes.mat, m = 0.1, alpha = 1:1:10
load ('Fraction_StdRes.mat');
% figure('Units', 'pixels', 'Position', [100 100 500 375]);
% axis([0 4000 0 100]);
% hold on;
m=0.2;
Max_Run = 5;
Max_Protocol = 5;
Iteration_Max = 10;
for run = 1 : Max_Run
    File_Name_SP = strcat ('C:/Users/RaviHome/Desktop/SEP/Code/Data/Stability Period/', '_', int2str (run), '.txt');    
    File_SP = fopen (File_Name_SP, 'w');
    
    File_Name_AFrac = strcat ('C:/Users/RaviHome/Desktop/SEP/Code/Data/Fraction Of Nodes Cluster Heads/', '_', int2str (run), '.txt');    
    File_AFrac = fopen (File_Name_AFrac, 'w');
    
    File_Name_AveCHE = strcat ('C:/Users/RaviHome/Desktop/SEP/Code/Data/Cluster Head Energy/', '_', int2str (run), '.txt');    
    File_AveCHE = fopen (File_Name_AveCHE, 'w');
        
    File_Name_AveStdResEnergy = strcat ('C:/Users/RaviHome/Desktop/SEP/Code/Data/Standard Deviation Residual Energy/', '_', int2str (run), '.txt');        
    File_AveStdDevResEnergy = fopen (File_Name_AveStdResEnergy, 'w');
    
    m = 0.1;
    
for a = 1 : 10    
        product = m * a;
        fprintf (File_SP, '%f\t',  product);
        fprintf (File_AFrac, '%f\t',  product);
        fprintf (File_AveCHE, '%f\t',  product);
        fprintf (File_AveStdDevResEnergy, '%f\t',  product);
    for protocol = 1 : 5        
        fprintf (File_SP, '%d\t', Stability_Period(protocol, run, a, 1));
        fprintf (File_AFrac, '%f\t', Frac_Advance_Nodes (protocol, a, run, 2) );
        fprintf (File_AveCHE, '%f\t', Average_Cluster_Head_Energy  (protocol, a, run, 2) );
        fprintf (File_AveStdDevResEnergy, '%f\t',Average_Std_Dev_Residual_Energy  (protocol, a, run, 2) );
    end
        fprintf (File_SP, '\r\n');
        fprintf (File_AFrac, '\r\n');
        fprintf (File_AveCHE, '\r\n');
        fprintf (File_AveStdDevResEnergy, '\r\n');
end 

fclose (File_SP);
fclose (File_AFrac);
fclose (File_AveCHE);
fclose (File_AveStdDevResEnergy);

end


    
Final_SP = strcat ('C:/Users/RaviHome/Desktop/SEP/Code/Data/Stability Period/', '_', 'final', '.txt');  
File_SP = fopen (Final_SP, 'w');

Final_File_Name_AFrac = strcat ('C:/Users/RaviHome/Desktop/SEP/Code/Data/Fraction Of Nodes Cluster Heads/', '_', 'final', '.txt');    
Final_File_AFrac = fopen (Final_File_Name_AFrac, 'w');

Final_File_Name_AveCHE = strcat ('C:/Users/RaviHome/Desktop/SEP/Code/Data/Cluster Head Energy/', '_', 'final', '.txt');    
Final_File_AveCHE = fopen (File_Name_AveCHE, 'w');

Final_File_Name_AveStdResEnergy = strcat ('C:/Users/RaviHome/Desktop/SEP/Code/Data/Standard Deviation Residual Energy/', '_', 'final', '.txt');        
Final_File_AveStdDevResEnergy = fopen (Final_File_Name_AveStdResEnergy, 'w');
        
Average_Stability_Period = zeros (Max_Protocol, Iteration_Max, 2);
Average_Cluster_Head_Energy = zeros (Max_Protocol, Iteration_Max, 2);
Average_Std_Res_Energy = zeros (Max_Protocol, Iteration_Max, 2);
Average_A_Frac = zeros (Max_Protocol, Iteration_Max, 2);

for a = 1 : 10
        product = m * a;
        
        
        
        fprintf (File_SP, '%f\t',  product);
        fprintf (Final_File_AFrac, '%f\t',  product);
        fprintf (Final_File_AveCHE, '%f\t',  product);
        fprintf (Final_File_AveStdDevResEnergy, '%f\t',  product);
        for protocol = 1 : 5        
            Average_Stability_Period (protocol, a, 1) = product;
            Average_Stability_Period (protocol, a, 2) = round(mean(Stability_Period(protocol, :, a, 1)));
            
            Average_Cluster_Head_Energy(protocol, a, 1) = product;
            Average_Cluster_Head_Energy(protocol, a, 2) = mean(Frac_Advance_Nodes (protocol, :, run, 2));
            
            Average_Std_Res_Energy(protocol, a, 1) = product;
            Average_Std_Res_Energy(protocol, a, 2) = mean(Average_Cluster_Head_Energy  (protocol, a, :, 2));
            
            Average_A_Frac(protocol, a, 1) = product;
            Average_A_Frac(protocol, a, 2) = mean (Average_Std_Dev_Residual_Energy  (protocol, a, :, 2));
            
            
            fprintf (File_SP, '%d\t', round(mean(Stability_Period(protocol, :, a, 1))));
            fprintf (Final_File_AFrac, '%f\t', mean(Frac_Advance_Nodes (protocol, :, run, 2)));
            fprintf (Final_File_AveCHE, '%f\t', mean(Average_Cluster_Head_Energy  (protocol, a, :, 2)));
            fprintf (Final_File_AveStdDevResEnergy, '%f\t',mean (Average_Std_Dev_Residual_Energy  (protocol, a, :, 2)));
        end
        fprintf (File_SP, '\r\n');
        fprintf (Final_File_AFrac, '\r\n');
        fprintf (Final_File_AveCHE, '\r\n');
        fprintf (Final_File_AveStdDevResEnergy, '\r\n');        
end


        






% Write the Stability Period 
% Write the Average Fraction of CH that are advanced 
% Write the aveCHE 
% Write the AveStdDevResEnergy

% 
% protocol = 1;
% % Simple_LEACH = line (Frac_Advance_Nodes (protocol, :, 1), Frac_Advance_Nodes (protocol, :, 2));
% protocol =  protocol  + 1;
% LEACH = line (Frac_Advance_Nodes (protocol, :, 1), Frac_Advance_Nodes (protocol, :, 2));
% protocol =  protocol  + 1;
% SEP = line (Frac_Advance_Nodes (protocol, :, 1), Frac_Advance_Nodes (protocol, :, 2));
% protocol =  protocol  + 1;
% % FAIR = line (Frac_Advance_Nodes (protocol, :, 1), Frac_Advance_Nodes (protocol, :, 2));
% protocol =  protocol  + 1;
% CRP = line (Frac_Advance_Nodes (protocol, :, 1), Frac_Advance_Nodes (protocol, :, 2));
% 
% % Adjust Line Properties (Functional)
% % set (Simple_LEACH, 'Color', 'Blue');
% set (LEACH, 'Color', 'Red', 'Marker', 's');
% set (SEP, 'Color', 'Blue', 'Marker' , 'd');
% % set (FAIR, 'Color', 'Black', 'LineStyle' , '--');
% set (CRP, 'Color', 'Black', 'Marker', '+');
% 
% % Add Legend and Labels
% hTitle  = title ('Standard Deviation of Residual Energy as a function of m*\alpha');
% hXLabel = xlabel('Product(m*\alpha)'                     );
% hYLabel = ylabel('Standard Deviation of Residual Energy'                      );
% 
% hLegend = legend( ...
%   [LEACH,  SEP, CRP], ...
%   'LEACH' , ...  
%   'SEP'       , ...  
%   'CRP'                , ...
%   'location', 'NorthWest' );
% 
% 
% % Adjusting font and axis properties 
% set([hTitle, hXLabel, hYLabel], ...
%     'FontName'   , 'AvantGarde');
% set([hXLabel, hYLabel]  , ...
%     'FontSize'   , 10          );
% set(gca  , ...
%     'FontSize'   , 10          );
% set(gca, ...
%   'Box'         , 'on'     , ...
%   'TickDir'     , 'out'     , ...
%   'TickLength'  , [.02 .02] , ...
%   'XMinorTick'  , 'off'      , ...
%   'YMinorTick'  , 'off'      , ...
%   'YGrid'       , 'on'      , ...
%   'XGrid'       , 'off', ...
%   'XColor'      , [.3 .3 .3], ...
%   'YColor'      , [.3 .3 .3], ...
%   'LineWidth'   , 1         );
% 
% % Conversion to .eps
% % set(gcf, 'PaperPositionMode', 'auto');
% % print -depsc2 plot_std_product.eps
% % close;
save ('Analyze_Data.mat');
