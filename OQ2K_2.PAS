{$G+,A+,X+,R-,I-,S-,D+,L+,Q-,N-,E-}
Program OmniQuote2000;
{   �������������������������������������������������������������������Ŀ
    �  �����    .        .        ��   ����� �       .       �          �
    � ��� ��� � �� ���   � ���   ��� ���� ��� ��  ��  ���   ��   � ���  �
      ��  .�� .�� �� ��   �� ��   ��  ��   ��  �� �  �� �� ����  ��� ��
      ��� ���. �� �� �� . �� �� . ��  �������  �� �  �� ��  ��  �������
       �����  ��� �� ������� ��������  �����   ����� �����  ����  �����
          �                              ��� �     .
     � -����-- �        .           �      ��    �                .   .
          � ��������       ��������.     ��������   .  ��������
       �  |       ����    ����  ����   .����. ����    ����  ����    .
          .   ������      ��� �  ���    ���    ���    ���  . ���    |
     .       ���          ����  ����    ���� .����.   ����  ����    � .
            ���������  .   ��������  .   ��������      �������� �-������--�
    �               New and improved WITHOUT Beta Carotine!         �
                                                                    |
    �      .    An entire rewrite of the original OmniQuote!   �    .   �
    �                   (c)1996 Hacsoft Developments!                   �
    ���������������������������������������������������������������������
                   Development Revision 2 Thu 01-11-1996
    This version will allow for MaxLongInt of any and all multiple
    parameters...

    Bugs:
         Be aware, that while the file pickers are able to pick from
         2,147,483,647 items, the random function can only handle
         up to 65535 items.  Damn.  Work'n on it...
}
Uses HSD, TEMPFIX, CRTASM, UTILS, CRT, INI, OQ_MISC;
Const
     DefLine1    ='OmniQuote2k |VE - Time:|TI - Date:|DA';
     DefLine2    ='|TA^M';
{����������������������������������������������������������������}
Procedure ReadConfig(s:string);
Var x        :byte;
Begin
 ConfigFilename:=s;
 if not exist(s) then err(errConfigNotFound,s,'');
 with cfg do
      begin
         getINIToggle(s,'PipesEnabled',    RenPipes);
         getINIString(s,'UseSetNumber','RANDOM', Rnd);
         getINIToggle(s,'ANSI',          ANSI);
         getINIToggle(s,'ForceLowASCII',   ForceLowASCII);
         GetINIString(s,'SendTo','CON',  ComPort  );
         GetINIString(s,'TaglinePath','',TaglineFile);
         RandomSigFile:=RandomList(s,'Signature List Start','Signature List End');
         if randomsigfile[1]=^E then err(errList, randomsigfile[2], 'Signatures');
         if upcase(cfg.Rnd[1])='R' then
           begin
             RandomLine1  :=RandomList(s,'Line 1 Defines Start','Line 1 Defines End');
             if randomLine1[1]=^E then err(errList, randomLine1[2], 'Line 1 Defines');
             RandomLine2  :=RandomList(s,'Line 2 Defines Start','Line 2 Defines End');
             if randomLine2[1]=^E then err(errList, randomLine2[2], 'Line 2 Defines');
           end else
           begin
             RandomLine1  :=GetItemList(s,'Line 1 Defines Start','Line 1 Defines End',stow(rnd));
              if randomLine1[1]=^E then err(errList, randomLine2[2], 'Line 1 Defines');
             RandomLine2  :=GetItemList(s,'Line 2 Defines Start','Line 2 Defines End',stow(rnd));
              if randomLine2[1]=^E then err(errList, randomLine2[2], 'Line 2 Defines');
           end;
         if not exist(taglinefile) then err(errTaglineFileNotFound, taglinefile,'');
         if Comport='CON' then CON:=True;
     end;
End; {READ CONFIG}
{����������������������������������������������������������������}
{����������������������������������������������������������������}
{����������������������������������������������������������������}
{����������������������������������������������������������������}
{����������������������������������������������������������������}
{����������������������������������������������������������������}
{����������������������������������������������������������������}
Procedure PerformOmniQuoteDuties;
Begin
  if con then clrscr;
  outpipe(cfg.RandomLine1);
  outpipe(cfg.RandomLine2);
End;
{����������������������������������������������������������������}
{����������������������������������������������������������������}
{����������������������������������������������������������������}
Procedure Init;
Begin
   randomize;
   cfg.comport:=DefaultCom;
   CheckBreak:=False;
   if (paramcount >= 1) then ReadConfig(paramstr(1))
                        else ReadConfig(defaultconfig);
   If not CON then
                begin
                  assign(com, cfg.comport);
                  rewrite(com);
                end;
End;
{����������������������������������������������������������������}
Procedure DeInit;
Begin
     if not CON then begin flush(com); Close(com); end;
End;
{����������������������������������������������������������������}
Begin
     Init;
     PerformOmniQuoteDuties;
     DeInit;
End.
(* FEARLESS WRETCH...INSANITY...HE WATCHES...LURKING...*)