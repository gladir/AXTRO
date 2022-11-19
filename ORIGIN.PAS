{ @author: Sylvain Maltais (support@gladir.com)
  @created: 2022
  @website(https://www.gladir.com/axtro)
  @abstract(Target: Turbo Pascal, Free Pascal)
}

Program ORIGIN;

Uses Strings;

Type
 OriginRec=Record
  Nom:PChar;
  Org:PChar;
 End;

Const
 Origins:Array[1..9]of OriginRec=(
  (Nom:'Avril';Org:'V‚nus'),
  (Nom:'Dimanche';Org:'Soleil'),
  (Nom:'Jeudi';Org:'Jupiter'),
  (Nom:'Lundi';Org:'Lune'),
  (Nom:'Mardi';Org:'Mars'),
  (Nom:'Mars';Org:'Mars'),
  (Nom:'Mercredi';Org:'Mercure'),
  (Nom:'Samedi';Org:'Saturne'),
  (Nom:'Vendredi';Org:'V‚nus')
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
  WriteLn('ORIGIN : Cette commande permet d''indiquer ',
                      'l''origine astronomique du mot.');
  WriteLn;
  WriteLn('Syntaxe : ORIGIN mot');
 End
  Else
 If ParamCount>0 Then Begin
  For I:=1 to ParamCount do Begin
   For J:=Low(Origins) to High(Origins)do Begin
    If StrToUpper(ParamStr(I))=StrToUpper(StrPas(Origins[J].Nom))Then Begin
     WriteLn('L''origine astronomique du mot ®',StrPas(Origins[J].Nom),'¯ ',
             'provient de ®',StrPas(Origins[J].Org),'¯.');
     Break;
    End;
   End;
  End;
 End
  Else
 WriteLn('Mot attendue !');
END.