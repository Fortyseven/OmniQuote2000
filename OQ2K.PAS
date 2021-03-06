{G+,A+,X+}
Program OmniQuote2000;
{ PUT IN PREVIEW MODE!!}
{ ???? NUMBER OF BANNERS INCONSISTANT WITH ACTUAL NUMBER }
{   敖様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様幼�
    �  樂炳�    .        .        栩   樂炳� �       .       �          �
    � 渟� 渟� � 樛 樛�   � 樛�   樛� �渟� 渟� 樛  樛  樛�   栩   � 樛�  �
      栩  .栩 .栩 栩 栩   栩 栩   栩  栩   栩  栩 �  栩 栩 炳桎  樂� 栩
      渟� 渟�. 栩 栩 栩 . 栩 栩 . 栩  渟毬渟�  栩 �  栩 栩  栩  樂桎烝�
       炳樂�  樂� 栩 炳樛樂� 炳樛樂桀  炳栩�   炳槹� 炳樂�  炳槹  炳樛�
          �                              炳� �     .
     � -陳田-- �        .           �      烝    �                .   .
          � 炳栩栩桀       樂栩栩桀.     樂栩栩桀   .  樂栩栩桀
       �  |       栩泅    渟桎  炳桍   .渟桎. 炳桍    渟桎  炳桍    .
          .   樂栩桎      栩� �  渟�    栩�    渟�    栩�  . 渟�    |
     .       栩�          渟桀  樂桍    渟桀 .樂桍.   渟桀  樂桍    � .
            栩栩栩栩�  .   炳栩栩桎  .   炳栩栩桎      炳栩栩桎 �-陳田陳--�
       �                                            �               �
    �      .    An entire rewrite of the original OmniQuote!   �    |   �
    �                   (c)1996 Hacsoft Developments!               .   �
    青様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様幼�
}
Uses HSD, CRTASM, UTILS, CRT, INI, OQ_MISC;
Const
     DefLine1    ='OmniQuote2k |VE - Time:|TI - Date:|DA';
     DefLine2    ='|TA^M';
     MaxLines    =9;
{陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳}
Procedure ReadConfig(s:string);
Var x        :byte;
    allblank :boolean;
Begin
 ConfigFilename:=S;
 AllBlank:=True;
 if not exist(s) then err(errConfigNotFound,s,'');
 with cfg do
      begin
         getINIToggle(s,'PipesEnabled',    RenPipes);
         getINIString(s,'UseSetNumber','Random', Rnd);
         getINIToggle(s,'ANSI',            ANSI);
         getINIToggle(s,'ForceLowASCII',   ForceLowASCII);
         GetINIString(s,'SendTo','CON',    cfg.ComPort);
{         showtagline:=true;}
{         showsig:=true;}
         if cfg.Comport='CON' then CON:=True;
         {GET TAGLINE FILENAME}
         GetINIString(s,'TaglinePath','',TaglineFile);
         if taglinefile<>'' then
                         if not exist(taglinefile) then
                                       err(errTaglineFileNotFound, taglinefile,'');
               begin
                  for x:=0 to 9 do
                         begin
                           GetINIString(s,'SIG'+b2dec(x),'',randsig[x]);
                           if randsig[x]<>'' then
                                            begin
{                                              allblank:=false;}
                                              if not exist(randsig[x]) then
                                                               err(errNoFindRandSigFile,randsig[x],'SIG'+b2dec(x));
                                            end;
                         end;
{                        if allblank then err(errAllBlankRandom,'','');}
                       end;

         For x:=0 to 9 do               {GET FIRST LINE BANNER DEFINITIONS}
                     begin
                       GetINIString(s,'LINE1_'+b2dec(x),'',oqLine1[x]);
                       if oqLine1[x]='' then
                                   begin
                                     maxLine1:=x;
                                     break;
                                   end;
                     end;

         For x:=0 to 9 do               {GET SECOND LINE BANNER DEFINITIONS}
                     begin
                       GetINIString(s,'LINE2_'+b2dec(x),'',oqLine2[x]);
                       if oqLine2[x]='' then
                                   begin
                                     maxLine2:=x;
                                     break;
                                   end;
                     end;

      end; {WITH}
End; {READ CONFIG}
{陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳}
Procedure ShowLine1;
Begin
   if maxLine1>0 then
      if upcase(cfg.rnd[1])='R' then outpipe(cfg.oqLine1[random(maxLine1)])
                                else
                                    begin
                                      if stow(cfg.rnd) in [0..MaxLines] then
                                           outpipe(cfg.oqLine1[stow(cfg.rnd)]);
                                    end;
End;
{陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳}
Procedure ShowLine2;
Begin
   if maxLine2>0 then
      if upcase(cfg.rnd[1])='R' then outpipe(cfg.oqLine2[random(maxLine2)])
                                else
                                    begin
                                      if stow(cfg.rnd) in [0..MaxLines] then
                                           outpipe(cfg.oqLine2[stow(cfg.rnd)]);
                                    end;

End;
{陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳}
{陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳}
{陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳}
{陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳}
{陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳}
{陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳}
Procedure PerformOmniQuoteDuties;
Begin
  if con             then clrscr;
{  if maxLine1>0 then outpipe(cfg.oqLine1[random(maxLine1)]);
  if maxLine2>0 then outpipe(cfg.oqLine2[random(maxline2)]);}
  ShowLine1;
  ShowLine2;
End;
{陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳}
{陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳}
{陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳}
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
{陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳}
Procedure DeInit;
Begin
     if not CON then begin flush(com); Close(com); end;
End;
{陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳}
Begin
     Init;
     PerformOmniQuoteDuties;
     DeInit;
End.
(* FEARLESS WRETCH...INSANITY...HE WATCHES...LURKING...*)