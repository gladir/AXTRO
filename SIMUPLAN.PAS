{ @author: Sylvain Maltais (support@gladir.com)
  @created: 2025
  @website(https://www.gladir.com/axtro)
  @abstract(Target: Turbo Pascal, Free Pascal)
}

Program SIMUPLAN;

Uses {$IFDEF FPC}
      Crt,PtcGraph,PtcCrt,PtcMouse
     {$ELSE}
      Crt,Graph
     {$ENDIF};

Const
 MaxX=640;
 MaxY=480;
 NbAstres=14; { Soleil, Mercure, VÇnus, Terre, Mars, Jupiter, Saturne, Uranus, Neptune, CÇräs, Pallas, Encke }
 NbTotal=15;  { Ajout des lunes : Lune, Phobos, Deimos }

Type
 TTypeAstre = (Planete, Lune, Comete, Asteroide);

 TAstre=Record
  Nom:String;
  Rayon:Integer;
  Distance:Integer;
  Couleur:Integer;
  x,y:Integer;
  Vitesse:Real;
  Centre:Integer;
  Anneau:Boolean;
  TypeAstre:TTypeAstre;
 End;

Const
  Astres:Array[1..NbTotal]of TAstre=(
   (Nom: 'Soleil'; Rayon: 20; Distance: 0; Couleur: Yellow;
    x: MaxX shr 1; y: MaxY shr 1; Vitesse: 0; Centre: 0; Anneau: False; TypeAstre: Planete),
   (Nom: 'Mercure'; Rayon: 4; Distance: 50; Couleur: LightGray;
    x: 0; y: 0; Vitesse: 4.15; Centre: 1; Anneau: False; TypeAstre: Planete),
   (Nom: 'Venus'; Rayon: 6; Distance: 100; Couleur: LightRed;
    x: 0; y: 0; Vitesse: 1.62; Centre: 1; Anneau: False; TypeAstre: Planete),
   (Nom: 'Terre'; Rayon: 8; Distance: 150; Couleur: Blue;
    x: 0; y: 0; Vitesse: 1; Centre: 1; Anneau: False; TypeAstre: Planete),
   (Nom: 'Lune'; Rayon: 3; Distance: 25; Couleur: White;
    x: 0; y: 0; Vitesse: 12; Centre: 4; Anneau: False; TypeAstre: Lune),
   (Nom: 'Mars'; Rayon: 6; Distance: 200; Couleur: LightRed;
    x: 0; y: 0; Vitesse: 0.53; Centre: 1; Anneau: False; TypeAstre: Planete),
   (Nom: 'Phobos'; Rayon: 2; Distance: 10; Couleur: LightGray;
    x: 0; y: 0; Vitesse: 15; Centre: 6; Anneau: False; TypeAstre: Lune),
   (Nom: 'Deimos'; Rayon: 2; Distance: 20; Couleur: LightGray;
    x: 0; y: 0; Vitesse: 10; Centre: 6; Anneau: False; TypeAstre: Lune),
   (Nom: 'Jupiter'; Rayon: 10; Distance: 250; Couleur: Brown;
    x: 0; y: 0; Vitesse: 0.083; Centre: 1; Anneau: False; TypeAstre: Planete),
   (Nom: 'Saturne'; Rayon: 9; Distance: 320; Couleur: LightMagenta;
    x: 0; y: 0; Vitesse: 0.034; Centre: 1; Anneau: True; TypeAstre: Planete),
   (Nom: 'Uranus'; Rayon: 8; Distance: 400; Couleur: LightCyan;
    x: 0; y: 0; Vitesse: 0.012; Centre: 1; Anneau: True; TypeAstre: Planete),
   (Nom: 'Neptune'; Rayon: 8; Distance: 480; Couleur: Blue;
    x: 0; y: 0; Vitesse: 0.006; Centre: 1; Anneau: False; TypeAstre: Planete),
   { Ajout des nouveaux astres }
   (Nom: 'CÇräs'; Rayon: 3; Distance: 220; Couleur: DarkGray;
    x: 0; y: 0; Vitesse: 0.15; Centre: 1; Anneau: False; TypeAstre: Asteroide),
   (Nom: 'Pallas'; Rayon: 3; Distance: 230; Couleur: LightGray;
    x: 0; y: 0; Vitesse: 0.12; Centre: 1; Anneau: False; TypeAstre: Asteroide),
   (Nom: 'Encke'; Rayon: 2; Distance: 300; Couleur: White;
    x: 0; y: 0; Vitesse: 0.2; Centre: 1; Anneau: False; TypeAstre: Comete)
  );

Var
 ShowOrbite:Boolean;
 ShowName:Boolean;
 Driver,Mode:Integer;
 i,j,angle:Integer;
 ErrCode:Integer;

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

BEGIN
 If(ParamStr(1)='/?')or(ParamStr(1)='--help')or(ParamStr(1)='-h')or
   (ParamStr(1)='/h')or(ParamStr(1)='/H')Then Begin
  WriteLn('SIMUPLAN : Simulation des mouvements des astres du systäme solaire.');
  WriteLn;
  WriteLn('Syntaxe : SIMUPLAN [/?]');
  WriteLn;
  WriteLn(' /NAME    Affiche les noms des astres');
  WriteLn(' /ORBIT   Affiche l''orbite des astres');
 End
  Else
 Begin
  ShowOrbite:=False;
  For i:=1 to ParamCount do Begin
   If StrToUpper(ParamStr(I))='/ORBIT'Then ShowOrbite:=True Else
   If StrToUpper(ParamStr(I))='/NAME'Then ShowName:=True;
  End;
  {$IFDEF FPC}
   Driver:=VGA;
   Mode:=VGAHi;
  {$ELSE}
   Driver:=Detect;
   Mode:=VGAHi;
  {$ENDIF}
  InitGraph(Driver,Mode,'');
  ErrCode:=GraphResult;
  If ErrCode=grOk Then Begin
   SetColor(White);
   SetLineStyle(0,0,1);
  End
   Else
  Begin
   WriteLn('Erreur graphique : ',GraphErrorMsg(ErrCode));
   Halt;
  End;
   { Animation des astres }
  For i:=0 to 720 do Begin
   If(Keypressed)Then Begin
    If ReadKey=#27 Then Break;
   End;
   ClearDevice;
   { Dessiner la ceinture d'astÇroãdes en pointillÇs }
   SetColor(DarkGray);
   Angle:=0;
   While angle<=360 do Begin
    PutPixel(Astres[1].x + Round(220 * Cos(Angle*PI/180)),
             Astres[1].y - Round(220 * Sin(Angle*PI/180)),DarkGray);
    Angle:=Angle+10;
   End;
   { Mise Ö jour et affichage des astres }
   For j:=1 to NbTotal do Begin
    If Astres[j].Centre = 0 Then Begin
     { Soleil }
     SetColor(Astres[j].Couleur);
     SetFillStyle(SolidFill, Astres[j].Couleur);
     Fillellipse(Astres[j].x, Astres[j].y, Astres[j].Rayon, Astres[j].Rayon);
    End
    Else Begin
     If ShowOrbite Then Begin
      If Astres[j].Nom='Encke' Then Begin
       SetColor(LightGray);
       SetLineStyle(DottedLn, 0, 1);
       Angle := 0;
       While Angle <= 720 do Begin
        PutPixel(Astres[1].x + Round((100 + 100 * Cos(Angle * Pi / 180)) * Cos(Angle * Astres[j].Vitesse * Pi / 180)),
        Astres[1].y - Round((50 + 50 * Sin(Angle * Pi / 180)) * Sin(Angle * Astres[j].Vitesse * Pi / 180)), LightGray);
        Angle := Angle + 10;
       End;
       SetLineStyle(SolidLn, 0, 1);
      End
       Else
      Begin
       SetColor(White);
       SetLineStyle(DottedLn, 0, 1); { Style en pointillÇs pour les orbites }
       Circle(Astres[Astres[j].Centre].x, Astres[Astres[j].Centre].y, Astres[j].Distance);
       SetLineStyle(SolidLn, 0, 1); { RÇtablir le style normal }
      End;
     End;
     { Mise Ö jour des positions }
     Astres[j].x := Astres[Astres[j].Centre].x + Round(Astres[j].Distance * Cos(i * Astres[j].Vitesse * Pi / 180));
     Astres[j].y := Astres[Astres[j].Centre].y - Round(Astres[j].Distance * Sin(i * Astres[j].Vitesse * Pi / 180));
     If Astres[j].Nom='Encke' Then Begin
      Astres[j].x := Astres[1].x + Round((100 + 100 * Cos(i * Pi / 180)) * Cos(i * Astres[j].Vitesse * Pi / 180));
      Astres[j].y := Astres[1].y - Round((50 + 50 * Sin(i * Pi / 180)) * Sin(i * Astres[j].Vitesse * Pi / 180));
     End;

      {Dessiner l'astre }
     SetColor(Astres[j].Couleur);
     SetFillStyle(SolidFill, Astres[j].Couleur);
     Fillellipse(Astres[j].x, Astres[j].y, Astres[j].Rayon, Astres[j].Rayon);

     { Anneaux pour Saturne et Uranus }
     If Astres[j].Anneau Then Begin
       SetColor(White);
       Ellipse(Astres[j].x, Astres[j].y, 0, 360, Astres[j].Rayon + 3, Astres[j].Rayon + 1);
     End;
      { Affichage du nom de l'astre }
    End;
    If ShowName Then Begin
     SetColor(White);
     OutTextXY(Astres[j].x + Astres[j].Rayon + 3, Astres[j].y, Astres[j].Nom);
    End;
   End;
   Delay(50);
  End;
  CloseGraph;
 End;
END.
