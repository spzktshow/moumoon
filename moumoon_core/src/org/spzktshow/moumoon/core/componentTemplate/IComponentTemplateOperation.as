package org.spzktshow.moumoon.core.componentTemplate
{
	import org.spzktshow.moumoon.core.group.IGroup;
	import org.spzktshow.moumoon.core.group.IGroupItem;

	public interface IComponentTemplateOperation extends IGroup
	{
		/**
		 *获取组件模板列表 
		 * @return 
		 * 
		 */		
		function get componentTemplates():Vector.<IGroupItem>;
	}
}