#include <LiquidCrystal.h>
LiquidCrystal lcd(8,7,6,5,4,3);

static unsigned long lastTime = 0;

int voltagePin = A0;
int currentPin = A1;

float ampHours = 0;

void setup() {
  //delay(5000);
  Serial.begin(9600);
  lcd.begin(20,4);
  lcd.setCursor(0,0);
  lcd.print(" volt amp  mAh");
  Serial.println("time (ms),voltage (V),current (A),charge(mAh)");
}

void loop() {
  unsigned long thisTime = millis();

  // figure out how to get current and previous sample times
  int dacA0 = analogRead(voltagePin);
  int dacA1 = analogRead(currentPin);

  float voltageConvert = 1.5 / 306;  // calibration factor
  float currentConvert = 0.1 / 18;   // calibration factor

  float voltage = dacA0 * voltageConvert;
  float current = dacA1 * currentConvert;

  // output voltage to serial and lcd
  Serial.print(millis());
  Serial.print(", ");
  Serial.print(voltage, DEC);
  Serial.print(", ");
  lcd.setCursor(1, 1);
  lcd.print(voltage, 2);

  // output current to serial and lcd
  Serial.print(current, DEC);
  Serial.print(", ");
  lcd.setCursor(6, 1);
  lcd.print(current, 2);

  // calculate amphours based on current, thisTime, and lastTime
  ampHours += current / 3600 * (thisTime - lastTime);
  Serial.print(ampHours, DEC);
  lcd.setCursor(11, 1);
  lcd.print(ampHours,0);

  // print raw dac readings to serial
  Serial.print(", ");
  Serial.print(dacA0);
  Serial.print(", ");
  Serial.print(dacA1);

  lcd.setCursor(0, 2);
  lcd.print("time (sec)");
  lcd.setCursor(0, 3);
  lcd.print(millis()/1000);
  lcd.setCursor(10, 3);
  lcd.print(dacA1, DEC);
  Serial.println();

  lastTime = thisTime;

  delay(10000);
}
