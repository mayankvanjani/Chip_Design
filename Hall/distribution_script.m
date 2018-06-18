% Created by Emma Gan 09/03/17

% Inputs are Excel table and number of bins. A Gaussian distribution of each
% parameter in the table is calculated. A summary table of means and sigmas
% will be generated, and pictures of the distributions will be saved to a
% folder called 'distributions.'
clc
clear all
close all
numBins = 20;
excel_Table = 'table.xlsx';


%% Conversion from Excel to table variable in MATLAB
name = regexprep(excel_Table,'.xlsx','');
T = readtable(excel_Table);
T(:,1) = []; % deletes the coordinates column
T(end,:) = []; % deletes the 'Average' row
summary = table;



num = 1;

while num < width(T)+1
        % Probability density function automatically fitted by MATLAB
        pd = fitdist(T{:,num},'Normal');

        % Plot the data as a histogram
        figure;
        histfit(T{:,num},numBins,'normal');
        xlabel(T.Properties.VariableNames{num},'interpreter','none')
        ylabel('Count');
        figname = strcat(T.Properties.VariableNames{num},' distribution.jpg');
        saveas(gcf,figname);

        % Create new column in summary table
        summary(:,num) = num2cell([pd.mu; pd.sigma]);
        num = num+1;

end



summary.Properties.VariableNames = {'original_2D_int','fitted_2D1_int','fitted_2D2_int',...
    'original_G_int','fitted_G_int','original_D_int','fitted_D_int','Dpr_int',...
	'twoD1_area','twoD2_area','G_area','D_area','Dpr_area','original_2D_freq',...
    'fitted_2D1_freq','fitted_2D2_freq','original_G_freq','fitted_G_freq',...
    'original_D_freq','fitted_D_freq','Dpr_freq','twoD1_FWHM','twoD2_FWHM',...
    'G_FWHM','D_FWHM','Dpr_FWHM','original_2D_offset','fitted_2D1_offset',...
	'fitted_2D2_offset','original_G_offset','fitted_G_offset','original_D_offset',...
    'fitted_D_offset','Dpr_offset',...
    'I2D_IG','ID_IG','IDpr_IG','ID_IDpr','A2D_AG','AD_AG','ADpr_AG',...
    'L_a','n_d','L_d'};
summary.Properties.RowNames = {'Mean','Sigma'};
writetable(summary,strcat(name,' summary.xlsx'),'WriteRowNames',true);

