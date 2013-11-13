package org.spzktshow.moumoon.core.componentTemplate.componetProperty
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
		//以下接口为自动化创建使用
		/**
		 *是否在创建时是必须依赖的属性,如果是在创建的时候会需要填入属性 
		 * @param value
		 * 
		 */		
		function set isStructureDepend(value:Boolean):void;
		function get isStructureDepend():Boolean;
		/**
		 *构造函数的参数索引,在isStructureDepend为true的情况下,值>=0,当isStructureDepend为false情况下值为-1
		 * @param value
		 * 
		 */		
		function set structureDependIndex(value:int):void;
		function get structureDependIndex():int;
		/**
		 *非必要构造属性,在isStructureDepend为true的情况下,值为true时,构造参数可以为null,值为false时,构造参数必定有值
		 * @param value
		 * 
		 */		
		function set isDispensable(value:Boolean):void;
		function get isDispensable():Boolean;
	}
}