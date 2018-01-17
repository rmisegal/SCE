

function varargout = main(varargin)
% 1.07 - Rami first working version
% 2DO: problem with lda20, should fix the ldaLeav20 matrix.


%   MAIN MATLAB code for main.fig
%      MAIN, by itself, creates a new MAIN or raises the existing
%      singleton*.
%
%      H = MAIN returns the handle to a new MAIN or the handle to
%      the existing singleton*.
%
%      MAIN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAIN.M with the given input arguments.
%
%      MAIN('Property','Value',...) creates a new MAIN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before main_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to main_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help main

% Last Modified by GUIDE v2.5 12-Jan-2018 16:51:16

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @main_OpeningFcn, ...
    'gui_OutputFcn',  @main_OutputFcn, ...
    'gui_LayoutFcn',  [] , ...
    'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT
% --- Executes just before main is made visible.
function main_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% var10.0argin   command line arguments to main (see VARARGIN)

% Choose default command line output for main
handles.output = hObject;
% Update handles structure
guidata(hObject, handles);

set(hObject, 'DeleteFcn', @my_close);
if strcmp(get(hObject,'Visible'),'off')
    plot(rand(5));
end

% set( handles.exportGraph, 'String', 'Export Some PC''s')
% set( handles.uibuttongroup6.Children, 'Visible', 'off')
% set( handles.uibuttongroup5.Children, 'Visible', 'off')
set( handles.uibuttongroup6, 'Visible', 'off')
set( handles.uibuttongroup5, 'Visible', 'off')
set( handles.uipanel1, 'Visible', 'off')
% set( handles.uipanel1.Children, 'Visible', 'off')
set( handles.uibuttongroup5, 'Visible', 'off')
set( handles.uipanel2, 'Visible', 'off')
% set( handles.uipanel2.Children, 'Visible', 'off')





% UIWAIT makes main wait for user response (see UIRESUME)
% uiwait(handles.figure1);

setappdata(0,'hMain',gcf);
function my_close(hObject, eventdata)
hPCA = getappdata(0,'hPCA');
rmappdata(0,'hMain');
if(~isempty(hPCA))
    rmappdata(0,'hPCA');
end
% --- Outputs from this function are returned to the command line.
function varargout = main_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
% --- Executes on button press in IndexToFreq.
function Xaxis_Callback(hObject, eventdata, handles)

hMain = getappdata(0,'hMain');
Data = getappdata(hMain, 'data');
if(isempty(Data))
    errordlg('No data was imported');
    return;
end
if isempty(Data.Xaxis)
    [a,b,c] = uigetfile({'*.xls;*.xlsx;','Excel Files';'*.*','All Files'},'Choose Data',Data.CD);
    temp=importdata([b,a]);
    Data.CD=b;
    setappdata(hMain, 'data',Data);
    if length(temp)~=Data.numOfFeatures
        errordlg('Axis length do not match');
        return;
    end
    Data.Xaxis=temp;
    Data.XaxisBackup=Data.Xaxis;
end
Data.XaxisFlag=1;
plotdatafunc(Data, handles);

set( handles.IndexToFreq, 'Visible', 'off');
set( handles.FreqToIndex, 'Visible', 'on');
setappdata(hMain, 'data',Data);
function Xaxis2_Callback(hObject, eventdata, handles)

hMain = getappdata(0,'hMain');
Data = getappdata(hMain, 'data');
if(isempty(Data))
    errordlg('No data was imported');
    return;
end
Data.XaxisFlag=0;
plotdatafunc(Data, handles);
set( handles.FreqToIndex, 'Visible', 'off');
set( handles.IndexToFreq, 'Visible', 'on');
setappdata(hMain, 'data',Data);
function ChooseRangePB_Callback(hObject, eventdata, handles)

% set( handles.uibuttongroup6.Children, 'Visible', 'off')
% set( handles.uibuttongroup5.Children, 'Visible', 'off')
% set( handles.uipanel1, 'Visible', 'off')
% set( handles.uipanel1.Children, 'Visible', 'off')
% set( handles.uibuttongroup6, 'Visible', 'off')
% set( handles.uibuttongroup5, 'Visible', 'off')
% set( handles.uipanel2, 'Visible', 'off')
% set( handles.uipanel2.Children, 'Visible', 'off')

hMain = getappdata(0,'hMain');
Data = getappdata(hMain, 'data');
if(isempty(Data))
    errordlg('No data was imported');
    return;
end
if strcmp(handles.ChooseRangeTXT.Visible,'off')
    if ~handles.ChooseRangeTXT.Value
        handles.ChooseRangeTXT.String=['1:' int2str(Data.numOfFeatures)];
        handles.ChooseRangeTXT.Value=1;
    end
    set( handles.ChooseRangeTXT, 'Visible', 'on');
    set( handles.ChooseRangePB2, 'Visible', 'on');
    set( handles.ExampleText1, 'Visible', 'on');
else
    set( handles.ChooseRangeTXT, 'Visible', 'off');
    set( handles.ChooseRangePB2, 'Visible', 'off');
    set( handles.ExampleText1, 'Visible', 'off');
end
function ChooseRangePB2_Callback(hObject, eventdata, handles)

hMain = getappdata(0,'hMain');
Data = getappdata(hMain, 'data');
handles.message.String = 'calculating...';
pause(0.01);
if(isempty(Data))
    errordlg('No data was imported');
    return;
end

Data.NewXaxis=str2num(handles.ChooseRangeTXT.String);

if length(Data.NewXaxis)==length(Data.OriginalX(:,1))
    Data.RangeFlag=0;
else
    Data.RangeFlag=1;
end
temp1=find(handles.ChooseRangeTXT.String==',');
numofranges=length(temp1)+1;
if Data.XaxisFlag
    if numofranges>1
        for i=1:numofranges
            if i==1
                temprange=str2num(handles.ChooseRangeTXT.String(1:(temp1(i)-1)));
            elseif i<numofranges
                temprange=str2num(handles.ChooseRangeTXT.String((temp1(i-1)+1):(temp1(i)-1)));
            elseif i==numofranges
                temprange=str2num(handles.ChooseRangeTXT.String((temp1(i-1)+1):length(handles.ChooseRangeTXT.String)));
            end
            range(i,:)=[temprange(1),temprange(end)];
        end
    else
        temprange=str2num(handles.ChooseRangeTXT.String);
        range=[temprange(1),temprange(end)];
    end
    Data.NewXaxis=[];
    for i=1:numofranges
        [trash, a]=min(abs(Data.XaxisBackup-range(i,1)));
        [trash, b]=min(abs(Data.XaxisBackup-range(i,2)));
        Data.NewXaxis=[Data.NewXaxis,Data.XaxisBackup(a:b)];
    end
end

if Data.XaxisFlag
    temp=Data.NewXaxis;
    Data.NewXaxis=zeros(1,length(temp));
    for i=1:length(temp)
        Data.NewXaxis(i)=find(Data.XaxisBackup==temp(i));
    end
end

Data.X=[];
temp=Data.OriginalX(Data.NewXaxis,:);
Data.X=temp;
[Data.numOfFeatures,Data.numOfObservations] = size(Data.X);
if ~isempty(Data.Xaxis)
    Data.Xaxis=Data.XaxisBackup(Data.NewXaxis);
end

plotdatafunc(Data, handles);

set( handles.ChooseRangeTXT, 'Visible', 'off');
set( handles.ChooseRangePB2, 'Visible', 'off');
set( handles.ExampleText1, 'Visible', 'off');
setappdata(hMain, 'data',Data);
% --- Executes on button press in PCA.
function PCA_Callback(hObject, eventdata, handles)
% hObject    handle to PCA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if strcmp(handles.uipanel1.Visible,'on')
    set(handles.uipanel1, 'Visible', 'off');
    set( handles.uibuttongroup6.Children, 'Visible', 'off')
    set( handles.uibuttongroup5.Children, 'Visible', 'off')
    set( handles.uibuttongroup6, 'Visible', 'off')
    set( handles.uibuttongroup5, 'Visible', 'off')
    set(handles.custumpanel, 'Visible', 'off');
    return;
end
set( handles.uipanel2, 'Visible', 'off')
set( handles.uipanel2.Children, 'Visible', 'off')
set( handles.ChooseRangeTXT, 'Visible', 'off');
set( handles.ChooseRangePB2, 'Visible', 'off');
set( handles.ExampleText1, 'Visible', 'off');
set(handles.SVMpanel, 'Visible', 'off');
set(handles.custumpanel, 'Visible', 'off');

hMain = getappdata(0,'hMain');
Data = getappdata(hMain, 'data');
if(isempty(Data))
    errordlg('No data was imported');
    return;
end
Data.PCAdata.options=choosedialogPCA;

PCA(Data.PCAdata.options);


if ~strcmp(handles.uipanel1.Visible,'on')
    set( handles.uipanel2, 'Visible', 'off')
    set(handles.TtestPanel, 'Visible', 'off');
    set(handles.SVMpanel, 'Visible', 'off');
    set( handles.uipanel1, 'Visible', 'on')
    set( handles.uibuttongroup6.Children, 'Visible', 'on')
    set( handles.uibuttongroup5.Children, 'Visible', 'on')
    set( handles.uipanel1.Children, 'Visible', 'on')
    set( handles.uibuttongroup6, 'Visible', 'on')
    set( handles.uibuttongroup5, 'Visible', 'on')
end
function PCA(options)
hMain = getappdata(0,'hMain');
Data = getappdata(hMain, 'data');
if(isempty(Data))
    errordlg(['Can not find data. Export data first'], 'export error 1');
    return;
end

% if strcmp(options{3},'on')
%     N=Data.numOfObservations;
%     Data.X=Data.X.';
%     mu=sum(Data.X)/N;
%     P=diag(sqrt(sum((Data.X-ones(N,1)*mu).^2)/N));
%     Data.X=(Data.X-ones(N,1)*mu)*P^-1;
%     Data.X=Data.X.';
% end

Data.PCAdata=[];
[coeff,scores,eigenValues] = pca(Data.X','Algorithm',options{1}, 'Centered', options{2});
Data.PCAdata.numOfEigenValues = size(eigenValues,1);
Data.PCAdata.coeff = coeff.';
Data.PCAdata.scores = scores.';
Data.PCAdata.eigenValues = eigenValues.';
Data.PCAdata.algorithm = options{1};
if strcmp( options{2} , 'on')
    Data.PCAdata.centered = 'true';
else
    Data.PCAdata.centered = 'false';
end

Data.PCAdata.wights=100*Data.PCAdata.eigenValues/sum(Data.PCAdata.eigenValues);

setappdata(hMain, 'data',Data);
% --- Executes on button press in ImportData.
function ImportData_Callback(hObject, eventdata, handles)
% hObject    handle to ImportData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set( handles.uibuttongroup6.Children, 'Visible', 'off')
set( handles.uibuttongroup5.Children, 'Visible', 'off')
set( handles.uipanel1, 'Visible', 'off')
set( handles.uipanel1.Children, 'Visible', 'off')
set( handles.uibuttongroup6, 'Visible', 'off')
set( handles.uibuttongroup5, 'Visible', 'off')
set( handles.uipanel2, 'Visible', 'off')
set( handles.uipanel2.Children, 'Visible', 'off')
set( handles.ChooseRangeTXT, 'Visible', 'off');
set( handles.ChooseRangePB2, 'Visible', 'off');
set( handles.ExampleText1, 'Visible', 'off');
set( handles.TtestPB, 'Visible', 'off');
set( handles.custumpanel, 'Visible', 'off');
set( handles.custum, 'Visible', 'off');

hMain = getappdata(0,'hMain');
Data = getappdata(hMain,'data');
CD=[];
if ~isempty(Data)
    CD=Data.CD;
    rmappdata(hMain, 'data');
else
   CD='.\Database\2categories.xls'; 
end
[a,b,c] = uigetfile({'*.xls;*.xlsx;','Excel Files';'*.*','All Files'},'Choose Data',CD);
Data=importdata([b,a]);
Data.names=fieldnames(Data);
Data.Y=[];
Data.X=[];
Data.OriginalX=[];
Data.Xaxis=[];
Data.CD=b;
Data.PCAdata=[];

Data.numOfLabels = size(Data.names,1);
for i=1:Data.numOfLabels
    Data = setfield(Data,['label' int2str(i)],getfield(Data,Data.names{i,1}));
    Data.Y = [Data.Y,i*ones(1,size(getfield(Data,Data.names{i,1}),2))];
    Data.X = [Data.X,getfield(Data,Data.names{i,1})];
    Data = rmfield(Data,Data.names{i,1});
end

Data.OriginalX=Data.X;
[Data.numOfFeatures,Data.numOfObservations] = size(Data.X);
Data.RangeFlag=0;
Data.XaxisFlag=0;
Data.NewXaxis=1:Data.numOfFeatures;
Data.OriginalXaxis=1:Data.numOfFeatures;

Data.color=[0 0 255 ; 255 0 0 ; 0 255 0 ; 0 255 255 ; 255 0 255 ; 255 255 0 ; 255 215 0 ; 255 145 0 ;...
    0 160 255 ; 1 1 1 ; 70 25 190 ; 209 58 232 ; 255 17 152  ; 75 150 0 ; 190 190 190 ; 160 210 120 ; 150 50 100 ]/255;

setappdata(hMain, 'data',Data);
plotdatafunc(Data, handles);

set( handles.LDA, 'Visible', 'on');
set( handles.PCA, 'Visible', 'on');
set( handles.IndexToFreq, 'Visible', 'on');
set( handles.ChooseRangePB, 'Visible', 'on');
set( handles.TtestPB, 'Visible', 'on');
set(handles.SVMPB, 'Visible', 'on');
set( handles.custum, 'Visible', 'on');
function FileMenu_Callback(hObject, eventdata, handles)
function OpenMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to OpenMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
file = uigetfile('*.fig');
if ~isequal(file, 0)
    open(file);
end
function PrintMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to PrintMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
printdlg(handles.figure1)
function CloseMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to CloseMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
selection = questdlg(['Close ' get(handles.figure1,'Name') '?'],...
    ['Close ' get(handles.figure1,'Name') '...'],...
    'Yes','No','Yes');
if strcmp(selection,'No')
    return;
end

delete(handles.figure1)
function makeGraph_Callback(hObject, eventdata, handles)
% hObject    handle to makeGraph (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
num = str2num(handles.PCA_Numbers.String);
if isempty(num)
    errordlg('Not a valid input. Choose your PCs first.', 'error 3');
    return;
end

i = numel(num);
if i>3 || i<2
    errordlg('Not a valid input. Only two or three PC''s are allowed.', 'error 4');
    return;
end
hMain = getappdata(0,'hMain');
Data = getappdata(hMain, 'data');

try
    close(1);
catch
end
figure(1);

switch i
    case 2
        hold on;
        for j=1:Data.numOfLabels
            plot(Data.PCAdata.scores(num(1),find(Data.Y == j)),Data.PCAdata.scores(num(2),find(Data.Y == j)),'*','color',rand(1,3))
        end
        title(['2D view of ' , int2str(num), ' PCs']);
        xlabel([int2str(num(1)) '''th PC']);
        ylabel([int2str(num(2)) '''th PC']);
        L=legend(Data.names);
        hold off;
    case 3
        hold on;
        for j=1:Data.numOfLabels
            plot3(Data.PCAdata.scores(num(1),find(Data.Y == j)),Data.PCAdata.scores(num(2),find(Data.Y == j)), ...
                Data.PCAdata.scores(num(3),find(Data.Y == j)),'*','color',rand(1,3))
        end
        view(45,45);
        title(['3D view of ' , int2str(num), ' PCs']);
        xlabel([int2str(num(1)) '''th PC']);
        ylabel([int2str(num(2)) '''th PC']);
        zlabel([int2str(num(3)) '''th PC']);
        L=legend(Data.names);
        hold off;
end
function export_Callback(hObject, eventdata, handles)
hMain = getappdata(0,'hMain');
Data = getappdata(hMain, 'data');
delete('PCA.xlsx');
handles.message.String = 'calculating...';
pause(0.01);
if handles.coefficient.Value
    for j=1:Data.numOfLabels
        xlswrite('PCA.xlsx',Data.PCAdata.scores(:,find(Data.Y == j)),['coefficients of ' Data.names{j}]);
    end
end
if handles.EigenValues.Value
    xlswrite('PCA.xlsx',Data.PCAdata.eigenValues','eigenValues');
end
if handles.scores.Value
    xlswrite('PCA.xlsx',Data.PCAdata.coeff,'eigenVectors');
end
if handles.Weights.Value
    xlswrite('PCA.xlsx',Data.PCAdata.wights','wights');
end
if ~handles.coefficient.Value && ~handles.EigenValues.Value && ~handles.scores.Value && ~handles.Weights.Value
    errordlg('Choose options to export.', 'PCA error 2');
end
handles.message.String = 'the data was exported to PCA.xlsx';
function PCA_Numbers_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PCA_Numbers (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function exportGraph_Callback(hObject, eventdata, handles)
% hObject    handle to exportGraph (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
num = str2num(handles.PCA_Numbers.String);
if isempty(num)
    errordlg('Not a valid input. Choose your PCs first.', 'PCA error 3');
    return;
end
i = numel(num);
hMain = getappdata(0,'hMain');
Data = getappdata(hMain, 'data');
handles.message.String = 'calculating...';
pause(0.01);
string = ['PCA_' replace(num2str(num)) '.xlsx'];
for j=1:Data.numOfLabels
    xlswrite(string,[num' Data.PCAdata.scores(num,find(Data.Y == j))],Data.names{j});
end
handles.message.String = ['the data was exported to ' string];
function string2 = replace(string)
i=1;
string2=[];
while (i<size(string,2)+1)
    if string(i) == ' '
        j=i;
        while(string(j)==' ')
            j=j+1;
        end
        string2(size(string2,2)+1) = '_';
        i=j;
    else
        string2(size(string2,2)+1) = string(i);
        i=i+1;
    end
end
function edit5_Callback(hObject, eventdata, handles)
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function LDA_Callback(hObject, eventdata, handles)

set( handles.uibuttongroup6.Children, 'Visible', 'off')
set( handles.uibuttongroup5.Children, 'Visible', 'off')
set( handles.uipanel1, 'Visible', 'off')
set( handles.uipanel1.Children, 'Visible', 'off')
set( handles.uibuttongroup6, 'Visible', 'off')
set( handles.uibuttongroup5, 'Visible', 'off')
set( handles.ChooseRangeTXT, 'Visible', 'off');
set( handles.ChooseRangePB2, 'Visible', 'off');
set( handles.ExampleText1, 'Visible', 'off');
set(handles.custumpanel, 'Visible', 'off');

hMain = getappdata(0,'hMain');
Data = getappdata(hMain, 'data');
if(isempty(Data))
    errordlg('No data was imported', 'error 1');
    return;
end

if strcmp(handles.uipanel2.Visible,'on')
    set(handles.uipanel2, 'Visible', 'off');
    return;
else
    set( handles.uipanel1, 'Visible', 'off');
    set(handles.TtestPanel, 'Visible', 'off');
    set( handles.uipanel2, 'Visible', 'on');
    set( handles.uipanel2.Children, 'Visible', 'on')
    set( handles.uibuttongroup6.Children, 'Visible', 'off')
    set( handles.uibuttongroup5.Children, 'Visible', 'off')
    set( handles.uibuttongroup6, 'Visible', 'off')
    set( handles.uibuttongroup5, 'Visible', 'off')
    set(handles.SVMpanel, 'Visible', 'off');
    set(handles.custumpanel, 'Visible', 'off');
end

handles.LDA20.Value = 0;
handles.LDAloo.Value = 1;
function LDA20_Callback(hObject, eventdata, handles)
if handles.LDAloo.Value
    handles.LDAloo.Value = 0;
end
function LDAloo_Callback(hObject, eventdata, handles)
if handles.LDA20.Value
    handles.LDA20.Value = 0;
end
function LDAexportcm_Callback(hObject, eventdata, handles)
% hObject    handle to LDAexportcm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

hMain = getappdata(0,'hMain');
Data = getappdata(hMain, 'data');
num {1,1} = num2str(Data.numOfFeatures+1);
while str2num(num{:}) > Data.numOfFeatures
    prompt = {['PC can''t be more then ' int2str(Data.numOfFeatures) '. Enter PC limit:']};
    dlg_title = 'input';
    num_lines = 1;
    defaultans = {'20'};
    num = inputdlg(prompt,dlg_title,num_lines,defaultans);
end


handles.message.String = 'calculating...';
pause(0.01);
if handles.LDA20.Value    %% should fix the ldaLeav20 matrix.
    options = choosedialogLDA20;
    [Y,labels] = ldaLeav20( Data.PCAdata.scores(1:str2num(num{1,1}),:) , Data.Y ,options);
    Data.LDA.predictY = labels;
    Data.LDA.realY = Y;
    Data.LDA.PCnumber = str2num(num{1,1});
    CM = computeCM(Data.LDA.realY,Data.LDA.predictY);
    Data.LDA.CM = CM;
    string = ['LDA -20 80 test - confusion matrix PC' num{1,1} '.xlsx'];
end
if handles.LDAloo.Value
    labels = ldaLeavOneOut( Data.PCAdata.scores(1:str2num(num{1,1}),:) , Data.Y );
    
    Data.LDA.predictY = labels;
    Data.LDA.realY = Y;
    Data.LDA.PCnumber = str2num(num{1,1});
    CM = computeCM(Data.LDA.realY,Data.LDA.predictY);
    Data.LDA.CM = CM;
    string = ['LDA -leave one out test - confusion matrix PC' num{1,1} '.xlsx'];
end
xlswrite(string,Data.LDA.CM,'confusion matrix');
handles.message.String = ['the data was exported to ' string];
setappdata(hMain, 'data',Data);
function PCAanalyzer_Callback(hObject, eventdata, handles)
% hObject    handle to PCAanalyzer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
hMain = getappdata(0,'hMain');
Data = getappdata(hMain, 'data');
num {1,1} = num2str(Data.numOfFeatures+1);
while str2num(num{:}) > Data.numOfFeatures
    prompt = {['PC can''t be more then ' int2str(Data.numOfFeatures) '. Enter PC limit:']};
    dlg_title = 'input';
    num_lines = 1;
    defaultans = {'20'};
    num = inputdlg(prompt,dlg_title,num_lines,defaultans);
end


rate = zeros(1,str2num(num{:}));

if handles.LDAloo.Value
    h=waitbar(0,'Please wait...');
    pause(0.01);
    for i=1:str2num(num{:})
        X = Data.PCAdata.coeff(:,1:i).';
        Y = Data.Y;
        labels = ldaLeavOneOut( X , Y );
        a=sum(Y==labels);
        rate(i)=a/size(Y,2);
        waitbar(i / str2num(num{:}))
    end
else
    options = choosedialogLDA20;
    h=waitbar(0,'Please wait...');
    pause(0.01);
    for i=1:str2num(num{:})
        X = Data.PCAdata.scores(1:i,:);
        Y = Data.Y;
        [ Y ,labels] = ldaLeav20( X , Y ,options);
        a=sum(Y==labels);
        rate(i)=a/size(Y,2);
        waitbar(i / str2num(num{:}))
    end
    
end
close(h);
try
    close(2);
catch
end
figure(2);
plot(rate,'*');
hold on;
title(['PCA analyzer til ' num{:} ' PC']);
xlabel('PC');
ylabel('success rate');
hold off;
string = 'Success_rate_VS_Pcs.xlsx';
xlswrite(string,rate','Success rate VS Pcs');
handles.message.String = ['the data was exported to ' string];
function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function pushbutton16_Callback(hObject, eventdata, handles)
% indextofreq in coefficients analyzer
% hObject    handle to pushbutton16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
hMain = getappdata(0,'hMain');
Data = getappdata(hMain, 'data');
slider = str2num(handles.edit7.String);
if isempty(slider) || ~size(slider,2) || slider >  Data.PCAdata.numOfEigenValues
    errordlg('Not a valid input. Choose maximum Pc first.', 'Error 5');
    return;
end
num = str2num(handles.edit5.String);
if isempty(num) || ~size(num,2) || num >  Data.numOfObservations
    errordlg('Not a valid input. Choose your Vector first.', 'Error 4');
    return;
end

try
    close(2);
catch
end
figure(2);
hold on;

plot(Data.X(:,num)','color','b')
reconstructed = (Data.PCAdata.scores(1:slider,num)'*Data.PCAdata.coeff(1:slider,:))';
if strcmp(Data.PCAdata.centered,'true')
    reconstructed = reconstructed + mean(Data.X')';
end
plot(reconstructed,'color','r');
title(['reconstructing the vector '  num2str(num) ' til the ' num2str(slider) ' PC']);
xlabel('Features');
legend('original','reconstructed');
grid on;
hold off;
function ChooseRangeTXT_Callback(hObject, eventdata, handles)
% hObject    handle to ChooseRangeTXT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of ChooseRangeTXT as text
%        str2double(get(hObject,'String')) returns contents of ChooseRangeTXT as a double
% --- Executes during object creation, after setting all properties.
function ChooseRangeTXT_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ChooseRangeTXT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function plotdatafunc(Data, handles)

if Data.RangeFlag
    if Data.XaxisFlag
        axis=Data.Xaxis;
    else
        axis=1:Data.numOfFeatures;
    end
else
    if Data.XaxisFlag
        axis=Data.Xaxis;
    else
        axis=1:Data.numOfFeatures;
    end
end

cla;
hold on;
h = {};
a=ones(1,Data.numOfLabels);
b=zeros(1,Data.numOfLabels);
for i=1:Data.numOfLabels
    if i==Data.numOfLabels
        b(i)=length(eval(['Data.label' int2str(i) '(1,:)']));
    else
        a(i+1)=a(i+1)+length(eval(['Data.label' int2str(i) '(1,:)']));
        b(i)=length(eval(['Data.label' int2str(i) '(1,:)']));
    end
end
for i=1:Data.numOfLabels
    h{i} = plot(axis,Data.X(:,sum(a(1:i)):sum(b(1:i))),'color',Data.color(i,:));
    h{i}(2:end) = [];
end
legend([h{:}],Data.names{:});
grid on;
hold off;
% --- Executes on button press in OpenFolderPB.
function OpenFolderPB_Callback(hObject, eventdata, handles)
hMain = getappdata(0,'hMain');
Data = getappdata(hMain, 'data');
if isempty(Data)
    winopen(cd);
else
    winopen(Data.CD);
end
% % --- Executes on button press in TtestPB.
function TtestPB_Callback(hObject, eventdata, handles)


if strcmp(handles.TtestPanel.Visible,'on')
    set(handles.TtestPanel, 'Visible', 'off');
    return;
else
    set( handles.uipanel1, 'Visible', 'off')
    set( handles.uipanel2, 'Visible', 'off')
    set( handles.uibuttongroup6.Children, 'Visible', 'off')
    set( handles.uibuttongroup5.Children, 'Visible', 'off')
    set( handles.uibuttongroup6, 'Visible', 'off')
    set( handles.uibuttongroup5, 'Visible', 'off')
    set(handles.SVMpanel, 'Visible', 'off');
    set(handles.custumpanel, 'Visible', 'off');
    set(handles.TtestPanel, 'Visible', 'on');
end
function tTestEdit1_Callback(hObject, eventdata, handles)
% hObject    handle to tTestEdit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of tTestEdit1 as text
%        str2double(get(hObject,'String')) returns contents of tTestEdit1 as a double
% --- Executes during object creation, after setting all properties.
function tTestEdit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tTestEdit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function tTestEdit2_Callback(hObject, eventdata, handles)
% hObject    handle to tTestEdit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of tTestEdit2 as text
%        str2double(get(hObject,'String')) returns contents of tTestEdit2 as a double
% --- Executes during object creation, after setting all properties.
function tTestEdit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tTestEdit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
% --- Executes on button press in tTestPB.
function tTestPB_Callback(hObject, eventdata, handles)
% hObject    handle to tTestPB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
hMain = getappdata(0,'hMain');
Data = getappdata(hMain, 'data');

NumOfLab=Data.numOfLabels;
labelind=[str2num(handles.tTestEdit1.String), str2num(handles.tTestEdit2.String)];
Data.T=zeros(1,Data.numOfFeatures);
for i=1:Data.numOfFeatures
    Data.T(i)=myttest(eval(['Data.label' int2str(labelind(1)) '(i,:)']),eval(['Data.label' int2str(labelind(2)) '(i,:)']));
end
setappdata(hMain, 'data',Data);
try
    close(2);
catch
end
% try
%     close(3);
% catch
% end
% if isempty(Data.Xaxis)
%     axis=1:length(Data.T);
% else
%     axis=Data.Xaxis;
% end
if Data.RangeFlag
    if Data.XaxisFlag
        axis=Data.Xaxis;
    else
        axis=1:Data.numOfFeatures;
    end
else
    if Data.XaxisFlag
        axis=Data.Xaxis;
    else
        axis=1:Data.numOfFeatures;
    end
end
figure(2);
plot(axis,Data.T);
hold on;
plot(axis,0.95*ones(1,length(Data.T)));
title(['T-test: ' Data.names{labelind(1)} ' Vs ' Data.names{labelind(2)}]);
xlabel('Feature Number');
ylabel('T-test Score');
grid on;
% figure(3);
% semilogy(axis,Data.T);
% hold on;
% semilogy(axis,0.95*ones(1,length(Data.T)));
% title(['T-test: ' Data.names{labelind(1)} ' Vs ' Data.names{labelind(2)}]);
% xlabel('Feature Number');
% ylabel('T-test Score');
% grid on;

% --- Executes on button press in tTestPB2.
function tTestPB2_Callback(hObject, eventdata, handles)
% hObject    handle to tTestPB2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

hMain = getappdata(0,'hMain');
Data = getappdata(hMain, 'data');
labelind=[str2num(handles.tTestEdit1.String), str2num(handles.tTestEdit2.String)];
string = ['tTest_' Data.names{labelind(1)} '_Vs_' Data.names{labelind(2)} '.xlsx'];
string2 = ['t-Score of ' Data.names{labelind(1)} ' Vs ' Data.names{labelind(2)}];
if isempty(Data.Xaxis)
    axis=1:length(Data.T);
else
    axis=Data.Xaxis;
end
xlswrite(string,[axis; Data.T].',string2);


% --- Executes on button press in svm_lin_ker_radio.
function svm_lin_ker_radio_Callback(hObject, eventdata, handles)
handles.svm_pol_ker_radio.Value=0;
handles.svm_rbf_ker_radio.Value=0;
hMain = getappdata(0,'hMain');
Data = getappdata(hMain, 'data');
Data.SVM.kerstr='linear';
setappdata(hMain, 'data',Data);
% --- Executes on button press in svm_pol_ker_radio.
function svm_pol_ker_radio_Callback(hObject, eventdata, handles)
handles.svm_lin_ker_radio.Value=0;
handles.svm_rbf_ker_radio.Value=0;
hMain = getappdata(0,'hMain');
Data = getappdata(hMain, 'data');
Data.SVM.kerstr='polynomial';
setappdata(hMain, 'data',Data);
% --- Executes on button press in svm_PB.
function svm_PB_Callback(hObject, eventdata, handles)

hMain = getappdata(0,'hMain');
Data = getappdata(hMain, 'data');
Data.PCAdata.scores=Data.PCAdata.scores.';
for i=1:length(Data.Y)
    Y{i} = Data.names{Data.Y(i)};
end
Srate=KfoldCVforSVM( Data.PCAdata.scores(:,1:Data.SVM.numofpc),Y,Data.Y,Data.names,Data.SVM.kerstr,Data.SVM.Kfold,Data.SVM.Crange );
Data.PCAdata.scores=Data.PCAdata.scores.';
try
    close(2);
catch
end
figure(2);
plot(Data.SVM.Crange,Srate,'*','MarkerSize',5);
grid on;
xlabel('C');
ylabel('Success Rate');
title(['Success rates Vs C - Kfold Cross Validation | K=',num2str(Data.SVM.Kfold), ' | '...
    ,num2str(Data.SVM.numofpc), '-PC''s' ,' | kernel - ',Data.SVM.kerstr]);

setappdata(hMain, 'data',Data);


% --- Executes on button press in svm_rbf_ker_radio.
function svm_rbf_ker_radio_Callback(hObject, eventdata, handles)
handles.svm_pol_ker_radio.Value=0;
handles.svm_lin_ker_radio.Value=0;
hMain = getappdata(0,'hMain');
Data = getappdata(hMain, 'data');
Data.SVM.kerstr='rbf';
setappdata(hMain, 'data',Data);

% --- Executes on button press in svm_pcnum_radio.
function svm_pcnum_radio_Callback(hObject, eventdata, handles)
handles.svm_pcper_radio.Value=0;
handles.svm_pc_edit_txt2.Visible='off';
handles.svm_pc_edit_txt.Visible='on';
hMain = getappdata(0,'hMain');
Data = getappdata(hMain, 'data');
Data.SVM.numofpc=str2num(handles.svm_pc_edit_txt.String);
setappdata(hMain, 'data',Data);

% --- Executes on button press in svm_pcper_radio.
function svm_pcper_radio_Callback(hObject, eventdata, handles)
handles.svm_pcnum_radio.Value=0;
handles.svm_pc_edit_txt.Visible='off';
handles.svm_pc_edit_txt2.Visible='on';
hMain = getappdata(0,'hMain');
Data = getappdata(hMain, 'data');
Info=str2num(handles.svm_pc_edit_txt2.String);
sum=0;
for i=1:Data.numOfObservations
    sum=sum+Data.PCAdata.wights(i);
    if sum>Info
        Data.SVM.numofpc=i;
        break;
    end
end
setappdata(hMain, 'data',Data);

function svm_C_edit_txt_Callback(hObject, eventdata, handles)
hMain = getappdata(0,'hMain');
Data = getappdata(hMain, 'data');
temp=str2num(handles.svm_C_edit_txt.String);
Data.SVM.Crange=linspace(temp(1),temp(2),temp(3));
setappdata(hMain, 'data',Data);

% --- Executes during object creation, after setting all properties.
function svm_C_edit_txt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to svm_C_edit_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function svm_pc_edit_txt_Callback(hObject, eventdata, handles)
hMain = getappdata(0,'hMain');
Data = getappdata(hMain, 'data');
Data.SVM.numofpc=str2num(handles.svm_pc_edit_txt.String);
setappdata(hMain, 'data',Data);
% --- Executes during object creation, after setting all properties.
function svm_pc_edit_txt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to svm_pc_edit_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function svm_pc_edit_txt2_Callback(hObject, eventdata, handles)
hMain = getappdata(0,'hMain');
Data = getappdata(hMain, 'data');
Info=str2num(handles.svm_pc_edit_txt2.String);
sum=0;
for i=1:Data.numOfObservations
    sum=sum+Data.PCAdata.wights(i);
    if sum>Info
        Data.SVM.numofpc=i;
        break;
    end
end
setappdata(hMain, 'data',Data);
% --- Executes during object creation, after setting all properties.
function svm_pc_edit_txt2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to svm_pc_edit_txt2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function svm_Kfold_edit_txt_Callback(hObject, eventdata, handles)
hMain = getappdata(0,'hMain');
Data = getappdata(hMain, 'data');
Data.SVM.Kfold=str2num(handles.svm_Kfold_edit_txt.String);
setappdata(hMain, 'data',Data);
% --- Executes during object creation, after setting all properties.
function svm_Kfold_edit_txt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to svm_Kfold_edit_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in SVMPB.
function SVMPB_Callback(hObject, eventdata, handles)

hMain = getappdata(0,'hMain');
Data = getappdata(hMain, 'data');
if(isempty(Data.PCAdata))
    errordlg('First you must do PCA');
    return;
end

if strcmp(handles.SVMpanel.Visible,'on')
    set(handles.SVMpanel, 'Visible', 'off');
    return;
else
    set( handles.uipanel1, 'Visible', 'off')
    set( handles.uipanel2, 'Visible', 'off')
    set( handles.uibuttongroup6.Children, 'Visible', 'off')
    set( handles.uibuttongroup5.Children, 'Visible', 'off')
    set( handles.uibuttongroup6, 'Visible', 'off')
    set( handles.uibuttongroup5, 'Visible', 'off')
    set(handles.TtestPanel, 'Visible', 'off');
    set(handles.custumpanel, 'Visible', 'off');
    set(handles.SVMpanel, 'Visible', 'on');
    if ~handles.svm_pcper_radio.Value
        handles.svm_pc_edit_txt2.Visible='off';
    end
end

if handles.svm_pcnum_radio.Value
    Data.SVM.numofpc=str2num(handles.svm_pc_edit_txt.String);
else
    Data.SVM.numofpc=str2num(handles.svm_pc_edit_txt2.String);
end
if handles.svm_lin_ker_radio.Value
    Data.SVM.kerstr='linear';
elseif handles.svm_pol_ker_radio
    Data.SVM.kerstr='polynomial';
else
    Data.SVM.kerstr='rbf';
end
temp=str2num(handles.svm_C_edit_txt.String);
Data.SVM.Crange=linspace(temp(1),temp(2),temp(3));
Data.SVM.Kfold=str2num(handles.svm_Kfold_edit_txt.String);
setappdata(hMain, 'data',Data);


% --- Executes on button press in PCAbox.
function PCAbox_Callback(hObject, eventdata, handles)

% if handles.PCAbox.Value
%     handles.PCAbox.Value=0;
% else
%     handles.PCAbox.Value=1;
% end
% --- Executes on button press in maxpc.
function maxpc_Callback(hObject, eventdata, handles)
set(handles.infopc, 'Value', 0);
set(handles.maxpc, 'Value', 1);
% --- Executes on button press in infopc.
function infopc_Callback(hObject, eventdata, handles)
set(handles.maxpc, 'Value', 0);
set(handles.infopc, 'Value', 1);
% --- Executes on button press in svmradio.
function svmradio_Callback(hObject, eventdata, handles)
set(handles.ldaradio, 'Value', 0);
set(handles.svmradio, 'Value', 1);
% --- Executes on button press in ldaradio.
function ldaradio_Callback(hObject, eventdata, handles)
set(handles.svmradio, 'Value', 0);
set(handles.ldaradio, 'Value', 1);
% --- Executes on button press in radiobutton14.
function radiobutton14_Callback(hObject, eventdata, handles)
set(handles.radiobutton15, 'Value', 0);
set(handles.radiobutton16, 'Value', 0);
set(handles.radiobutton14, 'Value', 1);
% --- Executes on button press in radiobutton15.
function radiobutton15_Callback(hObject, eventdata, handles)
set(handles.radiobutton14, 'Value', 0);
set(handles.radiobutton16, 'Value', 0);
set(handles.radiobutton15, 'Value', 1);
% --- Executes on button press in radiobutton16.
function radiobutton16_Callback(hObject, eventdata, handles)
set(handles.radiobutton15, 'Value', 0);
set(handles.radiobutton14, 'Value', 0);
set(handles.radiobutton16, 'Value', 1);
function edit24_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function edit24_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit25_Callback(hObject, eventdata, handles)
% hObject    handle to edit25 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit25 as text
%        str2double(get(hObject,'String')) returns contents of edit25 as a double


% --- Executes during object creation, after setting all properties.
function edit25_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit25 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit26_Callback(hObject, eventdata, handles)
% hObject    handle to edit26 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit26 as text
%        str2double(get(hObject,'String')) returns contents of edit26 as a double


% --- Executes during object creation, after setting all properties.
function edit26_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit26 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit27_Callback(hObject, eventdata, handles)
% hObject    handle to edit27 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit27 as text
%        str2double(get(hObject,'String')) returns contents of edit27 as a double


% --- Executes during object creation, after setting all properties.
function edit27_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit27 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in radiobutton17.
function radiobutton17_Callback(hObject, eventdata, handles)
set( handles.radiobutton18, 'Value', 0);
set( handles.radiobutton17, 'Value', 1);
% --- Executes on button press in radiobutton18.
function radiobutton18_Callback(hObject, eventdata, handles)
set( handles.radiobutton17, 'Value', 0);
set( handles.radiobutton18, 'Value', 1);
function edit28_Callback(hObject, eventdata, handles)
% hObject    handle to edit28 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit28 as text
%        str2double(get(hObject,'String')) returns contents of edit28 as a double


% --- Executes during object creation, after setting all properties.
function edit28_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit28 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in custum.
function custum_Callback(hObject, eventdata, handles)



if strcmp(handles.custumpanel.Visible,'on')
    set(handles.custumpanel, 'Visible', 'off');
    return;
else
    set( handles.uibuttongroup6.Children, 'Visible', 'off')
    set( handles.uibuttongroup5.Children, 'Visible', 'off')
    set( handles.uipanel1, 'Visible', 'off')
    set( handles.uipanel1.Children, 'Visible', 'off')
    set( handles.uibuttongroup6, 'Visible', 'off')
    set( handles.uibuttongroup5, 'Visible', 'off')
    set( handles.ChooseRangeTXT, 'Visible', 'off');
    set( handles.ChooseRangePB2, 'Visible', 'off');
    set( handles.ExampleText1, 'Visible', 'off');
    set( handles.uipanel2, 'Visible', 'off');
    set(handles.TtestPanel, 'Visible', 'off');
    set(handles.SVMpanel, 'Visible', 'off');
    set(handles.custumpanel, 'Visible', 'on');
    
end




% --- Executes on button press in pushbutton29.
function pushbutton29_Callback(hObject, eventdata, handles)
rng(1)
hMain = getappdata(0,'hMain');
Data = getappdata(hMain, 'data');
pcaflag=handles.PCAbox.Value;
pcnum=[];
info=[];
if pcaflag
    if handles.maxpc.Value
        pcnum=str2num(handles.edit25.String);
    else
        info=str2num(handles.edit26.String);
    end
end
if handles.ldaradio.Value
    classifier='LDA';
else
    classifier='SVM';
end
if strcmp(classifier,'SVM')
    if handles.radiobutton14.Value
        kerstr='linear';
    elseif handles.radiobutton15.Value
        kerstr='polynomial';
    elseif handles.radiobutton16.Value
        kerstr='rbf';
    else
        'error!!!!!!!!!!'
    end
    BoxConstraint=str2num(handles.edit27.String);
end
if handles.radiobutton17.Value
    CV='LOO';
    K=length(Data.Y);
else
    CV='KF';
    K=str2num(handles.edit28.String);
end
X=Data.X.';
Y=Data.Y;
[ R ] = FScorelation( X,Y );
figure()
plot(R,'*')
grid on

Srate0=my_classifier_1( X , Y  , Data.names , classifier , K , BoxConstraint , kerstr , pcaflag , info , pcnum  )
Srate1=my_classifier_1( X.*(ones(size(X,1),1)*R) , Y  , Data.names , classifier , K , BoxConstraint , kerstr , pcaflag , info , pcnum  )
