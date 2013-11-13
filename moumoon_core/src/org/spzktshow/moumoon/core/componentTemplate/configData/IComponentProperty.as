package org.spzktshow.moumoon.core.componentTemplate.configData
{
	/**
	 *组件的属性 
	 * @author rocklee
	 * 
	 */	
	public interface IComponentProperty
	{
		/**
		 *属性名称 
		 * @param value
		 * 
		 */		
		function set name(value:String):void;
		function get name():String;
		/**
		 *属性值 
		 * @param value
		 * 
		 */		
		function set propertyValue(value:Object):void;
		function get propertyValue():Object;
		/**
		 *是否在创建时是必须依赖的属性,如果是在创建的时候会需要填入属性 
		 * @param value
		 * 
		 */		
		function set isCreateInject(value:Boolean):void;
		function get isCreateInject():Boolean;
	}
}