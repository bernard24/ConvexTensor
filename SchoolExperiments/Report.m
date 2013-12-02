 function Report( experiment )
%REPORT Summary of this function goes here
%   Detailed explanation goes here

addpath('../TotanaImpl');
addpath('../../Totana2');
addpath('../../Totana2/PlotFunctions');
addpath('../../Totana2/tensor_toolbox');

% D.description={{@select,1}, 'Measures', @average, 'Results'};
 D.description={{@select,1}, 'Measures', {@select,1}, 'beta', @average, 'Results'};
% D.description={{@select,1}, 'Measures', @minimize, 'beta', @minimize, 'alpha', @average, 'Results'};
%D.description={{@select,1}, 'Measures', @minimize, 'alpha', @average, 'Results'};
% D.description={{@select,1}, 'Measures', @minimize, 'beta', @minimize, 'alpha'};
D.tag='Testing...';
makeReport(experiment, D);

end

