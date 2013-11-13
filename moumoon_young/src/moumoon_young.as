package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	
	import starling.core.Starling;
	
	public class moumoon_young extends Sprite
	{
		private var _starling:Starling;
		
		public function moumoon_young()
		{
			addEventListener(Event.ADDED_TO_STAGE, onAddToStageHandler);
		}
		
		private function onAddToStageHandler(e:Event):void
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			_starling = new Starling(Main, stage);
			_starling.start();
			removeEventListener(Event.ADDED_TO_STAGE, onAddToStageHandler);
		}
	}
}