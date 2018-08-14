package hxlog.logging;

typedef HistoryOpts = {
	?maxLength: Int,
}

class History extends LogBend {
	var history: Array<LogMessage> = [];
	var maxLength: Null<Int>;

	public function new( opts: HistoryOpts ) {
		maxLength = opts.maxLength != null ? opts.maxLength : 512;
	}

	override public function bend( msg: LogMessage ) {
		while (history.length + 1 > maxLength) {
			history.shift();
		}

		var backup = new LogMessage();
		backup.copyFrom(msg);
		history.push(backup);
	}
}
