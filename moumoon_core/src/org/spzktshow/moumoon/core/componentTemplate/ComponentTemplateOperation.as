package org.spzktshow.moumoon.core.componentTemplate
{
	import org.spzktshow.moumoon.core.group.Group;
	import org.spzktshow.moumoon.core.group.IGroupItem;
	
	public class ComponentTemplateOperation extends Group implements IComponentTemplateOperation
	{
		public function ComponentTemplateOperation()
		{
			super();
		}
		
		public function get componentTemplates():Vector.<IGroupItem>
		{
			return _items;
		}
	}
}