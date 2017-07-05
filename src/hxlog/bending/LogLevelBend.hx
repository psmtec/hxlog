package hxlog.bending;

class LogLevelBend extends LogBend {

	var _levels:Array<String>;

	static var defaultTags = ["T/", "D/", "I/", "W/", "E/" ];

	public function new( ?tags )
		_levels = tags != null ? tags : defaultTags;

	override public function bend(msg:LogMessage)
		msg.text = '${_levels[msg.level]}${msg.text}';
}
