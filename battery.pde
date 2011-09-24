#include <LiquidCrystal.h>
//LiquidCrystal lcd(8,7,6,5,4,3);

// for sippino
LiquidCrystal lcd(7,6,5,4,3,2);


static unsigned long lastTime = 0;

int voltagePin = A0;
int currentPin = A1;

float ampHours = 0;

// voltage calibration
// 
int adcV2 = 316;
int adcV1 = 0;
float V2 = 1.67;
float V1 = 0;
float Voffset = - (adcV2 - adcV1) / (V2 - V1) * V1 + adcV1;
float Vgain = V2 / (adcV2 - Voffset);

// current calibration
int adcI2 = 37;
int adcI1 = 0;
float I2 = 0.200;
float I1 = 0;
float Ioffset = - (adcI2 - adcI1) / (I2 - I1) * I1 + adcI1;
float Igain = I2 / (adcI2 - Ioffset);


void setup() {
  //delay(5000);
  analogReference(EXTERNAL);
  Serial.begin(9600);
  lcd.begin(20,4);
  lcd.setCursor(0,0);
  lcd.print(" volt amp   mAh");
  Serial.println("time (ms),voltage (V),current (A),charge(mAh),voltage adc, current adc");
}


void loop() {
  unsigned long thisTime = millis();

  // figure out how to get current and previous sample times
  int adcA0 = analogRead(voltagePin);
  int adcA1 = analogRead(currentPin);

  float voltage = (adcA0 - Voffset) * Vgain;
  float current = (adcA1 - Ioffset) * Igain;

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
  lcd.print(current, 3);

  // calculate amphours based on current, thisTime, and lastTime
  ampHours += current / 3600 * (thisTime - lastTime);
  Serial.print(ampHours, DEC);
  lcd.setCursor(12, 1);
  lcd.print(ampHours,0);

  // print raw dac readings to serial
  Serial.print(", ");
  Serial.print(adcA0);
  Serial.print(", ");
  Serial.print(adcA1);

  lcd.setCursor(0, 2);
  lcd.print("t(sec)");
  
  lcd.setCursor(8, 2);
  lcd.print("vadc");
  
  lcd.setCursor(13, 2);
  lcd.print("iadc");

  lcd.setCursor(0, 3);
  lcd.print(millis()/1000);
  
  lcd.setCursor(8, 3);
  lcd.print(adcA0, DEC);

  lcd.setCursor(13, 3);
  lcd.print(adcA1, DEC);

  Serial.println();

  lastTime = thisTime;

  delay(10000);
}

