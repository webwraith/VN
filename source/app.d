// standard library imports
import std.stdio;
import std.string;
import std.container.dlist;
import std.conv;

// all other imports
import raylib;
import view;
import assets;
import characters;

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
	Character maru = Character(["idle": LoadTexture(get_character_path("maru").toStringz)]);
	current_state.characters.add("maru", maru, 120);

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
		else if (delta > 12) {
			current_state.characters.characters["maru"].activate();
		}
		else if (delta > 8) {
			current_state.background.fadeToImage(b2, 4);
			current_state.characters.characters["maru"].show();
		}
	}

	CloseWindow();
}
