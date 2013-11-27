package org.spzktshow.moumoon.sunshine.view.displayLayer.mediator
{
	import flash.geom.Point;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	import org.spzktshow.moumoon.sunshine.controller.componentList.ComponentListCommand;
	import org.spzktshow.moumoon.sunshine.controller.componentList.ComponentListCommandData;
	import org.spzktshow.moumoon.sunshine.controller.file.FileCommand;
	import org.spzktshow.moumoon.sunshine.view.displayLayer.ui.FocusPointLayer;
	
	public class FocusPointLayerMediator extends Mediator
	{
		public static const NAME:String = "focusPointLayerMediatorName";
		
		public function FocusPointLayerMediator(viewComponent:Object=null)
		{
			super(NAME, viewComponent);
		}
		
		override public function onRegister():void
		{
			focusPointLayer.visible = false;
		}
		
		override public function listNotificationInterests():Array
		{
			return [ComponentListCommand.REFRESHED, FileCommand.FILE_UNEMPTY, FileCommand.FILE_EMPTY];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			if (notification.getName() == ComponentListCommand.REFRESHED)
			{
				var sComponentListCommandData:ComponentListCommandData = notification.getBody() as ComponentListCommandData;
				var containerGlobalPoint:Point = new Point(0, 0);
				containerGlobalPoint = sComponentListCommandData.containerFocus.entity.localToGlobal(containerGlobalPoint, containerGlobalPoint);
				containerGlobalPoint = focusPointLayer.globalToLocal(containerGlobalPoint, containerGlobalPoint);
				focusPointLayer.focusPoint.x = containerGlobalPoint.x;
				focusPointLayer.focusPoint.y = containerGlobalPoint.y;
			}
			else if (notification.getName() == FileCommand.FILE_UNEMPTY)
			{
				focusPointLayer.visible = true;
			}
			else if (notification.getName() == FileCommand.FILE_EMPTY)
			{
				focusPointLayer.visible = false;
			}
		}
		
		public function get focusPointLayer():FocusPointLayer
		{
			return viewComponent as FocusPointLayer;
		}
	}
}