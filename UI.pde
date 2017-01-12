
// This draws the video tracker bar
// Not sure if this this the right name
// I mean the progress bar below the video
// Where you can see how far into the video you are
void drawTrackerBar(int _x, int _y, int _width) {
  float _lineThickness = 5;
  noStroke();
  textSize(11);
  fill(color4);
  textFont(smallRobotoMono);
  textAlign(LEFT);
  text(formatTimeCode(myMovie.time()), _x + 10, _y + 28);
  textAlign(RIGHT);
  text("-" + formatTimeCode(myMovie.duration()-myMovie.time()), _width-10, _y + 28);
  fill(color4, 72);
  rect(_x + 10, _y + 8, _width-20, _lineThickness);
  fill(color4, 255);
  if (myMovie.duration() > 0) {
    rect(_x + 10, _y + 8, (_width-20) * (myMovie.time()/myMovie.duration()), _lineThickness);
  }  
}

void switchToEdit() {
  UIMode="EDIT";
  purgeButts();
}

void switchToLoad() {
  Butt tButt;
  
  UIMode="LOAD";
  purgeButts();
  tButt = new Butt("LOAD VIDEO",24,24,94,24);
  tButt.verb = "LOAD";
  tButt.noun = "";
  butts.add(tButt);
  for (int i = 0; i < 8; i++) {
    tButt = new Butt("C:/netrunner/Bankjob 08 Rene v Hlinks.mp4",24,64+25*i,512,24);
    tButt.style = "LIST";
    tButt.verb = "LOAD";
    tButt.noun = "C:/netrunner/Bankjob 08 Rene v Hlinks.mp4";
    butts.add(tButt);
  }
}

void purgeButts() {
  butts = new ArrayList<Butt>();
}

void drawButts() {
  for (int i = 0; i < butts.size(); i++) {
    butts.get(i).drawMe();
  }  
}

void updateMouseOver() {
  Butt tButt;
  for (int i = 0; i < butts.size(); i++) {
    tButt = butts.get(i);
    if (mouseX >= tButt.x &&
        mouseX <= tButt.x+tButt.w &&
        mouseY >= tButt.y &&
        mouseY <= tButt.y+tButt.h) {
      
      tButt.state = "OVER";
    } else {
      tButt.state = "";
    }
  }
}

void updateMouseClick() {
  Butt tButt;
  for (int i = 0; i < butts.size(); i++) {
    tButt = butts.get(i);
    if (mouseX >= tButt.x &&
        mouseX <= tButt.x+tButt.w &&
        mouseY >= tButt.y &&
        mouseY <= tButt.y+tButt.h) {
      tButt.state = "CLICK";
      buttonCommand(tButt.verb, tButt.noun);
    } else {
      tButt.state = "";
    }
  }
}

void buttonCommand(String _verb, String _noun) {
  if (_verb == "LOAD") {
    if (_noun == "") {
      if (!dialogueWaiting) {
        selectInput("Select a video to load:", "fileSelected");
        dialogueWaiting = true;
      }
    } else {
      loadMovie(_noun);
    };
  }
}