module background;

import raylib;

import std.string;
import std.conv;
import std.algorithm;

class Background {
	Texture2D front, back;
	int width, height;
	ubyte alpha;
	ubyte fade_speed;

	private Texture2D[Color] bg_colors;

	this(int width, int height) {
		this.width = width;
		this.height = height;
		alpha = 255;
		fade_speed = 0;
	}

	void update() {
		if (fade_speed) {
			// adjust the alpha
			alpha -= min(alpha,fade_speed);
			// if the alpha is empty, swap front and back, then clear back
			if (alpha == 0) {
				front = back;
				alpha = 255;
				fade_speed = 0;
			}
		}
	}

	void draw() {
		if (fade_speed) {
			auto back_tint = Colors.WHITE;
			back_tint.a = 255-alpha;
			back.DrawTexture(0, 0, back_tint);
		}

		auto front_tint = Colors.WHITE;
		front_tint.a = alpha;
		front.DrawTexture(0, 0, front_tint);
	}

	void fadeToImage(Texture2D new_bg, ubyte speed) {
		if (fade_speed) return;
		back = new_bg;
		fade_speed = speed;
	}

	void fadeToColor(Color color, ubyte speed) {
		if (fade_speed) return;
		if ((color in bg_colors) != null) {
			back = bg_colors[color];
		} else {
			bg_colors[color] = back = LoadTextureFromImage(GenImageColor(width, height, color));
		}
		fade_speed = speed;
	}

	bool fading() {
		return fade_speed > 0;
	}
}