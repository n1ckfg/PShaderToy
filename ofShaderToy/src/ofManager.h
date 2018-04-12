#pragma once

#include "ofMain.h"

class ofManager : public ofBaseApp {

    public:
        enum KeyboardType { OSX, RPI };
        KeyboardType keyboardType;
    
        void setup();

        bool KeyIsArrow(int key);
        bool KeyIsNumber(int key);

        ofTrueTypeFont setupFont(string fileName, int fontSize);
        ofTrueTypeFont setupFont(string fileName, int fontSize, float letterSpacing, float lineHeight);

        ofFbo setupFbo();

        ofPlanePrimitive setupPlane();
        ofPlanePrimitive setupPlane(ofTexture tex);

        // ~ ~ ~ example ~ ~ ~
        
        void update();
        void draw();

        ofImage checkerboard;
        ofShader shader1;
        ofTrueTypeFont font1;
        ofFbo fbo1, fbo2;
        ofPlanePrimitive plane1;

};