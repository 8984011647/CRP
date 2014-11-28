function [Number_Nodes_Alive, first_dead, Throughput, CH_Energy, Std_Energy, Average_Cluster_Head_Energy, Average_Standard_Deviation_Energy, Average_Fraction, Fraction_CH] = run_LEACH (m, a, Num_Nodes, Popt)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                      %
% SEP: A Stable Election Protocol for clustered                        %
%      heterogeneous wireless sensor networks                          %
%                                                                      %
% (c) Georgios Smaragdakis                                             %
% WING group, Computer Science Department, Boston University           %
%                                                                      %
% You can find full documentation and related information at:          %
% http://csr.bu.edu/sep                                                %
%                                                                      %  
% To report your comment or any bug please send e-mail to:             %
% gsmaragd@cs.bu.edu                                                   %
%                                                                      %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                      %
% This is the SEP [1] code we have used.                               %
%                                                                      %
% [1]  Georgios Smaragdakis, Ibrahim Matta and Azer bestavros,         %      
%      "SEP: A Stable Election Protocol for clustered                  %
%      heterogeneous wireless sensor networks",                        %
%      Second International Workshop on Sensor and Actor Network       %
%      Protocols and Applications (SANPA 2004),Boston MA, August       %               					
%      2004.                                                           %
%                                                                      %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% clear;
Sum_Cluster_Head_Energy = 0;
Effective_Number_Rounds = 0;
Sum_Standard_Deviation_Energy = 0;
Sum_Fraction =0;


To_Plot = 0;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PARAMETERS %%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Field Dimensions - x and y maximum (in meters)
xm=100*3;
ym=100*3;

%x and y Coordinates of the Sink
sink.x=0.5*xm;
sink.y=0.5*ym;

%Number of Nodes in the field
n=Num_Nodes;
Energy_Nodes = zeros (n, 1);
%Optimal Election Probability of a node
%to become cluster head
% p=0.1;
p=Popt;

%Energy Model (all values in Joules)
%Initial Energy 
Eo=0.5;
%Eelec=Etx=Erx
ETX=50*0.000000001;
ERX=50*0.000000001;
%Transmit Amplifier types
Efs=10*0.000000000001;
Emp=0.0013*0.000000000001;
%Data Aggregation Energy
EDA=5*0.000000001;

%Values for Hetereogeneity
%Percentage of nodes than are advanced
% m=0.1;
%\alpha
% a=1;

%maximum number of rounds
rmax=7000;
Number_Nodes_Alive = zeros (rmax, 2);
Throughput = zeros (rmax, 3);
CH_Energy  = zeros (rmax, 2);
Std_Energy = zeros (rmax, 2);
Fraction_CH = zeros (rmax, 2);

for i = 1 : rmax 
    Number_Nodes_Alive (i, 1) = i;
    Throughput (i, 1) = i;
    CH_Energy (i, 1) = i;
    Std_Energy (i, 1) = i;
    Fraction_CH (i, 1) = i;
end

%%%%%%%%%%%%%%%%%%%%%%%%% END OF PARAMETERS %%%%%%%%%%%%%%%%%%%%%%%%

%Computation of do
do=sqrt(Efs/Emp); 

%Creation of the random Sensor Network
if (To_Plot == 1)
   figure(1);
end

s = struct ('xd', cell(1), 'yd', cell(1), 'G', cell(1), 'type', cell(1), 'epoch', cell(1), 'E', cell(1), 'Energy', cell(1));
S = repmat (s, n+1, 1);

PACKETS_TO_CH = zeros (rmax, 1);
PACKETS_TO_BS = zeros (rmax, 1);
% STATISTICS  = zeros (rmax, 1);
DEAD = zeros (rmax, 1);
DEAD_N = zeros (rmax, 1);
DEAD_A = zeros (rmax, 1);

for i=1:1:n
    S(i).xd=rand(1,1)*xm;    
    S(i).yd=rand(1,1)*ym;    
    S(i).G=0;
    %initially there are no cluster heads only nodes
    S(i).type='N';
    S(i).epoch = 0;
    temp_rnd0=i;
    %Random Election of Normal Nodes
    if (temp_rnd0>=m*n+1) 
        S(i).E=Eo;
        S(i).ENERGY=0;
        %%%%plot(S(i).xd,S(i).yd,'o');
%         hold on;
    end
    %Random Election of Advanced Nodes
    if (temp_rnd0<m*n+1)  
        S(i).E=Eo*(1+a);
        S(i).ENERGY=1;
        %%%%plot(S(i).xd,S(i).yd,'+');
%          hold on;
    end
end

S(n+1).xd=sink.x;
S(n+1).yd=sink.y;
%%%%plot(S(n+1).xd,S(n+1).yd,'x');
    
        
%First Iteration
if (To_Plot == 1)
    figure(1);
end

%counter for CHs
countCHs=0;
%counter for CHs per round
rcountCHs=0;
cluster=1;


rcountCHs=rcountCHs+countCHs;
flag_first_dead=0;

for r=1:1:rmax
  Frac_This_Round = 0;
  C_str = struct ('xd', cell(1), 'yd', cell(1), 'distance', cell(1), 'id', cell(1));
  C = repmat (C_str, n, 1);
  
  X = zeros (n, 1);
  Y = zeros (n, 1);
  
  %Election Probability for Normal Nodes
  pnrm=( p/ (1+a*m) );
  %Election Probability for Advanced Nodes
  padv= ( p*(1+a)/(1+a*m) );
  
  % Current Epoch_H, Epoch_Adv
%   Epoch_H = ceil(r/(1/pnrm));
%   Epoch_Adv = ceil(r/(1/padv));
   Epoch = ceil(r/(1/p));
    
  %Operation for heterogeneous epoch
  %if(mod(r, round(1/pnrm) )==0)
  
    for i=1:1:n
        if ((S(i).epoch < Epoch))
            S(i).G=1;
            S(i).cl=0;
        end
    end

%  %Operations for sub-epochs
% %  if(mod(r, round(1/padv) )==0)
% if ((S(i).epoch < Epoch_Adv) && (S(i).ENERGY == 1))
%     for i=1:1:n
% %         if(S(i).ENERGY==1)
%             S(i).G=1;
%             S(i).cl=0;
% %         end
%     end
% end

 
hold off;

%Number of dead nodes
dead=0;
%Number of dead Advanced Nodes
dead_a=0;
%Number of dead Normal Nodes
dead_n=0;

%counter for bit transmitted to Bases Station and to Cluster Heads
packets_TO_BS=0;
packets_TO_CH=0;
%counter for bit transmitted to Bases Station and to Cluster Heads 
%per round
PACKETS_TO_CH(r, 1)=0;
PACKETS_TO_BS(r, 1)=0;

if (To_Plot == 1)
    figure(1);
end

for i=1:1:n
    %checking if there is a dead node
    if (S(i).E<=0)
        if (To_Plot == 1)
            plot(S(i).xd,S(i).yd,'red .');
        end
        dead=dead+1;
        if(S(i).ENERGY==1)
            dead_a=dead_a+1;
        end
        if(S(i).ENERGY==0)
            dead_n=dead_n+1;
        end
%         hold on;    
    end
    
    if (S(i).E>0)
        S(i).type='N';
        if (S(i).ENERGY==0)  
              if (To_Plot == 1)
                  plot(S(i).xd,S(i).yd,'o');
              end
        end
        if (S(i).ENERGY==1)  
            if (To_Plot == 1)
                plot(S(i).xd,S(i).yd,'+');
            end
        end
%         hold on;
    end
end

Number_Nodes_Alive (r, 1) = r;
Number_Nodes_Alive (r, 2) = n-dead;

if (To_Plot == 1)
    plot(S(n+1).xd,S(n+1).yd,'x');
end


% STATISTICS(r+1).DEAD=dead;
DEAD(r+1)=dead;
DEAD_N(r+1)=dead_n;
DEAD_A(r+1)=dead_a;

%When the first node dies
if (dead>0)
    if(flag_first_dead==0)
        first_dead=Effective_Number_Rounds;
%         break;
        flag_first_dead=1;
    end
end

countCHs=0;
cluster=1;
Cluster_Head_Energy = 0;
Num_Advanced_Nodes = 0;
for i=1:1:n
   if(S(i).E>0)
   temp_rand=rand;     
   if ( (S(i).G) == 1)

 %Election of Cluster Heads for normal nodes
%  if( ( S(i).ENERGY==0 && ( temp_rand <= ( pnrm / ( 1 - pnrm * mod(r,round(1/pnrm)) )) ) )  )
if(temp_rand<= (p/(1-p*mod(r,round(1/p)))))
            Cluster_Head_Energy = Cluster_Head_Energy + S(i).E; 
            countCHs=countCHs+1;
            packets_TO_BS=packets_TO_BS+1;
            PACKETS_TO_BS(r+1)=packets_TO_BS;
            S(i).epoch  = Epoch;
            S(i).type='C';
            if (S(i).ENERGY == 1)
                Num_Advanced_Nodes = Num_Advanced_Nodes + 1;
            end
            S(i).G=0;
            C(cluster).xd=S(i).xd;
            C(cluster).yd=S(i).yd;
            if (To_Plot == 1)
                plot(S(i).xd,S(i).yd,'k*');
            end
            
            distance=sqrt( (S(i).xd-(S(n+1).xd) )^2 + (S(i).yd-(S(n+1).yd) )^2 );
            C(cluster).distance=distance;
            C(cluster).id=i;
            X(cluster)=S(i).xd;
            Y(cluster)=S(i).yd;
            cluster=cluster+1;
            
            %Calculation of Energy dissipated
            if (distance>do)
                S(i).E=S(i).E- ( (ETX+EDA)*(4000) + Emp*4000*( distance*distance*distance*distance )); 
            end
            if (distance<=do)
                S(i).E=S(i).E- ( (ETX+EDA)*(4000)  + Efs*4000*( distance * distance )); 
            end
end
   end
  end 
end
if (countCHs > 0)
    
    Effective_Number_Rounds = Effective_Number_Rounds + 1;  
    CH_Energy (Effective_Number_Rounds, 2) = Cluster_Head_Energy / countCHs;    
    Sum_Cluster_Head_Energy  = Sum_Cluster_Head_Energy + CH_Energy (Effective_Number_Rounds, 2);
    Sum_Fraction = Sum_Fraction + (Num_Advanced_Nodes/countCHs);
    Fraction_CH (Effective_Number_Rounds, 2) = (Num_Advanced_Nodes/countCHs);
else
%     CH_Energy (r, 2) = 0;
end


% STATISTICS(r, 1).CLUSTERHEADS=cluster-1;
% CLUSTERHS(r, 1)=cluster-1;

%Election of Associated Cluster Head for Normal Nodes
for i=1:1:n
   if ( S(i).type=='N' && S(i).E>0 )
     if(cluster-1>=1)
       min_dis=sqrt( (S(i).xd-S(n+1).xd)^2 + (S(i).yd-S(n+1).yd)^2 );
       min_dis_cluster=1;
       for c=1:1:cluster-1
           temp=min(min_dis,sqrt( (S(i).xd-C(c).xd)^2 + (S(i).yd-C(c).yd)^2 ) );
           if ( temp<min_dis )
               min_dis=temp;
               min_dis_cluster=c;
           end
       end
       
       %Energy dissipated by associated Cluster Head
%             min_dis;
            if (min_dis>do)
                S(i).E=S(i).E- ( ETX*(4000) + Emp*4000*( min_dis * min_dis * min_dis * min_dis)); 
            end
            if (min_dis<=do)
                S(i).E=S(i).E- ( ETX*(4000) + Efs*4000*( min_dis * min_dis)); 
            end
        %Energy dissipated
        if(min_dis>0)
            S(C(min_dis_cluster).id).E = S(C(min_dis_cluster).id).E- ( (ERX + EDA)*4000 ); 
         PACKETS_TO_CH(r+1)=n-dead-cluster+1; 
        end

       S(i).min_dis=min_dis;
       S(i).min_dis_cluster=min_dis_cluster;
     end
   end
end

if (countCHs >0)
    for num = 1 : n
        Energy_Nodes (num, 1) = S(num).E;
    end    
    
    Std_Energy (Effective_Number_Rounds, 2) = std (Energy_Nodes);
    Sum_Standard_Deviation_Energy = Sum_Standard_Deviation_Energy + Std_Energy (Effective_Number_Rounds, 2);
end
% hold on;

% countCHs;
rcountCHs=rcountCHs+countCHs;
Throughput (r, 2) = (n-dead-cluster+1)*4 ;
Throughput (r, 3) = (cluster-1)*4 ;

%Code for Voronoi Cells
%Unfortynately if there is a small
%number of cells, Matlab's voronoi
%procedure has some problems

%[vx,vy]=voronoi(X,Y);
%plot(X,Y,'r*',vx,vy,'b-');
% hold on;
% voronoi(X,Y);
% axis([0 xm 0 ym]);

if (dead/n >= 0.01)
%     first_dead=r;
%     Average_Cluster_Head_Energy = Sum_Cluster_Head_Energy / Effective_Number_Rounds;
%     Average_Standard_Deviation_Energy = Sum_Standard_Deviation_Energy / Effective_Number_Rounds;
%     Average_Fraction = Sum_Fraction / Effective_Number_Rounds;
%     break;
break;
end
    
end
    first_dead=Effective_Number_Rounds;
    Average_Cluster_Head_Energy = Sum_Cluster_Head_Energy / Effective_Number_Rounds;
    Average_Standard_Deviation_Energy = Sum_Standard_Deviation_Energy / Effective_Number_Rounds; 
    Average_Fraction = Sum_Fraction / Effective_Number_Rounds;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   STATISTICS    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                                     %
%  DEAD  : a rmax x 1 array of number of dead nodes/round 
%  DEAD_A : a rmax x 1 array of number of dead Advanced nodes/round
%  DEAD_N : a rmax x 1 array of number of dead Normal nodes/round
%  CLUSTERHS : a rmax x 1 array of number of Cluster Heads/round
%  PACKETS_TO_BS : a rmax x 1 array of number packets send to Base Station/round
%  PACKETS_TO_CH : a rmax x 1 array of number of packets send to ClusterHeads/round
%  first_dead: the round where the first node died                   
%                                                                                     %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%






end
