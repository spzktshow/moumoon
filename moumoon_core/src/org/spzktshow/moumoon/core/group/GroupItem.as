package org.spzktshow.moumoon.core.group
{
	public class GroupItem implements IGroupItem
	{
		private var _name:String;
		
		public function GroupItem()
		{
		}
		
		public function set name(value:String):void
		{
			_name = value;
		}
		
		public function get name():String
		{
			return _name;
		}
	}
}