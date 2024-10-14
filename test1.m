%table 1 generation -descriptive statistics of input data for econometric analysis.
data = readtable('EA19Data.xlsx', 'Sheet', 'List1');
numericalData = table2array(data(:, 2:end));
stats = deskriptor(numericalData);

% Define the row and column labels
rowLabels = {'Mean', 'Median', '1st Quartile', '3rd Quartile', 'Max', 'Min', ...
             'Std. Deviation', 'Skewness', 'Kurtosis', 'Observations'};
columnLabels = data.Properties.VariableNames(2:end);

% Create the table with appropriate labels
T = array2table(stats, 'RowNames', rowLabels, 'VariableNames', columnLabels);

% Display the table
disp(T);

% Run the computations for R0, R1, R2, and R3 as per the script...
%--------------------------------------------------------------------------------------------------------------

O = [mean(R0)' mean(R1)' mean(R2)' mean(R3)'];
out = deskriptor(O);
% Define the row and column names for the table display
rowNames = {'Mean', 'Median', '1st Quartile', '3rd Quartile', ...
    'Maximum', 'Minimum', 'Std. Deviation', 'Skewness', 'Kurtosis', 'Number of Observations'};
colNames = {'R0', 'R1', 'R2', 'R3'};
% Convert the output to a table for easier visualization
summaryTable = array2table(out, 'RowNames', rowNames, 'VariableNames', colNames);
% Display the summary table
disp(summaryTable);
%-------------------------------------------------------------------------------------------------------------------------
