insert into webguiVersion values ('5.1.0','upgrade',unix_timestamp());
delete from language where languageId=2;
insert into language (languageId,language,characterSet,toolbar) values (2, 'Deutsch (German)', 'ISO-8859-1', 'charcoal');
delete from international where languageId=2 and namespace='WebGUI' and internationalId=611;
insert into international (internationalId,languageId,namespace,message,lastUpdated) values (611,2,'WebGUI','<b>Firmen Name</b><br>\r\nDer Name Ihrer Firma. Er erscheint auf allen Emails und ?berall dort, wo das CompanyName-Macro eingesetzt wird.<br><br>\r\n<b>Firmen Email Adresse</b><br>\r\nEine allgemeine Firmen-Emailadresse. Von dieser Adresse werden alle automatischen Emails versendet. Sie kann auch ?ber das WebGUI-Macrosystem genutzt werden.<br><br>\r\n<b>Firmen URL</b><br>\r\nDie Haupt-URL Ihrer Firma. Diese erscheint auf allen von WebGUI versendeten Emails. Wie schon bei den ersten beiden Funktionen kann auch hier das WebGUI-Macrosystem benutzt werden.', 1043425351);
delete from international where languageId=2 and namespace='WebGUI' and internationalId=616;
insert into international (internationalId,languageId,namespace,message,lastUpdated) values (616,2,'WebGUI','<b>Pfad zu den WebGUI Extras</b><br>\r\nDer Webpfad zum Verzeichnis, dass die WebGUI Grafiken und javascript-Dateien enth?lt<br><br>\r\n<b>Maximale Dateigr??e f?r Anh?nge</b><br>\r\nDiese Einstellung gilt f?r alle Wobjects, die das Hochladen von Dateien und Bildern erlauben (wie z. B. Artikel) Die Gr?sse wird in Kilobytes angegeben.<br><br>\r\n<b>Gr?sse der Vorschaubilder (Thumbnails)</b><br>\r\nDie Gr?sse der l?ngsten Seite einer Grafik. Wenn Sie z. B. den Wert auf 100 setzen und Ihre Grafik ist 400 Pixel hoch und 200 Pixel breit, so wird das Vorschaubild eine H?he von 100 Pixels und eine Breite von 50 Pixels haben.<br><br><i>Beachten Sie:</i> Vorschaubilder werden automatisch generiert, wenn Grafiken hochgeladen/hinzugef?gt werden.<br><br>\r\n<b>Web Pfad f?r die Anh?nge</b><br>\r\nDer Webpfad zum Verzeichnis, in dem Anh?nge gespeichert werden sollen (z.B. /uploads).!  <br><br>\r\n<b>Serverpfad f?r die Anh?nge</b><br>\r\nDer lokale Pfad zum Verzeichnis, in dem die Anh?nge gespeichert werden sollen, z. B. /var/www/public/uploads. Beachten Sie, dass der Webserver gen?gend Rechte hat, um in dieses Verzeichnis speichern zu k?nnen.', 1043425071);
delete from international where languageId=2 and namespace='WebGUI' and internationalId=629;
insert into international (internationalId,languageId,namespace,message,lastUpdated) values (629,2,'WebGUI','<b>Proxy Caching unterbinden</b><br>\r\nEinige Firmen haben Proxy Server im Einsatz, die Probleme mit WebGUI verursachen k?nnen. Wenn Sie solche Problem feststellen, k?nnen Sie die Einstellungen auf \'JA\' setzen. Beachten Sie aber bitte, dass WebGUI\'s URLs nicht mehr so benutzerfreundlich sein werden, wenn dieses Feature aktiviert ist.\r\n<br><br>\r\n<b>Fehlersuche anzeigen</b><br>\r\nWenn dies aktiviert ist, werden erweiterte Meldungen, die lediglich f?r Entwickler oder Administratoren interessant sein k?nnen, angezeigt. Dies ist hilfreich beim L?sen eines Problems<br><br>\r\n<b>Seitenstatistik aktivieren<b><br>\r\nWebGUI kann einige statistische Informationen ?ber ihre Seite speichern. Jedoch wird dadurch die Prozessorbelastung erh?ht und die Datenbank wird etwas gr?sser. Aktivieren Sie dies nur, wenn Sie kein externes WebStatistik-Programm nutzen.', 1043424198);
delete from international where languageId=2 and namespace='WebGUI' and internationalId=630;
insert into international (internationalId,languageId,namespace,message,lastUpdated) values (630,2,'WebGUI','In WebGUI ist eine kleine, aber feine Echt-Zeit Suchmaschine integriert. Wenn Sie diese benutzen m?chten, k?nnen Sie das ^?; Makro nutzen, oder Sie f?gen \'?op=search\' ans Ende einer URL an oder Sie basteln Ihr eigenes Formular.<br><br>Einige Leute ben?tigen eine Suchmaschine, um ihre WebGUI Seite und andere Seiten zu indizieren. Oder sie haben mehr Anforderungen an eine Suchmaschine, als das, was die WebGUI Suchmaschine bietet. In diesen F?llen empfehlen wir <a href=\"http://www.mnogosearch.org/\">MnoGo Search</a> oder <a href=\"http://www.htdig.org/\">ht://Dig</a>.', 1043423742);
delete from international where languageId=2 and namespace='WebGUI' and internationalId=698;
insert into international (internationalId,languageId,namespace,message,lastUpdated) values (698,2,'WebGUI','Karma ist eine Methode, um Benutzeraktivit?ten zu verfolgen und den Benutzer m?glicherweise zu belohnen oder zu \'bestrafen\' f?r den Umfang der Aktivit?ten, die er durchgef?hrt hat. <br><br>Wenn Karma aktiviert ist, beachten Sie, dass bei den Einstellungen von vielen Komponenten in WebGUI Karma-Funktionen hinzugekommen sind (z. B. k?nnen Sie bei Abstimmungen \'Karma pro Abstimmung\' definieren.<br><br>\r\nSie k?nnen nachverfolgen bzw. Karma vergeben, wenn sich ein Benutzer anmeldet und wieviel er zu Ihrer Seite beigetragen hat (wieviele Beitr?ge er verfasst hat, etc.) \r\n<br><br>\r\nUnd Sie k?nnen z. B. je nach Karma-Anzahl Zugriff zu besonderen Bereichen gew?hren.<br><br>\r\nMehr ?ber Karma finden Sie in <a href=\"http://www.plainblack.com/ruling_webgui\">Ruling WebGUI</a>.', 1043423279);
delete from international where languageId=2 and namespace='WebGUI' and internationalId=819;
insert into international (internationalId,languageId,namespace,message,lastUpdated) values (819,2,'WebGUI','kann selbst deaktivieren', 1043422108);
delete from international where languageId=2 and namespace='WebGUI' and internationalId=836;
insert into international (internationalId,languageId,namespace,message,lastUpdated) values (836,2,'WebGUI','Schnipsel sind Text-Elemente, die mehrfach auf Ihrer Seite genutzt werden k?nnen. Dinge wie Java-Scripts, Style Sheets, Flash Animationen oder einfach nur Slogans sind Beispiele hierf?r. Das beste daran ist, dass Sie ?nderungen, die zum Beispiel in einem Slogan oder Werbespruch durchgef?hrt werden m?ssen, an zentraler Stelle ?ndern k?nnen.<br><br>\r\n<b>Name</b><br>Vergeben Sie einen eindeutigen Namen, damit Sie das Schnipsel sp?ter schnell wiederfinden k?nnen.<br><br>\r\n<b>In welches Verzeichnis</b><br>In welchen Ordner m?chten Sie das Schnipsel speichern<br><br>\r\n<b>Schnipsel</b><br>Geben Sie hier den Text ein oder noch einfacher: kopieren Sie den ben?tigten Text oder auch JavaScript-Code ?ber die Zwischenablage ein.', 1043421646);
alter table groups add column ipFilter varchar(255);
insert into international (internationalId,languageId,namespace,message,lastUpdated) values (857,1,'WebGUI','IP Address', 1043878310);
insert into international (internationalId,languageId,namespace,message,lastUpdated) values (861,1,'WebGUI','Make profile public?', 1043879954);
insert into international (internationalId,languageId,namespace,message,lastUpdated) values (860,1,'WebGUI','Make email address public?', 1043879942);
insert into international (internationalId,languageId,namespace,message,lastUpdated) values (859,1,'WebGUI','Signature', 1043879866);
insert into international (internationalId,languageId,namespace,message,lastUpdated) values (858,1,'WebGUI','Alias', 1043879848);
INSERT INTO userProfileField VALUES ('alias','WebGUI::International::get(858)',1,0,'text','','',4,3,0);
INSERT INTO userProfileField VALUES ('signature','WebGUI::International::get(859)',1,0,'HTMLArea','','',5,3,0);
INSERT INTO userProfileField VALUES ('publicProfile','WebGUI::International::get(861)',1,0,'yesNo','','[1]',9,4,0);
INSERT INTO userProfileField VALUES ('publicEmail','WebGUI::International::get(860)',1,0,'yesNo','','[1]',10,4,0);
insert into international (internationalId,languageId,namespace,message,lastUpdated) values (862,1,'WebGUI','This user\'s profile is not public.', 1043881275);
alter table groups add column dateCreated int not null default 997938000;
alter table groups add column lastUpdated int not null default 997938000;
alter table groups add column deleteOffset int not null default 14;
alter table groups add column expireNotifyOffset int not null default -14;
alter table groups add column expireNotifyMessage text;
alter table groups add column expireNotify int not null default 0;
alter table groups change expireAfter expireOffset int not null default 314496000;
insert into international (internationalId,languageId,namespace,message,lastUpdated) values (866,1,'WebGUI','Expire Notifcation Message', 1044127055);
insert into international (internationalId,languageId,namespace,message,lastUpdated) values (865,1,'WebGUI','Notify user about expiration?', 1044126938);
insert into international (internationalId,languageId,namespace,message,lastUpdated) values (864,1,'WebGUI','Expire Notification Offset', 1044126838);
insert into international (internationalId,languageId,namespace,message,lastUpdated) values (863,1,'WebGUI','Delete Offset', 1044126633);
delete from international where languageId=1 and namespace='WebGUI' and internationalId=367;
insert into international (internationalId,languageId,namespace,message,lastUpdated) values (367,1,'WebGUI','Expire Offset', 1044126611);
insert into international (internationalId,languageId,namespace,message,lastUpdated) values (867,1,'WebGUI','Loss of Privilege', 1044133143);






