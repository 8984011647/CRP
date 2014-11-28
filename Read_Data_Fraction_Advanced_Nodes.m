% Read fraction of advanced nodes as cluster heads
% Reading data for plotting the stability period 
File_CRP = fopen ('C:/Users/RaviHome/Desktop/SEP/Code/Data/Fraction Of Nodes Cluster Heads/data_final_CRP.txt', 'r');
File_SEP = fopen ('C:/Users/RaviHome/Desktop/SEP/Code/Data/Fraction Of Nodes Cluster Heads/data_final_SEP.txt', 'r');
% File_FAIR = fopen ('C:/Users/RaviHome/Desktop/SEP/Code/Data/Fraction Of Nodes Cluster Heads/data_final_FAIR.txt', 'r');
File_LEACH = fopen ('C:/Users/RaviHome/Desktop/SEP/Code/Data/Fraction Of Nodes Cluster Heads/data_final_LEACH.txt', 'r');

A = fscanf (File_CRP, '%f %f', [2 inf]);
A = A';
Fraction_Advanced_Nodes = zeros (3, 11, 2);
Fraction_Advanced_Nodes (3, :, 1) = A(:,1);
Fraction_Advanced_Nodes (3, :, 2) = A(:,2);

A = fscanf (File_SEP, '%f %f', [2 inf]);
A = A';
Fraction_Advanced_Nodes (2, :, 1) = A(:,1);
Fraction_Advanced_Nodes (2, :, 2) = A(:,2);

% 
% A = fscanf (File_FAIR, '%f %f', [2 inf]);
% A = A';
% Fraction_Advanced_Nodes (3, :, 1) = A(:,1);
% Fraction_Advanced_Nodes (3, :, 2) = A(:,2);


A = fscanf (File_LEACH, '%f %f', [2 inf]);
A = A';
Fraction_Advanced_Nodes (1, :, 1) = A(:,1);
Fraction_Advanced_Nodes (1, :, 2) = A(:,2);


fclose (File_CRP);
fclose (File_SEP);
% fclose (File_FAIR);
fclose (File_LEACH);
save ('Fraction_Advanced_Nodes_CRP_SEP_LEACH.mat');



