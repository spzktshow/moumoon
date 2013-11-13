package org.spzktshow.moumoon.core.component
{
	import org.spzktshow.moumoon.core.componentTemplate.IComponentTemplate;
	import org.spzktshow.moumoon.core.componentValue.IComponentValueList;
	import org.spzktshow.moumoon.core.group.IGroupItem;
	import org.spzktshow.moumoon.core.source.ISource;
	
	import starling.display.DisplayObject;

	/**
	 *通用组件，将界面中所有的元素看做是组件，以树状形式组合 
	 * @author rocklee
	 * 
	 */
	public interface IComponent extends IGroupItem
	{
		/**
		 *父节点 
		 * @param value
		 * 
		 */		
		function set parent(value:IComponent):void;
		function get parent():IComponent;
		/**
		 *子节点 
		 * @param value
		 * 
		 */		
		function set children(value:Vector.<IComponent>):void;
		function get children():Vector.<IComponent>;
		/**
		 *组件的type类型，componentEnum
		 * @param value
		 * 
		 */		
		function set type(value:String):void;
		function get type():String;
		/**
		 *组件模板 
		 * @param value
		 * 
		 */		
		function set componentTemplate(value:IComponentTemplate):void;
		function get componentTemplate():IComponentTemplate;
		/**
		 * 
		 * @param value
		 * 
		 */		
		function set componentValueList(value:IComponentValueList):void;
		function get componentValueList():IComponentValueList;
		/**
		 *资源 
		 * @param value
		 * 
		 */		
		function set source(value:ISource):void;
		function get source():ISource;
		/**
		 *设置x坐标 
		 * @param value
		 * 
		 */		
		function set x(value:Number):void;
		function get x():Number;
		/**
		 *设置y坐标 
		 * @param value
		 * 
		 */		
		function set y(value:Number):void;
		function get y():Number;
		/**
		 *设置宽度 
		 * @param value
		 * 
		 */		
		function set width(value:Number):void;
		function get width():Number;
		/**
		 *设置高度 
		 * @param value
		 * 
		 */		
		function set height(value:Number):void;
		function get height():Number;
		/**
		 *实体显示对象 
		 * @param value
		 * 
		 */		
		function set entity(value:DisplayObject):void;
		function get entity():DisplayObject;
	}
}