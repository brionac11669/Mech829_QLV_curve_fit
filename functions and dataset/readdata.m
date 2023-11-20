function [data_out,dedt]=readdata(filename,flag)
if flag=='n'||flag=="no"||flag=='0'||flag==0
        dataset=[filename,'.txt'];
        data_out=rmmissing(abs(readtable(dataset)));
        dedt=readmatrix(dataset,'range',[18 2 18 2]);
elseif flag=='y'||flag=="yes"||flag=='0'||flag==0
        data_out=rmmissing(abs(filename.table));
        dedt=filename.dedt;
end
if max(abs(diff(data_out.Position_z__Mm(31:35))))>1e-3
    data_out(1:27,:)=[];
end

end
