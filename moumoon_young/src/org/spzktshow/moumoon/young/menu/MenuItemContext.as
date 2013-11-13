package org.spzktshow.moumoon.young.menu
{
	public class MenuItemContext implements IMenuItemContext
	{
		private var _name:String;
		
		private var _data:Object;
		
		private var _father:IMenuListContext;
		
		public function MenuItemContext()
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
		
		public function set data(value:Object):void
		{
			_data = value;
		}
		
		public function get data():Object
		{
			return _data;
		}
		
		public function set father(value:IMenuListContext):void
		{
			_father = value;
		}
		
		public function get father():IMenuListContext
		{
			return _father;
		}
	}
}