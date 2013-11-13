package org.spzktshow.moumoon.young.screen
{
	import feathers.controls.List;
	import feathers.controls.ScreenNavigator;
	import feathers.controls.ScreenNavigatorItem;
	import feathers.data.ListCollection;
	import feathers.skins.StandardIcons;
	
	import org.spzktshow.moumoon.young.menu.IMenuListContext;
	
	import starling.textures.Texture;

	public class MenuScreenFactory implements IMenuScreenFactory
	{
		public function MenuScreenFactory()
		{
		}
		
		public function create(menuListContext:IMenuListContext):ScreenNavigator
		{
			var screenN:ScreenNavigator = new ScreenNavigator;
			screenN.clipContent = true;
			roundScreenNavigatorItem(menuListContext, screenN);
			return screenN;
		}
		
		protected function roundScreenNavigatorItem(menuItemList:IMenuListContext, screenNavigator:ScreenNavigator):void
		{
			if (menuItemList.menuItems && menuItemList.menuItems.length > 0)
			{
				var list:List = new List;
				var listCollection:ListCollection = new ListCollection();
				var next:String = "";
				if (menuItemList.father)
				{
					listCollection.push({text:menuItemList.father.name, data:menuItemList.father});
				}
				for each(var item:IMenuListContext in menuItemList.menuItems)
				{
					roundScreenNavigatorItem(item, screenNavigator);
					listCollection.push({text:item.name, data:item});
				}
				list.dataProvider = listCollection;
				list.itemRendererProperties.labelField = "text";
				list.itemRendererProperties.accessorySourceFunction = accessorySourceFunction;
				var screenItem:ScreenNavigatorItem = new ScreenNavigatorItem(list);
				screenNavigator.addScreen(menuItemList.name, screenItem);
			}
		}
		
		private function accessorySourceFunction(item:Object):Texture
		{
			var menuListContext:IMenuListContext = item.data as IMenuListContext;
			if (menuListContext)
			{
				if (menuListContext.menuItems && menuListContext.menuItems.length > 0)
				{
					return StandardIcons.listDrillDownAccessoryTexture;
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