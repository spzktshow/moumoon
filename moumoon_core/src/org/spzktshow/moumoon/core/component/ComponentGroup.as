package org.spzktshow.moumoon.core.component
{
	import org.spzktshow.moumoon.core.component.enum.ComponentEnum;
	import org.spzktshow.moumoon.core.group.Group;
	import org.spzktshow.moumoon.core.group.IGroupItem;

	/**
	 *组件小组 
	 * @author rocklee
	 * 
	 */	
	public class ComponentGroup extends Group implements IComponentGroup
	{
		protected var _entirety:IComponent;
		
		public function ComponentGroup()
		{
			super();
		}
		
		public function get entirety():IComponent
		{
			return _entirety;
		}
		
		override public function addItem(value:IGroupItem):int
		{
			var index:uint = super.addItem(value);
			var component:IComponent = value as IComponent;
			if (component.type == ComponentEnum.Entirety && index != -1)
			{
				_entirety = component;
			}
			return index;
		}
		
		override public function removeItem(name:String):IGroupItem
		{
			var component:IComponent = super.removeItem(name) as IComponent;
			if (component.name == _entirety.name)
			{
				_entirety = null;
			}
			return component;
		}
	}
}