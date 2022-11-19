{ @author: Sylvain Maltais (support@gladir.com)
  @created: 2022
  @website(https://www.gladir.com/axtro)
  @abstract(Target: Turbo Pascal, Free Pascal)
}

Program OBSERV;

Uses Strings;

Type
 ObservatoryRec=Record
  Nom:PChar;
  TailleEnMetre:Real;
  Site:PChar;
 End;

Const
 Observatories:Array[1..27]of ObservatoryRec=(
  (Nom:'Grand Telescopio Canarias';
   TailleEnMetre:10.4;
   Site:'La Palma, Canaries'),
  (Nom:'Keck I';
   TailleEnMetre:10.0;
   Site:'Mauna Kea, Hawaã'),
  (Nom:'Keck II';
   TailleEnMetre:10.0;
   Site:'Mauna Kea, Hawaã'),
  (Nom:'Hobby-Eberly';
   TailleEnMetre:9.2;
   Site:'Mont Fowlkes, Texas'),
  (Nom:'SALT';
   TailleEnMetre:9.2;
   Site:'Afrique du Sud'),
  (Nom:'Subaru';
   TailleEnMetre:8.3;
   Site:'Mauna Kea, Hawaã'),
  (Nom:'Large Binocular Telescope';
   TailleEnMetre:8.4;
   Site:'Mont Graham, Arizona'),
  (Nom:'Antu';
   TailleEnMetre:8.2;
   Site:'Cerro Paranal, Chili'),
  (Nom:'Kueyen';
   TailleEnMetre:8.2;
   Site:'Cerro Paranal, Chili'),
  (Nom:'Melipal';
   TailleEnMetre:8.2;
   Site:'Cerro Paranal, Chili'),
  (Nom:'Yepun';
   TailleEnMetre:8.2;
   Site:'Cerro Paranal, Chili'),
  (Nom:'Gemini North';
   TailleEnMetre:8.0;
   Site:'Mauna Kea, Hawaã'),
  (Nom:'Gemini South';
   TailleEnMetre:8.0;
   Site:'Cerro Pachon, Chili'),
  (Nom:'MMT';
   TailleEnMetre:6.5;
   Site:'Mont Hopkins, Arizona'),
  (Nom:'Magellan I';
   TailleEnMetre:6.5;
   Site:'La Serena, Chili'),
  (Nom:'Magellan II';
   TailleEnMetre:6.5;
   Site:'La Serena, Chili'),
  (Nom:'Bolshoi Teleskop Azimutalnyi';
   TailleEnMetre:6.0;
   Site:'Nizhny Arkhyz, Russie'),
  (Nom:'Hale';
   TailleEnMetre:5.0;
   Site:'Mont Palomar, Californie'),
  (Nom:'William Herschel';
   TailleEnMetre:4.2;
   Site:'La Palma, Canaries'),
  (Nom:'SOAR';
   TailleEnMetre:4.2;
   Site:'Cerro Pachon, Chili'),
  (Nom:'LAMOST';
   TailleEnMetre:4.2;
   Site:'Xinglong, Chine'),
  (Nom:'Victor Blanco';
   TailleEnMetre:4.0;
   Site:'Cerro Tololo, Chili'),
  (Nom:'Anglo-Australian Telescope';
   TailleEnMetre:3.9;
   Site:'Coonabarabran, Australie'),
  (Nom:'Mayall';
   TailleEnMetre:3.8;
   Site:'Kitt Peak, Arizona'),
  (Nom:'Canada-France-Hawaã';
   TailleEnMetre:3.6;
   Site:'Mauna Kea, Hawaã'),
  (Nom:'Telescopio Nazionale Galileo';
   TailleEnMetre:3.6;
   Site:'La Palma, Canaries'),
  (Nom:'360';
   TailleEnMetre:3.6;
   Site:'Cerro La Silla, Chili')
 );

Function StrToUpper(S:String):String;
Var
 I:Byte;
Begin
 For I:=1 to Length(S)do Begin
  If S[I]in['Ç','ä','à',#232,#233,#234]Then S[I]:='E'Else
  If S[I]in['å',#238]Then S[I]:='I'Else
  If S[I] in['a'..'z']Then S[I]:=Chr(Ord(S[I])-32);
 End;
 StrToUpper:=S;
End;

Var
 I,J:Integer;

BEGIN
 If(ParamStr(1)='/?')or(ParamStr(1)='--help')or(ParamStr(1)='-h')or
   (ParamStr(1)='/h')or(ParamStr(1)='/H')Then Begin
  WriteLn('OBSERV : Cette commande permet d''afficher la liste ',
                      ' des observatoires d''astronomique.');
  WriteLn;
  WriteLn('Syntaxe : OBSERV [nom] [/DETAIL]');
  WriteLn;
  WriteLn(' nom      Permet d''indiquer le nom de l''observatoire');
  WriteLn(' /DETAIL  Affichage dÇtaillÇs de la liste');
 End
  Else
 If(ParamCount=1)and(StrToUpper(ParamStr(1))='/DETAIL')Then Begin
  For J:=Low(Observatories) to High(Observatories)do Begin
   WriteLn('Nom : ',StrPas(Observatories[J].Nom));
   WriteLn('Diamätre : ',Observatories[J].TailleEnMetre:0:1,' mätres');
   WriteLn('Site : ',StrPas(Observatories[J].Site));
   WriteLn;
  End;
 End
  Else
 If ParamCount>0 Then Begin
  For I:=1 to ParamCount do Begin
   For J:=Low(Observatories) to High(Observatories)do Begin
    If StrToUpper(ParamStr(I))=StrToUpper(StrPas(Observatories[J].Nom))Then Begin
     WriteLn('Nom : ',StrPas(Observatories[J].Nom));
     WriteLn('Diamätre : ',Observatories[J].TailleEnMetre:0:1,' mätres');
     WriteLn('Site : ',StrPas(Observatories[J].Site));
     WriteLn;
    End;
   End;
  End;
 End
  Else
 Begin
  For J:=Low(Observatories) to High(Observatories)do Begin
   WriteLn(StrPas(Observatories[J].Nom));
  End;
 End;
END.