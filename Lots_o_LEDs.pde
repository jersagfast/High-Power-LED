#include <LiquidCrystal.h>
LiquidCrystal lcd(12, 8, 7, 4, 2, 1);
int ohwarmsw = 18;  //switch
int ohwarmv = 0;
int ohwarm = 11;  //load
int ohwarmtog = 0;
int ohwarmonoff = 0;
int ohcoolsw = 17;  //switch
int ohcoolv = 0;
int ohcool = 10;  //load
int ohcooltog = 0;
int ohcoolonoff = 0;
int shelfsw = 19;  //switch
int shelfv = 0;
int shelf = 5;  //load
int shelftog = 0;
int shelfonoff = 0;
int floorsw = 15;  //switch
int floorv = 0;
int floorled = 6;  //load
int floortog = 0;
int flooronoff = 0;
int spotsw = 16;  //switch
int spotv = 0;
int spot = 9;  //load
int spottog = 0;
int spotonoff = 0;
int auxsw = 14;
int auxv = 0;
int auxtog = 0;
int aux = 3;
int auxonoff = 0;
int masterv = 0;
int mastersw = 13;  //switch
int mastertog = 0;
int masteronoff = 0;
byte lcdlighton[8] = {
  B11111,
  B11111,
  B01110,
  B00000,
  B10101,
  B10101,
  B10101,
  B00000,
};
byte lcdlightoff[8] = {
  B11111,
  B11111,
  B01110,
  B00000,
  B00000,
  B00000,
  B00000,
  B00000,
};
long readVcc() {
  long result;
  // Read 1.1V reference against AVcc
  ADMUX = _BV(REFS0) | _BV(MUX3) | _BV(MUX2) | _BV(MUX1);
  delay(2); // Wait for Vref to settle
  ADCSRA |= _BV(ADSC); // Convert
  while (bit_is_set(ADCSRA,ADSC));
  result = ADCL;
  result |= ADCH<<8;
  result = 1126400L / result; // Back-calculate AVcc in mV
  return result;
}
void setup() {
  lcd.createChar(1, lcdlighton),
  lcd.createChar(0, lcdlightoff),
  pinMode (ohcoolsw, INPUT);
  pinMode (ohwarmsw, INPUT);
  pinMode (mastersw, INPUT);
  pinMode (shelfsw, INPUT);
  pinMode (floorsw, INPUT);
  pinMode (auxsw, INPUT);
  pinMode(floorled, OUTPUT);
  pinMode(spotsw, INPUT);
  pinMode(ohwarm, OUTPUT);
  pinMode(shelf, OUTPUT);
  pinMode(ohcool, OUTPUT);
  pinMode(aux, OUTPUT);
  lcd.begin(20, 4);
  lcd.setCursor(0, 0);
  lcd.print(" thecustomgeek.com");
  lcd.setCursor(0, 1);
  lcd.print("   LED Controller");
  lcd.setCursor(0, 2);
  lcd.print("Because shadows are");
  lcd.setCursor(0, 3);
  lcd.print("evil.");
  delay (6000);
  lcd.clear();
  lcd.print("Shelf:   Over-Warm:");
  lcd.setCursor(0, 1);
  lcd.print("Over-cool:   Spot:");
  lcd.setCursor(0, 2);
  lcd.print("Floor:       Aux:");
  lcd.setCursor(0, 3);
  lcd.print("Bus Voltage:");
  lcd.setCursor (16, 3);
  lcd.print(" mV");
  lcd.setCursor(6,0);
lcd.write(0);
lcd.setCursor(19,0);
lcd.write(0);
lcd.setCursor(10,1);
lcd.write(0);
lcd.setCursor(18,1);
lcd.write(0);
lcd.setCursor(6,2);
lcd.write(0);
lcd.setCursor(17,2);
lcd.write(0);
}
void loop() {
  ohcoolv = digitalRead(ohcoolsw);
  ohwarmv = digitalRead(ohwarmsw);
  shelfv = digitalRead(shelfsw);
  floorv = digitalRead(floorsw);
  spotv = digitalRead(spotsw);
  masterv = digitalRead(mastersw);
  auxv = digitalRead(auxsw);
  lcd.setCursor(12, 3);
 lcd.print(readVcc(), DEC );
 
if (ohwarmv != ohwarmtog) {
  if (ohwarmv == HIGH) {
    if (ohwarmonoff == 0) {
      ohwarmonoff = 1;
      ohwarmon();
  } else {
    ohwarmonoff = 0;
    ohwarmoff();
  }
  }
}
ohwarmtog = ohwarmv;
if (ohcoolv != ohcooltog) {
  if (ohcoolv == HIGH) {
    if (ohcoolonoff == 0) {
      ohcoolonoff = 1;
      ohcoolon();
  } else {
    ohcoolonoff = 0;
    ohcooloff();
  }
  }
}
if (shelfv != shelftog) {
  if (shelfv == HIGH) {
    if (shelfonoff == 0) {
      shelfonoff = 1;
      shelfon();
  } else {
    shelfonoff = 0;
    shelfoff();
  }
  }
}
shelftog = shelfv;
if (floorv != floortog) {
  if (floorv == HIGH) {
    if (flooronoff == 0) {
      flooronoff = 1;
      flooron();
  } else {
    flooronoff = 0;
    flooroff();
  }
  }
}
floortog = floorv;
if (spotv != spottog) {
  if (spotv == HIGH) {
    if (spotonoff == 0) {
      spotonoff = 1;
      spoton();
  } else {
    spotonoff = 0;
    spotoff();
  }
  }
}
spottog = spotv;
if (auxv != auxtog) {
  if (auxv == HIGH) {
    if (auxonoff == 0) {
      auxonoff = 1;
      auxon();
  } else {
    auxonoff = 0;
    auxoff();
  }
  }
}
auxtog = auxv;
if (masterv != mastertog) {
  if (masterv == HIGH) {
    if (masteronoff == 0) {
      masteronoff = 1;
      if (shelfonoff == 0) {
      shelfon();
      }
      if (ohwarmonoff == 0) {
      ohwarmon();
      }
      if (ohcoolonoff == 0) {
      ohcoolon();
      }
      if (auxonoff == 0) {
      spoton();
      }
      if (spotonoff == 0) {
      flooron();
      }
      if (flooronoff == 0) {
      auxon();
      }
  } else {
    masteronoff = 0;
    shelfoff();
    for (int pulsev = 255; pulsev >= 0; pulsev--) {
      if (ohwarmonoff == 1) {
       analogWrite(ohwarm, pulsev);
      }
      if (ohcoolonoff == 1) {
       analogWrite(ohcool, pulsev);
      }
      if (spotonoff == 1) {
       analogWrite(floorled, pulsev);
      }
      if (auxonoff == 1) {
       analogWrite(spot, pulsev);
      }
      if (flooronoff == 1) {
       analogWrite(aux, pulsev);
      }
      delay(7);
}
lcd.setCursor(6,0);
lcd.write(0);
lcd.setCursor(19,0);
lcd.write(0);
lcd.setCursor(10,1);
lcd.write(0);
lcd.setCursor(18,1);
lcd.write(0);
lcd.setCursor(6,2);
lcd.write(0);
lcd.setCursor(17,2);
lcd.write(0);
  }
  }
}
mastertog = masterv;
}
 void ohwarmon()  {
 for (int pulsev = 0; pulsev <= 255; pulsev++) {
       analogWrite(ohwarm, pulsev);
      delay(3);
}
lcd.setCursor(19,0);
lcd.write(1);
}
void ohcoolon()  {
 for (int pulsev = 0; pulsev <= 255; pulsev++) {
       analogWrite(ohcool, pulsev);
      delay(3);
}
lcd.setCursor(10,1);
lcd.write(1);
}
void shelfon()  {
 digitalWrite(shelf, HIGH);
 lcd.setCursor(6,0);
 lcd.write(1);
}
void spoton()  {
 for (int pulsev = 0; pulsev <= 255; pulsev++) {
       analogWrite(spot, pulsev);
      delay(3);
}
lcd.setCursor(18,1);
lcd.write(1);
}
void flooron()  {
 for (int pulsev = 0; pulsev <= 255; pulsev++) {
       analogWrite(floorled, pulsev);
      delay(3);
}
lcd.setCursor(6,2);
lcd.write(1);
}
void auxon()  {
 for (int pulsev = 0; pulsev <= 255; pulsev++) {
       analogWrite(aux, pulsev);
      delay(3);
}
lcd.setCursor(17,2);
lcd.write(1);
}
void ohwarmoff()  {
 for (int pulsev = 255; pulsev >= 0; pulsev--) {
       analogWrite(ohwarm, pulsev);
      delay(7);
}
lcd.setCursor(19,0);
lcd.write(0);
}
void ohcooloff()  {
 for (int pulsev = 255; pulsev >= 0; pulsev--) {
       analogWrite(ohcool, pulsev);
      delay(7);
}
lcd.setCursor(10,1);
lcd.write(0);
}
void shelfoff()  {
 digitalWrite(shelf, LOW);
 lcd.setCursor(6,0);
 lcd.write(0);
}
void spotoff()  {
 for (int pulsev = 255; pulsev >= 0; pulsev--) {
       analogWrite(spot, pulsev);
      delay(7);
}
lcd.setCursor(18,1);
lcd.write(0);
}
void flooroff()  {
 for (int pulsev = 255; pulsev >= 0; pulsev--) {
       analogWrite(floorled, pulsev);
      delay(7);
}
lcd.setCursor(6,2);
lcd.write(0);
}
void auxoff()  {
 for (int pulsev = 255; pulsev >= 0; pulsev--) {
       analogWrite(aux, pulsev);
      delay(7);
}
lcd.setCursor(17,2);
lcd.write(0);
}
