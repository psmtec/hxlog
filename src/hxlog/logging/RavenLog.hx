package hxlog.logging;

import hxlog.LogBend;
import hxlog.LogMessage;
import raven.Raven;

typedef RavenLogOpts = {
	dsn: String,
}

// logger for sentry.io using https://github.com/psmtec/raven-hx
class RavenLog extends LogBend {
	public function new( opts: RavenLogOpts )
		Raven.config(opts.dsn);

	override public function bend( msg: LogMessage )
		Raven.captureMessage(msg.text);
}
