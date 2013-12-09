package org.spzktshow.moumoon.sunshine.view.displayLayer.mediator
{
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	import org.spzktshow.moumoon.sunshine.controller.componentList.ComponentListCommand;
	import org.spzktshow.moumoon.sunshine.controller.componentList.ComponentListCommandData;
	import org.spzktshow.moumoon.sunshine.view.displayLayer.ui.ActDisplayLayer;
	
	public class ActDisplayLayerMediator extends Mediator
	{
		public static const NAME:String = "actDisplayLadyerMediatorName";
		
		public static const CHANGE_STATE:String = "actDisplayLayerMediatroChangeState"
		
		public function ActDisplayLayerMediator(viewComponent:Object=null)
		{
			super(NAME, viewComponent);
		}
		
		override public function onRegister():void
		{
			actDisplayLayer.touchable = false;
			actDisplayLayer.visible = false;
		}
		
		override public function listNotificationInterests():Array
		{
			return [ComponentListCommand.REFRESHED, CHANGE_STATE];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			if (notification.getName() == ComponentListCommand.REFRESHED)
			{
				var sData:ComponentListCommandData = notification.getBody() as ComponentListCommandData;
				actDisplayLayer.removeChildren();
				actDisplayLayer.addChild(sData.editorFile.component.entity);
			}
			else if (notification.getName() == CHANGE_STATE)
			{
				actDisplayLayer.visible = !actDisplayLayer.visible;
			}
		}
		
		public function get actDisplayLayer():ActDisplayLayer
		{
			return this.viewComponent as ActDisplayLayer;
		}
	}
}