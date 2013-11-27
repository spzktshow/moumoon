package org.spzktshow.moumoon.sunshine.view.applicationMain.ui
{
	import feathers.core.FeathersControl;
	import feathers.system.DeviceCapabilities;
	
	import org.spzktshow.moumoon.sunshine.core.assets.Assets;
	import org.spzktshow.moumoon.sunshine.view.uiLayer.ui.UILayer;
	import org.spzktshow.moumoon.young.core.YoungControl;
	import org.spzktshow.moumoon.young.theme.MoumoonYoungTheme;
	
	import starling.display.Sprite;
	import starling.display.Stage;
	import starling.events.Event;
	import starling.events.TouchEvent;
	
	public class ApplicationMain extends YoungControl
	{	
		private var _theme:MoumoonYoungTheme;
		
		private var _uiLayer:UILayer;
		
		private var _testLayer:Sprite;
		
		public function ApplicationMain()
		{
			super();
		}
		
		override public function dispose():void
		{
			super.dispose();
			this.removeChild(_uiLayer);
			_uiLayer.dispose();
			
			_theme.dispose();
		}
		
		override protected function initialize():void
		{
			DeviceCapabilities.dpi = 144;
			_theme = new MoumoonYoungTheme(stage);
			Assets.getInstance().registerGlobal();//初始化assets
			_uiLayer = new UILayer;
			this.addChild(_uiLayer);
			super.initialize();
		}
		
		private function onTouchHandler(e:TouchEvent):void
		{
			trace ("fdafsd");
		}
		
		override protected function addListeners():void
		{
			stage.addEventListener(Event.RESIZE, onResizeHandler);
		}
		
		override protected function removeListeners():void
		{
			stage.removeEventListener(Event.RESIZE, onResizeHandler);
		}
		
		private function onResizeHandler(e:Event):void
		{
			stage.stageWidth = Stage(e.target).width;
			stage.stageHeight = Stage(e.target).height;
			//
			_uiLayer.invalidate(FeathersControl.INVALIDATION_FLAG_SIZE);
		}
	}
}