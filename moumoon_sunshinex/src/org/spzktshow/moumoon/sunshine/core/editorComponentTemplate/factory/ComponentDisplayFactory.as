package org.spzktshow.moumoon.sunshine.core.editorComponentTemplate.factory
{
	import flash.utils.getDefinitionByName;
	
	import org.spzktshow.moumoon.core.component.IComponent;
	import org.spzktshow.moumoon.core.componentTemplate.IComponentTemplate;
	import org.spzktshow.moumoon.core.componentTemplate.componetProperty.IComponentProperty;
	import org.spzktshow.moumoon.core.componentTemplate.enum.ComponentTemplateEnum;
	import org.spzktshow.moumoon.core.componentValue.IComponentPropertyValue;
	import org.spzktshow.moumoon.sunshine.core.component.IListComponent;
	
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Sprite;

	/**
	 *显示层工厂 
	 * @author rocklee
	 * 
	 */
	public class ComponentDisplayFactory
	{
		public function ComponentDisplayFactory()
		{
		}
		
		public static function create(componentTemplate:IComponentTemplate):DisplayObject
		{
			if (componentTemplate.componentTemplateType == ComponentTemplateEnum.CONTAINER)
			{
				return new Sprite;
			}
			else if (componentTemplate.componentTemplateType == ComponentTemplateEnum.IMAGE)
			{
				var image:Image = new Image(componentTemplate.source.data);
				return image;
			}
			return null;
		}
		/**
		 *根据组建创建 
		 * @param component
		 * @return 
		 * 
		 */		
		public static function createComponent(component:IComponent):DisplayObject
		{
			var d:Class = getDefinitionByName(component.componentTemplate.componentTotalName) as Class;
			var structurePropertys:Vector.<IComponentProperty> = new Vector.<IComponentProperty>;
			//组合出构造需要的参数
			for each(var componentProperty:IComponentProperty in component.componentTemplate.componentPropertys)
			{
				if (componentProperty.isStructureDepend)
				{
					structurePropertys.push(componentProperty);
				}
			}	
			//排序出参数列表
			structurePropertys.sort(
				function (a:IComponentProperty, b:IComponentProperty):int
				{
					if (a.structureDependIndex > b.structureDependIndex)
					{
						return 1;
					}
					else if (a.structureDependIndex < b.structureDependIndex)
					{
						return -1;
					}
					else
					{
						throw new Error("错误的参数相同索引值");
					}
				}
			);
			var structurePropertsValues:Vector.<IComponentPropertyValue> = new Vector.<IComponentPropertyValue>;
			for each(componentProperty in structurePropertys)
			{
				var componentPropertyValue:IComponentPropertyValue = component.componentValueList.getItem(componentProperty.name) as IComponentPropertyValue;
				if (!componentPropertyValue && !componentProperty.isDispensable)
				{
					throw new Error("无法在参数数据列表中找到必要的构造函数参数值");
				}
				else if (!componentPropertyValue && componentProperty.isDispensable)
				{
					throw new Error("无法在参数数据列表中找到非必要的构造函数参数值");
				}
				else
				{
					structurePropertsValues.push(componentPropertyValue);
				}
			}
			//暂时定为参数为5位
			var returnObject:DisplayObject;
			if (structurePropertys.length == 0)
			{
				returnObject = new d();
			}
			else if (structurePropertys.length == 1)
			{
				returnObject = new d(structurePropertsValues[0].propertyValue);
			}
			else if (structurePropertys.length == 2)
			{
				returnObject = new d(structurePropertsValues[0].propertyValue, structurePropertsValues[1].propertyValue);
			}
			else if (structurePropertys.length == 3)
			{
				returnObject = new d(structurePropertsValues[0].propertyValue, structurePropertsValues[1].propertyValue, structurePropertsValues[2].propertyValue);
			}
			else if (structurePropertys.length == 4)
			{
				returnObject = new d(structurePropertsValues[0].propertyValue, structurePropertsValues[1].propertyValue, structurePropertsValues[2].propertyValue, structurePropertsValues[3].propertyValue);
			}
			else if (structurePropertys.length == 5)
			{
				returnObject = new d(structurePropertsValues[0].propertyValue, structurePropertsValues[1].propertyValue, structurePropertsValues[2].propertyValue, structurePropertsValues[3].propertyValue, structurePropertsValues[4].propertyValue);
			}
			else if (structurePropertys.length == 6)
			{
				returnObject = new d(structurePropertsValues[0].propertyValue, structurePropertsValues[1].propertyValue, structurePropertsValues[2].propertyValue, structurePropertsValues[3].propertyValue, structurePropertsValues[4].propertyValue, structurePropertsValues[5].propertyValue);
			}
			else
			{
				throw new Error("构造参数长度超出预估,请联系作者");
			}
			
			filterComponent(component, returnObject);
			returnObject.name = component.name;
			return returnObject as DisplayObject;
		}
		/**
		 *将属性赋值到显示实体上 
		 * @param component
		 * 
		 */		
		public static function filterComponent(component:IComponent, displayObject:DisplayObject):void
		{
			//赋值需要的参数
			for each(var componentProperty:IComponentProperty in component.componentTemplate.componentPropertys)
			{
				if (!componentProperty.isStructureDepend)
				{
					var componentPropertyValue:IComponentPropertyValue = component.componentValueList.getItem(componentProperty.name) as IComponentPropertyValue;
					displayObject[componentProperty.name] = componentPropertyValue.propertyValue;
				}
			}
		}
		/**
		 *将ListComponent的属性赋值到displayObject 
		 * @param component
		 * @param displayObject
		 * 
		 */		
		public static function filterListComponent(component:IListComponent, displayObject:DisplayObject):void
		{
			displayObject.visible = component.isView;
		}
		
		public static function createAuto(componentTemplate:IComponentTemplate):DisplayObject
		{
			return null;
		}
	}
}