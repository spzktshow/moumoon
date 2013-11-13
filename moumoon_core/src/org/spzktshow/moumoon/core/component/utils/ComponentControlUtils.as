package org.spzktshow.moumoon.core.component.utils
{
	import org.spzktshow.moumoon.core.component.IComponent;
	import org.spzktshow.moumoon.core.component.IComponentGroup;
	
	import starling.display.DisplayObject;
	import starling.display.DisplayObjectContainer;

	public class ComponentControlUtils
	{
		public function ComponentControlUtils()
		{
		}
		/**
		 *获取组件名称 
		 * @param componentGroup
		 * @param name
		 * @return 
		 * 
		 */		
		public static function getComponentByName(componentGroup:IComponentGroup, name:String):IComponent
		{
			return componentGroup.getItem(name) as IComponent;
		}
		/**
		 *获取子组件 
		 * @param componentGroup
		 * @param parent
		 * @param name
		 * @return 
		 * 
		 */		
		public static function getChildByName(componentGroup:IComponentGroup, parent:IComponent, name:String):IComponent
		{
			if (parent.entity is DisplayObjectContainer)
			{
				var displayObject:DisplayObject = DisplayObjectContainer(parent.entity).getChildByName(name);
				if (displayObject)
				{
					return getComponentByName(componentGroup, displayObject.name);
				}
			}
			return null;
		}
		/**
		 *根据名字获取组件在父级中的索引 
		 * @param parent
		 * @param name
		 * @return 
		 * 
		 */	
		public static function getChildIndexByName(componentGroup:IComponentGroup, parent:IComponent, name:String):int
		{
			if (parent.entity is DisplayObjectContainer)
			{
				var displayObject:DisplayObject = DisplayObjectContainer(parent.entity).getChildByName(name);
				if (displayObject)
				{
					return DisplayObjectContainer(parent.entity).getChildIndex(displayObject);
				}
			}
			return -1;
		}
		
		//add
		/**
		 *给定父级组件，子组件，为子组件添加组件 
		 * @param component
		 * @param parent
		 * @return 
		 * 
		 */		
		public static function addChild(componentGroup:IComponentGroup, component:IComponent, parent:IComponent):IComponent
		{
			if (parent.entity is DisplayObjectContainer)
			{
				var tempComponent:IComponent = getChildByName(componentGroup, parent, component.name);
				if (tempComponent) return tempComponent;
				DisplayObjectContainer(parent.entity).addChild(component.entity);//displaylist operation
				componentGroup.addItem(component);//group operation
				return component;
			}
			return null;
		}
		/**
		 *给定父级组件，子组件，索引 
		 * @param component
		 * @param index
		 * @param parent
		 * @return 
		 * 
		 */
		public static function addChildAt(componentGroup:IComponentGroup, component:IComponent, parent:IComponent, index:uint):int
		{
			if (parent.entity is DisplayObjectContainer)
			{
				var i:int = getChildIndexByName(componentGroup, parent, component.name);
				if (i != -1) return i;
				DisplayObjectContainer(parent.entity).addChildAt(component.entity, index);//displaylist operation
				componentGroup.addItem(component);//group operation
				return index;
			}
			return -1;
		}
		/**
		 *移除子组件 
		 * @param componentGroup
		 * @param component
		 * @return 
		 * 
		 */		
		public static function removeChild(componentGroup:IComponentGroup, component:IComponent):IComponent
		{
			if (component.entity.parent)
			{
				componentGroup.removeItem(component.name);
				component.entity.parent.removeChild(component.entity);
				return component;
			}
			return null;
		}
	}
}