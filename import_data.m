function [adcp, ctd, h] = import_data(RF, DS)

addpath(strcat(RF,'Tools\adcptoolsGit')); %path to ADCPTools
addpath(strcat(RF,'Tools\loess-master')); %path to loess-master
% addpath(strcat(RF,'Tools\T_Tide'))
addpath(strcat(RF,'Tools\BrewerMap-master')); %path to BrewerMap (see github)
% addpath(strcat(RF,'Tools\subaxis'));

F2 = 'WP2\TwoJunctions\';
addpath(strcat(RF,F2,'\data\processedData')); %path to .mat structs of processed data

adcp = load(['ADCP',DS], '-mat').adcp;
h3 = load('NAPWaterLevels.mat');
h = h3.(['H',DS]); %bit ugly
h.wl = h.wl/100; % cm to m


% ctd = load(['CTD', DS], '-mat').ctd;
% h.time            = datetime(h.date, 'ConvertFrom', 'datenum', 'Format', 'HH:mm:ss');



if strcmp(DS,'NMOMNW15')
    ctd = load(['CTD',DS,'-2.mat']).CTD_20150914 ;
    BN = {' New Meuse'; ' Old Meuse'; ' Rotterdam Waterway'};
else
    ctd = load(['CTD',DS,'-2.mat']).OBSsal;
    BN = {' Hartel Canal'; ' Old Meuse South'; ' Old Meuse North'};
end

ctd = split_branches(ctd, DS, BN); %empirical function filtering the CTD data belonging to each transect
% ctd = split_branches(ctd, DS, BN);
% save(string(strcat('CTD',DS)) , 'ctd')

end
