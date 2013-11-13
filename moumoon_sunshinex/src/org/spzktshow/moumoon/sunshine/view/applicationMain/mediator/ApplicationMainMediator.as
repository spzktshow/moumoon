package org.spzktshow.moumoon.sunshine.view.applicationMain.mediator
{
	import org.puremvc.as3.patterns.mediator.Mediator;
	import org.spzktshow.moumoon.sunshine.view.applicationMain.ui.ApplicationMain;
	
	public class ApplicationMainMediator extends Mediator
	{
		public static const NAME:String = "applicationMainMediatorName";
		
		public function ApplicationMainMediator(viewComponent:Object)
		{
			super(NAME, viewComponent);
		}
		
		override public function onRegister():void
		{
			
		}
		
		public function get applicationMain():ApplicationMain
		{
			return viewComponent as ApplicationMain;
		}
	}
}