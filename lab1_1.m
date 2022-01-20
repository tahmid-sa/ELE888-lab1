%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ELE 888/ EE 8209: LAB 1: Bayesian Decision Theory
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [posteriors_x,g_x]=lab1_1(x1,x2,Training_Data,feature1,feature2)

% x = individual sample to be tested (to identify its probable class label)
% featureOfInterest = index of relevant feature (column) in Training_Data 
% Train_Data = Matrix containing the training samples and numeric class labels
% posterior_x  = Posterior probabilities
% g_x = value of the discriminant function

D=Training_Data;

% D is MxN (M samples, N columns = N-1 features + 1 label)
[M,N]=size(D);    
 
f=D(:,1);  % feature samples
la=D(:,N); % class labels

%% %%%%Prior Probabilities%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Hint: use the commands "find" and "length"

disp('Prior probabilities:');
Pr11 = length(find(D(1:M,N)==1))/length(find(D(1:M,N))); 
Pr12 = length(find(D(1:M,N)==1))/length(find(D(1:M,N))); 
Pr21 = length(find(D(1:M,N)==2))/length(find(D(1:M,N))); 
Pr22 = length(find(D(1:M,N)==2))/length(find(D(1:M,N))); 

d12 = 2;

%% %%%%%Class-conditional probabilities%%%%%%%%%%%%%%%%%%%%%%%

disp('Mean & Std for class 1 & 2');

%%this part identifies the features that are of interest 

if strcmp(feature1, 'sepal length') == 1
    disp('sepal length has been chosen as the feature to discrimate classes'); 
    X_feature1 = 1; 
elseif strcmp(feature1, 'sepal width') == 1
    disp('sepal width has been chosen as the feature to discrimate classes'); 
    X_feature1 = 2; 
elseif strcmp(feature1, 'petal length') == 1
    disp('petal length has been chosen as the feature to discrimate classes'); 
    X_feature1 = 3; 
elseif strcmp(feature1, 'petal width') == 1
    disp('petal width has been chosen as the feature to discrimate classes'); 
    X_feature1 = 4; 
else 
    disp('Error! Please specify the following features: "sepal length", "sepal width", "petal length", or, "petal width"'); 
    return 
end 

if strcmp(feature2, 'sepal length') == 1
    disp('sepal length has been chosen as the feature to discrimate classes'); 
    X_feature2 = 1; 
elseif strcmp(feature2, 'sepal width') == 1
    disp('sepal width has been chosen as the feature to discrimate classes'); 
    X_feature2 = 2; 
elseif strcmp(feature2, 'petal length') == 1
    disp('petal length has been chosen as the feature to discrimate classes'); 
    X_feature2 = 3; 
elseif strcmp(feature2, 'petal width') == 1
    disp('petal width has been chosen as the feature to discrimate classes'); 
    X_feature2 = 4; 
else 
    disp('Error! Please specify the following features: "sepal length", "sepal width", "petal length", or, "petal width"'); 
    return 
end 

%%using the find function, we idenity which of the features we want. 

m11 =  mean(D(find(D(1:M,N)==1), X_feature1)); % mean of the class conditional density p(x/w1)
std11 = std(D(find(D(1:M,N)==1), X_feature1)); % Standard deviation of the class conditional density p(x/w1)

m12 = mean(D(find(D(1:M,N)==2),X_feature2)); % mean of the class conditional density p(x/w2)
std12 = std(D(find(D(1:M,N)==1),X_feature2)); % Standard deviation of the class conditional density p(x/w2)

disp(['Conditional probabilities for x=' num2str(x1,x2)]);
syms x; 
cp11= (1/(sqrt(2*pi)*std11)*exp((-0.5)*((x1-m11)/std11)^2)); % use the above mean, std and the test feature to calculate p(x/w1)
cp12= (1/(sqrt(2*pi)*std12)*exp((-0.5)*((x2-m12)/std12)^2));% use the above mean, std and the test feature to calculate p(x/w2)


%% %%%%%%Compute the posterior probabilities%%%%%%%%%%%%%%%%%%%%

disp('Posterior prob. for the test feature');

%use the definition of posterior to calculate posterior probabilities 

pos11= cp11*Pr11/(cp11*Pr11 + cp12*Pr12); % p(w1/x) for the given test feature value

pos12= cp12*Pr21/(cp11*Pr12 + cp12*Pr21);% p(w2/x) for the given test feature value

posteriors_x= [pos11 pos12]; 

%% %%%%%%Discriminant function for min error rate classifier%%%

disp('Discriminant function for the test feature');

%use the equation solver to find the minimum error rate for this type of
%classification system 

g1_x = pos11; 
g2_x = pos12; 

g_x = g1_x - g2_x;  % compute the g(x) for min err rate classifier.

eqn = pos11 == pos12; 
slx = solve(eqn,x); 
solns = double(slx);
x = solns(solns >= 0); 

%decision boundary solution

if (x > 0)
    disp('Iris Setosa w = 1'); 
elseif (x == 0)
    disp('At Decision bounary!'); 
else 
    disp('Iris versicolour w = 2'); 
end 

%% ##### BONUS QUESTION 2 ######
%%find mu, and sigma, and then calculate for posterior probability of x
%%=[x1 x2]; 
x12 = [find(D(1:M,N)==1) find(D(1:M,N)==2)]';
mu = mean(x12);
sigma = cov(x12); 
sigma_det = det(sigma); 
sigma_sqrt = sqrt(sigma_det); 
sigma_inv = sigma.^(-1); 
d = 2; 

x_mu = x12-mu; 
x_mu_t = x_mu'; 

post_x = (1/((2*pi)^(d/2)*(sigma_sqrt)))*exp(-0.5*x_mu*sigma_inv*x_mu_t); 

fprintf('\nmean = %f', mu); 
fprintf('\nsigma = %f', sigma); 
fprintf('\n|sigma| = %f',sigma_det); 
fprintf('\nswrt(sigma) = %f',sigma_sqrt); 
fprintf('\ninv(sigma) = %f',sigma_inv); 
fprintf('\nd = %f',d); 
fprintf('\npost(x) = %f',post_x); 

%%
%%check decision boundary 
fprintf('\n\n'); 
if (post_x> x2)
    disp('Iris Setosa w = 1'); 
elseif (post_x == 0)
    disp('At Decision Bounary!'); 
else 
    disp('Iris Versicolour w = 2'); 
end 

