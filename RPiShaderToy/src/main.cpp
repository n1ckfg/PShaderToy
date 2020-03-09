#include "ofMain.h"
#include "ofApp.h"

int main() {  
	
    ofGLESWindowSettings settings;
	settings.glesVersion = 2;
	ofCreateWindow(settings);
    
    ofSetupOpenGL(1280, 720, OF_FULLSCREEN);
    ofRunApp(new ofApp());
    
}
