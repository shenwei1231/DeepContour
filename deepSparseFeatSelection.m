function [selected_dims, ndim] = deepSparseFeatSelection(deepFeatPath, zero_th, sparsity_th)

feat_files = dir([deepFeatPath, '*.mat']);
bFirst = true;
nfile = length(feat_files);
for i = 1:nfile
    file_name = feat_files(i).name;
    load([deepFeatPath file_name]);
    if bFirst
        [h, w, ndim] = size(deepFeat);
        sparsityDims = zeros(size([1:ndim]'));
        bFirst = false;
    end
    sparsityDims = sparsityDims + squeeze(sum(sum(deepFeat < zero_th)));
end
try
    sparsityDims = sparsityDims / (nfile * h * w);


    selected_dims = find(sparsityDims > sparsity_th);
catch
    selected_dims = [];
    ndim = [];
end