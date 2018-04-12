#include "ofManager.h"

void ofManager :: setup(int& width, int& height) {
    ofSetLogLevel(OF_LOG_VERBOSE);
    
    ofSetVerticalSync(true);
    //ofDisableArbTex();
    //ofEnableDepthTest();
    //ofEnableSmoothing();
    //ofEnableNormalizedTexCoords();
    //ofEnableLighting();
    //ofEnableAntiAliasing();
    //ofEnableAlphaBlending();
    
    ofHideCursor();
    
    keyboardType = OSX;
    
    width = ofGetWidth();
    height = ofGetHeight();
}

//--------------------------------------------------------------

bool ofManager :: KeyIsArrow(int key) {
    if (key == OF_KEY_UP || key == OF_KEY_DOWN || key == OF_KEY_LEFT || key == OF_KEY_RIGHT) {
        return true;
    } else {
        return false;
    }
}

bool ofManager :: KeyIsNumber(int key) {
    if (key == '0' || key == '1' || key == '2' || key == '3' || key == '4' || key == '5' || key == '6' || key == '7' || key == '8' || key == '9') {
        return true;
    } else {
        return false;
    }
}