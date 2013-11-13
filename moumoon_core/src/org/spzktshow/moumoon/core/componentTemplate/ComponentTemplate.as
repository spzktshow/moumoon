package org.spzktshow.moumoon.core.componentTemplate
{
	import org.spzktshow.moumoon.core.componentTemplate.componetProperty.IComponentProperty;
	import org.spzktshow.moumoon.core.group.GroupItem;

	public class ComponentTemplate extends GroupItem implements IComponentTemplate
	{
		private var _componentTemplateType:String;
		
		private var _componentPropertys:Vector.<IComponentProperty>;
		
		private var _componentTotalName:String;
		
		public function ComponentTemplate()
		{
			_componentPropertys = new Vector.<IComponentProperty>;
		}
		
		public function get componentTemplateType():String
		{
			return _componentTemplateType;
		}
		
		public function set componentTemplateType(value:String):void
		{
			_componentTemplateType = value;
		}
		
		public function set componentPropertys(value:Vector.<IComponentProperty>):void
		{
			_componentPropertys = value;
		}
		
		public function get componentPropertys():Vector.<IComponentProperty>
		{
			return _componentPropertys;
		}
		
		public function set componentTotalName(value:String):void
		{
			_componentTotalName = value;
		}
		
		public function get componentTotalName():String
		{
			return _componentTotalName;
		}
	}
}