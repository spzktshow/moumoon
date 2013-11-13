package org.spzktshow.moumoon.sunshine.view.leftWorkGroup.ui
{
	import feathers.controls.Panel;
	import feathers.controls.PickerList;
	import feathers.controls.ScreenNavigator;
	import feathers.controls.ScreenNavigatorItem;
	import feathers.core.FeathersControl;
	import feathers.data.ListCollection;
	
	import org.spzktshow.moumoon.sunshine.core.ApplicationFacade;
	import org.spzktshow.moumoon.sunshine.view.componentPanel.mediator.ComponentPanelMediator;
	import org.spzktshow.moumoon.sunshine.view.sourcePanel.mediator.SourcePanelMediator;
	import org.spzktshow.moumoon.young.core.YoungControl;
	
	import starling.events.Event;

	/**
	 *左边的工作组，位于左边的界面封装在一个screen中 
	 * @author rocklee
	 * 
	 */	
	public class LeftWorkGroup extends YoungControl
	{
		/**
		 *资源面板遥控名称 
		 */		
		public static const NAV_ITEM_SOURCE:String = "source";
		/**
		 *组件面板遥控名称 
		 */		
		public static const NAV_ITEM_COMPONENT:String = "component";
		/**
		 *选择 
		 */		
		protected var _pickList:PickerList;
		/**
		 *屏幕 
		 */		
		protected var _screenNav:ScreenNavigator;
		/**
		 *资源面板 
		 */		
		protected var _sourcePanel:Panel;
		/**
		 *组件面板  
		 */		
		protected var _componentPanel:Panel;
		public function LeftWorkGroup()
		{
			super();
		}
		
		override public function dispose():void
		{
			super.dispose();
			ApplicationFacade.getInstance().removeMediator(SourcePanelMediator.NAME);
			ApplicationFacade.getInstance().removeMediator(ComponentPanelMediator.NAME);
		}
		
		override protected function initialize():void
		{
			_pickList = new PickerList;
			var listCollection:ListCollection = new ListCollection(
				[
				{text:NAV_ITEM_SOURCE},
				{text:NAV_ITEM_COMPONENT}
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
			
			_sourcePanel = new Panel;
			_sourcePanel.headerProperties.title = "source";
			var sourcePanelMediator:SourcePanelMediator = new SourcePanelMediator(_sourcePanel);
			ApplicationFacade.getInstance().registerMediator(sourcePanelMediator);
			
			_componentPanel = new Panel;
			_componentPanel.headerProperties.title = "component";
			var componentPanelMediator:ComponentPanelMediator = new ComponentPanelMediator(_componentPanel);
			ApplicationFacade.getInstance().registerMediator(componentPanelMediator);
			
			var sourceScreenNavItem:ScreenNavigatorItem = new ScreenNavigatorItem(_sourcePanel);
			_screenNav.addScreen(NAV_ITEM_SOURCE, sourceScreenNavItem);
			var componentScreenNavItem:ScreenNavigatorItem = new ScreenNavigatorItem(_componentPanel);
			_screenNav.addScreen(NAV_ITEM_COMPONENT, componentScreenNavItem);
			_screenNav.showScreen(NAV_ITEM_SOURCE);
			addChild(_pickList);
			
			super.initialize();
		}
		
		override protected function draw():void
		{
			const sizeChangeFlag:Boolean = this.isInvalid(FeathersControl.INVALIDATION_FLAG_SIZE);
			if (sizeChangeFlag)
			{
				//layout
				_sourcePanel.width = this.width;
				_sourcePanel.height = this.height;
				
				_componentPanel.width = this.width;
				_componentPanel.height = this.height;
				
				_screenNav.height = this.height;
				_screenNav.width = this.width;
				
				_pickList.y = 0;
				_pickList.x = 150;
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
					_screenNav.showScreen(NAV_ITEM_SOURCE);
				}
				else if (pickList.selectedIndex == 1)
				{
					_screenNav.showScreen(NAV_ITEM_COMPONENT);
				}
			}
		}
	}
}