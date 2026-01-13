% Install IRSL library (package: +irsl)

thisDir = fileparts(mfilename('/Users/shinesrivastava/Desktop/IRSL'));  % IRSL folder
addpath(thisDir);                             % add IRSL to path
savepath;                                     % optional, make permanent

fprintf('✅ IRSL library installed. Use functions as irsl.FunctionName()\n');