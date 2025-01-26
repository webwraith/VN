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
	ubyte alpha, max_alpha;
	byte speed;

	this(ubyte max_alpha = 255) {
		this.max_alpha = max_alpha;
	}


	void show(ubyte speed = 2) {
		// set the speed of the fade
		if (speed > 127) speed = 127;
		if (this.speed == 0) this.speed = speed;
	}

	void hide(ubyte speed = 2) {
		if (speed > 127) speed = 127;
		if (this.speed == 0) this.speed = cast(ubyte)(cast(int)(-speed));
	}

	bool isAnimating() {
		return speed > 0;
	}

	bool isVisible() {
		return alpha > 0;
	}

	void update() {
		// if the box is fading in/out, update it and return
		alpha += speed;
	}

	/// draws the current state of the text box and associated character graphics
	void draw() {
		box_colour.a = alpha;
		DrawRectangle(x, y, width, height, box_colour);
	}
}