package org.spzktshow.moumoon.sunshine.core.componentInput
{
	import org.spzktshow.moumoon.core.componentValue.IComponentPropertyValue;
	import org.spzktshow.moumoon.sunshine.core.componentInput.proxy.ComponentInputTextInputProxy;
	import org.spzktshow.moumoon.sunshine.core.componentInput.proxy.IComponentInputProxy;
	import org.spzktshow.moumoon.sunshine.core.editorComponentTemplate.IEditorComponentProperty;
	import org.spzktshow.moumoon.young.componentInput.textInput.ComponentInputTextInput;
	import org.spzktshow.moumoon.young.core.YoungControl;

	public class ComponentInputFactory
	{
		public function ComponentInputFactory()
		{
		}
		/**
		 *创建 
		 * @return 
		 * 
		 */		
		public static function create(componentProperty:IEditorComponentProperty, componentPropertyValue:IComponentPropertyValue):IComponentInputProxy
		{
			var componentInputView:YoungControl;
			var componentInputProxy:IComponentInputProxy;
			if (componentProperty.input.type == ComponentInputEnum.TEXT_INPUT)
			{
				componentInputProxy = new ComponentInputTextInputProxy;
				componentInputView = new ComponentInputTextInput;
				
				componentInputProxy.componentInput = componentInputView;
				componentInputProxy.componentProperty = componentProperty;
				componentInputProxy.componentPropertyValue = componentPropertyValue;
			}
			return componentInputProxy;
		}
	}
}