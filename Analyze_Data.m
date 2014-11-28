% Plot Average Standard Deviation of Residual Energy as a function of
% product (m * a)
% File - Fraction_StdRes.mat, m = 0.1, alpha = 1:1:10
load ('Fraction_StdRes_2.mat');
% figure('Units', 'pixels', 'Position', [100 100 500 375]);
% axis([0 4000 0 100]);
% hold on;
m=0.2;
Max_Run = 3;
Max_Protocol = 5;
Iteration_Max = 10;
for run = 1 : Max_Run
    File_Name_SP = strcat ('C:/Users/RaviHome/Desktop/SEP/Code/Data/Stability Period/data', '_', int2str (run), '.txt');    
    File_SP = fopen (File_Name_SP, 'w');
    
    File_Name_AFrac = strcat ('C:/Users/RaviHome/Desktop/SEP/Code/Data/Fraction Of Nodes Cluster Heads/data', '_', int2str (run), '.txt');    
    File_AFrac = fopen (File_Name_AFrac, 'w');
    
    File_Name_AveCHE = strcat ('C:/Users/RaviHome/Desktop/SEP/Code/Data/Cluster Head Energy/data', '_', int2str (run), '.txt');    
    File_AveCHE = fopen (File_Name_AveCHE, 'w');
        
    File_Name_AveStdResEnergy = strcat ('C:/Users/RaviHome/Desktop/SEP/Code/Data/Standard Deviation Residual Energy/data', '_', int2str (run), '.txt');        
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


    
Final_SP = strcat ('C:/Users/RaviHome/Desktop/SEP/Code/Data/Stability Period/data', '_', 'final', '.txt');  
File_SP = fopen (Final_SP, 'w');

Final_File_Name_AFrac = strcat ('C:/Users/RaviHome/Desktop/SEP/Code/Data/Fraction Of Nodes Cluster Heads/data', '_', 'final', '.txt');    
Final_File_AFrac = fopen (Final_File_Name_AFrac, 'w');

Final_File_Name_AveCHE = strcat ('C:/Users/RaviHome/Desktop/SEP/Code/Data/Cluster Head Energy/data', '_', 'final', '.txt');    
Final_File_AveCHE = fopen (Final_File_Name_AveCHE, 'w');

Final_File_Name_AveStdResEnergy = strcat ('C:/Users/RaviHome/Desktop/SEP/Code/Data/Standard Deviation Residual Energy/data', '_', 'final', '.txt');        
Final_File_AveStdDevResEnergy = fopen (Final_File_Name_AveStdResEnergy, 'w');
        
Average_Stability_Period = zeros (Max_Protocol, Iteration_Max, 2);
Average_Cluster_Head_Energy_Mean = zeros (Max_Protocol, Iteration_Max, 2);
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
            
            Average_Cluster_Head_Energy_Mean(protocol, a, 1) = product;
            Average_Cluster_Head_Energy_Mean(protocol, a, 2) = mean(Average_Cluster_Head_Energy (protocol, a, :, 2));
            
            Average_Std_Res_Energy(protocol, a, 1) = product;
            Average_Std_Res_Energy(protocol, a, 2) = mean(Average_Std_Dev_Residual_Energy  (protocol, a, :, 2));
            
            Average_A_Frac(protocol, a, 1) = product;
            Average_A_Frac(protocol, a, 2) = mean (Frac_Advance_Nodes  (protocol, a, :, 2));
            
            
            fprintf (File_SP, '%d\t', round(mean(Stability_Period(protocol, :, a, 1))));
            fprintf (Final_File_AFrac, '%f\t',  Average_A_Frac(protocol, a, 2));
            fprintf (Final_File_AveCHE, '%f\t', Average_Cluster_Head_Energy_Mean (protocol, a, 2));
            fprintf (Final_File_AveStdDevResEnergy, '%f\t', Average_Std_Res_Energy(protocol, a, 2));
            
        end
        fprintf (File_SP, '\r\n');
        fprintf (Final_File_AFrac, '\r\n');
        fprintf (Final_File_AveCHE, '\r\n');
        fprintf (Final_File_AveStdDevResEnergy, '\r\n');        
end

save ('Analyze_Data_mp2.mat');
