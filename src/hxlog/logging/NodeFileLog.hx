package hxlog.logging;

class NodeFileLog extends LogBend {
	var stream: Dynamic; // WriteStream

	public function new( filename: String, append = false ) {
		var fs = untyped __js__("require('fs');");
		var path = untyped __js__("require('path');");

		if (!append) {
			fs.unlinkSync(path.resolve(untyped __js__('__dirname'), filename));
		}

		stream = untyped __js__("fs.createWriteStream(path.resolve(__dirname, filename), { autoClose: true });");
	}

	override public function bend( msg: LogMessage ) {
		stream.write('${msg.text}\n');
	}
}
