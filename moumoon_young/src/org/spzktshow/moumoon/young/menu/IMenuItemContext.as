package org.spzktshow.moumoon.young.menu
{
	public interface IMenuItemContext
	{
		/**
		 * menuItem的索引名称
		 * @param value
		 * 
		 */		
		function set name(value:String):void;
		function get name():String;
		/**
		 *menuItem的数据引用 
		 * @param value
		 * 
		 */		
		function set data(value:Object):void;
		function get data():Object;
		/**
		 *父级menuList对象 
		 * @param value
		 * 
		 */		
		function set father(value:IMenuListContext):void;
		function get father():IMenuListContext;
	}
}