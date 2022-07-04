clc
clear all
close all

D = rand(500, 3); % 500 samples with 3 features

% The number of Clusters
k = 3;  

% Initialization the centroid
% To initialize 'u', the element of input data D is randomly selected.
random = randperm(length(D),k);
u = D(random ,:);


% Start learning
% z == The number of iterations
for z=1:15
    % Create the set of clusters
    % Maximum storage memory allocation
    C = cell(k,1);
    for j=1:length(D)
        % Calculate the distance (euclidean distance)
        for i =1:k
            dist(i,1) = norm(D(j,:)-u(i,:));
        end
        % Assign each observation to the cluster with the nearest mean
        arg = find(dist==min(dist));
        C{arg}(end+1,:) = D(j,:);
    end
    
   % Update
    for i = 1:k
        % Clustered cluster elements
        cluster = C{i};
        % Overall mean value
        cluster = sum(cluster) ./ sum(cluster~=0,1);
        try
            % Once the iteration is complete, based on this, 
            % modify the central axis uk of C through the average of the elements.
            u(i,:) = cluster;
        catch
            fprintf("Update error is occured\n")
        end
    end

    %plot
    % Checking cluster results in real time
    cla; 
    hold on;
    for i = 1: k
        cluster = C{i};
        try
            scatter3(cluster(:,1),cluster(:,2),cluster(:,3),'filled') % cluster data
            scatter3(u(:,1),u(:,2),u(:,3),'*r','LineWidth',5) % centroid
        catch
            fprintf("Plot error is occured\n")
        end
    end
    pause(0.5) 
end
