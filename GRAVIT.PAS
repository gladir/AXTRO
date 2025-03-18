{ @author: Sylvain Maltais (support@gladir.com)
  @created: 2022
  @website(https://www.gladir.com/axtro)
  @abstract(Target: Turbo Pascal, Free Pascal)
}


Program GRAVIT;

Uses Crt;

Const
 G=6.67430E-11; { Constante gravitationnelle en m au cube/kg/s au carr‚ }

Var
 M1,M2,R,Force:Real;
 Err:Word;

BEGIN
 {$IFDEF FPC}
  {$IFDEF WINDOWS}
   SetUseACP(False);
  {$ENDIF}
 {$ENDIF}
 If(ParamStr(1)='/?')or(ParamStr(1)='--help')or(ParamStr(1)='-h')or
   (ParamStr(1)='/h')or(ParamStr(1)='/H')Then Begin
  WriteLn('GRAVIT : Cette commande permet de calculer la force ',
                    'gravitation entre deux objets c‚lestes.');
  WriteLn;
  WriteLn('Syntaxe : GRAVIT [obj1 obj2 distance]');
  WriteLn;
  WriteLn(' obj1     Ce paramŠtre permet d''indiquer le permier object');
  WriteLn(' obj2     Ce paramŠtre permet d''indiquer le deuxiŠme objet');
  WriteLn(' distance Ce paramŠtre permet d''indiquer la distance entre objets');
  WriteLn;
  WriteLn('Exemple : GRAVIT 5.972E24 7.348E22 3.844E8');
 End
  Else
 If ParamCount>0 Then Begin
  Val(ParamStr(1),M1,Err);
  If Err>0 Then Begin
   WriteLn('Le premier objet n''est pas valide');
   Halt(1);
  End;
  Val(ParamStr(2),M2,Err);
  If Err>0 Then Begin
   WriteLn('Le deuxiŠme objet n''est pas valide');
   Halt(1);
  End;
  Val(ParamStr(3),R,Err);
  If Err>0 Then Begin
   WriteLn('La distance entre les objets n''est pas valide');
   Halt(1);
  End;
  Force:=G*M1*M2/(R*R);
  WriteLn('La force gravitationnelle est de ', Force:0:5, ' N');
 End
  Else
 Begin
  ClrScr;
  Write('Entrez la masse du premier objet (kg) : '); ReadLn(M1);
  Write('Entrez la masse du second objet (kg) : '); ReadLn(M2);
  Write('Entrez la distance entre les objets (m) : '); ReadLn(R);
  Force:=G*M1*M2/(R*R);
  WriteLn('La force gravitationnelle est de ', Force:0:5, ' N');
  ReadLn;
 End;
END.
