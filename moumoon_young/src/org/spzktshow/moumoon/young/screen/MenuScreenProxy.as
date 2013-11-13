package org.spzktshow.moumoon.young.screen
{
	
	import feathers.controls.List;
	import feathers.controls.ScreenNavigator;
	import feathers.controls.ScreenNavigatorItem;
	
	import org.spzktshow.moumoon.young.menu.IMenuListContext;
	import org.spzktshow.moumoon.young.proxy.FeatherControlProxy;
	
	import starling.events.Event;
	
	public class MenuScreenProxy extends FeatherControlProxy
	{	
		protected var _screenNavigatorItems:Vector.<ScreenNavigatorItem>;
		
		public function MenuScreenProxy(screenNavigator:ScreenNavigator)
		{
			super(screenNavigator);
		}
		
		public function showScreen(id:String):void
		{
			var navigatorItem:ScreenNavigatorItem = screenNavigator.getScreen(id) as ScreenNavigatorItem;
			var list:List = navigatorItem.screen as List;
			list.selectedIndex = -1;
			screenNavigator.showScreen(id);
		}
		
		override protected function createUI():void
		{
			_screenNavigatorItems = new Vector.<ScreenNavigatorItem>;
			var ids:Vector.<String> = this.screenNavigator.getScreenIDs();
			for each(var id:String in ids)
			{
				_screenNavigatorItems.push(this.screenNavigator.getScreen(id));
			}
		}
		
		override protected function disposeUI():void
		{
			_screenNavigatorItems = null;
		}
		
		override protected function addListeners():void
		{
			for each(var item:ScreenNavigatorItem in _screenNavigatorItems)
			{
				var list:List = item.screen as List;
				list.addEventListener(Event.CHANGE, onListSelectChangeHandler);
			}
		}
		
		override protected function removeListeners():void
		{
			for each(var item:ScreenNavigatorItem in _screenNavigatorItems)
			{
				var list:List = item.screen as List;
				list.removeEventListener(Event.CHANGE, onListSelectChangeHandler);
			}
		}
		
		protected function onListSelectChangeHandler(e:Event):void
		{
			var list:List = e.currentTarget as List;
			if (list.selectedIndex >= 0)
			{
				var item:Object = list.selectedItem;
				if (item.data)
				{
					var menuScreenEvent:MenuScreenEvent;
					var menuListContext:IMenuListContext = IMenuListContext(item.data);
					if (menuListContext.menuItems && menuListContext.menuItems.length > 0)
					{
						//screenNavigator.showScreen(menuListContext.name);
						this.showScreen(menuListContext.name);
						
						menuScreenEvent = new MenuScreenEvent(MenuScreenEvent.TRANSTION_LIST);
						menuScreenEvent.menuListContext = menuListContext;
						screenNavigator.dispatchEvent(menuScreenEvent);
					}
					else
					{
						menuScreenEvent = new MenuScreenEvent(MenuScreenEvent.SELECT_ITEM, true);
						menuScreenEvent.menuListContext = menuListContext;
						screenNavigator.dispatchEvent(menuScreenEvent);
					}
				}
			}
		}
		
		public function get screenNavigator():ScreenNavigator
		{
			return this._featherControl as ScreenNavigator;
		}
	}
}