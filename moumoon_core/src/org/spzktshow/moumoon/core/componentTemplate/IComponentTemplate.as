package org.spzktshow.moumoon.core.componentTemplate
{
	import org.spzktshow.moumoon.core.componentTemplate.componetProperty.IComponentProperty;
	import org.spzktshow.moumoon.core.group.IGroupItem;

	public interface IComponentTemplate extends IGroupItem
	{
		function get componentTemplateType():String;
		
		function get componentPropertys():Vector.<IComponentProperty>;
		/**
		 *组件type类型 
		 * @param value
		 * 
		 */		
		function set componentTemplateType(value:String):void;
		/**
		 *组件属性 
		 * @param value
		 * 
		 */		
		function set componentPropertys(value:Vector.<IComponentProperty>):void;
		/**
		 *组建全称 
		 * @param value
		 * @return 
		 * 
		 */		
		function set componentTotalName(value:String):void;
		/**
		 *组建全称 
		 * @return 
		 * 
		 */		
		function get componentTotalName():String;
	}
}