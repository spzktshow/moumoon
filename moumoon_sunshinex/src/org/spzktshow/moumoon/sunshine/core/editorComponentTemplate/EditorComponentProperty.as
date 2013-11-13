package org.spzktshow.moumoon.sunshine.core.editorComponentTemplate
{
	import org.spzktshow.moumoon.core.componentTemplate.componetProperty.ComponentProperty;
	import org.spzktshow.moumoon.core.componentValue.IComponentPropertyValue;
	import org.spzktshow.moumoon.sunshine.core.componentInput.IComponentInput;
	
	public class EditorComponentProperty extends ComponentProperty implements IEditorComponentProperty
	{
		private var _input:IComponentInput;
		
		private var _defaultValue:IComponentPropertyValue;
		
		public function EditorComponentProperty()
		{
			super();
		}
		
		public function set input(value:IComponentInput):void
		{
			_input = value
		}
		
		public function get input():IComponentInput
		{
			return _input;
		}
		
		public function set defaultValue(value:IComponentPropertyValue):void
		{
			_defaultValue = value;
		}
		
		public function get defaultValue():IComponentPropertyValue
		{
			return _defaultValue;
		}
	}
}