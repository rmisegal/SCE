function totalKill = KillExcel_COM_Process()
% In some circumstances, Excel ActivX (COM) may not shut down after calling
% XLSREAD, XLSWRITE, or XLSINFO from MATLAB.
% To communicate with Excel the Matlab is using ActiveX.
% The way ActiveX works is that if 2 applications both make connections to
% the same server, the server will not close until both applications have
% terminated their connection. 
% e.g if your folder are sinced with the cloud then the Matlab and the Sinc
% program are using the same ActiveX.
totalKill=0;
if ismac
    % Code to run on Mac plaform
    disp('Close Excel ActiveX: Can not perform the Mac system command: tasklist /FO "CSV" /NH /FI "IMAGENAME eq EXCEL.EXE" /FI "WINDOWTITLE eq HardwareMonitorWindow"');
elseif isunix
    % Code to run on Linux plaform
    disp('Close Excel ActiveX: Can not perform the Linux system command: tasklist /FO "CSV" /NH /FI "IMAGENAME eq EXCEL.EXE" /FI "WINDOWTITLE eq HardwareMonitorWindow"');
elseif ispc
    % Code to run on Windows platform
    %[aa, PidLine]=system('tasklist /FO "CSV" /NH /M Microsoft.Office.PolicyTips.dll');
    [aa, PidLine]=system('tasklist /FO "CSV" /NH /FI "IMAGENAME eq EXCEL.EXE" /FI "WINDOWTITLE eq HardwareMonitorWindow"');
    PidLine=strrep(PidLine,'"','');
    PidVector=split(PidLine,',');
    [a b] = size(PidVector);
    while a>1 || totalKill>50 %check if there are proccess to kill and limit it up to 50
        %for i=2:5:a
        cmd= 'taskkill /F /PID ';
        kill_cmd=[cmd ' ' char(PidVector(2))];
        [stm1 stm2] = system(kill_cmd);
        totalKill=totalKill+1;          
        [aa, PidLine]=system('tasklist /FO "CSV" /NH /FI "IMAGENAME eq EXCEL.EXE" /FI "WINDOWTITLE eq HardwareMonitorWindow"');
        PidLine=strrep(PidLine,'"','');
        PidVector=split(PidLine,',');
        [a b] = size(PidVector);
    end
else
    disp('Platform not supported')
end
