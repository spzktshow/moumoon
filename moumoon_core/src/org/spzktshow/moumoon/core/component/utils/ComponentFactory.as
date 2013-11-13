package org.spzktshow.moumoon.core.component.utils
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
		 *创建顶级的组件 
		 * @param name
		 * @return 
		 * 
		 */		
		public static function createEntirety(name:String):IComponent
		{
			var component:Component = new Component;
			component.type = ComponentEnum.Entirety;
			component.name = name;
			return component;
		}
		/**
		 *创建子级的组件 
		 * @param name
		 * @return 
		 * 
		 */		
		public static function createCell(name:String):IComponent
		{
			var component:Component = new Component;
			component.type == ComponentEnum.CELL;
			component.name = name;
			return component;
		}
		/**
		 *创建一个空组件 
		 * @param name
		 * @return 
		 * 
		 */		
		public static function createComponent(name:String):IComponent
		{
			var component:Component = new Component;
			return component;
		}
	}
}