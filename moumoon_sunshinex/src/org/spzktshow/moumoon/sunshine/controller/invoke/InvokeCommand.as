package org.spzktshow.moumoon.sunshine.controller.invoke
{
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	import org.spzktshow.moumoon.sunshine.handler.InvokeHandler;
	
	public class InvokeCommand extends SimpleCommand
	{
		/***初始化**/
		public static const INIT:String = "InvokeCommandInit";
		/***初始化完成**/
		public static const INITED:String = "InvokeCommandInited";
		/***销毁**/
		public static const DISPOSE:String = "InvokeCommandDispose";
		/***销毁完成**/
		public static const DISPOSED:String = "InvokeCommandDisposed";
		
		public function InvokeCommand()
		{
			super();
		}
		
		override public function execute(notification:INotification):void
		{
			if (notification.getName() == INIT)
			{
				var invokeHandler:InvokeHandler = new InvokeHandler();
				facade.registerProxy(invokeHandler);
			}
			else if (notification.getName() == DISPOSE)
			{
				facade.removeProxy(InvokeHandler.NAME);
			}
		}
	}
}