package hxlog.logging;

class NodeFileLog extends LogBend {
	var stream: Dynamic; // WriteStream

	public function new( filename: String ) {
		var fs = untyped __js__("require('fs');");
		var path = untyped __js__("require('path');");
		stream = untyped __js__("fs.createWriteStream(path.resolve(__dirname, filename), { autoClose: true });");
		trace('---');
		trace(stream);
		trace('---');
	}

	override public function bend( msg: LogMessage ) {
		stream.write('${msg.text}\n');
		// Log.nativeTrace.haxeTrace(msg.text, msg.infos);
	}
}
