"use strict";

let shader_test;

function preload() {
	shader_test = loadShader("./js/shaders/blank.vert", "./js/shaders/snow.frag");
}

function setup() {
	createCanvas(640, 480, WEBGL);
}

function draw() {
	shader(shader_test);
	shader_test.setUniform("iResolution", [width, height]);
	shader_test.setUniform("iGlobalTime", millis()/1000.0);
	shader_test.setUniform("iMouse", [0,0,0,0]);
	rect(0, 0, width, height, 1, 1);
}