package org.spzktshow.moumoon.sunshine.core.editorComponentTemplate
{
	import org.spzktshow.moumoon.core.componentTemplate.componetProperty.IComponentProperty;
	import org.spzktshow.moumoon.core.componentValue.IComponentPropertyValue;
	import org.spzktshow.moumoon.sunshine.core.componentInput.IComponentInput;
	
	public interface IEditorComponentProperty extends IComponentProperty
	{
		/**
		 *输入配置 
		 * @param value
		 * 
		 */		
		function set input(value:IComponentInput):void;
		function get input():IComponentInput;
		/**
		 *默认值 
		 * @param value
		 * 
		 */		
		function set defaultValue(value:IComponentPropertyValue):void;
		function get defaultValue():IComponentPropertyValue;
	}
}