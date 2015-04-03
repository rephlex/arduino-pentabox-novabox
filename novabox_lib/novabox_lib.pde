// Konstanten
static const int NUMLEDS=9;
static const int NUMCOL=3;
static const int NUMROW=3;
static const int NUMFARB=4;

static const int SIZEPAL = 8; //Anzahl der definierten Farben in setColor()




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
 



  
void setup()   {                

  //Variablen
  int i; //generic

  // Box- und Farbpins als Output setzen
  for (i = 0; i < NUMLEDS+NUMFARB; i++) { pinMode(i, OUTPUT); }

  // Box-Pins ausschalten (LOW - keine Spannung)
  for (i = 0; i < NUMLEDS; i++) { digitalWrite(i,LOW); }

  // Farb-Pins deaktivieren (HIGH - keine Farbe)
  for (i = NUMLEDS; i < NUMLEDS+NUMFARB; i++) { digitalWrite(i,HIGH); }

  // Zufallszahlen seeden
  randomSeed(analogRead(0));
 
 
}







// ---------------------- HAUPTPROGRAMM -----------------------
void loop() {
/*  int i;
    
  setColor(3);
  
  int matrix[9];
  int del = 200;

  drawletter('E', del);
  drawletter('I', del);
  drawletter('N', del);
  drawletter(' ', del);
  drawletter('R', del);
  drawletter('A', del);
  drawletter('D', del);
  drawletter('L', del);
  drawletter('E', del);
  drawletter('R', del);
  drawletter(' ', del);
  drawletter('B', del);
  drawletter('I', del);
  drawletter('T', del);
  drawletter('T', del);
  drawletter('E', del);
  drawletter(' ', del);
  drawletter(' ', del);
  drawletter(' ', del);
  drawletter(' ', del);
  drawletter(' ', del);
*/
int i;
for (i = 0; i < 3; i++) {
    setRandomColor();
    demoCoolShuffle(5000,50);
  }
  
  for (i = 0; i < SIZEPAL; i++) {
    setColor(i);
    fadeAllIn(5);
    fadeAllOut(5);
  }
  
  for (i = 0; i < 10; i++) {
    setAllOff(0);
    setRandomColor();
    for (i = 0; i < NUMLEDS; i++) {
      digitalWrite(i,HIGH);
      delay(250);
    }
    setAllOff(0);
    delay(100);
  }



}
// ---------------------- ENDE HAUPTPROGRAMM ------------------













//---------------------------------------------------------------------------------------- BASIS: ALLE AN, ALLE AUS
void setAllOn (int duration) {
 for (int i = 0; i < NUMLEDS; i++) { digitalWrite(i,HIGH); }
 delay(duration);
}


void setAllOff (int duration) {
 for (int i = 0; i < NUMLEDS; i++) { digitalWrite(i,LOW); }
 delay(duration);
}


//---------------------------------------------------------------------------------------- BASIS: FADE IN / FADE OUT (1=FAST, 5=SLOW)
void fadeAllIn (int speed) {
  for (int j=20; j > -1; j--) {  
    for (int i = 0; i < speed; i++) {
      setAllOn(20-j);
      setAllOff(j);
    }  
  }
}

void fadeAllOut(int speed) {
  for (int j=0; j < 21; j++) {    
    for (int i = 0; i < speed ; i++) {
      setAllOn(20-j);
      setAllOff(j);
    }  
  }
}

//------------------------------------------------------------------------------------------- ANIMATION: GADGETS
  
  void demoCoolShuffle(int duration, int stepping) {
  setAllOff(0);
  int led;
  while (duration > -1) {
    led = random(0,NUMLEDS);
    if (digitalRead(led) == HIGH) { digitalWrite(led,LOW); } else { digitalWrite(led,HIGH); }
    delay(stepping); duration -=stepping;    
  }  
  setAllOff(0);
}





// ------------------------------------------------------------------------------------------ ZEICHNE MATRIX 3x3 -----
void draw (int matrix[9]) {

  int i;
  
  for (i = 0; i < 9; i++) {
    if (matrix[i] == 0) { digitalWrite(i,LOW); }
    else { digitalWrite(i,HIGH); }
  }
  

}



// ------------------------------------------------------------------------------- ZEICHNE BUCHSTABEN -----
void drawletter(char letter, int stepping) {  // stepping in ms
  int matrix[9];
  prod_letter(matrix, letter);
  draw (matrix);
  delay(stepping*3);
  setAllOff(stepping);
}


void scrollletter(char letter, int stepping) {  // stepping in ms
  
  int matrix[9];            //originaler buchstabe
  int internalmatrix[21];   //originaler buchstabe mit 000000 header und 000000 trailer
  int drawmatrix[9];        //temp-3x3 für draw funktionsaufruf
  int nullmatrix[9] = { 0, 0, 0, 0, 0, 0, 0, 0, 0 }; //header/trailer für anzeige
 
 
  int i;    //zähler
  int j;


  prod_letter(matrix,letter);
  

  // erstelle: 000 000 + letter + 000 000
  for (i=0; i < 21; i++) {
    if ((i > 5) && (i < 15)) { internalmatrix[i] = matrix[i-6]; }
    else { internalmatrix[i] = 0; } 
  }


  // ausgeben header
// draw(nullmatrix); delay(stepping);

  // ausgeben der dreierreihen
  for (i = 0; i < 5; i++) {

    for (j = 0; j < 9; j++) {
      drawmatrix[j] = internalmatrix[i*3+j];
    }
    

  draw(drawmatrix);
    delay(stepping);
        
  }

 draw(nullmatrix); delay(stepping);
 
}


void prod_letter(int* matrix, char letter) {

  switch (letter) {
  
    case ' ':
      matrix[0] = 0;
      matrix[1] = 0;
      matrix[2] = 0;
      matrix[3] = 0;
      matrix[4] = 0;
      matrix[5] = 0;
      matrix[6] = 0;
      matrix[7] = 0;
      matrix[8] = 0;
      break;

    case 'A':
      matrix[0] = 0;
      matrix[1] = 1;
      matrix[2] = 1;
      matrix[3] = 1;
      matrix[4] = 1;
      matrix[5] = 0;
      matrix[6] = 0;
      matrix[7] = 1;
      matrix[8] = 1;
      break;

    case 'B':
      matrix[0] = 1;
      matrix[1] = 1;
      matrix[2] = 1;
      matrix[3] = 1;
      matrix[4] = 1;
      matrix[5] = 1;
      matrix[6] = 0;
      matrix[7] = 1;
      matrix[8] = 1;
      break;

    case 'C':
      matrix[0] = 1;
      matrix[1] = 1;
      matrix[2] = 1;
      matrix[3] = 1;
      matrix[4] = 0;
      matrix[5] = 1;
      matrix[6] = 1;
      matrix[7] = 0;
      matrix[8] = 1;
      break;

    case 'D':
      matrix[0] = 1;
      matrix[1] = 1;
      matrix[2] = 1;
      matrix[3] = 1;
      matrix[4] = 0;
      matrix[5] = 1;
      matrix[6] = 0;
      matrix[7] = 1;
      matrix[8] = 0;
      break;

    case 'E':
      matrix[0] = 1;
      matrix[1] = 1;
      matrix[2] = 1;
      matrix[3] = 1;
      matrix[4] = 1;
      matrix[5] = 1;
      matrix[6] = 1;
      matrix[7] = 1;
      matrix[8] = 1;
      break;

    case 'F':
      matrix[0] = 1;
      matrix[1] = 1;
      matrix[2] = 1;
      matrix[3] = 1;
      matrix[4] = 1;
      matrix[5] = 0;
      matrix[6] = 1;
      matrix[7] = 0;
      matrix[8] = 0;
      break;

    case 'H':
      matrix[0] = 1;
      matrix[1] = 1;
      matrix[2] = 1;
      matrix[3] = 0;
      matrix[4] = 1;
      matrix[5] = 0;
      matrix[6] = 1;
      matrix[7] = 1;
      matrix[8] = 1;
      break;

    case 'I':
      matrix[0] = 0;
      matrix[1] = 0;
      matrix[2] = 0;
      matrix[3] = 1;
      matrix[4] = 1;
      matrix[5] = 1;
      matrix[6] = 0;
      matrix[7] = 0;
      matrix[8] = 0;
      break;

    case 'K':
      matrix[0] = 1;
      matrix[1] = 1;
      matrix[2] = 1;
      matrix[3] = 0;
      matrix[4] = 1;
      matrix[5] = 0;
      matrix[6] = 1;
      matrix[7] = 0;
      matrix[8] = 1;
      break;


    case 'L':
      matrix[0] = 1;
      matrix[1] = 1;
      matrix[2] = 1;
      matrix[3] = 0;
      matrix[4] = 0;
      matrix[5] = 1;
      matrix[6] = 0;
      matrix[7] = 0;
      matrix[8] = 1;
      break;

    case 'M':
      matrix[0] = 1;
      matrix[1] = 1;
      matrix[2] = 1;
      matrix[3] = 1;
      matrix[4] = 1;
      matrix[5] = 0;
      matrix[6] = 0;
      matrix[7] = 1;
      matrix[8] = 1;
      break;

    case 'N':
      matrix[0] = 1;
      matrix[1] = 1;
      matrix[2] = 1;
      matrix[3] = 1;
      matrix[4] = 0;
      matrix[5] = 0;
      matrix[6] = 1;
      matrix[7] = 1;
      matrix[8] = 1;
      break;
      
    case 'O':
      matrix[0] = 1;
      matrix[1] = 1;
      matrix[2] = 1;
      matrix[3] = 1;
      matrix[4] = 0;
      matrix[5] = 1;
      matrix[6] = 1;
      matrix[7] = 1;
      matrix[8] = 1;
      break;
      
    case 'R':
      matrix[0] = 1;
      matrix[1] = 1;
      matrix[2] = 1;
      matrix[3] = 1;
      matrix[4] = 0;
      matrix[5] = 0;
      matrix[6] = 1;
      matrix[7] = 0;
      matrix[8] = 0;
      break;


   case 'T':
      matrix[0] = 1;
      matrix[1] = 0;
      matrix[2] = 0;
      matrix[3] = 1;
      matrix[4] = 1;
      matrix[5] = 1;
      matrix[6] = 1;
      matrix[7] = 0;
      matrix[8] = 0;
      break;


    case 'X':
      matrix[0] = 1;
      matrix[1] = 0;
      matrix[2] = 1;
      matrix[3] = 0;
      matrix[4] = 1;
      matrix[5] = 0;
      matrix[6] = 1;
      matrix[7] = 0;
      matrix[8] = 1;
      break;

  }


}
