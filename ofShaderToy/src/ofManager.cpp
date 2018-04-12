#include "ofManager.h"

void ofManager :: setup() {
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
    
    ofTrueTypeFont :: setGlobalDpi(72); // old oF default is 96 - but this results in fonts looking larger than in other programs.
    
    // ~ ~ ~ example ~ ~ ~

    checkerboard.loadImage("textures/checkerboard.png");
    shader1.load("shaderExample");
    
    font1 = setupFont("fonts/verdana.ttf", 30, 34.0, 1.035);
    fbo1 = setupFbo();
    fbo2 = setupFbo();
    plane1 = setupPlane(fbo1.getTextureReference());
}

void ofManager :: update() {
    fbo1.begin();
    ofClear(255,255,255,0);
    
    ofBackground(0);
    checkerboard.draw(0,0,ofGetWidth(), ofGetHeight());

    ofSetColor(255); // why does this work?
    fbo1.end();

    fbo2.begin();
    ofClear(255,255,255,0);

    shader1.begin();
    shader1.setUniformTexture("tex0", fbo1.getTextureReference(), 0);
    shader1.setUniform1f("time", ofGetElapsedTimef());
    shader1.setUniform2f("resolution", ofGetWidth(), ofGetHeight());
    fbo1.getTextureReference().bind();
    plane1.draw();
    fbo1.getTextureReference().unbind();
    shader1.end();

    fbo2.end();
}

void ofManager :: draw() {
    ofBackground(0);
    fbo2.draw(0,0);
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

ofTrueTypeFont ofManager :: setupFont(string fileName, int fontSize) {
	ofTrueTypeFont font;
	font.loadFont(fileName, fontSize, true, true);
    return font;
}

ofTrueTypeFont ofManager :: setupFont(string fileName, int fontSize, float letterSpacing, float lineHeight) {
	ofTrueTypeFont font;
	font.loadFont(fileName, fontSize, true, true);
    font.setLetterSpacing(letterSpacing);
    font.setLineHeight(lineHeight);
    return font;
}

ofFbo ofManager :: setupFbo() {
	ofFbo fbo;
	fbo.allocate(ofGetWidth(), ofGetHeight(), GL_RGBA);
    return fbo;
}

ofPlanePrimitive ofManager :: setupPlane() {
	ofPlanePrimitive plane;
	plane.set(ofGetWidth(), ofGetHeight());   // dimensions for width and height in pixels
    plane.setPosition(ofGetWidth()/2, ofGetHeight()/2, 0); // position in x y z
    plane.setResolution(2, 2); // this resolution (as columns and rows) is enough
    return plane;
}

ofPlanePrimitive ofManager :: setupPlane(ofTexture tex) {
	ofPlanePrimitive plane;
	plane.set(ofGetWidth(), ofGetHeight());   // dimensions for width and height in pixels
    plane.setPosition(ofGetWidth()/2, ofGetHeight()/2, 0); // position in x y z
    plane.setResolution(2, 2); // this resolution (as columns and rows) is enough
    plane.mapTexCoordsFromTexture(tex); // *** don't forget this ***
    return plane;
}