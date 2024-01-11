{ @author: Sylvain Maltais (support@gladir.com)
  @created: 2022
  @website(https://www.gladir.com/axtro)
  @abstract(Target: Turbo Pascal, Free Pascal)
}

Program COSMIC;

Uses Strings;

Const
 Words:Array[0..234]of PChar=(
  'comic','ipsum','albedo','Alpha Centauri','apastron','aperature',
 'aphelion','apogee','asterism','asteroid','astronaut','astronomer',
 'astronomical unit','astronomy','axial tilt','azimuth',
 'background radiation','Bailey''s beads','big bang theory',
 'binary star','black body','black hole','bolometer','celestial',
 'celestial coordinates','celestial equator','circumpolar',
 'cislunar','cluster','comet','conjunction','constellation',
 'coriolis force','cosmic rays','corona','cosmology','cosmonaut',
 'cosmos','crater','crescent moon','culmination','dark matter',
 'day','declination','deep space','Deneb','density','docking',
 'Doppler shift','double star','Drake equation','dust','dwarf planet',
 'dwarf star','Earth','Earthshine','eccentricity','eclipse',
 'ecliptic','elliptical orbit','ephemeris','equinox','escape velocity',
 'event horizon','exoplanet','extragalactic','falling star',
 'flare','flyby','free fall','full moon','galaxy','gamma ray',
 'gas giant','gegenschein','geostationary','geosynchronous',
 'gibbous moon','globular cluster','gravitation',
 'gravitational constant','gravitational lens','gravity','half moon',
 'heliocentric','hydrogen','helium','H-R diagram','Hubble telescope',
 'Hubble''s law','hyperbolic orbit','hypernova','ice giant',
 'inclination','inertia','inferior planets','inner planets',
 'interstellar','interstellar dust','ionosphere','Jupiter',
 'Kepler''s laws','kiloparsec','Kirkwood gaps','Kuiper belt',
 'Lagrange points','lens','libration','light-year','limb','local arm',
 'local group','lunar','magnitude','Lunar mare','Mars','mass',
 'Mercury','meridian','Messier object','meteor','meteor shower',
 'meteorite','meteoroid','Milky Way','minor planet','Mir',
 'moon','muttnik','nadir','NASA','nebula','Neptune','neutron star',
 'new moon','north star','nova','observatory','occultation',
 'Oort cloud','opposition','orbit','orbital eccentricity',
 'orbital inclination','outer planets','parallax','parsec',
 'partial eclipse','penumbra','perigee','perihelion','perturbation',
 'phase','plane of the ecliptic','planet','planetary nebula',
 'planetoid','planisphere','Pluto','pole star','precession',
 'probe','pulsar','quarter moon','quasar','radiant','radiation',
 'red dwarf','red giant star','red shift','revolve','retrograde',
 'right ascension','rings','Roche limit','rocket','satellite',
 'Saturn','scientific notation','scintillation','seeing',
 'shooting star','solar','sidereal','singularity','sky','solar',
 'solar system','solar wind','solstice','space','space exploration',
 'space station','spectroscope','spectrum','Sputnik','star',
 'starlight','sun','sunspot','superior planets','supernova',
 'synodic','syzygy','telemetry','telescope','terminator',
 'terrestrial','total eclipse','totality','transit','translunar',
 'transneptunians','transparency','twinkling','umbra','universe',
 'Uranus','vacuum','Van Allen belt','variable star','Venus',
 'vernal equinox','visual magnitude','waning','wavelength',
 'waxing','weightlessness','white dwarf','white giant','wormhole',
 'x-rays','yellow dwarf','zenith','zodiac'
 );

Function StrToCapital(S:String):String;Begin
 If Length(S)=0 Then StrToCapital:=''
                Else StrToCapital:=UpCase(S[1])+Copy(S,2,255);
End;

Function Gauss:Real;
Var
 U,V,X,Y:Real;
Begin
 X:=Random;
 Y:=Random;
 U:=Sqrt(-2*Ln(X))*Cos(2*PI*Y);
 V:=Sqrt(-2*Ln(X))*Sin(2*PI*Y);
 Gauss:=U;
End;

Function GaussMs(M,S:Real):Real;Begin
 GaussMs:=Gauss+S+M;
End;

Function GaussSentence:Integer;Begin
 GaussSentence:=Round(GaussMs(2.460,5.080));
End;

Procedure GetWords(Count:Integer;LoremIpsum:Boolean);
Var
 I,NumWord,_Index,LenSentence:Integer;
 Capital:Boolean;
 LastWord:String;
Begin
 Capital:=True;
 LenSentence:=GaussSentence;
 I:=0;NumWord:=0;
 If(LoremIpsum)Then Begin
  I:=2;
  Write('Cosmic ');
  Write('Ipsum ');
  NumWord:=2;
 End;
 While(I<Count)do Begin
  _Index:=Random(High(Words));
  If LastWord=StrPas(Words[_Index])Then _Index:=Random(High(Words));
  If(Capital)Then Begin
   Write(StrToCapital(StrPas(Words[_Index])));
   Capital:=False;
  End
   Else
  Write(StrPas(Words[_Index]));
  If I+1<Count Then Begin
   If NumWord>=LenSentence Then Begin
    LenSentence:=GaussSentence;
    Case Random(2) of
     0:Write(', ');
     1:Begin
      Write('. ');
      Capital:=True;
     End;
    End;
    NumWord:=0;
   End
    Else
   Begin
    Write(' ');
    Inc(NumWord);
    Capital:=False;
   End;
  End;
  LastWord:=StrPas(Words[_Index]);
  Inc(I);
 End;
 Write('.');
End;

Var
 Len,I:Integer;
 Err:Word;


BEGIN
 If(ParamStr(1)='/?')or(ParamStr(1)='--help')or(ParamStr(1)='-h')or
   (ParamStr(1)='/h')or(ParamStr(1)='/H')Then Begin
  WriteLn('COSMIC : Cette commande permet de gÇnÇrer du ',
                      'texte alÇatoirement d''astronomie (Cosmic Ipsum).');
  WriteLn;
  WriteLn('Syntaxe : COSMIC longueur');
  WriteLn;
  WriteLn(' longueur  Ce parametre permet d''indiquer le nombre de mots a gÇnÇrer');
 End
  Else
 If ParamCount>0Then Begin
  Randomize;
  For I:=1 to ParamCount do Begin
   Val(ParamStr(I),Len,Err);
   If Err>0Then Begin
    WriteLn('Valeur invalide');
    Halt;
   End;
   GetWords(Len,I=1);
   If ParamCount>1 Then Begin
    WriteLn;
    WriteLn;
   End;
  End;
 End
  Else
 WriteLn('Paramätre requis');
END.

