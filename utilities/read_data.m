function [data_out,dedt]=read_data(filename)
if isa(filename,'char')||isa(filename,'string')
    filename=[filename,'.txt'];
    data=rmmissing(abs(readtable(filename)));
    dedt=readmatrix(filename,'range',[18 2 18 2]);
else
    data=rmmissing(abs(filename.table));
    dedt=filename.dedt;
end
if max(abs(diff(data.Position_z__Mm(31:35))))>1e-3
    data(1:27,:)=[];
end
if isa(data,'table')
    data_out.time=data.Time_S;
    data_out.force=data.Fz_N;
    data_out.eps=data.Position_z__Mm;
end
end