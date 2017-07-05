package hxlog.bending;

class NamedBend extends LogBend {
	var name: String;

	public function new( name: String )
		this.name = name;

	override public function bend( msg: LogMessage )
		msg.text = '$name${msg.text}';
}
