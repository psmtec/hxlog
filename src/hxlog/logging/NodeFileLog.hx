package hxlog.logging;

class NodeFileLog extends LogBend {
	var stream: Dynamic; // WriteStream

	public function new( path: String, filename: String, append = false ) {
		trace('creating FileLog: $path/$filename');

#if !macro
		var fs = js.Syntax.code("require('electron').remote.require('fs');");
		var p = js.Syntax.code("require('electron').remote.require('path');");
		var url = js.Syntax.code("p.resolve(path, filename);");

		if (!append) {
			try {
				fs.unlinkSync(url);
			} catch (x: Dynamic) {
				// trace(x);
			}
		}

		try {
			stream = js.Syntax.code("fs.createWriteStream(url, { autoClose: true });");
		} catch (x: Dynamic) {
			trace(x);
		}
#end
	}

	override public function bend( msg: LogMessage ) {
		if (stream != null) {
			stream.write('${msg.text}\n');
		}
	}
}
