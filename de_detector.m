function de_detector
% This is the starting point for a simplified detector based on Marie Roche's  
% teager energy detector. It includes ideas/code snips from Simone, 
% and calls functions from triton.

% The low and hi-res detection passes still happen, but no teager energy 
% is used.

% All input parameters are contained within two separate scripts:
%   dLoad_STsettings : settings for low res detector
%   dLoad_HRsettings : settings for hi res detector
% See those files for info on settings.

% clearvars
close all
fclose all;

% Set transfer function location
tfFullFile = 'E:\Code\TF_files\585_091116_invSensit_MC.tf';

% Location of files to be analyzed
baseDir = 'H:\';

% Name of the deployment. This should be the first few characters in the names 
% of the xwav files you want to look at.
depl = 'GofMX';

% Set flags indicating which routines to run. 
lowResDet = 1; %run short time detector.
highResDet = 1; %run high res detector

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[metaDir] = dBuild_dirs(baseDir);
inDisk = fileparts(baseDir(1:3));

% Build list of xwav names in the base directory
[detFiles,~]= dFind_xwavs(baseDir,depl); % doesn't read in manual detection 
% files in this version, but this can be added pretty easily, using an
% older version.

viewPath = {metaDir, baseDir};
[fullFiles,fullLabels] = get_fileset(baseDir,metaDir,detFiles); % returns a list of files to scan through
% profile on
% profile clear
if ~isempty(detFiles)
    % Short time detector
    if lowResDet == 1
        % load settings
        parametersST = dLoad_STsettings;
        % run detector
        dtST_batch(baseDir,detFiles,parametersST,viewPath,tfFullFile);
    end
    
    % High res detector
    if highResDet == 1
        % load settings
        parametersHR = dLoad_HRsettings;
        % run detector
        dHighres_click_batch(fullFiles,fullLabels,inDisk,parametersHR,viewPath,tfFullFile)
    end
end
% profile viewer
% profile off