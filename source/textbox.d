module textbox;

import raylib;
import std.math;
import std.algorithm;
import std.conv;

import util.vars;

class TextBoxState {
	
	string text;
	int height, width, x, y;

	Color box_colour;
	DeltaVar!ubyte box_alpha;

	this(){
		box_alpha = new DeltaVar!ubyte(0, 5, 0, 70);
	}

	void show() {
		box_alpha.target = 70;
	}

	void hide() {
		// reduce opacity of the box
		box_alpha.target = 0;
	}

	bool isAnimating() {
		return !box_alpha.idle;
	}

	bool isVisible() {
		return !box_alpha.min;
	}

	void update(int delta) {
		// if the box is fading in/out, update it and return
		box_alpha.update(delta);
	}

	/// draws the current state of the text box and associated character graphics
	void render() {
		box_colour.a = to!ubyte(box_alpha.value);
		DrawRectangle(x, y, width, height, box_colour);
	}
}