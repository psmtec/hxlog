package hxlog;

import haxe.PosInfos;

@:final
class LogPipe {

	var _msg:LogMessage = new LogMessage();
	var _bends:Array<LogBend> = [];
	var _pipes:Array<LogPipe> = [];
	var _filter:Int = 0xFFFFFFFF;

	function new() {}

	function run() {
		var msg = _msg;
		for (bend in _bends) {
			bend.bend(msg);
		}
		for (pipe in _pipes) {
			pipe._msg.copyFrom(msg);
			pipe.run();
		}
	}

	/** Dispose unmanaged resources for this bend **/
	function dispose() {
		for (pipe in _pipes) {
			pipe.dispose();
		}
		for (bend in _bends) {
			bend.dispose();
		}
	}

	/** Clear message **/
	function clear() {
		for (pipe in _pipes) {
			pipe.clear();
		}
		for (bend in _bends) {
			bend.clear();
		}
	}

	public function branch():LogPipe {
		var pipe = new LogPipe();
		_pipes.push(pipe);
		return pipe;
	}

	public function bend(b:LogBend):LogPipe {
		if(b == null) throw "Invalid argument";
		_bends.push(b);
		return this;
	}

	function print(message:Any, level:LogLevel, ?infos:PosInfos) {
		if (message == null || !level.check(_filter)) {
			return;
		}

		_msg.text = message;
		_msg.level = level;
		_msg.infos = infos;
		run();
	}

	public inline function filter(?levels:Array<LogLevel>) {
		_filter = LogLevel.buildMask(levels);
	}

	public inline function trace(message:Any, ?position:PosInfos)
		print(message, LogLevel.TRACE, position);

	public inline function debug(message:Any, ?position:PosInfos)
		print(message, LogLevel.DEBUG, position);

	public inline function info(message:Any, ?position:PosInfos)
		print(message, LogLevel.INFO, position);

	public inline function warning(message:Any, ?position:PosInfos)
		print(message, LogLevel.WARNING, position);

	public inline function error(message:Any, ?position:PosInfos)
		print(message, LogLevel.ERROR, position);
}
