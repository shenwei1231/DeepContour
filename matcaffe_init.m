function  matcaffe_init(use_gpu, model_def_file, model_file, gpu_id)
% matcaffe_init(model_def_file, model_file, use_gpu)
% Initilize matcaffe wrapper

if nargin < 1
  % By default use CPU
  use_gpu = 0;
end
% if nargin < 2 || isempty(model_def_file)
%   % By default use imagenet_deploy
%   model_def_file = '../../examples/car/car_deploy.prototxt';
% end
% if nargin < 3 || isempty(model_file)
%   % By default use caffe reference model
%   model_file = '../../examples/car/caffe_car_train_iter_80000';
% end


if caffe2('is_initialized') == 0
  if exist(model_file, 'file') == 0
    % NOTE: you'll have to get the pre-trained ILSVRC network
    error('You need a network model file');
  end
  if ~exist(model_def_file,'file')
    % NOTE: you'll have to get network definition
    error('You need the network prototxt definition');
  end
  caffe2('init', model_def_file, model_file)
else
    caffe2('reset');
    if exist(model_file, 'file') == 0
        % NOTE: you'll have to get the pre-trained ILSVRC network
        error('You need a network model file');
    end
    if ~exist(model_def_file,'file')
        % NOTE: you'll have to get network definition
        error('You need the network prototxt definition');
    end
    caffe2('init', model_def_file, model_file)
end
fprintf('Done with init\n');

% set to use GPU or CPU
if use_gpu
  fprintf('Using GPU Mode\n');
  caffe2('set_mode_gpu');
else
  fprintf('Using CPU Mode\n');
  caffe2('set_mode_cpu');
end
fprintf('Done with set_mode\n');

% put into test mode
caffe2('set_phase_test');
fprintf('Done with set_phase_test\n');

if use_gpu
   fprintf('choose gpu\n'); 
    caffe2('set_device', gpu_id);
end
