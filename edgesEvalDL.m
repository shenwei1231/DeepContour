function varargout = edgesEvalDL( model, varargin )
% Run and evaluate structured edge detector with deep contour features on BSDS500.
% The code is modified from Structured Edge Detection Toolbox

% get default parameters
dfs={'dataType','test', 'name','', 'opts',{}, 'show',0, ...
  'pDistr',{{'type','parfor'}}, 'cleanup',0, 'thrs',99, 'maxDist',.0075};
p=getPrmDflt(varargin,dfs,1);

% load model and update model.opts acoording to opts
if( ischar(model) ), model=load(model); model=model.model; end
for i=1:length(p.opts)/2, model.opts.(p.opts{i*2-1})=p.opts{i*2}; end
rgbd=model.opts.rgbd; model.opts.nms=1;

% get list of relevant directories (image, depth, gt, results)
name = [model.opts.modelFnm,p.name];
imgDir = fullfile(model.opts.bsdsDir,'images',p.dataType);
depDir = fullfile(model.opts.bsdsDir,'depth',p.dataType);
resDir = fullfile(model.opts.modelDir,p.dataType,name);

gtDir  = fullfile(model.opts.bsdsDir,'groundTruth',p.dataType);
evaDir = resDir;


assert(exist(imgDir,'dir')==7); assert(exist(gtDir,'dir')==7);
% run edgesDetect() on every image in imgDir and store in resDir
if( ~exist(fullfile([evaDir '-eval'],'eval_bdry.txt'),'file') )
  if(~exist(resDir,'dir')), mkdir(resDir); end
  ids=dir(imgDir); ids=ids([ids.bytes]>0); ids={ids.name}; n=length(ids);
  ext=ids{1}(end-2:end); for i=1:n, ids{i}=ids{i}(1:end-4); end
  res=cell(1,n); for i=1:n, res{i}=fullfile(resDir,[ids{i} '.png']); end
  do=false(1,n); for i=1:n, do(i)=~exist(res{i},'file'); end
  ids=ids(do); res=res(do); m=length(ids);
  for i=1:m, id=ids{i};
    I = imread(fullfile(imgDir,[id '.' ext])); D=[];
    if(rgbd), D=single(imread(fullfile(depDir,[id '.png'])))/1e4; end
    if(rgbd==1), I=D; elseif(rgbd==2), I=cat(3,single(I)/255,D); end
    model.imgId = id;
    tic;
    E=edgesDetectDL(I,model); imwrite(uint8(E*255),res{i});
    toc;
  end
end

% perform actual evaluation using edgesEvalDir
varargout=cell(1,max(1,nargout));
[varargout{:}] = edgesEvalDir('resDir',resDir,'gtDir',gtDir,...
  'pDistr',p.pDistr,'cleanup',p.cleanup,'thrs',p.thrs,'maxDist',p.maxDist);
if( p.show ), figure(p.show); edgesEvalPlot(evaDir,name); end

end
