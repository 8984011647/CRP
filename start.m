% The code commences here 
% protocol = 1 : Simple-LEACH, 2 : LEACH, 3 :SEP,  4 :FAIR, 5 :RCP
Round_Max = 7000;
Max_Protocol = 5;
Number_Nodes_Alive = zeros (Max_Protocol, Round_Max, 2);
total_iterations = 11;
total_Runs = 5;
Stability_Period = zeros (Max_Protocol, total_Runs, total_iterations, 1);
m = 0.1;
% a = 3;
Throughput = zeros (Max_Protocol, Round_Max, 3);
CH_Energy = zeros (Max_Protocol, Round_Max, 2);
Std_Energy = zeros (Max_Protocol, Round_Max, 2);
Fraction_Nodes_Cluster_Heads = zeros (Max_Protocol, Round_Max, 2);
Average_Cluster_Head_Energy = zeros (Max_Protocol, total_iterations, total_Runs, 2);
Average_Std_Dev_Residual_Energy = zeros (Max_Protocol, total_iterations, total_Runs, 2);
Frac_Advance_Nodes = zeros (Max_Protocol, total_iterations, total_Runs, 2);
Efs=10*0.000000000001;
Emp=0.0013*0.000000000001;
Num_Nodes_Initial = 900;
Num_Nodes = Num_Nodes_Initial;
M = 300;
DtoBS = 0.765*M/2;
Popt = (sqrt(Num_Nodes * Efs / (2*pi*Emp)) * (M/DtoBS^2))/ (Num_Nodes) ;

for run = 2 : total_Runs    
    run
    File_Path = 'C:/Users/RaviHome/Desktop/SEP/Code/Data/LargeField/'; 
    File_Name_SP = strcat (File_Path, 'data_SP_', int2str(run), '.txt');
    File_Name_CHE = strcat (File_Path, 'data_CHE_', int2str(run), '.txt');
    File_Name_STD = strcat (File_Path, 'data_STD_', int2str(run), '.txt');
    File_Name_Fraction = strcat (File_Path, 'data_Fraction_', int2str(run), '.txt');
    
    File_SP = fopen (File_Name_SP, 'w');
    File_CHE = fopen (File_Name_CHE, 'w');
    File_STD = fopen (File_Name_STD, 'w');
    File_Fraction = fopen (File_Name_Fraction, 'w');
    
for iteration_Number = 1: total_iterations
    a = iteration_Number-1;
    product = m * a;
    Num_Nodes = (iteration_Number-1) * step + Num_Nodes_Initial;
%     iteration_Number
    
    fprintf (File_SP, '%f\t', product);
    fprintf (File_CHE, '%f\t', product);
    fprintf (File_STD, '%f\t', product);
    fprintf (File_Fraction, '%f\t', product);
    
for protocol = 3 : 3
%     protocol
    Average_Cluster_Head_Energy (protocol, iteration_Number, run, 1) = m * a;
    Average_Std_Dev_Residual_Energy (protocol, iteration_Number, run, 1) = m * a;
    Frac_Advance_Nodes (protocol, iteration_Number, run, 1) = m * a;
    switch protocol
        case 1
%             continue;
            [nodesAlive, Stability_Period(protocol, run, iteration_Number, 1), Throughput(protocol, :, :), ch_Energy, std_Energy, ache, sdre, frac, frac_cluster_head] = run_LEACH (0 , 0,  Num_Nodes, Popt);                                 
%             fprintf (File_Id, '%f\t%d\t', product, Stability_Period (protocol, run, iteration_Number, 1));
%             plot (Number_Nodes_Alive (protocol, :, 1), Number_Nodes_Alive (protocol, :, 2), 'red');
%             hold on;            
        case 2
%             continue;
            [nodesAlive, Stability_Period(protocol, run, iteration_Number, 1), Throughput(protocol, :, :), ch_Energy, std_Energy, ache, sdre, frac, frac_cluster_head] = run_LEACH (m , a, Num_Nodes, Popt);
%             fprintf (File_Id, '%d\t', Stability_Period (protocol, run, iteration_Number, 1));
%             plot (Number_Nodes_Alive (protocol, :, 1), Number_Nodes_Alive (protocol, :, 2), 'red');
%             hold on;            
        case 3
%             continue;
            [nodesAlive, Stability_Period(protocol, run, iteration_Number, 1), Throughput(protocol, :, :), ch_Energy, std_Energy, ache, sdre, frac, frac_cluster_head] = run_SEP (m , a, Num_Nodes, Popt);
%             fprintf (File_Id, '%d\t', Stability_Period (protocol, run, iteration_Number, 1));
%             plot (Number_Nodes_Alive (protocol, :, 1), Number_Nodes_Alive (protocol, :, 2), 'red');
%             hold on;
        case 4 
%             continue;
            [nodesAlive, Stability_Period(protocol, run, iteration_Number, 1), Throughput(protocol, :, :), ch_Energy, std_Energy, ache, sdre, frac, frac_cluster_head] = run_FAIR (m , a, Num_Nodes, Popt);
%             fprintf (File_Id, '%d\t', Stability_Period (protocol, run, iteration_Number, 1));
%             plot (Number_Nodes_Alive (protocol, :, 1), Number_Nodes_Alive (protocol, :, 2), 'green');
%             hold on;            
        case 5
%             continue;
            [nodesAlive, Stability_Period(protocol, run, iteration_Number, 1), Throughput(protocol, :, :), ch_Energy, std_Energy, ache, sdre, frac, frac_cluster_head] = run_CRP (m , a, Num_Nodes, Popt);
%             fprintf (File_Id, '%d\r\n', Stability_Period (protocol, run, iteration_Number, 1));
%             plot (Number_Nodes_Alive (protocol, :, 1), Number_Nodes_Alive (protocol, :, 2), 'blue');            
    end
            CH_Energy (protocol, :, :) = ch_Energy (:, :);
            Std_Energy(protocol,:, :) = std_Energy (:, :);
            Fraction_Nodes_Cluster_Heads(protocol,:, :) = frac_cluster_head (:, :); 
            Number_Nodes_Alive (protocol, :, :) = nodesAlive (:, :);
            
            Average_Cluster_Head_Energy (protocol, iteration_Number, run, 2) = ache;
            Average_Std_Dev_Residual_Energy (protocol, iteration_Number, run, 2) = sdre;
            Frac_Advance_Nodes (protocol, iteration_Number, run, 2) = frac;
            
            
            fprintf (File_SP, '%d\t', Stability_Period(protocol, run, iteration_Number, 1));
            fprintf (File_CHE, '%f\t', ache);
            fprintf (File_STD, '%f\t', sdre);
            fprintf (File_Fraction, '%f\t', frac);
    
end
fprintf (File_SP, '\r\n');
fprintf (File_CHE, '\r\n');
fprintf (File_STD, '\r\n');
fprintf (File_Fraction, '\r\n');
end
fclose (File_SP);
fclose (File_CHE);
fclose (File_STD);
fclose (File_Fraction);
% save('stability_period.mat');
% fclose (File_Id);
end
save('Large_Field_Data.mat');