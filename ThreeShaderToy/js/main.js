"use strict";

function main() {

	var camera, scene, renderer, clock;
	var container, mesh;
	var geometry, material, mtlUniforms;
    var start = Date.now();

	var isUserInteracting = false,
		lon = 0, lat = 0,
		phi = 0, theta = 0,
		distance = 50,
		onPointerDownPointerX = 0,
		onPointerDownPointerY = 0,
		onPointerDownLon = 0,
		onPointerDownLat = 0;

	init();
	animate();

	function init() {
		container = document.getElementById("container");

		camera = new THREE.PerspectiveCamera(75, window.innerWidth / window.innerHeight, 1, 1100);
		camera.target = new THREE.Vector3(0, 0, 0);
		clock = new THREE.Clock();

		scene = new THREE.Scene();

		geometry = new THREE.SphereBufferGeometry(100, 256, 256);
		//geometry = new THREE.IcosahedronGeometry(100, 6);
		// invert the geometry on the x-axis so that all of the faces point inward
		geometry.scale(- 1, 1, 1);

		mtlUniforms = {
			time: {
				type: "t",
				value: 0
			},
			resolution: {
				type: "t",
				value: [256, 256]
			}
		};

	    material = new THREE.ShaderMaterial({
	    	uniforms: mtlUniforms,
	        vertexShader: document.getElementById("vertexShader").textContent,
	        fragmentShader: document.getElementById("fragmentShader").textContent
	    });

		mesh = new THREE.Mesh(geometry, material);

		scene.add(mesh);

		renderer = new THREE.WebGLRenderer();
		renderer.setPixelRatio(window.devicePixelRatio);
		renderer.setSize(window.innerWidth, window.innerHeight);
		container.appendChild(renderer.domElement);

		document.addEventListener("mousedown", onDocumentMouseDown, false);
		document.addEventListener("mousemove", onDocumentMouseMove, false);
		document.addEventListener("mouseup", onDocumentMouseUp, false);
		document.addEventListener("wheel", onDocumentMouseWheel, false);

		//

		window.addEventListener("resize", onWindowResize, false);
	}

	function onWindowResize() {
		camera.aspect = window.innerWidth / window.innerHeight;
		camera.updateProjectionMatrix();

		renderer.setSize(window.innerWidth, window.innerHeight);
	}

	function onDocumentMouseDown(event) {
		event.preventDefault();

		isUserInteracting = true;

		onPointerDownPointerX = event.clientX;
		onPointerDownPointerY = event.clientY;

		onPointerDownLon = lon;
		onPointerDownLat = lat;
	}

	function onDocumentMouseMove(event) {
		if (isUserInteracting === true) {
			lon = (onPointerDownPointerX - event.clientX) * 0.1 + onPointerDownLon;
			lat = (event.clientY - onPointerDownPointerY) * 0.1 + onPointerDownLat;
		}
	}

	function onDocumentMouseUp() {
		isUserInteracting = false;
	}

	function onDocumentMouseWheel(event) {
		distance += event.deltaY * 0.05;

		distance = THREE.Math.clamp(distance, 1, 50);
	}

	function animate() {
		requestAnimationFrame(animate);
		update();
	}

	function update() {
		lat = Math.max(- 85, Math.min(85, lat));
		phi = THREE.Math.degToRad(90 - lat);
		theta = THREE.Math.degToRad(lon);

		camera.position.x = distance * Math.sin(phi) * Math.cos(theta);
		camera.position.y = distance * Math.cos(phi);
		camera.position.z = distance * Math.sin(phi) * Math.sin(theta);

		camera.lookAt(camera.target);
		mtlUniforms.time.value = clock.getElapsedTime();
		renderer.render(scene, camera);
	}

}

window.onload = main;