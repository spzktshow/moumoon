package org.spzktshow.moumoon.core.componentValue
{
	import org.spzktshow.moumoon.core.group.IGroupItem;

	public interface IComponentPropertyValue extends IGroupItem
	{
		/**
		 *属性值 
		 * @param value
		 * 
		 */		
		function set propertyValue(value:Object):void;
		function get propertyValue():Object;
	}
}