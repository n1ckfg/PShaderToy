using UnityEngine;
using System.Collections;

public class BasicController : MonoBehaviour {

    private Rigidbody rb;

    private void Awake() {
        rb = GetComponent<Rigidbody>();
    }

    private void Start() {
		if (useKeyboard) wasdStart();
		if (useMouse) mouseStart();
        collisionStart();
	}

	private void Update() {
		if (useKeyboard) wasdUpdate();
		if (useMouse) mouseUpdate();	
		if (useRaycaster) rayUpdate();	
	}

    // ~ ~ ~ ~ ~ ~ ~ ~ 

    [Header("Keyboard")] 
    public bool useKeyboard = true;
    public bool useYAxis = false;
    public string yAxisName = "Vertical2";
	public float walkSpeed = 10f;
	public float runSpeed = 100f;
	public float accel = 0.01f;
	public Transform homePoint;

	private float currentSpeed;
	private Vector3 p = Vector3.zero;
	private bool run = false;

	private void wasdStart() {
		currentSpeed = walkSpeed;
    }

    private void wasdUpdate() {
		if (Input.GetKeyDown(KeyCode.LeftShift)) {
			run = true;
		} else if (Input.GetKeyUp(KeyCode.LeftShift)) {
			run = false;
		}

		if (run && currentSpeed < runSpeed) {
			currentSpeed += accel;
			if (currentSpeed > runSpeed) currentSpeed = runSpeed;
		} else if (!run && currentSpeed > walkSpeed) {
			currentSpeed -= accel;
			if (currentSpeed < walkSpeed) currentSpeed = walkSpeed;
		}

		p.x = Input.GetAxis("Horizontal") * Time.deltaTime * currentSpeed;
        if (useYAxis) {
            p.y = Input.GetAxis(yAxisName) * Time.deltaTime * currentSpeed;
        }
        else {
            p.y = 0f;
        }
		p.z = Input.GetAxis("Vertical") * Time.deltaTime * currentSpeed;

		transform.Translate(p.x, p.y, p.z);

		if (homePoint != null && Input.GetKeyDown(KeyCode.Home)){
			transform.position = homePoint.position;
			transform.rotation = homePoint.rotation;
			transform.localScale = homePoint.localScale;
		}
	}

	// ~ ~ ~ ~ ~ ~ ~ ~ 

	public enum RotationAxes { MouseXAndY, MouseX, MouseY };
    [Header("Mouse")]
    public bool useMouse = true;
    public bool showCursor = false;
	public bool useButton = true;
	public RotationAxes axes = RotationAxes.MouseXAndY;
	public float sensitivityX = 2f;
	public float sensitivityY = 2f;

	[HideInInspector] public Vector3 mousePos = Vector3.zero;
	[HideInInspector] public bool clicked = false;
	[HideInInspector] public bool isDrawing = false;

	private bool fixedZ = false;
	private float minimumX = -360f;
	private float maximumX = 360f;
	private float minimumY = -60f;
	private float maximumY = 60f;
	private float zPos = 1f;
	private float rotationY = 0f;

	private void mouseStart() {
        Cursor.visible = showCursor;
		if (rb != null) rb.freezeRotation = true;
	}

	private void mouseUpdate() {
		if (axes == RotationAxes.MouseXAndY) {
			float rotationX = transform.localEulerAngles.y + Input.GetAxis("Mouse X") * sensitivityX;

			rotationY += Input.GetAxis("Mouse Y") * sensitivityY;
			rotationY = Mathf.Clamp (rotationY, minimumY, maximumY);

			transform.localEulerAngles = new Vector3(-rotationY, rotationX, 0f);
		} else if (axes == RotationAxes.MouseX) {
			transform.Rotate(0f, Input.GetAxis("Mouse X") * sensitivityX, 0f);
		} else {
			rotationY += Input.GetAxis("Mouse Y") * sensitivityY;
			rotationY = Mathf.Clamp (rotationY, minimumY, maximumY);

			transform.localEulerAngles = new Vector3(-rotationY, transform.localEulerAngles.y, 0f);
		}

		// ~ ~ ~

		clicked = false;

		if (useButton) {
			if (Input.GetMouseButtonDown(0) && GUIUtility.hotControl == 0) {
				clicked = true;
				isDrawing = true;
			}

			if (Input.GetMouseButton(0) && GUIUtility.hotControl == 0) {
				if (!fixedZ) zPos = lastHitPos.z;
				mousePos = Camera.main.ScreenToWorldPoint(new Vector3(Input.mousePosition.x, Input.mousePosition.y, zPos));
			}

			if (Input.GetMouseButtonUp(0)) {
				isDrawing = false;
			}
		}
	}

	// ~ ~ ~ ~ ~ ~ ~ ~ 

	[Header("Raycaster")]
	public bool useRaycaster = true;
	public bool followMouse = true;

	[HideInInspector] public bool isLooking = false;
	[HideInInspector] public string isLookingAt = "";
	[HideInInspector] public Vector3 lastHitPos = Vector3.one;

	private void rayUpdate() {
		RaycastHit hit;
		Ray ray;

		if (followMouse) {
			ray = Camera.main.ScreenPointToRay(Input.mousePosition);
		} else {
			ray = new Ray(transform.position, transform.forward);
		}

		if (Physics.Raycast(ray, out hit)) {
			isLooking = true;
			isLookingAt = hit.collider.name;

			lastHitPos = hit.point;
		} else {
			isLooking = false;
			isLookingAt = "";
		}
    }

    // ~ ~ ~ ~ ~ ~ ~ ~ 

    [Header("Collisions")]
    public bool useCollisions = false;

    private void collisionStart() {
        if (rb != null) {
            if (useCollisions) {
                rb.useGravity = true;
                rb.constraints = RigidbodyConstraints.FreezePositionX | RigidbodyConstraints.FreezePositionZ | RigidbodyConstraints.FreezeRotation;
            } else {
                rb.useGravity = false;
                rb.constraints = RigidbodyConstraints.FreezePosition | RigidbodyConstraints.FreezeRotation;
            }
        }
    }

}
