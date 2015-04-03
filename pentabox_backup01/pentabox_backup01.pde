void setup()   {                
  pinMode(0, OUTPUT);     
  pinMode(1, OUTPUT);     
  pinMode(2, OUTPUT);     
  pinMode(3, OUTPUT);     
  pinMode(4, OUTPUT);
  pinMode(5, OUTPUT);     

  digitalWrite(0,LOW);
  digitalWrite(1,LOW);
  digitalWrite(2,LOW);
  digitalWrite(3,LOW);
  digitalWrite(4,LOW);

}

void loop() {

setAllOn(1000);
  
  
  
  
  
  
/*  int i;
  demoOutToInLoop(1500,10);
  for(i=0; i<4; i++) { demoOutToIn(1500); }
  for(i=0; i<4; i++) { demoTopToBottom1(1000); demoBottomToTop1(1000); }
  for(i=0; i<8; i++) { demoTopToBottom1(500); demoBottomToTop1(500); }
  for(i=0; i<16; i++) { demoTopToBottom1(200); demoBottomToTop1(200); }
  setAllOff(300);
  for(i=0; i<20; i++) { setAllOff(50); setAllOn(50); }
  setAllOn(10000);
*/

}





// ------------------------------------------------------------------------------------------ BASIS: ALLE AN / ALLE AUS --

void setAllOn (int duration) {
  digitalWrite(0,HIGH);
  digitalWrite(1,HIGH);
  digitalWrite(2,HIGH);
  digitalWrite(3,HIGH);
  digitalWrite(4,HIGH);

  delay(duration);

}

void setAllOff (int duration) {
  digitalWrite(0,LOW);
  digitalWrite(1,LOW);
  digitalWrite(2,LOW);
  digitalWrite(3,LOW);
  digitalWrite(4,LOW);

  delay(duration);

}



// ------------------------------------------------------------------------------------------ DEMOS - LAUFLICHT OBEN -> UNTEN // UNTEN -> OBEN --

void demoBottomToTop1 (int duration) {
  for (int i = 0; i < 5; i++) {
    digitalWrite(i,HIGH);
    delay(duration/5);
    digitalWrite(i,LOW);
  }
}

void demoTopToBottom1 (int duration) {
  for (int i = 4; i > -1; i--) {
    digitalWrite(i,HIGH);
    delay(duration/5);
    digitalWrite(i,LOW);
  }
}

void demoBottomToTop2 (int duration) {
  for (int i = 0; i < 4; i++) {
    digitalWrite(i,HIGH);
    digitalWrite(i+1,HIGH);
    delay(duration/3);
    digitalWrite(i,LOW);
    digitalWrite(i+1,LOW);
  }
}

void demoTopToBottom2 (int duration) {
  for (int i = 4; i > 0; i--) {
    digitalWrite(i,HIGH);
    digitalWrite(i-1,HIGH);
    delay(duration/3);
    digitalWrite(i,LOW);
    digitalWrite(i-1,LOW);
  }
}

// ------------------------------------------------------------------------------------------ DEMOS - AUSSEN -> INNEN, INNEN -> AUSSEN --


void demoInToOut (int duration) {
  for (int i = 2; i < 5; i++) {
    digitalWrite(i,HIGH);
    digitalWrite(2+(2-i),HIGH);
    delay(duration/3);
    digitalWrite(i,LOW);
    digitalWrite(2+(2-i),LOW);
  }
}

void demoOutToIn (int duration) {
  for (int i = 4; i > 1; i--) {
    digitalWrite(i,HIGH);
    digitalWrite(4-i,HIGH);
    delay(duration/3);
    digitalWrite(i,LOW);
    digitalWrite(4-i,LOW);
  }
}

void demoOutToInLoop (int duration, int count) {

  for (int j = count; j > 0; j--) {
    setAllOff(0);
    digitalWrite(0,HIGH);
    digitalWrite(4,HIGH);
    delay(duration/4);
  
    setAllOff(0);
    digitalWrite(1,HIGH);
    digitalWrite(3,HIGH);
    delay(duration/4);
  
    setAllOff(0);
    digitalWrite(2,HIGH);
    delay(duration/4);
  
    setAllOff(0);
    digitalWrite(1,HIGH);
    digitalWrite(3,HIGH);
    delay(duration/4);
  }
    setAllOff(0);
    digitalWrite(0,HIGH);
    digitalWrite(4,HIGH);
    delay(duration/4);

}

