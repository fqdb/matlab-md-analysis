% https://nl.mathworks.com/matlabcentral/answers/463302-how-to-save-automatically-all-opened-figures-unknown-amount-in-one-pdf-file

% Get handles to all open figures:
figHandles = findall(0,'Type','figure'); 

% Create filename c
fn = '';
 
 % Save first figure
 export_fig(fn, '-pdf', figHandles(1))
 
 % Loop through figures 2:end
 for i = 2:numel(figHandles)
     export_fig(fn, '-pdf', figHandles(i), '-append')
 end