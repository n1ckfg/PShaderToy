#include "ofApp.h"

//--------------------------------------------------------------
void ofApp::setup(){
	shader1.load("shaders/myShader");
	fbo1 = ofm.setupFbo();
}

//--------------------------------------------------------------
void ofApp::update(){
	fbo1.begin();
	ofClear(255, 255, 255, 0);
	shader1.begin();
	shader1.setUniform1f("iGlobalTime", ofGetElapsedTimef());
	shader1.setUniform3f("iResolution", ofGetWidth(), ofGetHeight(), 0.0);
	ofDrawRectangle(0, 0, ofGetWidth(), ofGetHeight());
	shader1.end();
	fbo1.end();
}

//--------------------------------------------------------------
void ofApp::draw(){
	ofBackground(0);
	fbo1.draw(0,0);
}

//--------------------------------------------------------------
void ofApp::keyPressed(int key){

}

//--------------------------------------------------------------
void ofApp::keyReleased(int key){

}

//--------------------------------------------------------------
void ofApp::mouseMoved(int x, int y ){

}

//--------------------------------------------------------------
void ofApp::mouseDragged(int x, int y, int button){

}

//--------------------------------------------------------------
void ofApp::mousePressed(int x, int y, int button){

}

//--------------------------------------------------------------
void ofApp::mouseReleased(int x, int y, int button){

}

//--------------------------------------------------------------
void ofApp::mouseEntered(int x, int y){

}

//--------------------------------------------------------------
void ofApp::mouseExited(int x, int y){

}

//--------------------------------------------------------------
void ofApp::windowResized(int w, int h){

}

//--------------------------------------------------------------
void ofApp::gotMessage(ofMessage msg){

}

//--------------------------------------------------------------
void ofApp::dragEvent(ofDragInfo dragInfo){ 

}
