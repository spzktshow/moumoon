package org.spzktshow.moumoon.sunshine.handler
{
	import flash.desktop.NativeApplication;
	import flash.events.InvokeEvent;
	
	import org.puremvc.as3.patterns.proxy.Proxy;
	import org.spzktshow.moumoon.sunshine.controller.invoke.InvokeCommand;

	/**
	 *命令行接受 
	 * @author rocklee
	 * 
	 */	
	public class InvokeHandler extends Proxy
	{
		public static const NAME:String = "invokeHandlerName";
		
		public function InvokeHandler()
		{
			super(NAME);
		}
		
		override public function onRegister():void
		{
			NativeApplication.nativeApplication.addEventListener(InvokeEvent.INVOKE, onInvokeHandler);
			sendNotification(InvokeCommand.INITED);
		}
		
		override public function onRemove():void
		{
			sendNotification(InvokeCommand.DISPOSED);
			NativeApplication.nativeApplication.removeEventListener(InvokeEvent.INVOKE, onInvokeHandler);
		}
		
		private function onInvokeHandler(e:InvokeEvent):void
		{
			trace (e.arguments);
		}
	}
}