#include <TimerOne.h>

// Konstanten
static const int NUMLEDS=9;
static const int NUMFARB=4;
static const int SIZEPAL = 8; //Anzahl der definierten Farben in setColor()

static int matrix[9] = {-1,-1,-1,-1,-1,-1,-1,-1,-1};



void setColor(int col) {
  int i;
  
  // Farb-Pins deaktivieren (HIGH - keine Farbe)
  for (i = NUMLEDS; i < NUMLEDS+NUMFARB; i++) { digitalWrite(i,HIGH); }

  switch (col) {
    case 0: digitalWrite (NUMLEDS+0, LOW); break; //rot
    case 1: digitalWrite (NUMLEDS+1, LOW); break; //gelb
    case 2: digitalWrite (NUMLEDS+2, LOW); break; //blau
    case 3: digitalWrite (NUMLEDS+3, LOW); break; //weiss

    case 4: digitalWrite (NUMLEDS+0, LOW); digitalWrite(NUMLEDS+1,LOW); break; //rot+gelb (orange)
    case 5: digitalWrite (NUMLEDS+0, LOW); digitalWrite(NUMLEDS+2,LOW); break; //rot+blau (lila)
    case 6: digitalWrite (NUMLEDS+2, LOW); digitalWrite(NUMLEDS+3,LOW); break; //blau+weiss (schlonz)

    case 7: digitalWrite (NUMLEDS+0, LOW); digitalWrite(NUMLEDS+1,LOW); digitalWrite(NUMLEDS+2,LOW); digitalWrite(NUMLEDS+3,LOW); break; //alle, heller schlonz
  }
}
  
void setRandomColor() {
  setColor(random(0,NUMFARB));
}
 



// -------------------------------------------------------------------------------------------------------------------------- SETUP --------------------------
void setup()   {                

  int i;
  // Box- und Farbpins als Output setzen
  for (i = 0; i < NUMLEDS+NUMFARB; i++) { pinMode(i, OUTPUT); }
  // Box-Pins ausschalten (LOW - keine Spannung)
  for (i = 0; i < NUMLEDS; i++) { digitalWrite(i,LOW); }
  // Farb-Pins deaktivieren (HIGH - keine Farbe)
  for (i = NUMLEDS; i < NUMLEDS+NUMFARB; i++) { digitalWrite(i,HIGH); }

  // Zufallszahlen seeden
  randomSeed(analogRead(0));
 
  //refresh-Timer anwerfen
  // 30FPS (alle 0.033s oder 33ms
  Timer1.initialize(1/1000/1000*500*1000000); //alle 500 mikrosekunden
  Timer1.attachInterrupt(drawit);
  
}







// -------------------------------------------------------------------------------------------------------------------------- LOOP --------------------------
void loop() {
  
int i;

for (i = 0; i < 9; i++) {
  matrix[i] = 3;
}


}

// --------------------------------------------------------------------------------------------------------------------------- INTERRUPT  ---------------------

void drawit() {
  int i, j;

  for (i = 0; i < SIZEPAL; i++) {  //wir gehen alle farben durch

    setAllOff();

    setColor(i);

    for (j = 0; j < NUMLEDS; j++) {  //wir gehen alle leds durch
      //wenn aktuelle led und farbe zusammenpassen: anschalten!
      if (matrix[j] == i) digitalWrite(j,HIGH);
    }

      delayMicroseconds(400);


  }
}

void setAllOff () {
 for (int i = 0; i < NUMLEDS; i++) { digitalWrite(i,LOW); }
}
