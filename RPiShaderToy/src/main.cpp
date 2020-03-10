#include "ofMain.h"
#include "ofApp.h"

int main() {  
    	ofGLESWindowSettings settings;
	settings.glesVersion = 2;
	ofCreateWindow(settings);
    	ofRunApp(new ofApp());
}
