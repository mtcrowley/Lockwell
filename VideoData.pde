// Functions to manipulate Video Data

// This creates a new Credit Event
Keyframe addKeyframe(int _type, float _time, int _value, int _side) {
  Keyframe _tempKeyframe;
  
  _tempKeyframe = new Keyframe();
  _tempKeyframe.type = _type;
  _tempKeyframe.time = _time;
  _tempKeyframe.value = _value;
  _tempKeyframe.side = _side;
  keyframes.add(_tempKeyframe);
  
  return _tempKeyframe;
}

// This gets a value of the last keyframe of a certain stat at any given time
// Basically it gets the credit count at any given time for example
Keyframe getKeyframe(int _type, float _time, int _side) {
  Keyframe _foundFrame = null;
  Keyframe _tempFrame = null;
  
  if (keyframes != null) {
    for (int i = 0; i < keyframes.size(); i++) {
      _tempFrame = keyframes.get(i);
      if (_tempFrame.type == _type && _tempFrame.side == _side && _tempFrame.time <= _time) {
        if (_foundFrame == null) {
          _foundFrame = _tempFrame;
        } else if (_tempFrame.time > _foundFrame.time) {
          _foundFrame = _tempFrame;
        }
      }
    }
  }
  return _foundFrame;
}

// This is what gets executed when you press a button to change the agenda points
void agendaButt(int _side, int _d) {
  Keyframe _lastKeyframe = null;
  Keyframe _newKeyframe = null;
  
  // Check if there is a keyframe at current time
  // If no, create one
  if ((_side == LEFTPLAYER && selFrameAgendaLeft == null) || (_side == RIGHTPLAYER && selFrameAgendaRight == null)) {
    _lastKeyframe = getKeyframe(KFAGENDAS, headPos, _side);
    if (_lastKeyframe == null) {
      _newKeyframe = addKeyframe(KFAGENDAS, headPos, 0, _side);
    } else {
      _newKeyframe = addKeyframe(KFAGENDAS, headPos, _lastKeyframe.value, _side);
    }
    if (_side == LEFTPLAYER) {
      selFrameAgendaLeft = _newKeyframe;
    } else {
      selFrameAgendaRight = _newKeyframe;
    }
  }
  
  // Increase Agenda value by one
  if (_side == LEFTPLAYER) {
    _newKeyframe = selFrameAgendaLeft;
  } else {
    _newKeyframe = selFrameAgendaRight;
  }
  _newKeyframe.value+=_d;
}

// This is what gets executed when you press a button to change the credit points
void creditButt(int _side, int _d) {
  Keyframe _lastKeyframe = null;
  Keyframe _newKeyframe = null;
  
  // Check if there is a keyframe at current time
  // If no, create one
  if ((_side == LEFTPLAYER && selFrameCreditLeft == null) || (_side == RIGHTPLAYER && selFrameCreditRight == null)) {
    _lastKeyframe = getKeyframe(KFCREDITS, headPos, _side);
    if (_lastKeyframe == null) {
      _newKeyframe = addKeyframe(KFCREDITS, headPos, 0, _side);
    } else {
      _newKeyframe = addKeyframe(KFCREDITS, headPos, _lastKeyframe.value, _side);
    }
    if (_side == LEFTPLAYER) {
      selFrameCreditLeft = _newKeyframe;
    } else {
      selFrameCreditRight = _newKeyframe;
    }
  }
  
  // Increase Agenda value by one
  if (_side == LEFTPLAYER) {
    _newKeyframe = selFrameCreditLeft;
  } else {
    _newKeyframe = selFrameCreditRight;
  }
  _newKeyframe.value+=_d;
}

// This returns ANY keyframe time before the current head position if possible
// Otherwise, it returns the head position
float getLastKeyframe() {
  Keyframe _foundFrame = null;
  Keyframe _tempFrame = null;
  
  if (keyframes != null) {
    for (int i = 0; i < keyframes.size(); i++) {
      _tempFrame = keyframes.get(i);
      if (_tempFrame.time < headPos) {
        if (_foundFrame == null) {
          _foundFrame = _tempFrame;
        } else if (_tempFrame.time > _foundFrame.time) {
          _foundFrame = _tempFrame;
        }
      }
    }
  }
  if (_foundFrame == null) {
    return headPos;
  }
  return _foundFrame.time;
}

// This returns ANY keyframe time before the current head position if possible
// Otherwise, it returns the head position
float getNextKeyframe() {
  Keyframe _foundFrame = null;
  Keyframe _tempFrame = null;
  
  if (keyframes != null) {
    for (int i = 0; i < keyframes.size(); i++) {
      _tempFrame = keyframes.get(i);
      if (_tempFrame.time > headPos) {
        if (_foundFrame == null) {
          _foundFrame = _tempFrame;
        } else if (_tempFrame.time < _foundFrame.time) {
          _foundFrame = _tempFrame;
        }
      }
    }
  }
  if (_foundFrame == null) {
    return headPos;
  }
  return _foundFrame.time; 
}