#include <LiquidCrystal.h>
LiquidCrystal lcd(8,7,6,5,4,3);

int sensorPin = A0;    // select the input pin for the potentiometer
float ampHours = 0;

void setup() {
  Serial.begin(9600);
  lcd.begin(16,1);
}

void loop() {
  int sensorValue = analogRead(sensorPin);
  float voltage = sensorValue * 5.0 / 1024;
  Serial.print(voltage, DEC);
  Serial.print("V ");
  lcd.setCursor(0,0);
  lcd.print(voltage,1);
  lcd.print("V ");
  
  float current = sensorValue * 5.0 / 1024 / 10;  
  Serial.print(current, DEC);
  Serial.print("A ");
  lcd.print(current,1);
  lcd.print("A ");
  
  ampHours += current / 3600 * 1000;
  Serial.print(ampHours, DEC);
  Serial.print("mAh");
  lcd.print(ampHours,0);
  
  Serial.println();
  delay(1000);
}
