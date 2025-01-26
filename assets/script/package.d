module script;

public import script.command;
public import std.typecons;
import view;

class Script {
	string scriptfile;
	Command[] commands;

	this(string scriptfile) {
		this.scriptfile = scriptfile;
	}

	void load() {
		// read the script file
		// for each line, create a command and add it to the commands array
		// should this be in JSON, XML, or some other format?
		// 
	}

	void execute(View view) {
		foreach (command; commands) {
			while (command.execute(view) == No.finished) {
				continue;
			}
		}
	}
}