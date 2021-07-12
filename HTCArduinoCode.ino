
#include <Firebase_Arduino_WiFiNINA.h>
#include <Firebase_Arduino_WiFiNINA_HTTPClient.h>

#include "Firebase_Arduino_WiFiNINA.h"
#include "Arduino_LSM6DS3.h"

#define FIREBASE_HOST ""
#define FIREBASE_AUTH ""
#define WIFI_SSID ""
#define WIFI_PASSWORD ""


FirebaseData firebaseData;


#include <Servo.h>

  Servo servo1;

  
void setup() {
  // put your setup code here, to run once:

  //Serial.begin(9600);

    WiFi.begin(WIFI_SSID, WIFI_PASSWORD);

      WiFi.localIP();
 // Serial.println();
  Firebase.begin(FIREBASE_HOST, FIREBASE_AUTH, WIFI_SSID, WIFI_PASSWORD);

servo1.attach(6);
  pinMode(3, OUTPUT);
  pinMode(12, OUTPUT);
  pinMode(13, OUTPUT);
  
  
}

void loop() {
  // put your main code here, to run repeatedly:

int val = Firebase.getInt(firebaseData, "/arduinoVal");
//int val = firebaseData.intData();

while(val==1)
{

servo1.write(0);
servo1.write(180);
digitalWrite(12, HIGH);
delay(1000);
digitalWrite(12, LOW);
}

}
