import os
from os import environ
import easyocr
reader = easyocr.Reader(['en'])
import pyrebase
import nltk
import smtplib
nltk.download('punkt')

config = {
  "apiKey": environ['apiKey'],
  "authDomain": environ['authDomain'],
  "databaseURL": environ['databaseURL'],
  "storageBucket": environ['storageBucket']
}

firebase = pyrebase.initialize_app(config)
storage = firebase.storage()
database = firebase.database()

def sendEmail(subject, message):
  tEmail = database.child('teacher').child("email").get().val()

  server = smtplib.SMTP_SSL('smtp.gmail.com', 465)
  password= "Helloworld1!"
  server.login(tEmail, password)
  toEmail = '[SendToEmail]'
  server.sendmail(tEmail, toEmail, 'Subject: {}\n\n{}'.format(subject, message))
  server.quit()

  print('Message Sent Successfully')

def convertImgToTxt(imgName):
  arrayOfText = reader.readtext(imgName, detail = 0)
  myString = ''

  for i in arrayOfText:
    myString+= (i + " ")
  
  return myString


storage.child('/uploaded.png').download('imageFromFirebase.png')

finalString = convertImgToTxt('img.png')

database.child('whatWeRead').set(finalString)

myFile = open('input.txt', 'w')
myFile.write(finalString)
myFile.close()


stream = os.popen('sumy luhn --length=30% --language=english --file=input.txt')
output = stream.read()
formattedOutput = ''
for i in output:
  formattedOutput += (i + " ")

database.child('shortenedText').set(formattedOutput)

sendEmail('MESSAGE from STUDENT', formattedOutput)
