package org.spzktshow.moumoon.sunshine.view.menu.mediator
{
	import org.puremvc.as3.patterns.mediator.Mediator;
	import org.spzktshow.moumoon.sunshine.controller.file.FileCommand;
	import org.spzktshow.moumoon.sunshine.view.menu.ui.FeatureMenu;
	import org.spzktshow.moumoon.young.screen.MenuScreenEvent;
	
	public class FeatureMenuMediator extends Mediator
	{
		public static const NAME:String = "featureMenuMediatorName";
		
		public function FeatureMenuMediator(viewComponent:Object)
		{
			super(NAME, viewComponent);
		}
		
		override public function onRegister():void
		{
			this.featureMenu.addEventListener(MenuScreenEvent.SELECT_ITEM, onSelectItemHandler);
		}
		
		override public function onRemove():void
		{
			this.featureMenu.removeEventListener(MenuScreenEvent.SELECT_ITEM, onSelectItemHandler);
		}
		
		private function onSelectItemHandler(e:MenuScreenEvent):void
		{
			e.stopImmediatePropagation();
			trace (e.menuListContext.data);
			if (e.menuListContext.data == 1001)//new
			{
				this.sendNotification(FileCommand.ADD_FILE);
			}
			else if (e.menuListContext.data == 1002)//open
			{
				
			}
		}
		
		public function get featureMenu():FeatureMenu
		{
			return this.viewComponent as FeatureMenu;
		}
	}
}