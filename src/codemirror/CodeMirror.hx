package codemirror;

@:native("CodeMirror")
extern class CodeMirror
{
	public static function fromTextArea(element: Dynamic, params:Dynamic):Editor;
}
extern class Editor
{
	public function getValue():String;
}