package org.spzktshow.moumoon.sunshine.core.componentInput.proxy
{
	import org.spzktshow.moumoon.core.componentTemplate.componetProperty.IComponentProperty;
	import org.spzktshow.moumoon.core.componentValue.IComponentPropertyValue;
	import org.spzktshow.moumoon.young.core.YoungControl;

	public interface IComponentInputProxy
	{
		/**
		 *设置属性 
		 * @param value
		 * 
		 */		
		function set componentProperty(value:IComponentProperty):void;
		
		function get componentProperty():IComponentProperty;
		/**
		 *设置属性值 
		 * @param value
		 * 
		 */		
		function set componentPropertyValue(value:IComponentPropertyValue):void;
		
		function get componentPropertyValue():IComponentPropertyValue;
		/**
		 *设置组建输入 
		 * @param value
		 * 
		 */		
		function set componentInput(value:YoungControl):void;
		/**
		 *组建 
		 * @return 
		 * 
		 */		
		function get componentInput():YoungControl;
	}
}