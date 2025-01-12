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

/// remove from final code; only here to keep the code compiling while I work on the rendering


void main()
{
	// initialise file locations
	set_asset_path("bg", `backgrounds\`);
	set_asset_path("chars", `characters\`);
	
	
	SetTargetFPS(30);
	current_state.start(SCREEN_WIDTH, SCREEN_HEIGHT, "The First Survivor");

	auto bg = get_path(`bg`, `1.png`);

	current_state.background = LoadTexture(bg.toStringz);
	writeln(bg);


	while (!WindowShouldClose()) {
		BeginDrawing();

		current_state.draw();
		
		EndDrawing();

		current_state.update(to!int (GetFrameTime()*100));
	}

	CloseWindow();
}
