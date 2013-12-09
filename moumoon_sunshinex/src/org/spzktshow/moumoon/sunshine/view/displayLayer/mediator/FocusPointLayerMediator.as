package org.spzktshow.moumoon.sunshine.view.displayLayer.mediator
{
	import flash.geom.Point;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	import org.spzktshow.moumoon.core.componentTemplate.configData.ComponentPropertyEnum;
	import org.spzktshow.moumoon.core.componentValue.ComponentPropertyValueUtils;
	import org.spzktshow.moumoon.sunshine.controller.componentList.ComponentListCommand;
	import org.spzktshow.moumoon.sunshine.controller.componentList.ComponentListCommandData;
	import org.spzktshow.moumoon.sunshine.controller.file.FileCommand;
	import org.spzktshow.moumoon.sunshine.view.displayLayer.ui.FocusPointLayer;
	
	import starling.display.DisplayObjectContainer;
	
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
			return [];
			//return [ComponentListCommand.REFRESHED, FileCommand.FILE_UNEMPTY, FileCommand.FILE_EMPTY, ComponentListCommand.FOCUS_OPREATION_REFRESHED];
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
			else if (notification.getName() == ComponentListCommand.FOCUS_OPREATION_REFRESHED)
			{
				sComponentListCommandData = notification.getBody() as ComponentListCommandData;
				if (sComponentListCommandData.focus.entity is DisplayObjectContainer)
				{
					if (ComponentPropertyValueUtils.checkHasProperty(ComponentPropertyEnum.X, sComponentListCommandData.componentPropertyValueList)
						|| ComponentPropertyValueUtils.checkHasProperty(ComponentPropertyEnum.Y, sComponentListCommandData.componentPropertyValueList))
					{
						containerGlobalPoint = new Point(0, 0);
						containerGlobalPoint = sComponentListCommandData.focus.entity.localToGlobal(containerGlobalPoint, containerGlobalPoint);
						containerGlobalPoint = focusPointLayer.globalToLocal(containerGlobalPoint, containerGlobalPoint);
						focusPointLayer.focusPoint.x = containerGlobalPoint.x;
						focusPointLayer.focusPoint.y = containerGlobalPoint.y;
					}
				}
			}
		}
		
		public function get focusPointLayer():FocusPointLayer
		{
			return viewComponent as FocusPointLayer;
		}
	}
}