#!/bin/bash

#Servidor SMTP
SERVIDOR_SMTP="smtp-mail.outlook.com:587"
SENHA=""

EMAIL_FROM="igortullio@hotmail.com"

MENSAGEM="Prezados,\n\nSegue meu currículo para a vaga.\n\nDesde já agradeço.\n\nIgor Túllio"

ANEXO=Igor_Tullio.pdf

read -p "Quantos e-mails deseja enviar? " NUMBER
rm emails.txt
for ((n=0; n<$NUMBER; n++)) do
	read -p "Digite o destinatário: " EMAIL_TO
	echo $EMAIL_TO >> emails.txt
done

read -p "Digite o assunto: " ASSUNTO
rm assunto.txt
echo $ASSUNTO >> assunto.txt
iconv assunto.txt -f UTF-8 -t UNICODELITTLE -o assunto.txt

while read EMAIL_TO; do 
	sendEmail -f $EMAIL_FROM -t $EMAIL_TO -u "`cat assunto.txt`" -m $MENSAGEM -a $ANEXO -s $SERVIDOR_SMTP -xu $EMAIL_FROM -xp $SENHA -o message-charset=UTF-8;
done < emails.txt

rm assunto.txt
rm emails.txt
