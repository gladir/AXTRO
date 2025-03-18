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
  AnneeLumiere:Real;
  Delta:PChar;
 End;

Const
 Astres:Array[1..13]of AstreRec=(
  (Nom:'Alpha du Centaure';
   AnneeLumiere:4.37;       Delta:'4,37 ann‚es-lumiŠre'),
  (Nom:'AndromŠde';
   AnneeLumiere:2500000.0;  Delta:'2 500 000 ann‚es-lumiŠre'),
  (Nom:'Centre de la Voie lact‚e';
  AnneeLumiere:26500.0;     Delta:'26 500 ann‚es-lumiŠre'),
  (Nom:'Lune';
   AnneeLumiere:0.000000038;Delta:'1,28 secondes-lumiŠre'),
  (Nom:'Mercure';
   AnneeLumiere:0.00000612; Delta:'3,2 minutes-lumiŠre'),
  (Nom:'Pluton';
   AnneeLumiere:0.00062299; Delta:'5,5 heures-lumiŠre'),
  (Nom:'Soleil';
   AnneeLumiere:0.00001581; Delta:'8,3 minutes-lumiŠre'),
  (Nom:'V‚nus';
   AnneeLumiere:0.00000272; Delta:'1,4 minutes-lumiŠre'),
  (Nom:'Mars';
   AnneeLumiere:0.00000593; Delta:'3,2 minutes-lumiŠre'),
  (Nom:'Jupiter';
   AnneeLumiere:0.00008217; Delta:'43 minutes-lumiŠre'),
  (Nom:'Saturne';
   AnneeLumiere:0.00015094; Delta:'1,3 heures-lumiŠre'),
  (Nom:'Uranus';
   AnneeLumiere:0.00027739; Delta:'2,5 heures-lumiŠre'),
  (Nom:'Neptune';
   AnneeLumiere:0.00045788; Delta:'4,2 heures-lumiŠre')
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
 If ParamStr(1)='--version'Then Begin
  WriteLn('DISTANCE 1.1 - Utilitaire pour Pascal d''axtro');
  WriteLn('Licence MIT');
  WriteLn;
  WriteLn('crit par Sylvain Maltais');
 End
  Else
 If ParamCount>0 Then Begin
  For I:=1 to ParamCount do Begin
   For J:=Low(Astres) to High(Astres)do Begin
    If StrToUpper(ParamStr(I))=StrToUpper(StrPas(Astres[J].Nom))Then Begin
     WriteLn('Distance entre la terre et ',StrPas(Astres[J].Nom),' est en ',
             'moyenne de ',StrPas(Astres[J].Delta));
     WriteLn('Soit : ',Astres[J].AnneeLumiere:0:8,' ann‚es-lumiŠre');
     Break;
    End;
   End;
  End;
 End
  Else
 WriteLn('Vous devez indiquer le nom de l''astre comme par exemple, Lune, Soleil,...');
END.
