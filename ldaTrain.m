function [ Priors, Means, Covar ] = ldaTrain( Data, Outputs)

% LDA - clculates the parameters given the DATA and the OUTPUTs for Linear Discriminant Analysis.
% 
% Data - PxN matrix of observations. N observations of P elements.
% Output - 1xN vector of atributes (lables) of the data.
% Values in the range 1 - K. Each value must apeare at least two times.
% 
% Prires - 1xK vector of the priors of each class.
% Means - PxK matrix. Each column is a mean vector of a class.
% Covar - PxP inter-class covarins matrix..

if nargin ~= 2
     error('Wrong number of input arguments')
end;

[D1, D2] = size(Data);
[O1, O2] = size(Outputs);
if D2 ~= O2,
    error('The number of Data vectors diferent then the number of the Outputs');
end;

Labels = max(Outputs) ;
Priors = zeros(1 , Labels) ;
Means = zeros(D1 , Labels) ;
Covar = zeros(D1 , D1) ;
for k = 1 : Labels,
    DataK = find( Outputs == k) ;
    LabelSize = max(size(DataK)) ;
    if LabelSize < 2,
        Priors = [];
        Means = [] ;
        Covar = [] ;
        k
        error( 'Number of otputs less than 2');
    end;
    Priors(k) = LabelSize/O2 ;
    Means( : , k) = mean( Data( : , DataK)')' ; 
    Covs( : , : , k) = cov( Data( : , DataK)') ;
%     Covar = Covar + Priors(k) * Covs( : , : , k) ;
    Covar = Covar +(LabelSize - 1) * Covs( : , : , k) ;
end ;
Covar = Covar/(O2 - Labels) ;

