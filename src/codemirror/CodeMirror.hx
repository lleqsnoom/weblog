package codemirror;

@:native("CodeMirror")
extern class CodeMirror
{
	public static function fromTextArea(element: Dynamic, params:Dynamic):Editor;
	public static function Pos(d:Dynamic):Dynamic;
}
extern class Editor
{
	public function getValue():String;
	public function replaceRange(s:String, d:Dynamic):Void;
	public function lastLine():Int;
	
}