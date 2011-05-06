#include <LiquidCrystal.h>
LiquidCrystal lcd(8,7,6,5,4,3);

int voltagePin = A0;
int currentPin = A1;

float ampHours = 0;

void setup() {
  delay(5000);
  Serial.begin(9600);
  lcd.begin(16,4);
  lcd.setCursor(0,0);
  lcd.print(" volt amp  mAh");
  Serial.println("time (ms),voltage (V),current (A),charge(mAh)");
}

void loop() {
  // figure out how to get current and previous sample times
  float voltage = analogRead(voltagePin) * 5.0 / 1024;
  float current = analogRead(currentPin) * 5.0 / 1024;
  
  Serial.print(millis());
  Serial.print(", ");
  Serial.print(voltage, DEC);
  Serial.print(", ");
  lcd.setCursor(1, 1);
  lcd.print(voltage, 2);
  
  Serial.print(current, DEC);
  Serial.print(", ");
  lcd.setCursor(6, 1);
  lcd.print(current, 2);
  
  ampHours += current / 3600 * 1000;
  Serial.print(ampHours, DEC);
  lcd.setCursor(11, 1);
  lcd.print(ampHours,0);
  
  lcd.setCursor(-3, 2);
  lcd.print("time (sec)");
  lcd.setCursor(-3, 3);
  lcd.print(millis());
  
  Serial.println();
  delay(1000);
}
