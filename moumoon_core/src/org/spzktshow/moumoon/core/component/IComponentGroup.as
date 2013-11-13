package org.spzktshow.moumoon.core.component
{
	import org.spzktshow.moumoon.core.group.IGroup;
	/**
	 *组件小组 
	 * @author rocklee
	 * 
	 */	
	public interface IComponentGroup extends IGroup
	{
		/**
		 *顶级 
		 * @param value
		 * 
		 */
		function get entirety():IComponent;
	}
}