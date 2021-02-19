%Anteckningar från möte 16/2 

%Primitiver som flaggor, 3 färger svårt att mappa till en bildpunkt -->
%lättare och mer logiskt att använda flaggornas medelvärden som mätpunkt.

%Svårt att se översiklgihet om bilderna INTE är brusiga, därmed är 
%brusiga flaggor inget problem!

%Sätta till ett standrardrektaungulär är helt ok, kan också göra det 
%kvadratiskt men då förlorar man lite av flagigheten så kanske endast göra
%om tiden är knapp.

%Att välja ut alla flaggor med ett gemensammt mått (typ 2:3 eller 5:8)
%låter rimligt så länge färgspannet är acceptabelt. 

%Enklast att ha alla flaggor liggande. Att ha flaggorna stående också hade gett
%eventuellt mer detaljrikhet men hade också gett en hel del pusspelproblem
%som skulle stöka till. Inte nödvändigt.

%Hitta globala flaggor för att spänna upp ett gamut, hitta ett bra sådant.
%Slutresultatet är inte viktigit egentligen,  enbart motivering.

%Vi ska inte vara rädda för att boka tid för mer handledning, de bits inte!


%% PHASE ONE

% Skapa databas för mean färg av varje flagga i L a b
    % meanFlagColors.m skapar en vektor 1x654 med mean L,a,b värden
    % Exempel: colorDiffFlagToImage = (me

% Kolla om in-bilden är för stor eller för liten, korrigera och skriv varningsmeddelande
    
% Preliminärt återskapas svartvita bilder med samma metod som för färgbilder

% Loopa igenom bilden i 32x16 block, om det inte går ut => klipp bort på kanter

% Beräkna medelfärg i L a b och ut block med närmsta medelfärgiga flagga i L a b

% Kolla på S-CIELab för att undersöka reproduktionskvalitetén

%% PHASE TWO

% Scatterplotta alla flaggors L a b färg och ta med i diskussion för rapport

% Ta bort väldigt lika färger i databasen

% Ta lite objektiva kvalitetsmått för olika sorters bilder (utöver visuell bedömning)

% Gör optimering (ta bort flaggor som inte komme användas för två bilder)












