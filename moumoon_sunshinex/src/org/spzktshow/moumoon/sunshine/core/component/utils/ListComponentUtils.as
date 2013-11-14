package org.spzktshow.moumoon.sunshine.core.component.utils
{
	import org.spzktshow.moumoon.core.component.IComponentGroup;
	import org.spzktshow.moumoon.sunshine.core.component.IListComponent;
	
	import starling.display.DisplayObjectContainer;

	public class ListComponentUtils
	{
		public function ListComponentUtils()
		{
		}
		/**
		 *检测父级的组件中是否有组件已经锁定 
		 * @param listComponent
		 * @return 
		 * 
		 */		
		public static function checkTopLock(listComponent:IListComponent):IListComponent
		{
			if (listComponent.isLock) return listComponent;
			while(listComponent.parent)
			{
				listComponent = listComponent.parent as IListComponent;
				if (listComponent.isLock) return listComponent;
			}
			return null;
		}
		/**
		 *检测父级的组件中是否有组件已经显示 
		 * @param listComponent
		 * @return 
		 * 
		 */		
		public static function checkTopUnView(listComponent:IListComponent):IListComponent
		{
			if (!listComponent.isView) return listComponent;
			while(listComponent.parent)
			{
				listComponent = listComponent.parent as IListComponent;
				if (!listComponent.isView) return listComponent;
			}
			return null;
		}
		/**
		 *从当前组件开始检查是否是容器类组件 
		 * @param listComponent
		 * @return 
		 * 
		 */		
		public static function checkContainerComponent(componentGroup:IComponentGroup, listComponent:IListComponent):IListComponent
		{
			while(listComponent)
			{
				if (listComponent.entity is DisplayObjectContainer)
				{
					return listComponent;
				}
				if (listComponent.entity.parent)
				{
					listComponent = componentGroup.getItem(listComponent.entity.parent.name) as IListComponent;
				}
				else
				{
					return null;
				}
			}
			return null;
		}
	}
}