% Analyze the data for A Particular Iteration  m=2,a =1
load ('Data_Per_Iteration_m2_a1');

File_Nodes_Alive = fopen ('C:/Users/RaviHome/Desktop/SEP/Code/Data/Per_Iteration/Nodes_Alive_m2_p1.txt', 'w');
File_Ave_Cluster_Head_Energy = fopen ('C:/Users/RaviHome/Desktop/SEP/Code/Data/Per_Iteration/Cluster_Head_Energy_m2_p1.txt', 'w');

rmax=7000;
for r = 1 : rmax
    fprintf (File_Nodes_Alive, '%d\t',  r);
    fprintf (File_Ave_Cluster_Head_Energy, '%d\t',  r);
    for protocol = 1 : 5
        fprintf (File_Nodes_Alive, '%d\t', Number_Nodes_Alive (protocol, r, 1));
        fprintf (File_Ave_Cluster_Head_Energy, '%d\t', CH_Energy (protocol, r, 1));
    end
    fprintf (File_Nodes_Alive, '\r\n');
    fprintf (File_Ave_Cluster_Head_Energy, '\r\n');
end
fclose (File_Nodes_Alive);
fclose (File_Ave_Cluster_Head_Energy);