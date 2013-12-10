package
{
	import feathers.display.Scale9Image;
	import feathers.system.DeviceCapabilities;
	import feathers.themes.MetalWorksMobileTheme;
	
	import org.spzktshow.moumoon.young.menu.Menu;
	import org.spzktshow.moumoon.young.theme.MoumoonYoungTheme;
	import org.spzktshow.moumoon.young.theme.TestTheme;
	
	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class Main extends Sprite
	{
		protected var _theme:TestTheme;
		
		public function Main()
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStageHandler);
		}
		
		override public function dispose():void
		{
			removeListeners();
			super.dispose();
		}
		
		protected function addListeners():void
		{
			stage.addEventListener(Event.RESIZE, onResizeHandler);
		}
		
		protected function removeListeners():void
		{
			stage.removeEventListener(Event.RESIZE, onResizeHandler);
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStageHandler);
		}
		
		private function onAddedToStageHandler(e:Event):void
		{
			trace (DeviceCapabilities.dpi);
			DeviceCapabilities.dpi = 144;
			_theme = new TestTheme(this.stage);
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStageHandler);
			
			this.initView();
			addListeners();
		}
		
		private function onResizeHandler(e:Event):void
		{
			Starling.current.viewPort.width = stage.width;
			Starling.current.viewPort.height = stage.height;
			
			stage.stageWidth = stage.width;
			stage.stageHeight = stage.height;
		}
		private var menu:Menu;
		protected function initView():void
		{
			var image:Scale9Image = new Scale9Image(_theme.testSource);
			addChild(image);
			image.width = 20;
		}
		
		
		private function onEventChange(e:Event):void
		{
		}
	}
}