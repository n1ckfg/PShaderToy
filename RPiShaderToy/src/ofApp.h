#pragma once

#include "ofMain.h"
#include "ofManager.h"

class ofApp : public ofBaseApp {
	
	public:
        int width;
        int height;
        ofManager ofm;
    
		void setup();
		void update();
		void draw();
		
		void keyPressed(int key);
		void keyReleased(int key);
		void mouseMoved(int x, int y );
		void mouseDragged(int x, int y, int button);
		void mousePressed(int x, int y, int button);
		void mouseReleased(int x, int y, int button);
		void windowResized(int w, int h);
		void dragEvent(ofDragInfo dragInfo);
		void gotMessage(ofMessage msg);

        vector<string> editStr;
        vector<string> playStr;
        vector<string> introStr;
    
        enum ModeSelector { EDIT, PLAY, SWAP, KEYSTONE, INTRO };
        ModeSelector modeSelector;
    
        // ~ ~ ~ edit / swap ~ ~ ~
		ofTrueTypeFont editFont;
        int editFontSize;
        float editLetterSpacing;
        float editLineHeight;
        int editLeftMargin;
        int editTopMargin;
    
        ofColor editFontColor;
        ofColor editFontHighlightColor;
        ofColor swapFontHighlightColor;
        ofColor playFontHighlightColor;
        ofColor editBgColor;

        int editCounter;
        int swapCounter;

        // ~ ~ ~ play ~ ~ ~
        vector<string> playFontsList;
        vector<ofTrueTypeFont> playFonts;
        void initFonts();
    
        vector<string> playImagesList;
        vector<ofImage> playImages;
        void initImages();
    
        int playFontSelector;
        int playImageSelector;
    
        int playFontSize;
        float playLetterSpacing;
        float playLineHeight;
        int playLeftMargin;
        int playTopMargin;
        void centerPlayText();
        int playFontSizeChangeIncrement;
    
        ofColor playFontColor;
        ofColor playBgColor;

        ofColor introBgColor;
    
        int playCounter;
    
        // ~ ~ ~ ~ ~ ~ ~
  
        ofImage checkerboard;
        ofFbo fbo1, fbo2;
        ofShader shader1;
        string shaderName;
        string shaderTexName;
        float shaderContrast;
        float shaderBrightness;
        float shaderBlendMix;
        int shaderBlendMode;
        bool doShader;
    
        ofPlanePrimitive plane1;
        int keystoneIndex;
        float keystoneStep;
        void keystoneVertex(int index, int key);
        vector<ofVec3f> keystoneVertsOrig;
        void saveKeystoneVertsOrig();
        void loadKeystoneVertsOrig();
        int keystoneHandleSize;
        int keystoneHandleStroke;
        ofColor keystoneHandleColor;

};

