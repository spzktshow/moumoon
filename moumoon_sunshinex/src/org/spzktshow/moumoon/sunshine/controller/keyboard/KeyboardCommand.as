package org.spzktshow.moumoon.sunshine.controller.keyboard
{
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	import org.spzktshow.moumoon.sunshine.handler.KeyboardHandler;
	
	public class KeyboardCommand extends SimpleCommand
	{
		/***初始化**/
		public static const INIT:String = "KeyboardCommandInit";
		/***初始化完成**/
		public static const INITED:String = "KeyboardCommandInited";
		/***销毁**/
		public static const DISPOSE:String = "KeyboardCommandDispose";
		/***销毁完成**/
		public static const DISPOSED:String = "KeyboardCommandDisposed";
		
		public function KeyboardCommand()
		{
			super();
		}
		
		override public function execute(notification:INotification):void
		{
			if (notification.getName() == INIT)
			{
				var keyboardHandler:KeyboardHandler = new KeyboardHandler;
				facade.registerProxy(keyboardHandler);
			}
			else if (notification.getName() == DISPOSE)
			{
				facade.removeProxy(KeyboardHandler.NAME);
			}
		}
	}
}