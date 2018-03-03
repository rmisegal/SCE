function [RealLabels, Label ] = ldaLeav20( Data , Outputs , Options )

[ D1 , D2 ] = size( Data ) ;
numofiteration = str2double(Options{1});
numoftestsubjects = floor(str2double(Options{2})*D2/100);
numofminimumsubjects = floor(str2double(Options{3})*D2/100);
Label = zeros( 1 , numofiteration * (D2-numoftestsubjects) ) ;
RealLabels = zeros( 1 , numofiteration * (D2-numoftestsubjects) ) ;

Q = max( Outputs ) ;
LDA = zeros( (D2-numoftestsubjects) , Q ) ;


for k = 1 : numofiteration
    % get random data
    r = randperm(D2);
    datatest  = Data(:,r(1:numoftestsubjects));
    outputstest = Outputs(:,r(1:numoftestsubjects));
    datavalid = Data(:,r(numoftestsubjects+1:D2)); 
    RealLabels((((k-1)*(D2-numoftestsubjects))+1):(k*(D2-numoftestsubjects))) = Outputs(:,r(numoftestsubjects+1:D2));
    
    %check number of minimum data
    flag = 0;
    for q=1:Q
        A = find(outputstest == q);
        if size(A,2) <numofminimumsubjects
            flag=1;
            break;
        end
    end
    if flag
        k=k-1;
        continue;
    end
    % do LDA
    [ P , M , C ] = ldaTrain( datatest , outputstest ) ;
    InvC = inv( C ) ;
    for q = 1 : Q,
        LDA( :,q ) = datavalid'*InvC*M( : , q ) - 0.5*M( : , q )'*InvC*M( : , q ) + log( P(q ) ) ;
    end ;
    [~ , Label( (((k-1)*(D2-numoftestsubjects))+1):(k*(D2-numoftestsubjects)))  ] = max( LDA' ) ;
end;