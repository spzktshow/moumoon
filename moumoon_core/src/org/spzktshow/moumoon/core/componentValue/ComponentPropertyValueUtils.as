package org.spzktshow.moumoon.core.componentValue
{
	/**
	 *组件属性值工具 
	 * @author rocklee
	 * 
	 */	
	public class ComponentPropertyValueUtils
	{
		/**
		 *检测是否拥有属性
		 *  
		 * @param propertyType
		 * @param componentValueList
		 * @return 
		 * 
		 */		
		public static function checkHasProperty(propertyType:String, componentValueList:IComponentValueList):Boolean
		{
			for each(var componentPropertyValue:IComponentPropertyValue in componentValueList.total)
			{
				if (componentPropertyValue.name == propertyType)
				{
					return true;
				}
			}
			return false;
		}
		
		public function ComponentPropertyValueUtils()
		{
		}
	}
}