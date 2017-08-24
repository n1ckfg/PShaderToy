using UnityEngine;
using UnityEditor;
using UnityEditorInternal;
using NUnit.Framework;
using System.IO;

internal static class ShadertoyToUnity{

	private const string MenuRoot = "ShaderToy Converter/"; 

	[MenuItem (MenuRoot + "ShaderToy->Unity")]
	static void StToUnity() {
		string path = AssetDatabase.GetAssetPath (Selection.activeObject);
		//string stCode = File.ReadAllText(AssetDatabase.GetAssetPath(Selection.activeObject.GetInstanceID()));
		string stCode = File.ReadAllText(path);
		string code = File.ReadAllText("Assets/ShaderToyConverter/Base.shader");

		code = code.Replace("Shader \"Paintings/Base\"{", "Shader \"ShaderToy/" + Path.GetFileNameWithoutExtension(path) + "\"{");
		code = code.Replace("return fixed4(0., 0., 0., 0.);}", "");
		code = code.Replace("//Shadertoy Code Goes Here", stCode);
		code = code.Replace("void mainImage( out vec4 fragColor, in vec2 fragCoord )\n{", "");
		code = code.Replace("fragCoord.xy", "i.screenCoord.xy * _ScreenParams.xy");
		code = code.Replace("iResolution", "_ScreenParams");
		code = code.Replace("vec", "float");
		code = code.Replace("mix", "lerp");
		code = code.Replace("iGlobalTime", "_Time.y");
		code = code.Replace("fragColor =", "return");

		Debug.Log(code);
		File.WriteAllText(path, code);
	}

	[MenuItem (MenuRoot + "ShaderToy->Unity", true)]
	static bool ValidateShaderFile() {
		string path = AssetDatabase.GetAssetPath (Selection.activeObject);
		string ext = Path.GetExtension(path);
		return (ext == ".shader");
	}

}
