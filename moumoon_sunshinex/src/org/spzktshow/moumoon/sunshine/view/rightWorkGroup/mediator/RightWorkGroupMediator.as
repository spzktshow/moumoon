package org.spzktshow.moumoon.sunshine.view.rightWorkGroup.mediator
{
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	import org.spzktshow.moumoon.sunshine.controller.file.FileCommand;
	import org.spzktshow.moumoon.sunshine.view.rightWorkGroup.ui.RightWorkGroup;
	
	public class RightWorkGroupMediator extends Mediator
	{
		public static const NAME:String = "rightWorkGroupMediatorName";
		
		public function RightWorkGroupMediator(viewComponent:Object=null)
		{
			super(NAME, viewComponent);
		}
		
		override public function onRegister():void
		{
			rightWorkGroup.visible = false;
		}
		
		override public function listNotificationInterests():Array
		{
			return [FileCommand.FILE_UNEMPTY, FileCommand.FILE_EMPTY];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			if (notification.getName() == FileCommand.FILE_UNEMPTY)
			{
				rightWorkGroup.visible = true;
			}
			else if (notification.getName() == FileCommand.FILE_EMPTY)
			{
				rightWorkGroup.visible = false;
			}
		}
		
		public function get rightWorkGroup():RightWorkGroup
		{
			return this.viewComponent as RightWorkGroup;
		}
	}
}