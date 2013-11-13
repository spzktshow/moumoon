package org.spzktshow.moumoon.sunshine.core.componentInput.proxy
{
	import org.spzktshow.moumoon.core.componentTemplate.componetProperty.IComponentProperty;
	import org.spzktshow.moumoon.core.componentValue.IComponentPropertyValue;
	import org.spzktshow.moumoon.young.core.YoungControl;
	
	public class ComponentInputProxy implements IComponentInputProxy
	{
		/**
		 *组件属性 
		 */		
		protected var _componentProperty:IComponentProperty;
		/**
		 *组件属性直 
		 */		
		protected var _componentPropertyValue:IComponentPropertyValue;
		/**
		 *输入组件 
		 */		
		protected var _componentInput:YoungControl;
		
		public function ComponentInputProxy()
		{
		}
		
		public function set componentProperty(value:IComponentProperty):void
		{
			_componentProperty = value;
		}
		
		public function set componentPropertyValue(value:IComponentPropertyValue):void
		{
			_componentPropertyValue = value;
		}
		
		public function set componentInput(value:YoungControl):void
		{
			_componentInput = value;
		}
		
		public function get componentInput():YoungControl
		{
			return _componentInput;
		}
		
		public function get componentProperty():IComponentProperty
		{
			return _componentProperty;
		}
		
		public function get componentPropertyValue():IComponentPropertyValue
		{
			return _componentPropertyValue;
		}
		
		
	}
}