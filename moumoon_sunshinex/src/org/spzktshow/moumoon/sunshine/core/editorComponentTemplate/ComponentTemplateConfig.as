package org.spzktshow.moumoon.sunshine.core.editorComponentTemplate
{
	import flash.net.getClassByAlias;
	
	import avmplus.getQualifiedClassName;
	
	import org.spzktshow.moumoon.core.componentTemplate.ComponentTemplate;
	import org.spzktshow.moumoon.core.componentTemplate.ComponentTemplateOperation;
	import org.spzktshow.moumoon.core.componentTemplate.componetProperty.IComponentProperty;
	import org.spzktshow.moumoon.core.componentTemplate.enum.ComponentPropertyEnum;
	import org.spzktshow.moumoon.core.componentTemplate.enum.ComponentTemplateEnum;
	import org.spzktshow.moumoon.core.componentValue.ComponentPropertyValue;
	import org.spzktshow.moumoon.sunshine.core.componentInput.ComponentInputConfig;
	import org.spzktshow.moumoon.sunshine.core.componentInput.ComponentInputEnum;
	
	import starling.display.Image;
	import starling.display.Sprite;

	/**
	 *组件模板配置表 
	 * @author rocklee
	 * 
	 */	
	public class ComponentTemplateConfig extends ComponentTemplateOperation
	{
		private static var _instance:ComponentTemplateConfig;
		
		public static function getInstance():ComponentTemplateConfig
		{
			if (!_instance)
			{
				_instance = new ComponentTemplateConfig;
			}
			return _instance;
		}
		
		public function ComponentTemplateConfig()
		{
			initData();
		}
		
		private function initData():void
		{
			//image
			var componentTemplate:ComponentTemplate = new ComponentTemplate;
			componentTemplate.componentTemplateType = ComponentTemplateEnum.IMAGE;
			componentTemplate.name = ComponentTemplateEnum.IMAGE;
			componentTemplate.componentTotalName = getQualifiedClassName(Image);
			//x,y,texture
			var list:Vector.<IComponentProperty> = new Vector.<IComponentProperty>;
			var cp:EditorComponentProperty = new EditorComponentProperty;
			cp.name = ComponentPropertyEnum.X;
			cp.isStructureDepend = false;
			cp.input = ComponentInputConfig.getInstance().getComponentInput(ComponentInputEnum.TEXT_INPUT);
			var defaultPropertyValue:ComponentPropertyValue = new ComponentPropertyValue;
			defaultPropertyValue.name = cp.name;
			defaultPropertyValue.propertyValue = 0;
			cp.defaultValue = defaultPropertyValue;
			list.push(cp);
			cp = new EditorComponentProperty;
			cp.name = ComponentPropertyEnum.Y;
			cp.isStructureDepend = false;
			cp.input = ComponentInputConfig.getInstance().getComponentInput(ComponentInputEnum.TEXT_INPUT);
			defaultPropertyValue = new ComponentPropertyValue;
			defaultPropertyValue.name = cp.name;
			defaultPropertyValue.propertyValue = 0;
			cp.defaultValue = defaultPropertyValue;
			list.push(cp);
			cp = new EditorComponentProperty;
			cp.name = ComponentPropertyEnum.TEXTURE;
			cp.isStructureDepend = true;
			cp.structureDependIndex = 0;
			cp.isDispensable = false;
			cp.input = ComponentInputConfig.getInstance().getComponentInput(ComponentInputEnum.TEXTURE);
			defaultPropertyValue = new ComponentPropertyValue;
			defaultPropertyValue.name = cp.name;
			defaultPropertyValue.propertyValue = null;
			cp.defaultValue = defaultPropertyValue;
			list.push(cp);
			componentTemplate.componentPropertys = list;
			addItem(componentTemplate);
			
			//container
			componentTemplate = new ComponentTemplate;
			componentTemplate.componentTemplateType = ComponentTemplateEnum.CONTAINER;
			componentTemplate.name = ComponentTemplateEnum.CONTAINER;
			componentTemplate.componentTotalName = getQualifiedClassName(Sprite);
			//x,y
			list = new Vector.<IComponentProperty>;
			cp = new EditorComponentProperty;
			cp.name = ComponentPropertyEnum.X;
			cp.isStructureDepend = false;
			cp.input = ComponentInputConfig.getInstance().getComponentInput(ComponentInputEnum.TEXT_INPUT);
			defaultPropertyValue = new ComponentPropertyValue;
			defaultPropertyValue.name = cp.name;
			defaultPropertyValue.propertyValue = 0;
			cp.defaultValue = defaultPropertyValue;
			list.push(cp);
			cp = new EditorComponentProperty;
			cp.name = ComponentPropertyEnum.Y;
			cp.isStructureDepend = false;
			cp.input = ComponentInputConfig.getInstance().getComponentInput(ComponentInputEnum.TEXT_INPUT);
			defaultPropertyValue = new ComponentPropertyValue;
			defaultPropertyValue.name = cp.name;
			defaultPropertyValue.propertyValue = 0;
			cp.defaultValue = defaultPropertyValue;
			list.push(cp);
			componentTemplate.componentPropertys = list;
			addItem(componentTemplate);
		}
	}
}