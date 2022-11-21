package gameObjects.userInterface;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.FlxGraphic;
import sys.FileSystem;
import openfl.utils.Assets;

using StringTools;

class HealthIcon extends FlxSprite
{
	// rewrite using da new icon system as ninjamuffin would say it
	public var sprTracker:FlxSprite;
	public var initialWidth:Float = 0;
	public var initialHeight:Float = 0;
	public var initialAngle:Float = 0;
	public var isPlayer = false;

	public function new(char:String = 'bf', isPlayer:Bool = false)
	{
		super();
		updateIcon(char, isPlayer);
		this.isPlayer = isPlayer;
	}

	public function updateIcon(char:String = 'bf', isPlayer:Bool = false)
	{
		var trimmedCharacter:String = char;
		if (trimmedCharacter.contains('-'))
			trimmedCharacter = trimmedCharacter.substring(0, trimmedCharacter.indexOf('-'));

		var iconPath = char;
		if (!Assets.exists(Paths.getPath('images/icons/icon-' + iconPath + '.png', IMAGE)))
		{
			if (iconPath != trimmedCharacter)
				iconPath = trimmedCharacter;
			else
				iconPath = 'face';
			trace('$char icon trying $iconPath instead you fuck');
		}

		antialiasing = true;
		var iconGraphic:FlxGraphic = Paths.image('icons/icon-' + iconPath);
		loadGraphic(iconGraphic, true, Std.int(iconGraphic.width / 2), iconGraphic.height);

		initialWidth = width;
		initialHeight = height;

		animation.add('icon', [0, 1], 0, false, isPlayer);
		animation.play('icon');
		scrollFactor.set();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (sprTracker != null)
			setPosition(sprTracker.x + sprTracker.width + 10, sprTracker.y - 30);
	}
	
	public function frameCheck(life:Float) {
		if(!isPlayer) {
			animation.curAnim.curFrame = ((life > 80) ? 1 : 0);
		} else {
			animation.curAnim.curFrame = ((life < 20) ? 1 : 0);
		}
	}
}
