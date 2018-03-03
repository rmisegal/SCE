function [ Label ] = ldaLeavOneOut( Data , Outputs )

[ D1 , D2 ] = size( Data ) ;
Label = zeros( 1 , D2 ) ;
Q = max( Outputs ) ;
LDA = zeros( 1 , Q ) ;
for k = 1 : D2,
    [ P , M , C ] = ldaTrain( Data( : , 2 : D2) , Outputs( 2 : D2) ) ;
    InvC = inv( C ) ;
    for q = 1 : Q,
        LDA( q ) = Data( : , 1 )'*InvC*M( : , q ) - 0.5*M( : , q )'*InvC*M( : , q ) + log( P(q ) ) ;
    end ;
    [Ma , Label( k ) ] = max( LDA ) ;
    Data = circshift( Data , [ 0 -1 ] ) ;
    Outputs = circshift( Outputs , [ 0 -1 ] ) ;
end;
