package org.spzktshow.moumoon.core.component.factory
{
	import org.spzktshow.moumoon.core.component.Component;
	import org.spzktshow.moumoon.core.component.IComponent;
	import org.spzktshow.moumoon.core.component.enum.ComponentEnum;

	public class ComponentFactory
	{
		public function ComponentFactory()
		{
		}
		/**
		 *创建父级组件 
		 * @param name
		 * @return 
		 * 
		 */		
		public static function createFatherComponent(name:String):IComponent
		{
			var component:Component = new Component;
			component.children = new Vector.<IComponent>;
			component.name = name;
			component.type = ComponentEnum.Entirety;
			return component;
		}
		/**
		 *创建普通组件 
		 * @param name
		 * @return 
		 * 
		 */		
		public static function createNormalComponent(name:String):IComponent
		{
			var component:Component = new Component;
			component.children = new Vector.<IComponent>;
			component.name = name;
			component.type = ComponentEnum.CELL;
			return component;
		}
	}
}