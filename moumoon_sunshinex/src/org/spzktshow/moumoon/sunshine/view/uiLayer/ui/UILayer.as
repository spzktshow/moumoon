package org.spzktshow.moumoon.sunshine.view.uiLayer.ui
{
	import feathers.controls.Panel;
	import feathers.core.FeathersControl;
	
	import org.spzktshow.moumoon.sunshine.core.ApplicationFacade;
	import org.spzktshow.moumoon.sunshine.view.displayLayer.mediator.DisplayerLayerMediator;
	import org.spzktshow.moumoon.sunshine.view.displayLayer.mediator.FocusPointLayerMediator;
	import org.spzktshow.moumoon.sunshine.view.displayLayer.mediator.UnFocusDisplayLayerMediator;
	import org.spzktshow.moumoon.sunshine.view.displayLayer.ui.DisplayLayer;
	import org.spzktshow.moumoon.sunshine.view.displayLayer.ui.FocusPointLayer;
	import org.spzktshow.moumoon.sunshine.view.displayLayer.ui.UnFocusDisplayLayer;
	import org.spzktshow.moumoon.sunshine.view.displayList.mediator.DisplayListMediator;
	import org.spzktshow.moumoon.sunshine.view.fileBar.mediator.FileBarMediator;
	import org.spzktshow.moumoon.sunshine.view.fileBar.ui.FileBar;
	import org.spzktshow.moumoon.sunshine.view.floatLayer.mediator.FloatlayerMediator;
	import org.spzktshow.moumoon.sunshine.view.floatLayer.ui.FloatLayer;
	import org.spzktshow.moumoon.sunshine.view.leftWorkGroup.mediator.LeftWorkGroupMediator;
	import org.spzktshow.moumoon.sunshine.view.leftWorkGroup.ui.LeftWorkGroup;
	import org.spzktshow.moumoon.sunshine.view.menu.mediator.FeatureMenuMediator;
	import org.spzktshow.moumoon.sunshine.view.menu.ui.FeatureMenu;
	import org.spzktshow.moumoon.sunshine.view.rightWorkGroup.mediator.RightWorkGroupMediator;
	import org.spzktshow.moumoon.sunshine.view.rightWorkGroup.ui.RightWorkGroup;
	import org.spzktshow.moumoon.young.core.YoungControl;
	import org.spzktshow.moumoon.young.menu.IMenuListContext;
	import org.spzktshow.moumoon.young.menu.MenuListContext;
	
	public class UILayer extends YoungControl
	{
		private static const MENU_ITEM_META:String = "menuItem";
		
		private var _featureXML:XML = <featureMenu>
			<menuItem name='file'>
				<menuItem name='new' data='1001'/>
				<menuItem name='open' data = '1002'/>
			</menuItem>
			<menuItem name='editor' data='2001'>
			</menuItem>
		</featureMenu>
		/**
		 *工具菜单 
		 */		
		private var _featureMenu:FeatureMenu;
		/**
		 *文件tabBar 
		 */		
		private var _fileBar:FileBar;
		
		private var _leftWorkGroup:LeftWorkGroup;
		
		private var _rightWorkGroup:RightWorkGroup;
		/**
		 *浮动层 
		 */		
		private var _floatLayer:FloatLayer;
		/**
		 * 焦点显示层
		 * */
		private var _focusPointLayer:FocusPointLayer;
		/**
		 *显示层 
		 */		
		private var _displayLayer:DisplayLayer;
		/**
		 *未焦点的显示层 
		 */		
		private var _unFocusDisplayLayer:UnFocusDisplayLayer;
		
		public function UILayer()
		{
			super();
		}
		
		override public function dispose():void
		{
			super.dispose();
			ApplicationFacade.getInstance().removeMediator(FeatureMenuMediator.NAME);
			ApplicationFacade.getInstance().removeMediator(FileBarMediator.NAME);
			ApplicationFacade.getInstance().removeMediator(LeftWorkGroupMediator.NAME);
			ApplicationFacade.getInstance().removeMediator(FocusPointLayerMediator.NAME);
			ApplicationFacade.getInstance().removeMediator(UnFocusDisplayLayerMediator.NAME);
			ApplicationFacade.getInstance().removeMediator(FileBarMediator.NAME);
			ApplicationFacade.getInstance().removeMediator(RightWorkGroupMediator.NAME);
			ApplicationFacade.getInstance().removeMediator(FloatlayerMediator.NAME);
		}
		
		override protected function initialize():void
		{
			_unFocusDisplayLayer = new UnFocusDisplayLayer;
			addChild(_unFocusDisplayLayer);
			var unFocusDisplayLayerMedaitor:UnFocusDisplayLayerMediator = new UnFocusDisplayLayerMediator(_unFocusDisplayLayer);
			ApplicationFacade.getInstance().registerMediator(unFocusDisplayLayerMedaitor);
			
			_displayLayer = new DisplayLayer;
			addChild(_displayLayer);
			var displayLayerMediator:DisplayerLayerMediator = new DisplayerLayerMediator(_displayLayer);
			ApplicationFacade.getInstance().registerMediator(displayLayerMediator);
			
			_leftWorkGroup = new LeftWorkGroup;
			_leftWorkGroup.width = 200;
			addChild(_leftWorkGroup);
			var leftWorkGroupMediator:LeftWorkGroupMediator = new LeftWorkGroupMediator(_leftWorkGroup);
			ApplicationFacade.getInstance().registerMediator(leftWorkGroupMediator);
			
			//build data
			var menuListContext:MenuListContext = buildData();
			_featureMenu = new FeatureMenu(menuListContext);
			addChild(_featureMenu);
			_featureMenu.width = 200;
			
			var featureMenuMeidator:FeatureMenuMediator = new FeatureMenuMediator(_featureMenu);
			ApplicationFacade.getInstance().registerMediator(featureMenuMeidator);
			
			_fileBar = new FileBar();
			_fileBar.width = stage.width - 200;
			_fileBar.height = 35;
			addChild(_fileBar);
			
			var fileBarMediator:FileBarMediator = new FileBarMediator(_fileBar);
			ApplicationFacade.getInstance().registerMediator(fileBarMediator);
			
//			_displayList = new Panel;
//			_displayList.width = 300;
//			_displayList.headerProperties.title = "displayList";
//			addChild(_displayList);
//			var displayListMediator:DisplayListMediator = new DisplayListMediator(_displayList);
//			ApplicationFacade.getInstance().registerMediator(displayListMediator);
			
			_rightWorkGroup = new RightWorkGroup;
			_rightWorkGroup.width = 300;
			addChild(_rightWorkGroup);
			var rightWorkGroupMediator:RightWorkGroupMediator = new RightWorkGroupMediator(_rightWorkGroup);
			ApplicationFacade.getInstance().registerMediator(rightWorkGroupMediator);
			
			_focusPointLayer = new FocusPointLayer;
			addChild(_focusPointLayer);
			var focusPointLayerMediator:FocusPointLayerMediator = new FocusPointLayerMediator(_focusPointLayer);
			ApplicationFacade.getInstance().registerMediator(focusPointLayerMediator);
			
			_floatLayer = new FloatLayer;
			addChild(_floatLayer);
			
			var floatLayerMediator:FloatlayerMediator = new FloatlayerMediator(_floatLayer);
			ApplicationFacade.getInstance().registerMediator(floatLayerMediator);
			
			layoutFeatureMenu();
			layoutFileBar();
//			layoutSourcePanel();
			layoutLeftWorkGroup();
			layoutRightWorkGroup();
//			layoutDisplayPanel();
			
			super.initialize();
		}
		
		override protected function draw():void
		{
			const sizeChangeFlag:Boolean = this.isInvalid(FeathersControl.INVALIDATION_FLAG_SIZE);
			if (sizeChangeFlag)
			{
				layoutFeatureMenu();
				layoutFileBar();
//				layoutSourcePanel();
				layoutLeftWorkGroup();
				layoutRightWorkGroup();
//				layoutDisplayPanel();
			}
		}
		/**
		 *布局featureMenu 
		 * 
		 */		
		private function layoutFeatureMenu():void
		{
			_featureMenu.height = stage.stageHeight;
		}
		/**
		 *布局fileBar 
		 * 
		 */		
		private function layoutFileBar():void
		{
			_fileBar.x = 200;
			_fileBar.y = stage.height - _fileBar.height;
			_fileBar.width = stage.stageWidth - 200; 
		}
		/**
		 *布局资源面板 
		 * 
		 */		
		private function layoutSourcePanel():void
		{
//			_sourcePanel.height = stage.stageHeight - _fileBar.height;
		}
		
		private function layoutLeftWorkGroup():void
		{
			_leftWorkGroup.height = stage.stageHeight - _fileBar.height;
		}
		
		private function layoutRightWorkGroup():void
		{
			_rightWorkGroup.x = stage.stageWidth - _rightWorkGroup.width;
			_rightWorkGroup.height = stage.stageHeight - _fileBar.height;
		}
		
//		/**
//		 *布局显示列表面板 
//		 * 
//		 */		
//		private function layoutDisplayPanel():void
//		{
//			_displayList.x = stage.stageWidth - _displayList.width;
//			_displayList.height = stage.stageHeight - _fileBar.height;
//		}
		
		private function buildData():MenuListContext
		{
			var menuListContext:MenuListContext = new MenuListContext;
			menuListContext.name = "menu";
			var xmlList:XMLList = _featureXML.child(MENU_ITEM_META);
			this.roundData(xmlList, menuListContext);
			return menuListContext;
		}
		
		private function roundData(xmlList:XMLList, menuListContext:MenuListContext):void
		{
			for each(var xml:XML in xmlList)
			{
				if (!menuListContext.menuItems) menuListContext.menuItems = new Vector.<IMenuListContext>;
				var tempXMLList:XMLList = xml.child(MENU_ITEM_META);
				var tempMenuListContext:MenuListContext = new MenuListContext;
				tempMenuListContext.father = menuListContext;
				tempMenuListContext.name = xml.@name;
				tempMenuListContext.data = xml.@data;
				menuListContext.menuItems.push(tempMenuListContext);
				this.roundData(tempXMLList, tempMenuListContext);
			}
		}
	}
}