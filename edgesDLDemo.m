% Demo for Deep Countour Detector (please see readme.txt first).
function edgesDLDemo(dlPara)

%% set opts for training (see edgesTrain.m)
opts=edgesTrainDL();                % default options (good settings)
opts.modelDir='models/';          % model will be in models/forest
opts.modelFnm='modelBsds';        % model name
opts.nPos=5e5; opts.nNeg=5e5;     % decrease to speedup training
opts.useParfor=0;                 % parallelize if sufficient memory

%% train edge detector
tic, model=edgesTrainDL(dlPara); toc; % will load model if already trained

%% set detection parameters (can set after training)
model.opts.multiscale=0;          % for top accuracy set multiscale=1
model.opts.sharpen=2;             % for top speed set sharpen=0
model.opts.nTreesEval=4;          % for top speed set nTreesEval=1
model.opts.nThreads=4;            % max number threads for evaluation
model.opts.nms=0;                 % set to true to enable nms
model.opts.modelDir = dlPara.modelDir;
%%
%To achieve 0.76 F-measure, set "model.opts.nTreesEval=10" and
%"model.opts.multiscale=1".
%%
%% evaluate edge detector on BSDS500 (see edgesEval.m)
if(1), edgesEvalDL( model, 'show',1, 'name',''); end