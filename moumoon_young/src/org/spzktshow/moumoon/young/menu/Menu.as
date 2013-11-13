package org.spzktshow.moumoon.young.menu
{
	import feathers.controls.Button;
	import feathers.controls.Header;
	import feathers.controls.ScreenNavigator;
	import feathers.motion.transitions.ScreenSlidingStackTransitionManager;
	
	import org.spzktshow.moumoon.young.button.IButtonFactory;
	import org.spzktshow.moumoon.young.button.MenuButtonFactory;
	import org.spzktshow.moumoon.young.core.YoungControl;
	import org.spzktshow.moumoon.young.header.IHeaderFactory;
	import org.spzktshow.moumoon.young.header.MenuHeaderFactory;
	import org.spzktshow.moumoon.young.screen.IMenuScreenFactory;
	import org.spzktshow.moumoon.young.screen.MenuScreenEvent;
	import org.spzktshow.moumoon.young.screen.MenuScreenFactory;
	import org.spzktshow.moumoon.young.screen.MenuScreenProxy;
	
	import starling.display.DisplayObject;
	import starling.events.Event;
	
	public class Menu extends YoungControl
	{
		/**
		 *headFactory 
		 */		
		protected static const INVALIDATION_FLAG_HEADER_FACTORY:String = "headerFactory";
		/**
		 *buttonFactory 
		 */		
		protected static const INVALIDATION_FLAG_BUTTON_FACTORY:String = "buttonFactory";
		/**
		 *screenNavigatorFactory 
		 */		
		protected static const INVALIDATION_FLAG_SCREEN_NAVIGATOR_FACTORY:String = "screenNavigatorFactory";
		/**
		 *view state 
		 */		
		protected static const INVALIDATION_FLAG_VIEW_STATE:String = "viewState";
		
		/**
		 *header ui component 
		 */		
		protected var header:Header;
		/**
		 *button ui component 
		 */		
		protected var button:Button;
		/**
		 *screenNavigator ui component 
		 */		
		protected var screenNavigator:ScreenNavigator;
		/**
		 *screenNavigaotro ui proxy 
		 */		
		protected var screenNavigatorProxy:MenuScreenProxy;

		private var _headerFactory:IHeaderFactory = new MenuHeaderFactory;

		public function get headerFactory():IHeaderFactory
		{
			return _headerFactory;
		}
		
		public function set headerFactory(value:IHeaderFactory):void
		{
			_headerFactory = value;
		}
		
		private var _buttonFactory:IButtonFactory = new MenuButtonFactory;
		
		public function get buttonFactory():IButtonFactory
		{
			return _buttonFactory;
		}
		
		public function set buttonFactory(value:IButtonFactory):void
		{
			_buttonFactory = value;
		}
		
		private var _screenFactory:IMenuScreenFactory = new MenuScreenFactory;

		public function get screenFactory():IMenuScreenFactory
		{
			return _screenFactory;
		}

		public function set screenFactory(value:IMenuScreenFactory):void
		{
			_screenFactory = value;
		}
		
		private var _isViewMenu:Boolean;
		
		public function get isViewMenu():Boolean
		{
			return _isViewMenu;
		}
		/**
		 *是否显示菜单 
		 * @param value
		 * 
		 */		
		public function set isViewMenu(value:Boolean):void
		{
			if (_isViewMenu == value) 
			{
				return;
			}
			_isViewMenu = value;
			this.invalidate(INVALIDATION_FLAG_VIEW_STATE);
		}
		/**
		 *data 
		 */		
		protected var _menuListContext:IMenuListContext;
		/**
		 *transitionManager 
		 */		
		protected var _transitionManager:ScreenSlidingStackTransitionManager;
		
		public function Menu(menuListContext:IMenuListContext)
		{
			_menuListContext = menuListContext;
			super();
		}
		
		override public function dispose():void
		{
			super.dispose();
			_transitionManager.clearStack();
			this.disposeHeader();
			this.disposeButton();
			screenNavigatorProxy.dispose();
			this.disposeScreenNavigator();
		}
		
		override protected function initialize():void
		{
			this.createHeader();//header
			
			this.createScreenNavigator();//screenNavigator
			
			this.createButton();//button
			
			super.initialize();
		}
		
		override protected function draw():void
		{	
			const sizeInvalid:Boolean = this.isInvalid(INVALIDATION_FLAG_SIZE);
			if (sizeInvalid)
			{
				this.header.width = this.width;
				
				this.button.width = this.width;
				this.button.y = this.height - this.button.height;
				
				this.screenNavigator.height = this.height - this.button.height - this.header.height;
				this.screenNavigator.y = this.header.height;
				this.screenNavigator.width = this.width;
			}
			
			const viewStateInvalid:Boolean = this.isInvalid(INVALIDATION_FLAG_VIEW_STATE);
			if (viewStateInvalid)
			{
				this.header.visible = this._isViewMenu;
				this.screenNavigator.visible = this._isViewMenu;
				
				if (this._isViewMenu)//如果viewState变化了，并且值为true，则screenNavigator显示初始画面
				{
					this.header.title = _menuListContext.name;
					screenNavigatorProxy.showScreen(_menuListContext.name);
				}
			}
			
			super.draw();
		}
		
		protected function createHeader():void
		{	
			this.header = _headerFactory.create();
			Header(this.header).title = this._menuListContext.name;
			this.addChild(this.header as DisplayObject);
		}
		
		protected function disposeHeader():void
		{
			if (header)
			{
				this.removeChild(DisplayObject(this.header), true);
				this.header = null;
			}
		}
		
		protected function createButton():void
		{
			this.button = this._buttonFactory.create();
			this.addChild(this.button);
		}
		
		protected function disposeButton():void
		{
			if (this.button)
			{
				this.removeChild(this.button, true);
				this.button = null;
			}
		}
		
		protected function createScreenNavigator():void
		{
			this.screenNavigator = this._screenFactory.create(_menuListContext);
			this.addChild(this.screenNavigator);
			screenNavigatorProxy = new MenuScreenProxy(screenNavigator);
			_transitionManager = new ScreenSlidingStackTransitionManager(screenNavigator);
			_transitionManager.duration = .4;
		}
		
		protected function disposeScreenNavigator():void
		{
			if (this.screenNavigator)
			{
				this.removeChild(this.screenNavigator, true);
				this.screenNavigator = null;
			}
		}
		
		override protected function addListeners():void
		{
			super.addListeners();
			this.button.addEventListener(Event.TRIGGERED, onTriggerButtonHandler);
			this.screenNavigator.addEventListener(MenuScreenEvent.SELECT_ITEM, onSelectMenuItemHandler);
			this.screenNavigator.addEventListener(MenuScreenEvent.TRANSTION_LIST, onTransitionListHandler);
		}
		
		override protected function removeListeners():void
		{
			this.screenNavigator.removeEventListener(MenuScreenEvent.TRANSTION_LIST, onTransitionListHandler);
			this.screenNavigator.removeEventListener(MenuScreenEvent.SELECT_ITEM, onSelectMenuItemHandler);
			this.button.removeEventListener(Event.TRIGGERED, onTriggerButtonHandler);
			super.removeListeners();
		}
		
		protected function onTriggerButtonHandler(e:Event):void
		{
			e.stopImmediatePropagation();
			this.isViewMenu = !this.isViewMenu;
		}
		
		protected function onSelectMenuItemHandler(e:MenuScreenEvent):void
		{
			this.isViewMenu = false;
		}
		
		protected function onTransitionListHandler(e:MenuScreenEvent):void
		{
			this.header.title = e.menuListContext.name;
		}
	}
}