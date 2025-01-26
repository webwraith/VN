// standard library imports
import std.stdio;
import std.string;
import std.container.dlist;
import std.conv;

// all other imports
import raylib;
import view;
import assets;

const int SCREEN_WIDTH = 1920;
const int SCREEN_HEIGHT = 1080;

View current_state;

/**

TODO:

[ ] - Implement the command system
[ ] - Implement the text box system
[ ] - Implement the character system
[X] - Implement the background system
[ ] - Implement the script system
[ ] - Implement the music system
[ ] - Implement the game loop

**/


void main()
{
	// initialise file locations
	set_asset_path("bg", `backgrounds\`);
	set_asset_path("chars", `characters\`);
	set_asset_path("script", `scripts\`);
	
	
	SetTargetFPS(30);
	string title = "The First Survivor";
	/++/
	current_state.start(SCREEN_WIDTH, SCREEN_HEIGHT, title);

	auto bg = LoadTexture(get_path(`bg`, `1.png`).toStringz);
	auto b2 = LoadTexture(get_path(`bg`, `2.png`).toStringz);

	current_state.background.fadeToImage(bg, 2);
	writeln(bg);

	double delta = 0.0;
	while (!WindowShouldClose()) {
		BeginDrawing();

		current_state.draw();
		
		EndDrawing();

		current_state.update();
		delta += GetFrameTime(); // remember, this is in seconds
		if (delta > 17 && !current_state.background.fading()) {
			break;
		}
		else if (delta > 16) {
			current_state.background.fadeToColor(Colors.BLACK, 4);
		}
		else if (delta > 8) {
			current_state.background.fadeToImage(b2, 4);
		}
	}
	// +/
	
	/++
		// This is a quick test of the colour tint option for the DrawTexture function
		InitWindow(1920, 1080, "Test");
		
		auto b1 = LoadTexture((get_path(`bg`, `1.png`)).toStringz);
		auto b2 = LoadTexture((get_path(`bg`, `2.png`)).toStringz);

		Color tint = Colors.WHITE;
		Color tint2 = Colors.WHITE;
		byte delta = 2;
		ubyte alpha = 255;

		while(!WindowShouldClose) {
			BeginDrawing();

			DrawTexture(b1, 0, 0, tint);
			DrawTexture(b2, 0, 0, tint2);
			
			EndDrawing();
			
			tint.a = alpha;
			tint2.a = 255 - alpha;

			alpha += delta;
			if (alpha == 0 || alpha == 255) {
				delta *= -1;
			}
		}
	// +/

	CloseWindow();
}
