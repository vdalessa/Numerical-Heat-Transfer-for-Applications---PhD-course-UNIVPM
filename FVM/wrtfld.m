function wrtfld(time, m , field , name, caseName)

%time =1;
Nc = m.numberOfElements;
Nb = m.numberOfBoundaries;

mkdir(caseName,num2str(time));
fname=fullfile(pwd,caseName,num2str(time),name);
%fname= fullfile([pwd "/" num2str(1) "/T"]);
fileID = fopen(fname, 'w');
fprintf(fileID,'%s\n','FoamFile');
fprintf(fileID,'%s\n','{');
fprintf(fileID,'%s\n','    version     2.0;');
fprintf(fileID,'%s\n','    format      ascii;');
fprintf(fileID,'%s\n','    arch        "LSB;label=32;scalar=64;"');
fprintf(fileID,'%s\n','    class       volScalarField;');
fprintf(fileID,'%s\n', ['    location    "',num2str(time),'";']);
fprintf(fileID,'%s\n',['    object      ',name,';']);
fprintf(fileID,'%s\n','}');
%
fprintf(fileID,'%s\n','');
fprintf(fileID,'%s\n','dimensions      [0 0 0 1 0 0 0];');
fprintf(fileID,'%s\n','');
%
% Write internal field
fprintf(fileID,'%s\n','internalField   nonuniform List<scalar>');
fprintf(fileID,'%s\n',num2str(Nc));
fprintf(fileID,'%s\n','(');
for i=1:Nc
    fprintf(fileID,'%s\n',num2str(field(i)));
end
fprintf(fileID,'%s\n',')');
fprintf(fileID,'%s\n',';');
%
% Write boundary field
fprintf(fileID,'%s\n','');
fprintf(fileID,'%s\n','boundaryField');
fprintf(fileID,'%s\n','{');
%
for i=1:Nb
    fprintf(fileID,'%s\n',m.boundaries(i).userName);
    fprintf(fileID,'%s\n','{');
    fprintf(fileID,'%s\n','        type            zeroGradient;');
    fprintf(fileID,'%s\n','}');
end
fprintf(fileID,'%s\n','}');
fclose(fileID);

end