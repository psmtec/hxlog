package hxlog.logging;

class NodeFileLog extends LogBend {
	var stream: Dynamic; // WriteStream

	public function new( filename: String, append = false ) {
		var fs = untyped __js__("require('fs');");
		var path = untyped __js__("require('path');");

		if (!append) {
			try {
				fs.unlinkSync(path.resolve(untyped __js__('__dirname'), filename));
			} catch (x: Dynamic) {
				trace(x);
			}
		}

		try {
			stream = untyped __js__("fs.createWriteStream(path.resolve(__dirname, filename), { autoClose: true });");
		} catch (x: Dynamic) {
			trace(x);
		}
	}

	override public function bend( msg: LogMessage ) {
		if (stream != null) {
			stream.write('${msg.text}\n');
		}
	}
}
