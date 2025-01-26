module script.command;

import view;
import std.typecons;
debug import std.stdio;

class Command {
	string name;
	string[] args;

	this(string name, string[] args) {
		this.name = name;
		this.args = args;
	}

	abstract Flag!"finished" execute(View view);
}

class CommandFadeIn : Command {
	this(string[] args) {
		// should be a single argument, the time to fade in
		super("fadein", args);
	}

	override Flag!"finished" execute(View view) {
		debug writeln("Fade in command executed\n");
		view.state = ViewState.FadeIn;
		return Flag!"finished".Yes;
	}
}

class CommandFadeOut : Command {
	this(string[] args) {
		// should be a single argument, the time to fade out
		super("fadeout", args);
	}

	override Flag!"finished" execute(View view) {
		debug writeln("Fade out command executed\n");
		view.state = ViewState.FadeOut;
		if (view.view_alpha.idle) {
			view.view_alpha.target = 1.0;
		}
	}
}

class CommandChangeBackground : Command {
	string bg;

	this(string[] args) {
		// should be a single argument, the background to change to
		super("changebg", args);
		bg = args[0];
	}

	override Flag!"finished" execute(View view) {
		debug writeln("Change background command executed\n");
		view.background = LoadTexture(args[0].toStringz);
	}
}

class CommandShowTextBox : Command {
	this(string[] args) {
		super("showtextbox", args);
	}

	override Flag!"finished" execute(View view) {
		debug writeln("Show text box command executed\n");
		view.textbox.show();
	}
}

class CommandHideTextBox : Command {
	this(string[] args) {
		super("hidetextbox", args);
	}

	override Flag!"finished" execute(View view) {
		debug writeln("Hide text box command executed\n");
		view.textbox.hide();
	}
}

class CommandLoadScript : Command {
	string scriptfile;

	this(string[] args) {
		super("loadscript", args);
		scriptfile = args[0];
	}

	override Flag!"finished" execute(View view) {
		debug writeln("Load script command executed\n");
	}
}