package org.spzktshow.moumoon.core.group
{
	public interface IGroup
	{
		/**
		 *添加item
		 * @param value
		 * @return 
		 * 
		 */		
		function addItem(value:IGroupItem):int;
		/**
		 *移除item 
		 * @param name
		 * @return 
		 * 
		 */		
		function removeItem(name:String):IGroupItem;
		/**
		 *检测item 
		 * @param name
		 * @return 
		 * 
		 */		
		function checkItem(name:String):int;
		/**
		 *获取item 
		 * @param name
		 * @return 
		 * 
		 */		
		function getItem(name:String):IGroupItem;
		/**
		 *获取全部 
		 * @return 
		 * 
		 */		
		function get total():Vector.<IGroupItem>;
	}
}