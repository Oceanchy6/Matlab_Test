function [fileList] = find_files(dirName, extension, ignore_dirs)

if ~exist('ignore_dirs', 'var')
    ignore_dirs = {};
end

ignore_dirs_full = cat(2,{'.','..'},ignore_dirs);

  dirData  = dir(dirName);     %# Get the data for the current directory
  dirIndex = [dirData.isdir];   %# Find the index for directories
  fileList = {dirData(~dirIndex).name}';  %# Get a list of the files
  
  mat_ind = cellfun(@(x) strcmpi(x(end-3:end), extension), fileList, 'UniformOutput', true); % FIND XML FILES
  fileList = fileList(mat_ind); % keep only XML files
      
  if ~isempty(fileList)
      
      fileList = cellfun(@(x) fullfile(dirName,x), fileList, 'UniformOutput', false);  %# Prepend path to files
      
  end
  
  subDirs = {dirData(dirIndex).name};  %# Get a list of the subdirectories
  validIndex = ~ismember(subDirs, ignore_dirs_full);  %# Find index of subdirectories
                                               %#   that are not '.' or '..'
                                               
  for iDir = find(validIndex)                  %# Loop over valid subdirectories
      nextDir = fullfile(dirName,subDirs{iDir});    %# Get the subdirectory path
      fileList = [fileList; find_files(nextDir, extension, ignore_dirs)];    %# Recursively call getAllFiles
  end

end
