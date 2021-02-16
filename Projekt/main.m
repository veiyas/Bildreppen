img = imread('CD-128.png');

scaled_img = rescale(img, 0.5);

imshow(scaled_img);

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