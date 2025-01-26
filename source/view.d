module view;

import std.stdio;
import std.string;
import std.conv;

import raylib;
import textbox;
import characters;
import background;
import util.vars;

enum ViewState {
	FadeIn,
	Idle,
	FadeOut
}

struct View {
	Background background;
	Characters characters;
	TextBoxState textbox;
	int width, height;

	void start(int width, int height, string title) {
		this.width = width;
		this.height = height;
		InitWindow(width, height, title.toStringz);
		textbox = new TextBoxState();
		background = new Background(width, height);
		characters = new Characters();

		debug writeln("Dims: [", width, ", ", height, "]\n");
	}

	void update() {
		background.update();
		characters.update();
		textbox.update();
	}

	void draw() {
		background.draw();
		characters.draw();
		textbox.draw();
	}
}