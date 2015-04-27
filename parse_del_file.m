function [nImg, nChannel, nPatchSizeH, nPatchSizeW, nClass] = parse_del_file(model_del_file)

fid = fopen(model_del_file, 'rt');


input_dim = zeros(4, 1);
i = 1;
while ~feof(fid)
    tline = fgets(fid);
    if(length(tline) > length('input_dim: ') && strcmp(tline(1:length('input_dim: ')), 'input_dim: '))
        input_dim(i) = sscanf(tline(length('input_dim: ') + 1:end), '%d');
        i = i + 1;
    end
    if(length(tline) > length('    num_output: ') && strcmp(tline(1:length('    num_output: ')), '    num_output: '))
        nClass = sscanf(tline(length('    num_output: ') + 1:end), '%d');
    end
end

fclose(fid);

nImg = input_dim(1);
nChannel = input_dim(2);
nPatchSizeH = input_dim(3);
nPatchSizeW = input_dim(4);