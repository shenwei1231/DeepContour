function S = edgesChnsDL2(I, opts)

shirk = opts.shrink;
PATCH_MEAN = opts.patch_mean;
patchSize = size(PATCH_MEAN, 1);
radius = round((patchSize - 1) / 2);

I = I(:, :, [3 2 1]);
I = permute(I, [2 1 3]);
I = imPad(I, radius, 'symmetric');

S = caffe2('test_image', single(I), PATCH_MEAN, shirk);
S = permute(S, [3, 2, 1]);