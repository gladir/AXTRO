{ @author: Sylvain Maltais (support@gladir.com)
  @created: 2022
  @website(https://www.gladir.com/axtro)
  @abstract(Target: Turbo Pascal, Free Pascal)
}

Program PLANET;

Uses Strings;

Type
 PlanetRec=Record
  Position:Byte;
  Nom:PChar;
  AnneeSiderale:Real;
  JourSiderale:Real;
  Inclinaison:Real;
  Diametre:LongInt;
 End;

Const
 Planets:Array[1..8]of PlanetRec=(
  (Position:1;
   Nom:'Mercure';
   AnneeSiderale:88.0;
   JourSiderale:59.0;
   Inclinaison:0.0;
   Diametre:4878),
  (Position:2;
   Nom:'V‚nus';
   AnneeSiderale:224.70;
   JourSiderale:243.0;
   Inclinaison:2.6;
   Diametre:12104),
  (Position:3;
   Nom:'Terre';
   AnneeSiderale:365.26;
   JourSiderale:1.0;
   Inclinaison:23.5;
   Diametre:12756),
  (Position:4;
   Nom:'Mars';
   AnneeSiderale:686;
   JourSiderale:1.02;
   Inclinaison:25.2;
   Diametre:6794),
  (Position:5;
   Nom:'Jupiter';
   AnneeSiderale:4332;
   JourSiderale:0.4;
   Inclinaison:3.1;
   Diametre:142800),
  (Position:6;
   Nom:'Saturne';
   AnneeSiderale:10760;
   JourSiderale:0.4;
   Inclinaison:27.0;
   Diametre:120000),
  (Position:7;
   Nom:'Uranus';
   AnneeSiderale:30697;
   JourSiderale:0.71;
   Inclinaison:98.0;
   Diametre:51120),
  (Position:8;
   Nom:'Neptune';
   AnneeSiderale:60195;
   JourSiderale:0.75;
   Inclinaison:30.0;
   Diametre:49528)
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
  WriteLn('PLANET : Cette commande permet d''afficher la liste ',
                      ' des planetes du systŠmes solaire.');
  WriteLn;
  WriteLn('Syntaxe : PLANET [nom]');
  WriteLn;
  WriteLn(' nom      Permet d''indiquer le nom de l''observatoire');
 End
  Else
 If ParamCount>0 Then Begin
  For I:=1 to ParamCount do Begin
   For J:=Low(Planets) to High(Planets)do Begin
    If StrToUpper(ParamStr(I))=StrToUpper(StrPas(Planets[J].Nom))Then Begin
     WriteLn('Position … partir du soleil : ',Planets[J].Position);
     WriteLn('Nom : ',StrPas(Planets[J].Nom));
     WriteLn('DiamŠtre : ',Planets[J].Diametre,' km');
     WriteLn('Ann‚e sid‚rale : ',Planets[J].AnneeSiderale:0:2,' jours');
     WriteLn('Jour sid‚rale : ',Planets[J].JourSiderale:0:2,' jours');
     WriteLn('Inclinaison : ',Planets[J].Inclinaison:0:1,'ø');
     WriteLn;
    End;
   End;
  End;
 End
  Else
 Begin
  For J:=Low(Planets) to High(Planets)do Begin
   WriteLn(StrPas(Planets[J].Nom));
  End;
 End;
END.