
Function HiAsciiFilter(s:string):String;
Const
     Connectors:string='ڿ��ô�ɻ��̹�ƵոԾ�ַӽǶ�';
     hLines    :string='���߯����';
     vLines    :string='��������';
     Blocks    :string='۲������';
var x:byte;
    z:string;
Begin
    z:=s;
    for x:=1 to length(s) do
        begin
         if pos(z[x],connectors)>0  then z[x]:='+';
         if pos(z[x],hLines)>0      then z[x]:='-';
         if pos(z[x],vLines)>0      then z[x]:='|';
         if pos(z[x],Blocks)>0      then z[x]:='x';
         if (z[x]<#32) or (z[x]>#127) then z[x]:='.';
        end;
    hiasciifilter:=z;
End;
Begin
        writeln(HiAsciiFilter('����������ͻ'));
        writeln(HiAsciiFilter('����������Ľ'));
End.