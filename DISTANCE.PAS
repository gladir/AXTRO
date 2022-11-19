{ @author: Sylvain Maltais (support@gladir.com)
  @created: 2022
  @website(https://www.gladir.com/axtro)
  @abstract(Target: Turbo Pascal, Free Pascal)
}

Program DISTANCE;

Uses Strings;

Type
 AstreRec=Record
  Nom:PChar;
  Delta:PChar;
 End;

Const
 Astres:Array[1..6]of AstreRec=(
  (Nom:'Alpha du Centaure';Delta:'4,2 ann‚es-lumiŠre'),
  (Nom:'AndromŠde';Delta:'2 500 000 ann‚es-lumiŠre'),
  (Nom:'Centre de la Voie lact‚e';Delta:'26 000 ann‚es-lumiŠre'),
  (Nom:'Lune';Delta:'1,3 seconde-lumiŠre'),
  (Nom:'Pluton';Delta:'6,7 heures-lumiŠre'),
  (Nom:'Soleil';Delta:'8 minutes-lumiŠre')
 );

Function StrToUpper(S:String):String;
Var
 I:Byte;
Begin
 For I:=1 to Length(S)do Begin
  If S[I]in['‚','Š','ˆ',#232,#233,#234]Then S[I]:='E'Else
  If S[I]in['Œ',#238]Then S[I]:='I'Else
  If S[I] in['a'..'z']Then S[I]:=Chr(Ord(S[I])-32);
 End;
 StrToUpper:=S;
End;

Var
 I,J:Integer;

BEGIN
 If(ParamStr(1)='/?')or(ParamStr(1)='--help')or(ParamStr(1)='-h')or
   (ParamStr(1)='/h')or(ParamStr(1)='/H')Then Begin
  WriteLn('DISTANCE : Cette commande permet d''indiquer ',
                      'la distance d''un astre avec la planŠte Terre.');
  WriteLn;
  WriteLn('Syntaxe : DISTANCE astre');
 End
  Else
 If ParamCount>0 Then Begin
  For I:=1 to ParamCount do Begin
   For J:=Low(Astres) to High(Astres)do Begin
    If StrToUpper(ParamStr(I))=StrToUpper(StrPas(Astres[J].Nom))Then Begin
     WriteLn('Distance entre la terre et ',StrPas(Astres[J].Nom),' est de ',
             StrPas(Astres[J].Delta));
     Break;
    End;
   End;
  End;
 End
  Else
 WriteLn('Vous devez indiquer le nom de l''astre comme par exemple, Lune, Soleil,...');
END.