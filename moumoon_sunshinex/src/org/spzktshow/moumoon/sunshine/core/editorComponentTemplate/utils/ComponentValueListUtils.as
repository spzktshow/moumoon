package org.spzktshow.moumoon.sunshine.core.editorComponentTemplate.utils
{
	import org.spzktshow.moumoon.core.componentValue.IComponentPropertyValue;
	import org.spzktshow.moumoon.core.componentValue.IComponentValueList;

	/**
	 *组件数值工具 
	 * @author rocklee
	 * 
	 */	
	public class ComponentValueListUtils
	{
		public function ComponentValueListUtils()
		{
		}
		/**
		 *获取组件属性值 
		 * @param componentValueList
		 * @param name
		 * @return 
		 * 
		 */		
		public static function getComponentPropertyValue(componentValueList:IComponentValueList, name:String):IComponentPropertyValue
		{
			for each(var componentPropertyValue:IComponentPropertyValue in componentValueList.total)
			{
				if (componentPropertyValue.name == name) return componentPropertyValue;
			}
			return null;
		}
	}
}