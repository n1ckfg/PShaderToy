#pragma once

#include "ofMain.h"

class ofManager : public ofBaseApp {

    public:
        enum KeyboardType { OSX, RPI };
        KeyboardType keyboardType;
    
        void setup(int& width, int& height);
    
        bool KeyIsArrow(int key);
        bool KeyIsNumber(int key);

};