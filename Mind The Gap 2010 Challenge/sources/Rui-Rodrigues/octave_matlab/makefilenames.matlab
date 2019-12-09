function texto=makefilenames(folder,signal)

%folder is for example 'b21'
%signal is for example 'ecgavr'

base='../';

directoria=strcat (base,folder,'/');

ext='.txt';

%nomes dos varios ficheiros

longsignals='_longsignals';

rbmvislinearhiddendata='rbmvislinearhiddendata_';

netrbmvislinear='netrbmvislinear_';

netrbmlogistic='netrbmlogistic_';

lasterror='lasterror_';

fwd_data_rbmvislinear='fwd_data_rbmvislinear_';

autoencoder_allcoeficients='autoencoder_allcoeficients_';

autoencoder_allcoeficientsgsl='autoencoder_allcoeficientsgsl_';

patchdata='patchdata_';

fwdautoencoder_data='fwdautoencoder_data_';

autoencoderbackpropweights='autoencoderbackpropweights_';

imagedata_afterbackprop='imagedata_afterbackprop_';

imagedata_after_rbmbackprop='imagedata_after_rbmbackprop_';

firstlayerdata='firstlayerdata_';

secondlayerdata='secondlayerdata_';

patch_fwd_data_rbmvislinear='patch_fwd_data_rbmvislinear_';

backprop_rbmvislinear_weights='backprop_rbmvislinear_weights_';

backprop_rbmlogistic_weights='backprop_rbmlogistic_weights_';

backprop_rbmvislinear_image='backprop_rbmvislinear_image_';

backprop_rbmlogistic_image='backprop_rbmlogistic_image_';


%%%%start

texto=strcat (directoria,signal,longsignals,ext,'\n');

texto=strcat (texto,directoria,rbmvislinearhiddendata ,signal,ext,'\n');

texto=strcat (texto,directoria,netrbmvislinear ,signal,'.dat','\n');

texto=strcat (texto,directoria,netrbmlogistic  ,signal,'.dat','\n');

texto=strcat (texto,directoria,lasterror ,signal,ext,'\n');

texto=strcat (texto,directoria, fwd_data_rbmvislinear  ,signal,ext,'\n');

texto=strcat (texto,directoria, autoencoder_allcoeficients  ,signal,ext,'\n');

texto=strcat (texto,directoria, autoencoder_allcoeficientsgsl ,signal,ext,'\n');

texto=strcat (texto,directoria, patchdata ,signal,ext,'\n');

texto=strcat (texto,directoria, fwdautoencoder_data ,signal,ext,'\n');

texto=strcat (texto,directoria, autoencoderbackpropweights ,signal,ext,'\n');

texto=strcat (texto,directoria, imagedata_afterbackprop ,signal,ext,'\n');

texto=strcat (texto,directoria, imagedata_after_rbmbackprop ,signal,ext,'\n');

texto=strcat (texto,directoria, firstlayerdata ,signal,ext,'\n');

texto=strcat (texto,directoria, secondlayerdata ,signal,ext,'\n');

texto=strcat (texto,directoria, patch_fwd_data_rbmvislinear ,signal,ext,'\n');

texto=strcat (texto,directoria, backprop_rbmvislinear_weights ,signal,ext,'\n');

texto=strcat (texto,directoria, backprop_rbmlogistic_weights ,signal,ext,'\n');

texto=strcat (texto,directoria, backprop_rbmvislinear_image ,signal,ext,'\n');

texto=strcat (texto,directoria, backprop_rbmlogistic_image ,signal,ext,'\n');





