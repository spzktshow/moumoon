package org.spzktshow.moumoon.sunshine.view.rightWorkGroup.ui
{
	import feathers.controls.Panel;
	import feathers.controls.PickerList;
	import feathers.controls.ScreenNavigator;
	import feathers.controls.ScreenNavigatorItem;
	import feathers.core.FeathersControl;
	import feathers.data.ListCollection;
	
	import org.spzktshow.moumoon.sunshine.core.ApplicationFacade;
	import org.spzktshow.moumoon.sunshine.view.componentPropertyPanel.mediator.ComponentPropertyPanelMediator;
	import org.spzktshow.moumoon.sunshine.view.displayList.mediator.DisplayListMediator;
	import org.spzktshow.moumoon.young.core.YoungControl;
	
	import starling.events.Event;
	
	public class RightWorkGroup extends YoungControl
	{
		/**
		 *组件列表 
		 */		
		public static const NAV_ITEM_DISPLAY_LIST:String = "displayList";
		/**
		 *组件属性 
		 */		
		public static const NAV_ITEM_COMPONENT_PROPERTY:String = "componentProperty";
		/**
		 *选择 
		 */		
		protected var _pickList:PickerList;
		/**
		 *屏幕 
		 */		
		protected var _screenNav:ScreenNavigator;
		/**
		 *显示列表 
		 */		
		protected var _displayList:Panel;
		/**
		 *组件属性 
		 */		
		protected var _componentProperty:Panel;
		
		public function RightWorkGroup()
		{
			super();
		}
		
		override public function dispose():void
		{
			super.dispose();
			ApplicationFacade.getInstance().removeMediator(DisplayListMediator.NAME);
			ApplicationFacade.getInstance().removeMediator(ComponentPropertyPanelMediator.NAME);
		}
		
		override protected function initialize():void
		{
			_pickList = new PickerList;
			var listCollection:ListCollection = new ListCollection(
				[
					{text:NAV_ITEM_DISPLAY_LIST},
					{text:NAV_ITEM_COMPONENT_PROPERTY}
				]
				);
			_pickList.dataProvider = listCollection;
			_pickList.labelField = "text";
			_pickList.prompt = "Select an Item";
			_pickList.selectedIndex = 0;
			_pickList.listProperties.@itemRendererProperties.labelField = "text";
			
			_screenNav = new ScreenNavigator;
			_screenNav.clipContent = true;
			addChild(_screenNav);
			
			_displayList = new Panel;
			_displayList.headerProperties.title = "displayList";
			var displayListMediator:DisplayListMediator = new DisplayListMediator(_displayList);
			ApplicationFacade.getInstance().registerMediator(displayListMediator);
			
			_componentProperty = new Panel;
			_componentProperty.headerProperties.title = "componentProperty";
			var componentPropertyPanelMediator:ComponentPropertyPanelMediator = new ComponentPropertyPanelMediator(_componentProperty);
			ApplicationFacade.getInstance().registerMediator(componentPropertyPanelMediator);
			
			var screenNavItem:ScreenNavigatorItem = new ScreenNavigatorItem(_displayList);
			_screenNav.addScreen(NAV_ITEM_DISPLAY_LIST, screenNavItem);
			screenNavItem = new ScreenNavigatorItem(_componentProperty);
			_screenNav.addScreen(NAV_ITEM_COMPONENT_PROPERTY, screenNavItem);
			_screenNav.showScreen(NAV_ITEM_DISPLAY_LIST);
			addChild(_pickList);
			
			super.initialize();
		}
		
		override protected function draw():void
		{
			const sizeChangeFlag:Boolean = this.isInvalid(FeathersControl.INVALIDATION_FLAG_SIZE);
			if (sizeChangeFlag)
			{
				//layout
				_displayList.width = this.width;
				_displayList.height = this.height;
				
				_componentProperty.width = this.width;
				_componentProperty.height = this.height;
				
				_screenNav.height = this.height;
				_screenNav.width = this.width;
				
				_pickList.y = 0;
				_pickList.x = -70;
			}
			
			super.draw();
		}
		
		override protected function addListeners():void
		{
			super.addListeners();
			_pickList.addEventListener(Event.CHANGE, onListSelectChangeHandler);
		}
		
		override protected function removeListeners():void
		{
			_pickList.removeEventListener(Event.CHANGE, onListSelectChangeHandler);
			super.removeListeners();
		}
		
		protected function onListSelectChangeHandler(e:Event):void
		{
			var pickList:PickerList = e.currentTarget as PickerList;
			if (pickList.selectedIndex >= 0)
			{
				if (pickList.selectedIndex == 0)
				{
					_screenNav.showScreen(NAV_ITEM_DISPLAY_LIST);
				}
				else if (pickList.selectedIndex == 1)
				{
					_screenNav.showScreen(NAV_ITEM_COMPONENT_PROPERTY);
				}
			}
		}
	}
}