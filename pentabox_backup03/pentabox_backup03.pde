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

  randomSeed(analogRead(0));
}

void loop() {

  //Zufaelliges Programm auswaehlen
  int prog;
  prog = random(1,3+1);
  
  //Programmnummer für 5 Sekunden anzeigen
  for(int i = 0; i < prog; i++) {
     digitalWrite(i,HIGH);
  }
  delay(5000); setAllOff(0);

  switch (prog) {
    case 1:  //Programm 1: Dauer-An
      while (1==1) { setAllOn(10000); }
      break;
    case 2:  //Programm 2: Zufällige Demo abspielen
      while(1==1) { playRandomDemo(); }
      break;
    case 3:  //Programm 3: Feste Compilation #1 abspielen
      while (1==1) { playCompilation1(); }
      break;    
  }


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



// -------------------------------------------------------------------------------------- DEMOS - FADENDES LAUFLICHT OBEN -> UNTEN // UNTEN -> OBEN --

void demoFadeBottomToTop(int speed) {
  for (int k = 0; k < 6; k++) {

    // erste LED einblenden
    if (k == 0) {
      for (int j=20; j > -1; j--) {  
        for (int i = 0; i < speed; i++) {
  
          digitalWrite(k,HIGH); delay(20-j);    
          digitalWrite(k,LOW); delay(j);
  
        }  
      }
    }
    
    //k einblenden, k-1 ausblenden
    if ((k != 0) && (k != 5)) {
      for (int j=20; j > -1; j--) {  
        for (int i = 0; i < speed; i++) {
  
          digitalWrite(k,HIGH); digitalWrite(k-1, LOW); delay(20-j);    
          digitalWrite(k,LOW); digitalWrite(k-1,HIGH); delay(j);
  
        }  
      }
    digitalWrite(k-1,LOW);
    }
    
    // letzte LED ausblenden
    if (k == 5) {
      for (int j=20; j > -1; j--) {  
        for (int i = 0; i < speed; i++) {
          digitalWrite(k-1,LOW); delay(20-j);
          digitalWrite(k-1,HIGH); delay(j);
        }  
      }
    digitalWrite(k-1,LOW);    
    }
    
  }
}


void demoFadeTopToBottom(int speed) {
  for (int k = 4; k > -2; k--) {

    // erste LED einblenden
    if (k == 4) {
      for (int j=20; j > -1; j--) {  
        for (int i = 0; i < speed; i++) {
  
          digitalWrite(k,HIGH); delay(20-j);    
          digitalWrite(k,LOW); delay(j);
  
        }  
      }
    }
    
    //k einblenden, k+1 ausblenden
    if ((k != 4) && (k != -1)) {
      for (int j=20; j > -1; j--) {  
        for (int i = 0; i < speed; i++) {
  
          digitalWrite(k,HIGH); digitalWrite(k+1, LOW); delay(20-j);    
          digitalWrite(k,LOW); digitalWrite(k+1,HIGH); delay(j);
  
        }  
      }
    digitalWrite(k+1,LOW);
    }
    
    // letzte LED ausblenden
    if (k == -1) {
      for (int j=20; j > -1; j--) {  
        for (int i = 0; i < speed; i++) {
          digitalWrite(k+1,LOW); delay(20-j);
          digitalWrite(k+1,HIGH); delay(j);
        }  
      }
    digitalWrite(k+1,LOW);    
    }
    
  }
}



void demoFadePingPong(int speed, int count) {

  int k;
  
  // erste LED einblenden
  k = 4;
  for (int j=20; j > -1; j--) {  
    for (int i = 0; i < speed; i++) {
      digitalWrite(k,HIGH); delay(20-j);    
      digitalWrite(k,LOW); delay(j);
    }  
  }


  for (int ctr = 0; ctr < count; ctr++) {

    for (int k = 4; k > -1; k--) {
      
      //k einblenden, k+1 ausblenden
      if ((k != 4) && (k != -1)) {
        for (int j=20; j > -1; j--) {  
          for (int i = 0; i < speed; i++) {
    
            digitalWrite(k,HIGH); digitalWrite(k+1, LOW); delay(20-j);    
            digitalWrite(k,LOW); digitalWrite(k+1,HIGH); delay(j);
    
          }  
        }
      digitalWrite(k+1,LOW);
      }
            
    }
    
    for (int k = 0; k < 6; k++) {
  
      //k einblenden, k-1 ausblenden
      if ((k != 0) && (k != 5)) {
        for (int j=20; j > -1; j--) {  
          for (int i = 0; i < speed; i++) {
    
            digitalWrite(k,HIGH); digitalWrite(k-1, LOW); delay(20-j);    
            digitalWrite(k,LOW); digitalWrite(k-1,HIGH); delay(j);
    
          }  
        }
      digitalWrite(k-1,LOW);
      }
      
    }    
    
  }

 // letzte LED ausblenden
 k = 5;
 for (int j=20; j > -1; j--) {  
   for (int i = 0; i < speed; i++) {
     digitalWrite(k-1,LOW); delay(20-j);
     digitalWrite(k-1,HIGH); delay(j);
   }  
 }
 digitalWrite(k-1,LOW);    


}




// ------------------------------------------------------------------------------------------ DEMOS - LAUFLICHT HART OBEN -> UNTEN // UNTEN -> OBEN --
// ------------------------------------------------EINZELN
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

// ------------------------------------------------ZWEI GLEICHZEITIG
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

// ------------------------------------------------------------------------------------------ DEMOS - 2-3 --

void demoTwoThree(int duration, int count) {
  for (int i = 0; i < count; i++) {
    digitalWrite(0,LOW);
    digitalWrite(1,HIGH);
    digitalWrite(2,LOW);
    digitalWrite(3,HIGH);
    digitalWrite(4,LOW);
    delay(duration/2);
    digitalWrite(0,HIGH);
    digitalWrite(1,LOW);
    digitalWrite(2,HIGH);
    digitalWrite(3,LOW);
    digitalWrite(4,HIGH);
    delay(duration/2);
  }
}

// ----------------------------------------------------------------------------------------- DEMOS - VU --

void demoVUFromBottom(int duration, int pause, int count) {
  for (int j = 0; j < count; j++) {
    setAllOff(0);
    for (int i=0; i < 5; i++) {
      digitalWrite(i,HIGH);
      delay(duration/8);
    }
    setAllOn(0);
    for (int i=4; i > 0; i--) {
      digitalWrite(i,LOW);
      if (i != 0) { delay(duration/8); }
    }
  delay(pause);
  }
}

void demoVUFromTop(int duration, int pause, int count) {
  for (int j = 0; j < count; j++) {
    setAllOff(0);
    for (int i=4; i > -1; i--) {
      digitalWrite(i,HIGH);
      delay(duration/8);
    }
    setAllOn(0);
    for (int i=0; i < 5; i++) {
      digitalWrite(i,LOW);
      if (i != 4) { delay(duration/8); }
    }
  delay(pause);
  }
}

// ----------------------------------------------------------------------------------------- DEMOS - RAINDROP --

void demoRainFromTop(int duration, int count) {
  int i = duration/25;
  for (int j = 0; j < count; j++) {
   
    setAllOff(0);
  
    digitalWrite(4,HIGH);
    delay(i);
  
    digitalWrite(4,LOW);
    digitalWrite(3,HIGH);  
    delay(i);
  
    digitalWrite(3,LOW);
    digitalWrite(2,HIGH);  
    delay(i);
  
    digitalWrite(2,LOW);
    digitalWrite(1,HIGH);  
    delay(i);
  
    digitalWrite(1,LOW);
    digitalWrite(0,HIGH);  
    delay(i);
    
    delay(i);
    delay(i);
  
  //----
  
    digitalWrite(4,HIGH);
    delay(i);
  
    digitalWrite(4,LOW);
    digitalWrite(3,HIGH);  
    delay(i);
  
    digitalWrite(3,LOW);
    digitalWrite(2,HIGH);  
    delay(i);
  
    digitalWrite(2,LOW);
    digitalWrite(1,HIGH);  
    delay(i);
  
    delay(i);
    delay(i);
  
  //----  
  
    digitalWrite(4,HIGH);
    delay(i);
  
    digitalWrite(4,LOW);
    digitalWrite(3,HIGH);  
    delay(i);
  
    digitalWrite(3,LOW);
    digitalWrite(2,HIGH);  
    delay(i);
  
    delay(i);
    delay(i);
  
  //----  
  
    digitalWrite(4,HIGH);
    delay(i);
  
    digitalWrite(4,LOW);
    digitalWrite(3,HIGH);  
    delay(i);
  
    delay(i);
    delay(i);
  
  //----  
  
    digitalWrite(4,HIGH);
    delay(i);
  
    delay(i);
    delay(i);

  }
}

void demoRainFromBottom(int duration, int count) {
  int i = duration/25;
  for (int j = 0; j < count; j++) {
   
    setAllOff(0);
  
    digitalWrite(0,HIGH);
    delay(i);
  
    digitalWrite(0,LOW);
    digitalWrite(1,HIGH);  
    delay(i);
  
    digitalWrite(1,LOW);
    digitalWrite(2,HIGH);  
    delay(i);
  
    digitalWrite(2,LOW);
    digitalWrite(3,HIGH);  
    delay(i);
  
    digitalWrite(3,LOW);
    digitalWrite(4,HIGH);  
    delay(i);
    
    delay(i);
    delay(i);
  
  //----
  
    digitalWrite(0,HIGH);
    delay(i);
  
    digitalWrite(0,LOW);
    digitalWrite(1,HIGH);  
    delay(i);
  
    digitalWrite(1,LOW);
    digitalWrite(2,HIGH);  
    delay(i);
  
    digitalWrite(2,LOW);
    digitalWrite(3,HIGH);  
    delay(i);
  
    delay(i);
    delay(i);
  
  //----  
  
    digitalWrite(0,HIGH);
    delay(i);
  
    digitalWrite(0,LOW);
    digitalWrite(1,HIGH);  
    delay(i);
  
    digitalWrite(1,LOW);
    digitalWrite(2,HIGH);  
    delay(i);
  
    delay(i);
    delay(i);
  
  //----  
  
    digitalWrite(0,HIGH);
    delay(i);
  
    digitalWrite(0,LOW);
    digitalWrite(1,HIGH);  
    delay(i);
  
    delay(i);
    delay(i);
  
  //----  
  
    digitalWrite(0,HIGH);
    delay(i);
  
    delay(i);
    delay(i);

  }
}


//------------------------------------------------------------------------------------ STROBES
void demoStrobeSlow(int duration) {
  while (duration > -1) {
    setAllOn(30);
    duration-=30;
    setAllOff(90);
    duration-=90;
  }
}
void demoStrobeFast(int duration) {
  while (duration > -1) {
    setAllOn(40);
    duration-=40;
    setAllOff(40);
    duration-=40;
  }
}

void demoStrobeSingle (int duration) {
  int pause;
  int led;
  while (duration > -1) {
    setAllOff(0);

    pause = random(50,1000);
    delay(pause); duration-=pause;

    led = random (0,4+1);
    pause = random(30,60);
    
    digitalWrite(led,HIGH);
    delay(pause); duration-=pause;
  }
}


//------------------------------------------------------------------------------------ COOLSHUFFLE

void demoCoolshuffle(int duration, int stepping) {
  setAllOff(0);
  int led;
  while (duration > -1) {
    led = random(0,4+1);
    if (digitalRead(led) == HIGH) { digitalWrite(led,LOW); } else { digitalWrite(led,HIGH); }
    delay(stepping); duration -=stepping;    
  }  
  setAllOff(0);
}


// ====================================================================== [[[ DEMO COMPILATIONS ]]]

void playRandomDemo() {
  int scene = random(1,28+1);
  int i;
  int rep;
  int speed;

  setAllOff(0);
  
  switch (scene) {
    case 1: // alle anschalten für 0,1 - 10 Sekunden
      setAllOn(random(100,20000+1));
      break;
    case 2: // alle ausschalten für 0,1 - 3 Sekunden
      setAllOff(random(100,2000+1));
      break;
    case 3: // alle reinfaden, slow bis fast, 3-6 Wiederholungen
      rep = random(3,6+1);
      speed = random(1,5+1);
      for (i=0; i< rep; i++) { fadeAllIn(speed); delay(200);}
      break;
    case 4: // alle rausfaden, slow bis fast 3-6 Wiederholungen
      rep = random(3,6+1);
      speed = random (1,5+1);
      for (i=0; i< rep; i++) { fadeAllOut(speed); delay(200);}
      break;
    case 5: 
      rep = random(3,6+1);
      speed = random(1,3+1);
      for (i=0; i< rep; i++) { demoFadeBottomToTop(speed); }
      break;
    case 6: 
      rep = random(3,6+1);
      speed = random(1,3+1);
      for (i=0; i< rep; i++) { demoFadeTopToBottom(speed); }
      break;
    case 7: 
      rep = random(2,4+1);
      speed = random(1,3+1);
      demoFadePingPong(speed,rep);
      break;
    case 8: 
      rep = random(3,10+1);
      speed = random(500,2000);
      for (i=0; i< rep; i++) { demoBottomToTop1(speed); }
      break;
    case 9: 
      rep = random(3,10+1);
      speed = random(500,2000);
      for (i=0; i< rep; i++) { demoTopToBottom1(speed); }
      break;
    case 10: 
      rep = random(3,10+1);
      speed = random(500,2000);
      for (i=0; i< rep; i++) { demoBottomToTop1(speed); demoTopToBottom1(speed); }
      break;
    case 11:
      rep = random(3,10+1);
      speed = random(500,2000);
      for (i=0; i< rep; i++) { demoBottomToTop2(speed); }
      break;
    case 12:
      rep = random(3,10+1);
      speed = random(500,2000);
      for (i=0; i< rep; i++) { demoTopToBottom2(speed); }
      break;
    case 13:
      rep = random(3,10+1);
      speed = random(500,2000);
      for (i=0; i< rep; i++) { demoBottomToTop2(speed); demoTopToBottom2(speed); }
      break;
    case 14:
      rep = random(3,10+1);
      speed = random(500,3000);
      for (i=0; i< rep; i++) { demoInToOut(speed); }
      break;
    case 15:
      rep = random(3,10+1);
      speed = random(500,3000);
      for (i=0; i< rep; i++) { demoOutToIn(speed); }
      break;
    case 16:
      rep = random(3,10+1);
      speed = random(500,3000);
      demoOutToInLoop(speed,rep);
      break;
    case 17:
      rep = random(3,8+1);
      speed = random(200,2000);
      demoTwoThree(speed,rep);
      break;
    case 18:
      rep = random(3,8+1);
      speed = random(200,2000);
      demoVUFromBottom(speed,150,rep);
      break;
    case 19:
      rep = random(3,8+1);
      speed = random(200,2000);
      demoVUFromTop(speed,150,rep);
      break;
    case 20:
      rep = random(3,8+1);
      speed = random(200,2000);
      demoVUFromBottom(speed,0,rep);
      break;
    case 21:
      rep = random(3,8+1);
      speed = random(200,2000);
      demoVUFromTop(speed,0,rep);
      break;
    case 22:
      rep = random(1,4+1);
      speed = random(2000,8000);
      demoRainFromTop(speed,rep);
      break;
    case 23:
      rep = random(1,4+1);
      speed = random(2000,8000);
      demoRainFromBottom(speed,rep);
      break;
    case 24:
      speed = random(3000,10000);
      demoStrobeSlow(speed);
      break;
    case 25:
      speed = random(3000,10000);
      demoStrobeFast(speed);
      break;
    case 26:
      speed = random(3000,30000);
      demoStrobeSingle(speed);
      break;
    case 27:
      demoCoolshuffle (20000,200);
      break;
    case 28:
      demoCoolshuffle (25000,800);
      break;
  }

}


void playCompilation1() {
  
  int i;

  for (i = 0; i < 3; i++) {
    setAllOn(500);
    setAllOff(500);
  }
  for (i = 0; i < 5; i++) {
    setAllOn(200);
    setAllOff(200);
  }
  for (i = 0; i < 10; i++) {
    setAllOn(50);
    setAllOff(50);
  }
  for (i = 0; i < 10; i++) {
    setAllOn(40);
    setAllOff(40);
  }
  for (i = 0; i < 10; i++) {
    setAllOn(30);
    setAllOff(30);
  }
  for (i = 0; i < 10; i++) {
    setAllOn(20);
    setAllOff(20);
  }
  
  setAllOn (2000);
  
  fadeAllOut(3);
  fadeAllIn(3);
  fadeAllOut(3);
  fadeAllIn(3);
  fadeAllOut(2);
  fadeAllIn(2);
  fadeAllOut(2);
  fadeAllIn(2);
  fadeAllOut(1);
  fadeAllIn(1);
  fadeAllOut(1);
  fadeAllIn(1);
  
  demoFadeBottomToTop(3);
  demoFadeBottomToTop(3);
  demoFadeBottomToTop(2);
  demoFadeBottomToTop(2);
  demoFadeBottomToTop(1);
  demoFadeBottomToTop(1);

  demoFadeTopToBottom(1);
  demoFadeTopToBottom(1);
  demoFadeTopToBottom(2);
  demoFadeTopToBottom(2);
  demoFadeTopToBottom(3);
  demoFadeTopToBottom(3);

  demoFadePingPong(3,1);
  demoFadePingPong(2,2);
  demoFadePingPong(1,4);
  
  for(i=0; i<4; i++) { demoTopToBottom1(1000); demoBottomToTop1(1000); }
  for(i=0; i<8; i++) { demoTopToBottom1(500); demoBottomToTop1(500); }
  for(i=0; i<16; i++) { demoTopToBottom1(200); demoBottomToTop1(200); }

  for(i=0; i<4; i++) { demoTopToBottom2(1000); demoBottomToTop2(1000); }
  for(i=0; i<8; i++) { demoTopToBottom2(500); demoBottomToTop2(500); }
  for(i=0; i<16; i++) { demoTopToBottom2(200); demoBottomToTop2(200); }

  for(i=0; i<6; i++) { demoOutToIn(1500); }
  for(i=0; i<6; i++) { demoInToOut(1500); }
  demoOutToInLoop(1500,10);

  setAllOn(2000);
  demoTwoThree(1000,3);
  demoTwoThree(500,6);
  demoTwoThree(200,12);
  demoTwoThree(100,16);
  demoTwoThree(50,24);
  setAllOn (2000);
  
  setAllOff(0);
  demoVUFromBottom(750,150,5);
  demoVUFromTop(750,150,5);
  demoVUFromBottom(500,0,8);
  demoVUFromTop(500,0,8);

  setAllOff(0);
  demoRainFromTop(4000,3);
  demoRainFromBottom(4000,3);
  setAllOn (2000);

  demoStrobeSlow(5000);
  demoStrobeFast(5000);
  demoStrobeSingle(10000);
  setAllOn (2000);

  demoCoolshuffle (20000,200);
  demoCoolshuffle (25000,800);
  setAllOff (2000);
 

}
