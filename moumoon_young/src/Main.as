package
{
	import flash.display.BitmapData;
	import flash.display.Shape;
	
	import feathers.controls.Check;
	import feathers.controls.Radio;
	import feathers.core.ToggleGroup;
	import feathers.system.DeviceCapabilities;
	import feathers.themes.MetalWorksMobileTheme;
	
	import org.spzktshow.moumoon.young.alert.ContentAlert;
	import org.spzktshow.moumoon.young.button.MenuBackButtonFactory;
	import org.spzktshow.moumoon.young.button.MenuButtonFactory;
	import org.spzktshow.moumoon.young.header.MenuHeaderFactory;
	import org.spzktshow.moumoon.young.menu.IMenuListContext;
	import org.spzktshow.moumoon.young.menu.Menu;
	import org.spzktshow.moumoon.young.menu.MenuListContext;
	import org.spzktshow.moumoon.young.screen.MenuScreenFactory;
	import org.spzktshow.moumoon.young.theme.MoumoonYoungTheme;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	
	public class Main extends Sprite
	{
		protected var _theme:MetalWorksMobileTheme;
		
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
			_theme = new MoumoonYoungTheme(this.stage);
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
			var shape:Shape = new Shape;
			shape.graphics.beginFill(0xff0000);
			shape.graphics.drawRect(0, 0, 200, 200);
			shape.graphics.endFill();
			var bitmapData:BitmapData = new BitmapData(200, 200);
			bitmapData.draw(shape);
			var texture:Texture = Texture.fromBitmapData(bitmapData);
			var image:Image = new Image(texture);
			image.pivotX = -10;
			image.pivotY = -10;
			addChild(image);
		}
		
		
		private function onEventChange(e:Event):void
		{
		}
	}
}