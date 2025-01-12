module assets;

private static string root_assets = `.\assets\`;
private string[string] asset_types;

string get_path(string type, string filename) {
	if ((type in asset_types) != null)
		return root_assets ~ asset_types[type] ~ filename;
	return root_assets ~ filename;
}

string get_character_path(string character_name, string mood = "idle") {
	return get_path("chars", character_name ~ "/" ~ mood ~ ".png");
}

void set_asset_path(string reference, string location) {
	asset_types[reference] = location;
}
