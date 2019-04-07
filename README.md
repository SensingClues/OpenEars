# OpenEars
sensor to classify sounds

SERVAL image documentatie (Sound Event Recognition for Vigilance and Localisation)
Sensing Clues: Juli 2018
Image versie: 1.0

Deze uitvoering van de Serval is gebaseerd op een Raspberry Pi (3B+) en de Umik-1 microfoon. Na het opstarten stuurt de serval de gehoorde geluidsklassen naar een MQTT broker voor verdere afhandeling, in het volgende (JSON) formaat:
{"sid":"serval3", "timestamp":"1532238433096", "class":" Car passing by", "match":" 0.11"}

Dit image is gebouwd voor de RPi 3 B+ en een 32GB SD-kaart.
De Umik kan aangesloten worden op een willekeurige USB poort van de RPi.
Zorg voor een voldoende sterke power supply (>=2A) om zowel de RPi als de Umik te voeden.
Gebruik een heatsink setje om de chips op de RPi beter te koelen.
WiFi is *niet* geconfigureerd, gebruik voor de eerste setup een Ethernet kabel.
Inloggen met pi/scpiserval

Lokaties van code + scripts:
~/DL/devicehive-dev: De code die capture + processing doet
~/DL/devicehive-dev/models: DL model + class labels
~/DL/devicehive-dev/audio/params.py: DL model configuratie
~/serval: De scripts om de service te draaien en te monitoren

De MQTT configuratie kan aangepast worden in:
~/serval/serval.sh
Hier kan je ook de sensor 'ID' aanpassen die meegestuurd wordt in het JSON bericht.

De serval service start automatisch, indien je de service wilt stoppen gebruik dan:
sudo systemctl stop serval.service (en 'start' om weer te starten...)

De gevoeligheid van de Umik input kun je aanpassen met 'alsamixer'.

Crash monitor: De serval service schrijft in elke loop een timestamp naar een bestand: ~/DL/devicehive-dev/monitorhook.log
Een crontab job controleert of dit bestand wordt bijgewerkt, en indien dit niet gebeurt zal na 3 minuten de Serval opnieuw gestart worden. Om dit tijdelijk uit te zetten kun je de crontab regel editen en uitcommenten via het volgende commando:
'sudo crontab -e'

Het is aan te bevelen om de serval in een onvertrouwde omgeving via OpenVPN te verbinden met een vertrouwd netwerk, om zo een veilige verbinding te realiseren en remote management mogelijk te maken. Dit is op dit test-image *niet* geconfigureerd.

Bijwerken van het DL model met een nieuwe versie:
Een model bestaat uit de volgende 3 bestanden:
- 1: model.ckpt-*****.meta
- 2: model.ckpt-*****.index
- 3: model.ckpt-*****.data-00000-of-00001
en indien de class labels zijn aangepast ook een csv bestand met de nieuwe class labels (csv moet ',' separated zijn)

- Zet het nieuwe model (en de evt. csv file) in de DL models directory (zie boven).
- Pas de configuratie in params.py aan zodat het nieuwe model gebruikt wordt:
	YOUTUBE_CHECKPOINT_FILE
- Pas indien de class labels zijn aangepast aan:
	CLASS_LABELS_INDICES
- Indien het aantal klassen is aangepast dan ook deze parameter aanpassen
	PREDICTIONS_COUNT_LIMIT


Test of johan's fork
