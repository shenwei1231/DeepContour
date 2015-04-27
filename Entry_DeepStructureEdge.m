clear
clc

addpath(genpath(pwd));
addpath('../../edges-master');
deep_model_path = 'model_deep_contour/';
deepModel.model_del_file = [deep_model_path 'deploy_cov4.prototxt'];
deepModel.model_file = [deep_model_path 'deep_contour_model'];
deepModel.mean_proto_file = [deep_model_path 'mean.binaryproto.txt'];
deepModel.use_gpu = 1;
modelDir = [deep_model_path 'models'];
use_gpu = deepModel.use_gpu;
gpu_id = 0;
[nBatch, nC, patchSize, ~, nOutputNum] = parse_del_file(deepModel.model_del_file);

PATCH_MEAN = single(dlmread(deepModel.mean_proto_file));

PATCH_MEAN = single(reshape(PATCH_MEAN, patchSize, patchSize, nC));

if exist('use_gpu', 'var')
  matcaffe_init(deepModel.use_gpu, deepModel.model_del_file, deepModel.model_file, gpu_id);
else
  matcaffe_init();
end
featSelecttion = false;

if featSelecttion
    if exist([modelDir '/feat_selection.mat'], 'file')
        load([modelDir '/feat_selection.mat']);
    else
        [selected_dims, ndim] = deepSparseFeatSelection([modelDir '/feat/'], 1e-3, 0.7);
        if(~isempty(ndim) && ~isempty(selected_dims))
            save([modelDir '/feat_selection.mat'], 'selected_dims', 'ndim');
        end
    end
else
    selected_dims = [];
end

dlPara.selected_dims = selected_dims;
dlPara.patch_mean = PATCH_MEAN;
dlPara.modelDir = modelDir;


edgesDLDemo(dlPara);