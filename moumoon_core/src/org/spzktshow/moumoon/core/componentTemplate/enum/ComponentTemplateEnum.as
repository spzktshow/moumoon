package org.spzktshow.moumoon.core.componentTemplate.enum
{
	/**
	 *基本组件type类型的枚举 
	 * @author rocklee
	 * 
	 */	
	public class ComponentTemplateEnum
	{
		public function ComponentTemplateEnum()
		{
		}
		/**
		 *容器型组件模板 Sprite 
		 */		
		public static const CONTAINER:String = "componentTemplateEnumContainer";
		/**
		 *填充位图的组件模板 Image 
		 */		
		public static const IMAGE:String = "componentTemplateEnumImage";
		/**
		 *单色矩形 Quad 
		 */		
		public static const SHAPE:String = "componentTemplateEnumShape";
		/**
		 *自定义组件 
		 */		
		public static const CUSTOM:String = "componentTemplateEnumCustom";
	}
}