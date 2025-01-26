module character;

import util.types;

import raylib;

import std.algorithm;

struct Character {
	Texture2D[string] moods;
	string current_mood;
	Rectangle current_rect;
	int x, y;
	ubyte grayscale = 127;
	bool active;
	Visibility visibility;

	void update() {
		switch (visibility) {
			case Visibility.Hidden:
				break;
			case Visibility.Shown:
				if (active) {
				grayscale = cast(ubyte)min(grayscale + 2, 255);
				} else {
					grayscale = cast(ubyte)max(grayscale - 2, 127);
				}
				// TODO: include code for animating change of mood
				break;
			case Visibility.FadeIn:
				grayscale = cast(ubyte)min(grayscale + 2, 255);
				if (grayscale == 255){
					visibility = Visibility.Shown;
				}
				break;
			case Visibility.FadeOut:
				grayscale = cast(ubyte)min(grayscale - 2, 0);
				if (grayscale == 0){
					visibility = Visibility.Hidden;
				}
				break;
			default:
				break;
		}
	}

	void draw() {
		auto tint = Colors.WHITE;
		tint.r = tint.g = tint.b = grayscale;
		moods[current_mood].DrawTextureRec(current_rect, Vector2(x, y), tint);
	}

	void activate() {
		active = true;
	}

	void deactivate() {
		active = false;
	}

	void setMood(string mood) {
		if ((mood in moods) != null) {
			current_mood = mood;
			current_rect = Rectangle(0, 0, moods[mood].width, moods[mood].height);
		}
	}

	bool hasMood(string mood) {
		return (mood in moods) != null;
	}

	void flipSprite() {
		current_rect.width *= -1;
	}

	bool isFlipped() {
		return current_rect.width < 0;
	}

	void show() {
		if (visibility==Visibility.Hidden)
			visibility = Visibility.FadeIn;
	}

	void hide() {
		if (visibility==Visibility.Shown)
			visibility = Visibility.FadeOut;
	}
}