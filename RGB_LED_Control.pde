char datain[9];
int i;
int whtlev;
int redlev;
int grnlev;
int blulev;
int index;
int targetw;
int targetr;
int targetg;
int targetb;
char digit1[1];
char digit2[1];
char digit3[1];
String mystring;
void setup() {
  Serial.begin(9600);
  for(i = 0 ; i <= 255; i+=1) { 
    analogWrite(9, i);
    delay(2);
  }
  for(i = 255 ; i >= 0; i-=1) { 
    analogWrite(9, i);
    delay(2);
  }
  for(i = 0 ; i <= 255; i+=1) { 
    analogWrite(10, i);
    delay(2);
  }
  for(i = 255 ; i >= 0; i-=1) { 
    analogWrite(10, i);
    delay(2);
  }
  for(i = 0 ; i <= 255; i+=1) { 
    analogWrite(11, i);
    delay(2);
  }
  for(i = 255 ; i >= 0; i-=1) { 
    analogWrite(11, i);
    delay(2);
  }
  for(i = 0 ; i <= 255; i+=1) { 
    analogWrite(3, i);
    delay(2);
  }
  for(i = 255 ; i >= 0; i-=1) { 
    analogWrite(3, i);
    delay(2);
  }
  for(i = 0 ; i <= 255; i+=1) { 
    analogWrite(11, i);
    delay(3);
  }
  for(i = 0 ; i <= 255; i+=1) { 
    analogWrite(9, i);
    delay(2);
  }
  for(i = 0 ; i <= 255; i+=1) { 
    analogWrite(10, i);
    delay(2);
  }
  for(i = 0 ; i <= 255; i+=1) { 
    analogWrite(3, i);
    delay(2);
  }
  for(i = 255 ; i >= 0; i-=1) { 
    analogWrite(9, i);
    delay(2);
  }
  for(i = 255 ; i >= 0; i-=1) { 
    analogWrite(10, i);
    delay(2);
  }
  for(i = 255 ; i >= 0; i-=1) { 
    analogWrite(11, i);
    delay(5);
  }
  for(i = 255 ; i >= 0; i-=1) { 
    analogWrite(3, i);
    delay(5);
  }
}
void loop() {
index = 0;
while(Serial.available() > 0 && index < 9)
{
   char aChar = Serial.read();
   datain[index] = aChar;
   index++;
   datain[index] = '\0'; // Keep the string NULL terminated   
}
String mystring = datain;
if (mystring.startsWith("white")) {
digit1[1] = datain[6];
digit2[1] = datain[7];
digit3[1] = datain[8];
targetw = atoi(digit2);
white(targetw);
}
if (mystring.startsWith("red")) {
digit1[1] = datain[4];
digit2[1] = datain[5];
digit3[1] = datain[6];
targetr = atoi(digit2);
red(targetr);
}
if (mystring.startsWith("green")) {
digit1[1] = datain[6];
digit2[1] = datain[7];
digit3[1] = datain[8];
targetg = atoi(digit2);
green(targetg);
}
if (mystring.startsWith("blue")) {
digit1[1] = datain[5];
digit2[1] = datain[6];
digit3[1] = datain[7];
targetb = atoi(digit2);
blue(targetb);
}
delay(75);
/*
Serial.print("mystring:");
Serial.println(mystring);
Serial.print("Value:");
Serial.print(datain[6]);
Serial.print(datain[7]);
Serial.println(datain[8]);
Serial.print("targetw:");
Serial.print(targetw);
Serial.print("   targetr:");
Serial.print(targetr);
Serial.print("   targetg:");
Serial.print(targetg);
Serial.print("   targetb:");
Serial.println(targetb);
*/
}
void white(int targetw)  {
  if (whtlev < targetw) {
 for (int x = whtlev; x <= targetw; x++) {
        analogWrite(3, x);
        delay(8);
 }
  }
  if (whtlev > targetw) {
 for (int x = whtlev; x >= targetw; x--) {
        analogWrite(3, x);
        delay(8);
 }
  }
 whtlev = targetw;
}
void red(int targetr)  {
  if (redlev < targetr) {
 for (int x = redlev; x <= targetr; x++) {
        analogWrite(9, x);
        delay(8);
 }
  }
  if (redlev > targetr) {
 for (int x = redlev; x >= targetr; x--) {
        analogWrite(9, x);
        delay(8);
 }
  }
 redlev = targetr;
}
void green(int targetg)  {
  if (grnlev < targetg) {
 for (int x = grnlev; x <= targetg; x++) {
        analogWrite(10, x);
        delay(8);
 }
  }
  if (grnlev > targetg) {
 for (int x = grnlev; x >= targetg; x--) {
        analogWrite(10, x);
        delay(8);
 }
  }
 grnlev = targetg;
}
void blue(int targetb)  {
  if (blulev < targetb) {
 for (int x = blulev; x <= targetb; x++) {
        analogWrite(11, x);
        delay(8);
 }
  }
  if (blulev > targetb) {
 for (int x = blulev; x >= targetb; x--) {
        analogWrite(11, x);
        delay(8);
 }
  }
 blulev = targetb;
}
