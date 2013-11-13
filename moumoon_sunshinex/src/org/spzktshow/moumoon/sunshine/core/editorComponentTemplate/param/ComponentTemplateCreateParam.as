package org.spzktshow.moumoon.sunshine.core.editorComponentTemplate.param
{
	import org.spzktshow.moumoon.core.source.ISource;
	
	/**
	 *创建模板的参数 
	 * @author rocklee
	 * 
	 */
	public class ComponentTemplateCreateParam
	{
		public function ComponentTemplateCreateParam()
		{
		}
		/**
		 *模板类型 
		 */		
		public var templateType:String;
		/**
		 *资源 
		 */		
		public var source:ISource;
	}
}