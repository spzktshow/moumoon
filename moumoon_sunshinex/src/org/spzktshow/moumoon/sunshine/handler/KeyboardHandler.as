package org.spzktshow.moumoon.sunshine.handler
{
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	import org.puremvc.as3.patterns.proxy.Proxy;
	import org.spzktshow.moumoon.sunshine.controller.keyboard.KeyboardCommand;
	
	import starling.core.Starling;
	
	public class KeyboardHandler extends Proxy
	{
		public static const NAME:String = "keyboardHandlerName";
		
		public function KeyboardHandler()
		{
			super(NAME);
		}
		
		override public function onRegister():void
		{
			Starling.current.nativeStage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDownHandler);
			Starling.current.nativeStage.addEventListener(KeyboardEvent.KEY_UP, onKeyUpHandler);
			
			sendNotification(KeyboardCommand.INITED);
		}
		
		override public function onRemove():void
		{
			sendNotification(KeyboardCommand.DISPOSED);
			
			Starling.current.nativeStage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDownHandler);
			Starling.current.nativeStage.removeEventListener(KeyboardEvent.KEY_UP, onKeyUpHandler);
		}
		
		private function onKeyDownHandler(e:KeyboardEvent):void
		{
			
		}
		
		private function onKeyUpHandler(e:KeyboardEvent):void
		{
			trace (e.keyCode);
			if (e.keyCode == Keyboard.F6)
			{
				
			}
		}
	}
}