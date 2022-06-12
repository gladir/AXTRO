{ @author: Sylvain Maltais (support@gladir.com)
  @created: 2022
  @website(https://www.gladir.com/axtro)
  @abstract(Target: Turbo Pascal, Free Pascal)
}

Program Moon;

Const
 Mon:Array[1..12]of String[16]=('janvier','fevrier','mars','avril','mai','juin',
                                'juillet','aout','septembre','octobre',
                                'novembre','decembre');

Function StrToUpper(S:String):String;
Var
 I:Byte;
Begin
 For I:=1 to Length(S)do Begin
  If S[I] in['a'..'z']Then S[I]:=Chr(Ord(S[I])-32);
 End;
 StrToUpper:=S;
End;

Function MoonPhase(Year,Month,Day:Integer):Real;
Var
 M:Real;
 XYear,Century:LongInt;
Begin
 If Month <= 2 Then Begin
  Year := Year - 1;
  Month := Month + 12;
 End;
 Month := Month - 3;
 XYear := Year MOD 100;
 Century := (((Year DIV 100) * 146097)) shr 2;
 XYear := (XYear * 1461) shr 2;
 M := (Trunc(((((Month * 153) + 2) / 5) + Day) + 1721119 + XYear + Century) + 4.867) / 29.53058;
 MoonPhase:=Abs(2 * (M - Trunc(M)) - 1);
End;

Var
 I,Year,Month:Integer;
 CircleType:Real;
 Err:Word;

BEGIN
 If(ParamStr(1)='/?')or(ParamStr(1)='--help')or(ParamStr(1)='-h')or
   (ParamStr(1)='/h')or(ParamStr(1)='/H')Then Begin
  WriteLn('MOON : Cette commande permet d''afficher ',
                      'phase lunaire dans un mois.');
  WriteLn;
  WriteLn('Syntaxe : MOON annee mois');
 End
  Else
 If ParamCount>0Then Begin
  Val(ParamStr(1),Year,Err);
  If Err>0 Then Begin
   WriteLn('Format d''ann‚e invalide');
   Halt;
  End;
  Month:=-1;
  For I:=Low(Mon) to High(Mon)do Begin
   If StrToUpper(ParamStr(2))=StrToUpper(Mon[I])Then Begin
    Month:=I;
    Break;
   End;
  End;
  If Month=-1 Then Begin
   Val(ParamStr(2),Month,Err);
   If Err>0 Then Begin
    WriteLn('Format de mois invalide');
    Halt;
   End;
  End;
  For I:=1 to 31 do Begin
   CircleType := MoonPhase(Year, Month, I);
   If CircleType > 0.97 Then
    WriteLn(I,' ',Mon[Month],' ',Year,', Phase de la lune:Pleine lune')
   Else Begin
    If CircleType < 0.03 Then
     WriteLn(I,' ',Mon[Month],' ',Year,', Phase de la lune:Pas de lune')
    Else Begin
     If (CircleType > 0.46) and (CircleType < 0.53) Then Begin
      WriteLn(I,' ',Mon[Month],' ',Year,', Phase de la lune: Quart de lune');
     End;
    End;
   End;
  End;
 End
  Else
 WriteLn('Parametre requis');
END.
