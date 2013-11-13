package org.spzktshow.moumoon.core.componentTemplate.componetProperty
{
	import org.spzktshow.moumoon.core.componentTemplate.IComponentTemplate;

	/**
	 *组建属性工具 
	 * @author rocklee
	 * 
	 */	
	public class ComponentPropertyUtils
	{
		public function ComponentPropertyUtils()
		{
		}
		/**
		 *检测构造,返回一组构造参数列表 
		 * @param componentTemplate
		 * @return 
		 * 
		 */		
		public static function checkStructure(componentTemplate:IComponentTemplate):Vector.<IComponentProperty>
		{
			var list:Vector.<IComponentProperty> = new Vector.<IComponentProperty>;
			for each(var componentProperty:IComponentProperty in componentTemplate.componentPropertys)
			{
				if (componentProperty.isStructureDepend)
				{
					list.push(list);
				}
			}
			list.sort(
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
						throw new Error("错误的构造依赖索引");
					}
				}
			);
			return list;
		}
		
		
	}
}