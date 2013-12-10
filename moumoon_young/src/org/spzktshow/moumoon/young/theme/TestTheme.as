package org.spzktshow.moumoon.young.theme
{
	import feathers.textures.Scale9Textures;
	
	import starling.display.DisplayObjectContainer;
	
	public class TestTheme extends MoumoonYoungTheme
	{
		public function TestTheme(container:DisplayObjectContainer=null, scaleToDPI:Boolean=true)
		{
			super(container, scaleToDPI);
		}
		
		public function get testSource():Scale9Textures
		{
			return buttonDisabledSkinTextures;
		}
	}
}