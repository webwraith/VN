module character;

import util.types;

import raylib;

import std.algorithm;

struct Character {
	Texture2D[string] moods;
	Color tint = Colors.WHITE;
	string current_mood;
	Rectangle current_rect;
	int x, y;
	ubyte grayscale = 127, alpha = 0;
	bool active;
	Visibility visibility;

	this(Texture2D[string] moods, string current_mood = "idle", int xpos = 0) {
		this.moods = moods.dup;
		this.current_mood = current_mood;
		if(moods.length && (current_mood in moods) is null) current_mood = moods.keys[0].dup;
		
		x = xpos;
		y = GetScreenHeight() - moods[current_mood].height;
		current_rect = Rectangle(0, 0, moods[current_mood].width, moods[current_mood].height);

		active = false;
		visibility = Visibility.Hidden;
	}

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
				alpha = cast(ubyte)min(alpha + 2, 255);
				if (alpha == 255){
					visibility = Visibility.Shown;
				}
				break;
			case Visibility.FadeOut:
				alpha = cast(ubyte)min(alpha - 2, 0);
				if (alpha == 0){
					visibility = Visibility.Hidden;
				}
				break;
			default:
				break;
		}
		tint.a = alpha;
	}

	void draw() {
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

	void addMoods(Texture2D[string] moods) {
		this.moods = moods.dup;
	}

	void flipSprite() {
		current_rect.width *= -1;
	}

	bool isFlipped() {
		return current_rect.width < 0;
	}

	void show() {
		if (visibility == Visibility.Hidden)
			visibility = Visibility.FadeIn;
	}

	void hide() {
		if (visibility == Visibility.Shown)
			visibility = Visibility.FadeOut;
	}
}