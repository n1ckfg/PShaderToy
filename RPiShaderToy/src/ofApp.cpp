#include "ofApp.h"

//--------------------------------------------------------------
void ofApp :: setup() {
    ofm.setup(width, height);
    
    checkerboard.loadImage("textures/checkerboard.png");
    
    shaderName = "shaderExample";
    
    //#ifdef TARGET_OPENGLES
        //shader1.load("shaders/" + shaderName + "GLES");
    //#else
        shader1.load(shaderName);
    //#endif

    // parameters for the shader
    //shaderContrast = 0.8;//0.8;
    //shaderBrightness = 0.4;
    //shaderBlendMix = 0.5;
    // 10 blend modes
    //shaderBlendMode = 0;
    doShader = false;
    
    fbo1.allocate(width, height, GL_RGBA);
    fbo2.allocate(width, height, GL_RGBA);

    plane1.set(width, height);   // dimensions for width and height in pixels
    plane1.setPosition(width/2, height/2, 0); // position in x y z
    plane1.setResolution(2, 2); // this resolution (as columns and rows) is enough
    plane1.mapTexCoordsFromTexture(fbo1.getTextureReference()); // *** don't forget this ***
    
    saveKeystoneVertsOrig();
    keystoneStep = 10;
    keystoneIndex = 0;
    keystoneHandleColor = ofColor(255,0,0);
    keystoneHandleSize = 50;
    keystoneHandleStroke = 10;
    
    modeSelector = INTRO;
    
    editCounter = 0;
    playCounter = 0;
    swapCounter = -1;
    
	// old oF default is 96 - but this results in fonts looking larger than in other programs.
	ofTrueTypeFont :: setGlobalDpi(72);

    editFontSize = 30;
    editLineHeight = 34.0f;
    editLetterSpacing = 1.035;
	editFont.loadFont("fonts/verdana.ttf", editFontSize, true, true);
	editFont.setLineHeight(editLineHeight);
	editFont.setLetterSpacing(editLetterSpacing);
    editLeftMargin = 90;
    editTopMargin = 180;
    
    editFontColor = ofColor(225,225,225);
    editFontHighlightColor = ofColor(255,255,0);
    swapFontHighlightColor = ofColor(255,0,0);
    playFontHighlightColor = ofColor(0,255,255);
    editBgColor = ofColor(127,0,0);

    introBgColor = ofColor(60,60,120);
    
    playFontSize = 72;
    playLineHeight = 68.0f;
    playLetterSpacing = 1.035;
    playFontSelector = 0;
    playFontSizeChangeIncrement = 4;

    playFontsList.push_back("fonts/vcr_osd_mono.ttf");
    playFontsList.push_back("fonts/arcade.ttf");
    playFontsList.push_back("fonts/arcade_classic.ttf");
    playFontsList.push_back("fonts/stitch_warrior.ttf");
    
    initFonts();
    
    playImagesList.push_back("textures/bowie.png");
    playImagesList.push_back("textures/duckhunt.png");
    playImagesList.push_back("textures/gnr.png");
    playImagesList.push_back("textures/pacman.png");
    playImagesList.push_back("textures/rambo.png");
    playImagesList.push_back("textures/aliens.jpg");
    playImagesList.push_back("textures/starfox.png");

    initImages();
    
    playLeftMargin = 90;
    playTopMargin = (height/2) + (playFontSize/2);
    
    playFontColor = ofColor(255,225,225);
    playBgColor = ofColor(0,127,0);

    editStr.push_back("");
    playStr.push_back("");
    
    introStr.push_back("- ~ - EDIT - ~ -");
    introStr.push_back("");
    introStr.push_back("TAB:  go to Play mode");
    introStr.push_back("Letters:  you know what to do");
    introStr.push_back("Down arrow:  new singer");
    introStr.push_back("Question mark:  select two singers to swap");
    introStr.push_back("1, 2, 3, 4:  select keystone corner");
    introStr.push_back("5:  reset keystoning");
    introStr.push_back("");
    introStr.push_back("");
    introStr.push_back("~ - ~ PLAY ~ - ~");
    introStr.push_back("");
    introStr.push_back("TAB:  go to Edit mode");
    introStr.push_back("SPACE:  next singer");
    introStr.push_back("Z:  previous singer");
    introStr.push_back("F:  change font");
    introStr.push_back("Plus, Minus:  change font size");
    introStr.push_back("B:  change background");
    
    playImageSelector = 0;
    
}

//--------------------------------------------------------------
void ofApp :: update() {
    fbo1.begin();
        ofClear(255,255,255, 0);
    
        if (modeSelector == INTRO) {
            ofBackground(introBgColor);
            ofSetColor(editFontColor);

            for (int i=0; i<introStr.size(); i++) {
                editFont.drawString(introStr[i], editLeftMargin, editTopMargin + (i * editLineHeight));
            }
            
        } else if (modeSelector == EDIT || modeSelector == SWAP) {
            ofBackground(editBgColor);
            for (int i=0; i<editStr.size(); i++) {
                if (i == editCounter || i == swapCounter) {
                    if (i == editCounter && (modeSelector != SWAP || i != swapCounter)) {
                        ofSetColor(editFontHighlightColor);
                    } else if (modeSelector == SWAP && i == swapCounter && swapCounter != -1) {
                        ofSetColor(swapFontHighlightColor);
                    }
                } else {
                    if (i == playCounter) {
                        ofSetColor(playFontHighlightColor);
                    } else {
                        ofSetColor(editFontColor);
                    }
                }
                editFont.drawString(ofToString(i+1) + ". " + editStr[i], editLeftMargin, editTopMargin + (i * editLineHeight));
            }
            
        } else if (modeSelector == PLAY) {
            if (playImages.size() > 0) {
                playImages[playImageSelector].draw(0,0,width,height);
                ofSetColor(0,127);
                ofRect(0,0,width,height);
            } else {
                ofBackground(playBgColor);
            }
            ofSetColor(playFontColor);
            playFonts[playFontSelector].drawString(playStr[0], playLeftMargin, playTopMargin);
            
        } else if (modeSelector == KEYSTONE) {
            ofSetColor(255);
            checkerboard.draw(0,0,width,height);
        }
        ofSetColor(255); // why does this work?
    fbo1.end();

    //ofTexture tex1 = fbo1.getTextureReference();

    fbo2.begin();
        ofClear(255,255,255, 0);

        if (doShader) {
            shader1.begin();
                shader1.setUniformTexture("tex0", fbo1.getTextureReference(), 0);
                shader1.setUniform1f("time", ofGetElapsedTimef());
                shader1.setUniform2f("resolution", ofGetWidth(), ofGetHeight());
                fbo1.getTextureReference().bind();
                plane1.draw();
                fbo1.getTextureReference().unbind();
            shader1.end();

            //shaderContrast += 0.01;
        } else {
            fbo1.getTextureReference().bind();
            plane1.draw();
            fbo1.getTextureReference().unbind();
        }
    
        if (modeSelector == KEYSTONE) {
            ofVec2f center = ofVec2f(plane1.getMesh().getVertex(keystoneIndex).x + plane1.getPosition().x, plane1.getMesh().getVertex(keystoneIndex).y + plane1.getPosition().y);
            ofPath circle;
            circle.setFillColor(ofColor(255,0,0));
            circle.arc(center, keystoneHandleSize + (keystoneHandleStroke/2), keystoneHandleSize + (keystoneHandleStroke/2), 0, 360);
            circle.close();
            circle.arc(center, keystoneHandleSize - (keystoneHandleStroke/2), keystoneHandleSize - (keystoneHandleStroke/2), 0, 360);
            circle.draw();
        }
    fbo2.end();
}

//--------------------------------------------------------------
void ofApp :: draw() {
    ofBackground(0);
    fbo2.draw(0,0);
}

//--------------------------------------------------------------
void ofApp :: keyPressed(int key) {
    if (modeSelector == EDIT || modeSelector == PLAY) {
        if (key == OF_KEY_TAB) {
            if (modeSelector == EDIT) {
                modeSelector = PLAY;
            } else if (modeSelector == PLAY) {
                modeSelector = EDIT;
            } else if (modeSelector == SWAP) {
                swapCounter = -1;
                modeSelector = PLAY;
            }
        }
        
    }

    if (modeSelector == INTRO) {
        modeSelector = EDIT;
    } else if (modeSelector == EDIT || modeSelector == SWAP) {
        if (key == OF_KEY_DEL || key == OF_KEY_BACKSPACE) {
            if (modeSelector == EDIT) {
                if (editStr[editCounter].length() > 0) {
                    editStr[editCounter] = editStr[editCounter].substr(0, editStr[editCounter].length()-1);
                } else if (editCounter != 0) {
                    //editStr.erase(editStr.begin() + editCounter);
                    //editCounter--;
                    //if (editCounter < 0) editCounter = 0;
                }
            } else if (modeSelector == SWAP) {
                if (swapCounter != -1) {
                    if (editStr.size() > 1) {
                        editStr.erase(editStr.begin() + swapCounter);
                        if (editStr.size() > 1) {
                            editCounter--;
                        } else {
                            editCounter = 0;
                        }
                
                    } else if (editStr.size() == 1) {
                        editStr[0] = "";
                    }
                }
                swapCounter = -1;
                modeSelector = EDIT;
                if (editCounter <0) editCounter = 0;
            }
        } else if (key == '/' || key == '?') { //KeyControl()) {
            if (modeSelector == EDIT) {
                swapCounter = editCounter;
                modeSelector = SWAP;
            } else if (modeSelector == SWAP) {
                //if (editCounter != swapCounter) {
                if (swapCounter < 0) {
                    swapCounter = 0;
                } else if (swapCounter > editStr.size()-1) {
                    swapCounter = editStr.size()-1;
                }
                string swapLine = editStr[swapCounter];
                editStr[swapCounter] = editStr[editCounter];
                editStr[editCounter] = swapLine;
                //}
                swapCounter = -1;
                modeSelector = EDIT;
            }
        } else if (key == OF_KEY_UP && editCounter > 0) {
            editCounter--;
        } else if (key == OF_KEY_DOWN || key == OF_KEY_RETURN) {
            //editCounter++;
            if (editStr[editCounter].length() > 0) {
                if (editCounter == editStr.size()-1) {
                    editStr.push_back("");
                    editCounter = editStr.size()-1;
                } else {
                    editCounter++;
                }
            } else if (editCounter < editStr.size()-1) {
                editCounter++;
            }
        } else if (!ofm.KeyIsArrow(key)) {
            if (key == '0' || key == '1' || key == '2' || key == '3' || key == '4' || key == '5') {
                modeSelector = KEYSTONE;
            } else {            
                if (editCounter < 0) {
                    editCounter = 0;
                } else if (editCounter > editStr.size()-1) {
                    editCounter = editStr.size()-1;
                }
                editStr[editCounter].append(1, (char)key);
            }
        }
        
    } else if (modeSelector == PLAY) {
        if (key == ' ') {
            playCounter++;
            if (playCounter > editStr.size()-1 || (editStr[playCounter].length() < 1 && playCounter == editStr.size()-1)) playCounter = 0;
        } else if (key == 'z' || key == 'Z') {
            playCounter--;
            if (playCounter < 0) playCounter = editStr.size()-1;
        } else if (key == 's' || key == 'S') {
            doShader = !doShader;
        } else if (key == 'f' || key == 'F') {
            playFontSelector ++;
            if (playFontSelector > playFonts.size()-1) playFontSelector = 0;
        } else if (key == 'b' || key == 'B') {
            playImageSelector ++;
            if (playImageSelector > playImages.size()-1) playImageSelector = 0;
        } else if (key == '-' || key == '_' || key == '+' || key == '=') {
            if (key == '-' || key == '_') {
                playFontSize -= playFontSizeChangeIncrement;
                if (playFontSize < 10) playFontSize = 10;
            } else if (key == '+' || key == '=') {
                playFontSize += playFontSizeChangeIncrement;
            }
            
            initFonts();
        }
        
        if (editStr[playCounter].length() > 0) playStr[0] = editStr[playCounter];//ofSplitString(editStr[editCounter], "-");
        
    } else if (modeSelector == KEYSTONE) {
        if (key == '1') {
            keystoneIndex = 0;
        } else if (key == '2') {
            keystoneIndex = 1;
        } else if (key == '3') {
            keystoneIndex = 3;
        } else if (key == '4') {
            keystoneIndex = 2;
        } else if (key == '5') {
            loadKeystoneVertsOrig();
        } else if (ofm.KeyIsArrow(key)){
            keystoneVertex(keystoneIndex, key);
        } else {
            modeSelector = EDIT;
        }
     }
}

//--------------------------------------------------------------
void ofApp :: keyReleased(int key) { 
	
}

//--------------------------------------------------------------
void ofApp :: mouseMoved(int x, int y ) {
	
}

//--------------------------------------------------------------
void ofApp :: mouseDragged(int x, int y, int button) {
	
}

//--------------------------------------------------------------
void ofApp :: mousePressed(int x, int y, int button) {
	
}

//--------------------------------------------------------------
void ofApp :: mouseReleased(int x, int y, int button) {

}

//--------------------------------------------------------------
void ofApp :: windowResized(int w, int h) {

}

//--------------------------------------------------------------
void ofApp :: gotMessage(ofMessage msg) {

}

//--------------------------------------------------------------
void ofApp :: dragEvent(ofDragInfo dragInfo) { 

}

//--------------------------------------------------------------
void ofApp :: centerPlayText() {
    if (playStr.size() > 0 && playCounter <= playStr.size()-1) {
        playLeftMargin = (width/2) - ((playStr[playCounter].length() * playFontSize)/2);
    }
}

//--------------------------------------------------------------
void ofApp :: keystoneVertex(int index, int key) {
    ofVec3f v = plane1.getMesh().getVertex(index);
    
    if (key == OF_KEY_UP) {
        v.y -= keystoneStep;
    } else if (key == OF_KEY_DOWN) {
        v.y += keystoneStep;
    } else if (key == OF_KEY_LEFT) {
        v.x -= keystoneStep;
    } else if (key == OF_KEY_RIGHT) {
        v.x += keystoneStep;
    }
    
    plane1.getMesh().setVertex(index, v);
}


void ofApp :: saveKeystoneVertsOrig() {
    for (int i=0; i<plane1.getMesh().getVertices().size(); i++) {
        ofVec3f v = plane1.getMesh().getVertex(i);
        keystoneVertsOrig.push_back(v);
    }
}

//--------------------------------------------------------------
void ofApp :: loadKeystoneVertsOrig() {
    for (int i=0; i<keystoneVertsOrig.size(); i++) {
        plane1.getMesh().setVertex(i, keystoneVertsOrig[i]);
    }
}

void ofApp :: initFonts() {
    playFonts.clear();
    for (int i=0; i<playFontsList.size(); i++) {
        ofTrueTypeFont font;
        font.loadFont(playFontsList[i], playFontSize, true, true);
        playFonts.push_back(font);
        playFonts[i].setLineHeight(playLineHeight);
        playFonts[i].setLetterSpacing(playLetterSpacing);
    }
}

void ofApp :: initImages() {
    for (int i=0; i<playImagesList.size(); i++) {
        ofImage image;
        image.loadImage(playImagesList[i]);
        playImages.push_back(image);
    }
}

//--------------------------------------------------------------

