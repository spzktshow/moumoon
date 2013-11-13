package org.spzktshow.moumoon.sunshine.core.componentInput.proxy
{
	import org.spzktshow.moumoon.core.componentTemplate.componetProperty.IComponentProperty;
	import org.spzktshow.moumoon.core.componentValue.IComponentPropertyValue;
	import org.spzktshow.moumoon.young.componentInput.textInput.ComponentInputTextInput;

	public class ComponentInputTextInputProxy extends ComponentInputProxy
	{
		public function ComponentInputTextInputProxy()
		{
			super();
		}
		
		override public function set componentProperty(value:IComponentProperty):void
		{
			super.componentProperty = value;
			
			componentInputTextInput.title = value.name;
		}
		
		override public function set componentPropertyValue(value:IComponentPropertyValue):void
		{
			super.componentPropertyValue = value;
			
			componentInputTextInput.text = String(value.propertyValue);
		}
		
		public function get componentInputTextInput():ComponentInputTextInput
		{
			return componentInput as ComponentInputTextInput;
		}
	}
}