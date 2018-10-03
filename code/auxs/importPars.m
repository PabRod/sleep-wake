function pars = importPars(filename, id)
%IMPORTPARS Imports the model parameters from a .csv file
%
%   Example:
%   pars = importPars('philrob.csv', 'philrob2007');

%% Default identifier
if nargin == 1
    id = 1; % Select first row in table by default
end

%% Import
table = readtable(filename, 'ReadRowNames', true);

%% Select
if ischar(id) || isstring(id) % Call it by row name
    selected_row = table({char(id)}, :);
else % Call it by row index
    selected_row = table(id, :);
end

%% Format output
pars = table2struct(selected_row);

end