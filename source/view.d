module view;

import std.stdio;
import std.string;
import std.conv;

import raylib;
import textbox;
import util.vars;

enum ViewState {
	Opening,
	Idle,
	Closing
}

struct View {
	Texture2D background;
	int width, height;
	TextBoxState textbox;
	ViewState state;
	DeltaVar!float view_alpha = new DeltaVar!float(1.0, (1.0/30.0), 0.0, 1.0);

	void start(int width, int height, string title) {
		this.width = width;
		this.height = height;
		InitWindow(width, height, title.toStringz);
		textbox = new TextBoxState();
		state = ViewState.Idle;

		debug writeln("Dims: [", width, ", ", height, "]\n");
	}

	void update(int delta) {
		final switch(this.state) {
			case ViewState.Opening: updateOpening(delta); break;
			case ViewState.Closing: updateClosing(delta); break;
			case ViewState.Idle: updateIdle(delta); break;
		}
	}

	void draw() {
		// draw background
		background.DrawTexture(0, 0, Colors.RAYWHITE);
		DrawRectangle(0, 0, width, height, Fade(Colors.BLACK, view_alpha.value));

		if(state == ViewState.Idle) {
			// draw text
			textbox.render();
		}
	}

	void updateOpening(int delta) {
		SetWindowTitle("The First Survivor - OPENING");
		view_alpha.target = 0.0;
		view_alpha.update(delta);

		if (view_alpha.idle) {
			state = ViewState.Idle;
		}
	}
	
	void updateClosing(int delta) {
		SetWindowTitle("The First Survivor - CLOSING");
		view_alpha.target = 1.0;
		view_alpha.update(delta);

		if (view_alpha.idle) {
			// replace with next state
			state = ViewState.Idle;
		}
	}

	void updateIdle(int delta) {
		// this is where scripts will be run
		SetWindowTitle("The First Survivor - IDLE");
		if (IsKeyPressed(KeyboardKey.KEY_A)) {
			state = ViewState.Closing;
		}
		if (IsKeyPressed(KeyboardKey.KEY_S)) {
			state = ViewState.Opening;
		}
	}
}