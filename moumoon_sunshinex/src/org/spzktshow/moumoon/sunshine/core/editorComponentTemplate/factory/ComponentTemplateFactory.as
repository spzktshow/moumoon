package org.spzktshow.moumoon.sunshine.core.editorComponentTemplate.factory
{
	import org.spzktshow.moumoon.core.componentTemplate.IComponentTemplate;
	import org.spzktshow.moumoon.sunshine.core.editorComponentTemplate.ComponentTemplateConfig;

	/**
	 *组件模板工厂 
	 * @author rocklee
	 * 
	 */
	public class ComponentTemplateFactory
	{
		public function ComponentTemplateFactory()
		{
		}
		
		public static function create(templateType:String):IComponentTemplate
		{
			return ComponentTemplateConfig.getInstance().getItem(templateType) as IComponentTemplate;
		}
	}
}