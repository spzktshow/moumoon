package org.spzktshow.moumoon.young.menu
{
	public interface IMenuListContext extends IMenuItemContext
	{
		/**
		 *menuItems 
		 * @param value
		 * 
		 */		
		function set menuItems(value:Vector.<IMenuListContext>):void;
		function get menuItems():Vector.<IMenuListContext>;
	}
}