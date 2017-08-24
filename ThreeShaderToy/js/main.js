
"use strict";

var mouse3D = new THREE.Vector3(0,0,0);

function onMouseDown(event) {                
    updateMousePos(event);
}

function onMouseUp(event) {

}

function onMouseMove(event) {
    updateMousePos(event);
}

function updateMousePos(event) {
    mouse3D = new THREE.Vector3((event.clientX / window.innerWidth) * 2 - 1, -(event.clientY / window.innerHeight) * 2 + 1, 0.5);
    mouse3D.unproject(camera);   
}

function onTouchStart(event) {                
    updateTouchPos(event);
}

function onTouchEnd(event) {

}

function onTouchMove(event) {
    updateTouchPos(event);
}

function updateTouchPos(event) {
    if (event.targetTouches.length > 0) {
        var touch = event.targetTouches[0];
        mouse3D = new THREE.Vector3((touch.pageX / window.innerWidth) * 2 - 1, -(touch.pageY / window.innerHeight) * 2 + 1, 0.5);
        mouse3D.unproject(camera);   
    }
} 

// ~ ~ ~ 
function animate() {
    render();
    requestAnimationFrame(animate);         
}

function main() {
    document.addEventListener("mousedown", onMouseDown);
    document.addEventListener("mousemove", onMouseMove);
    document.addEventListener("mouseup", onMouseUp);

    document.addEventListener("touchstart", onTouchStart);
    document.addEventListener("touchmove", onTouchMove);
    document.addEventListener("touchend", onTouchEnd);

    init();

    var material = loadShader();
    var geometry = new THREE.PlaneGeometry(window.innerWidth, window.innerHeight); 
    var mesh = new THREE.Mesh(geometry, material); 
    scene.add(mesh);

    animate();
}

window.onload = main;