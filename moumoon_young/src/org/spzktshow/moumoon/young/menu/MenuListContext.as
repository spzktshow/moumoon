package org.spzktshow.moumoon.young.menu
{
	public class MenuListContext extends MenuItemContext implements IMenuListContext
	{
		private var _menuItems:Vector.<IMenuListContext>;
		
		public function MenuListContext()
		{
			super();
		}
		
		public function set menuItems(value:Vector.<IMenuListContext>):void
		{
			_menuItems = value;
		}
		
		public function get menuItems():Vector.<IMenuListContext>
		{
			return _menuItems;
		}
	}
}