package org.spzktshow.moumoon.core.source
{
	import org.spzktshow.moumoon.core.group.GroupItem;
	
	import starling.textures.Texture;
	
	public class Source extends GroupItem implements ISource
	{
		private var _data:Texture;
		
		public function Source()
		{
		}
		
		public function set data(value:Texture):void
		{
			_data = value;
		}
		
		public function get data():Texture
		{
			return _data;
		}
	}
}