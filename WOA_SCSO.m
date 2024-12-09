%_________________________________________________________________________% 
% Risk-Based Design Optimization of Contamination Detection 
% Sensors in Water Distribution Systems: Application of an 
% Improved Whale Optimization Algorithm
%                                                                         %
function [Leader_score,Leader_pos,Convergence_curve]=WOA_SCSO(W,SearchAgents_no,Max_iter,dim,fobj)

Leader_pos=zeros(1,dim);
Leader_score=inf; %change this to -inf for maximization problems
%Initialize the positions of search agents
Positions=initialization(SearchAgents_no,dim,1,0)>0.5;

Convergence_curve=zeros(1,Max_iter);

t=0;% Loop counter
for i=1:size(Positions,1)       
        whale_fitness(1,i)=singlebinary(Positions(i,:),W);   
end
% Main loop
while t<Max_iter
        S=2;                                    %%% S is maximum Sensitivity range 
       rg=S-((S)*t/(Max_iter));                %%%% guides R
   
    for i=1:size(Positions,1)
        
        % Calculate objective function for each search agent
        fitness=singlebinary(Positions(i,:),W);
      
        % Update the leader
        if fitness<Leader_score % Change this to > for maximization problem
            Leader_score=fitness; % Update alpha
            Leader_pos=Positions(i,:);
        end
        
    end
    
    a=2-t*((2)/Max_iter); 
    
    a2=-1+t*((-1)/Max_iter);
    
    % Update the Position of search agents 
    for i=1:size(Positions,1)
        r1=rand(); % r1 is a random number in [0,1]
        r2=rand(); % r2 is a random number in [0,1]
        
        A=2*a*r1-a;  
        C=2*r2;      
        
        
        b=1;               
        l=(a2-1)*rand+1;   
        
      
        p = rand();        
           if p<0.5   
                if abs(A)>=1

                    % rand_leader_index = tournamentSelection(1./whale_fitness,0.5);
                    % X_rand = Positions(rand_leader_index, :)>0.5;
                       for j=1:dim
                           teta=RouletteWheelSelection(p);
                           if((-1<=R)&&(R<=1)) 
                               Rand_position=abs(rand*Leader_pos(i,j)-Leader_pos(i,j));
                               Leader_pos(i,j)=Leader_pos(i,j)-r*Rand_position*cos(teta);
                           else
                               cp=floor(SearchAgents_no*rand()+1);
                               CandidatePosition =Positions(cp,:);
                               Positions(i,j)=r*(CandidatePosition(j)-rand*Positions(i,j));
                               s(i,j)=1/(1+exp(-Positions(i,j)/3));
                               if rand<s(i,j)
                               Position(i,j)=1;
                               else
                               Position(i,j)=0;
                               end
                            % end


                           end
                        end
                elseif abs(A)<1
                              X_rand = Positions(rand_leader_index, :)>0.5; 
                         for j=1:dim
                           teta=RouletteWheelSelection(p);
                           if((-1<=R)&&(R<=1)) 
                               % Rand_position=abs(rand*Leader_pos(i,j)-Leader_pos(i,j));
                               Leader_pos(i,j)=Leader_pos(i,j)-r*X_rand*cos(teta);
                           else
                               cp=floor(SearchAgents_no*rand()+1);
                               CandidatePosition =Positions(cp,:);
                               Positions(i,j)=r*(CandidatePosition(j)-rand*Positions(i,j));
                           end
                               s(i,j)=1/(1+exp(-Positions(i,j)/3));
                               if rand<s(i,j)
                               Position(i,j)=1;
                               else
                               Position(i,j)=0;

                           
                        end

                end
                
            elseif p>=0.5
              
                distance2Leader=abs(Leader_pos-Positions(i,:));
                Positions(i,:)=distance2Leader*exp(b.*l).*cos(l.*2*pi)+Leader_pos;
            end
    end
    t=t+1;
    for i=1:size(Positions,1)       
        whale_fitness(1,i)=singlebinary(Positions(i,:),W);   
    end
    Convergence_curve(t)=Leader_score;


    end
end

