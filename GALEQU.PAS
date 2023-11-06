{ @author: Sylvain Maltais (support@gladir.com)
  @created: 2023
  @website(https://www.gladir.com/axtro)
  @abstract(Target: Turbo Pascal 7, Free Pascal 3.2)
}

Program GALEQU;

{$E+,N+}

Var
 I:Integer;
 Err:Word;
 PosField:Byte;
 dt:Extended;
 Wrk:Extended;
 Sc,jd:Extended;
 cor,hr,mn,qu,ms,an:LongInt;
 TE,fler,fldt,flsv,flmn:boolean;
 hmq,hmc:Char;
 adh,adm,dcd,dcm,lgd,lgm,btd,btm:LongInt;
 ad,dc,lg,bt,ads,dcs,lgs,bts,adg,dcg,tht,theta,dzeta,za:Extended;

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

Function IsValidDate(qu,ms,an:longint):boolean;
Var
 Flg:Boolean;
 x,y:LongInt;
Begin
 x:=2;
 If((an<1583)and((an mod 4)=0))Then x:=1;
 If(an>1582)Then Begin
  y:=an mod 4;
  If (y=0)Then Begin
   y:=an mod 100;
   If(y<>0)Then x:=1
    Else
   Begin
    y:=(an div 100) mod 4;
    If(y=0)Then x:=1;
   End;
  End;
 End;
 flg:=(ms>0)and(ms<13);
 If(flg)Then
 Case ms of
  1,3,5,7,8,10,12 : flg:=(qu>0) and (qu<32);
  2               : flg:=(qu>0) and (qu<31-x);
  4,6,9,11        : flg:=(qu>0) and (qu<31);
 End;
 If(Flg and(an=1582)and(ms=10))Then Flg:=((qu<5) or (qu>14));
 IsValidDate:=flg;
End;

Function IsValidTime(Hr,Mn:LongInt;Sc:Extended):Boolean;
Var
 Flg:Boolean;
Begin
 Flg:=(hr>=0) and (hr<24);
 If(Flg)Then Flg:=(mn>=0) and (mn<60);
 If(Flg)Then Flg:=(sc>=0.0) and (sc<60.0);
 IsValidTime:=flg;
End;

Function IsValidDeclinaison(Hr,Mn:LongInt;Sc:Extended):Boolean;
Var
 Flg,Pl:Boolean;
Begin
 Flg:=(hr>=0)and(hr<90);
 If(Flg)Then Flg:=(mn>=0)and(mn<60);
 If(Flg)Then Flg:=(sc>=0.0)and(sc<60.0);
 pl:=(hr=90)and(mn=0)and(sc=0.0);
 IsValidDeclinaison:=Flg or Pl;
End;

Function IsValidLongitude(Hr,Mn:LongInt;Sc:Extended):Boolean;
Var
 Flg:Boolean;
Begin
 Flg:=(Hr>=0)and(Hr<360);
 If(Flg)Then flg:=(Mn>=0)and(Mn<60);
 If(Flg)Then flg:=(Sc>=0.0)and(Sc<60.0);
 IsValidLongitude:=Flg;
End;

Function jj(qu,ms,an,hr,mn:LongInt;sc:Extended):Extended;
Var
 x,y:Extended;
Begin
 wrk:=((an*100+ms)*100+qu)/10000;
 x:=an;
 y:=ms+1;
 If(ms<3)Then Begin
  x:=x-1;
  y:=y+12;
 End;
 If(wrk<1582.1015)Then wrk:=0
                  Else wrk:=2-int(x/100)+int(x/400);
 wrk:=wrk+qu+int(30.6001*y);
 If(x<0)Then wrk:=wrk+int(365.25*x-0.75)
        Else wrk:=wrk+int(365.25*x);
 jj:=1720994.5+wrk+((hr*60+mn)*60+sc)/86400.0;
End;

Procedure GalacticEquation;
Var
 mf,mt:Array[1..3,1..3] of Extended;
 pse,psg:Array[1..3] of Extended;
 psx,psy:Byte;
 i,j,k:LongInt;
Begin
 adg:=pi*30857517.0/28800000.0;
 dcg:=pi*12207713.0/81000000.0;
 tht:=pi*442554907.0/648000000.0;
 mf[1,1]:=-cos(tht)*cos(adg)*sin(dcg)-sin(tht)*sin(adg);
 mf[2,1]:=sin(tht)*cos(adg)-cos(tht)*sin(adg)*sin(dcg);
 mf[3,1]:=cos(tht)*cos(dcg);
 mf[1,2]:=cos(tht)*sin(adg)-sin(tht)*cos(adg)*sin(dcg);
 mf[2,2]:=-cos(tht)*cos(adg)-sin(tht)*sin(adg)*sin(dcg);
 mf[3,2]:=sin(tht)*cos(dcg);
 mf[1,3]:=cos(adg)*cos(dcg);
 mf[2,3]:=sin(adg)*cos(dcg);
 mf[3,3]:=sin(dcg);
 jd:=jj(qu,ms,an,hr,mn,sc);
 dt:=(jd-2451545.0)/365250.0;
 theta:=pi*dt*(20043109-dt*(42665+41833*dt))/648000000.0;
 dzeta:=pi*dt*(23062181+dt*(30188+17998*dt))/648000000.0;
 za:=pi*dt*(23062181+dt*(109468+18203*dt))/648000000.0;
 mt[1,1]:=cos(za)*cos(theta)*cos(dzeta)-sin(za)*sin(dzeta);
 mt[2,1]:=-(cos(za)*cos(theta)*sin(dzeta)+sin(za)*cos(dzeta));
 mt[3,1]:=-cos(za)*sin(theta);
 mt[1,2]:=sin(za)*cos(theta)*cos(dzeta)+cos(za)*sin(dzeta);
 mt[2,2]:=cos(za)*cos(dzeta)-sin(za)*cos(theta)*sin(dzeta);
 mt[3,2]:=-sin(za)*sin(theta);
 mt[1,3]:=sin(theta)*cos(dzeta);
 mt[2,3]:=-sin(theta)*sin(dzeta);
 mt[3,3]:=cos(theta);
 lg:=pi*((60*lgd+lgm)*60+lgs)/648000;
 bt:=pi*((60*btd+btm)*60+bts)/648000;
 If(hmc='S')Then bt:=-bt;
 psg[1]:=cos(lg)*cos(bt);
 psg[2]:=sin(lg)*cos(bt);
 psg[3]:=sin(bt);
 For i:=1 to 3 do Begin
  pse[i]:=0;
  For j:=1 to 3 do For k:=1 to 3 do pse[i]:=pse[i]+mt[i,j]*mf[j,k]*psg[k];
 End;
 If(pse[1]<>0)Then ad:=arctan(pse[2]/pse[1])*12/pi else ad:=6*pse[2]/abs(pse[2]);
 If(pse[1]<0)Then ad:=ad+12;
 If(ad<0)Then ad:=ad+24;
 If(ad>=24)Then ad:=ad-24;
 dc:=arctan(pse[3]/sqrt(pse[1]*pse[1]+pse[2]*pse[2]))*180/pi;
 adh:=trunc(ad);
 adm:=trunc(60*frac(ad));
 ads:=3600*ad;
 ads:=ads-60*int(ads/60);
 If(dc<0)Then hmq:='S'
         Else hmq:='N';
 dc:=abs(dc);
 dcd:=trunc(dc);
 dcm:=trunc(60*frac(dc));
 dcs:=3600*dc;
 dcs:=dcs-60*int(dcs/60);
 WriteLn('Position galactique :');
 WriteLn('Longitude : ',lgd:3,lgm:3,lgs:6:2);
 WriteLn('Latitude  : ',btd:3,btm:3,bts:6:2,hmc:2);
 WriteLn;
 WriteLn('Position Çquatoriale :');
 WriteLn('Ascension droite : ',adh:3,adm:3,ads:6:2);
 WriteLn('DÇclinaison      : ',dcd:3,dcm:3,dcs:6:2,hmq:2);
end;

BEGIN
 If(ParamStr(1)='/?')or(ParamStr(1)='--help')or(ParamStr(1)='-h')or
   (ParamStr(1)='/h')or(ParamStr(1)='/H')Then Begin
  WriteLn('GALEQU : Cette commande permet de passer des coordonnÇes ',
                    'Çquatoriales aux coordonnÇes galactiques.');
  WriteLn;
  WriteLn('L''Çchelle de temps est le Temps des êphÇmÇrides');
  WriteLn;
  WriteLn('Syntaxe : GALEQU /NORD|/SUD [/TE] ddd mm ss.sss dd mm ss.sss jj mm aaaa hh mm [ss.ssss]');
  WriteLn;
  WriteLn(' ddd mm ss.sss   Longitude galactique');
  WriteLn(' dd mm ss.sss    Latitude galactique');
  WriteLn(' jj mm aaaa      Date TE');
  WriteLn(' hh mm [ss.ssss] Heure TE');
  WriteLn(' /NORD           êmisphäre Nord');
  WriteLn(' /TE             Echelle de temps des êphÇmÇrides');
  WriteLn(' /SUD            êmisphäre Sud');
 End
  Else
 If ParamCount>0 Then Begin
  TE:=True; { Temps des êphÇmÇrides (TE) }
  sc:=0;
  PosField:=0;
  flmn:=True;
  fldt:=False;
  For I:=1 to ParamCount do Begin
   If StrToUpper(ParamStr(I))='/NORD'Then hmc:='N'Else
   If StrToUpper(ParamStr(I))='/SUD'Then hmc:='S' Else
   If StrToUpper(ParamStr(I))='/TE'Then TE:=True
    Else
   Begin
    Case PosField of
     0:Val(ParamStr(I),lgd,Err);
     1:Val(ParamStr(I),lgm,Err);
     2:Val(ParamStr(I),lgs,Err);
     3:Val(ParamStr(I),btd,Err);
     4:Val(ParamStr(I),btm,Err);
     5:Val(ParamStr(I),bts,Err);
     6:Val(ParamStr(I),qu,Err);{jj}
     7:Val(ParamStr(I),ms,Err);{mm}
     8:Val(ParamStr(I),an,Err);{aaaa}
     9:Val(ParamStr(I),hr,Err);{hh}
     10:Val(ParamStr(I),mn,Err);{mm}
     11:Begin
      flmn:=False;
      Val(ParamStr(I),sc,Err);{ss.ssss}
     End;
     Else Begin
      WriteLn('Paramätre non reconnu');
     End;
    End;
    Inc(PosField);
   End;
  End;
  If Not IsValidDate(qu,ms,an)Then Begin
   WriteLn('Format de date invalide !');
   Halt;
  End;
  If Not IsValidTime(hr,mn,sc)Then Begin
   WriteLn('Format d''heure invalide !');
   Halt;
  End;
  If Not IsValidLongitude(lgd,lgm,lgs)Then Begin
   WriteLn('Longitude galactique invalide !');
   Halt;
  End;
  If Not IsValidDeclinaison(btd,btm,bts)Then Begin
   WriteLn('Latitude galactique invalide !');
   Halt;
  End;
  GalacticEquation;
 End;
END.