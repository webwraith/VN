module characters;

public import character;
public import util.types;
import raylib;

class Characters{
	Character[string] characters;
	
	void add(string id, Character character, int x, Facing facing = Facing.Right) {
		character.x = x;
		
		if (facing == Facing.Left) {
			character.flipSprite();
		}
		characters[id] = character;
	}
	
	void remove(string id) {
		if (hasCharacter(id) && characters[id].visibility == Visibility.Hidden)
		characters.remove(id);
	}

	void update() {
		foreach(character; characters){
			character.update();
		}
	}
	
	void draw() {
		foreach(character; characters){
			character.draw();
		}
	}
	
	bool hasCharacter(string name) {
		return (name in characters) != null;
	}
	
	void activate(string name) {
		if(hasCharacter(name))
			characters[name].activate();
	}
	
	void deactivate(string name) {
		if(hasCharacter(name)){
			characters[name].deactivate();
		}
	}
	
	void setMood(string name, string mood){
		if (hasCharacter(name)){
			characters[name].setMood(mood);
		}
	}
	
	bool hasMood(string name, string mood){
		if (hasCharacter(name)){
			return characters[name].hasMood(mood);
		}
		return false;
	}
	
	void flipSprite(string name) {
		if (hasCharacter(name)) {
			characters[name].flipSprite();
		}
	}
	
	bool isFlipped(string name){
		if(hasCharacter(name)){
			return characters[name].isFlipped();
		}
		return false;
	}
	
	void setX(string name, int x){
		if(hasCharacter(name)){
			characters[name].x = x;
		}
	}
	
	int getX(string name){
		if(hasCharacter(name)){
			return characters[name].x;
		}
		return 0;
	}
	
	void deactivateAllActive() {
		foreach(character; characters){
			if(character.active){
				character.deactivate();
			}
		}
	}

	void hideAll() {
		foreach(character; characters){
			character.hide();
		}
	}

	void showAll() {
		foreach(character; characters){
			character.show();
		}
	}
}