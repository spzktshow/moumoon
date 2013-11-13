package org.spzktshow.moumoon.sunshine.view.leftWorkGroup.mediator
{
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	import org.spzktshow.moumoon.sunshine.controller.file.FileCommand;
	import org.spzktshow.moumoon.sunshine.view.leftWorkGroup.ui.LeftWorkGroup;
	
	public class LeftWorkGroupMediator extends Mediator
	{
		public static const NAME:String = "leftWorkGroupMediatorName";
		
		public function LeftWorkGroupMediator(viewComponent:Object=null)
		{
			super(NAME, viewComponent);
		}
		
		override public function onRegister():void
		{
			leftWorkGroup.visible = false;
		}
		
		public function get leftWorkGroup():LeftWorkGroup
		{
			return this.viewComponent as LeftWorkGroup;
		}
		
		override public function listNotificationInterests():Array
		{
			return [FileCommand.FILE_UNEMPTY, FileCommand.FILE_EMPTY];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			if (notification.getName() == FileCommand.FILE_UNEMPTY)
			{
				leftWorkGroup.visible = true;
			}
			else if (notification.getName() == FileCommand.FILE_EMPTY)
			{
				leftWorkGroup.visible = false;
			}
		}
	}
}