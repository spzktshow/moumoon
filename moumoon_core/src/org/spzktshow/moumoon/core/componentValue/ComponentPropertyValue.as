package org.spzktshow.moumoon.core.componentValue
{
	import org.spzktshow.moumoon.core.group.GroupItem;
	/**
	 *组件属性值 
	 * @author rocklee
	 * 
	 */	
	public class ComponentPropertyValue extends GroupItem implements IComponentPropertyValue
	{
		private var _propertyName:String;
		private var _propertyValue:Object;
		
		public function ComponentPropertyValue()
		{
		}
		
		public function set propertyValue(value:Object):void
		{
			_propertyValue = value;
		}
		
		public function get propertyValue():Object
		{
			return _propertyValue;
		}
	}
}