package org.spzktshow.moumoon.sunshine.core.component.utils
{
	import org.spzktshow.moumoon.sunshine.core.component.IListComponent;
	import org.spzktshow.moumoon.sunshine.core.component.ListComponent;

	public class ListComponentFactory
	{
		public function ListComponentFactory()
		{
		}
		/**
		 *创建一个listComponent 
		 * @param name
		 * @return 
		 * 
		 */		
		public static function createComponent(name:String):IListComponent
		{
			var component:ListComponent = new ListComponent;
			component.name = name;
			return component;
		}
	}
}