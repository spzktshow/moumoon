package org.spzktshow.moumoon.sunshine.core.editorComponentTemplate.factory
{
	import org.spzktshow.moumoon.core.component.IComponent;
	import org.spzktshow.moumoon.core.componentValue.ComponentValueList;
	import org.spzktshow.moumoon.core.componentValue.IComponentPropertyValue;
	import org.spzktshow.moumoon.core.componentValue.IComponentValueList;
	import org.spzktshow.moumoon.sunshine.core.editorComponentTemplate.IEditorComponentProperty;

	public class ComponentValueListFactory
	{
		public function ComponentValueListFactory()
		{
		}
		/**
		 *补足没有的属性为默认属性 
		 * @param component
		 * 
		 */		
		public static function filter(component:IComponent):void
		{
			if (!component.componentValueList) component.componentValueList = new ComponentValueList;
			//先检测现有的componentValueList是否有值,如果没有则用default代替
			for each(var editorComponentProperty:IEditorComponentProperty in component.componentTemplate.componentPropertys)
			{
				var bool:Boolean = false;
				for each(var componentPropertyValue:IComponentPropertyValue in component.componentValueList)
				{
					if (editorComponentProperty.name == componentPropertyValue.name)
					{
						bool = true;
						break;
					}
				}
				if (!bool)
				{
					component.componentValueList.addItem(editorComponentProperty.defaultValue);
				}
			}
		}
		/**
		 *混合组建值 
		 * @param component
		 * @param componentValueList
		 * 
		 */		
		public static function mix(component:IComponent, componentValueList:IComponentValueList):void
		{
			for each(var componentPropertyValue:IComponentPropertyValue in componentValueList.total)
			{
				var bool:Boolean = false;
				for each(var componentPropertyValue1:IComponentPropertyValue in component.componentValueList.total)
				{
					if (componentPropertyValue.name == componentPropertyValue1.name)
					{
						componentPropertyValue1.propertyValue = componentPropertyValue.propertyValue;
						bool = true;
						break;
					}
				}
				if (!bool)
				{
					component.componentValueList.addItem(componentPropertyValue);
				}
				component.entity[componentPropertyValue.name] = componentPropertyValue.propertyValue;
			}
		}
	}
}