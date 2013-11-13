package org.spzktshow.moumoon.sunshine.view.fileBar.mediator
{
	import feathers.data.ListCollection;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	import org.spzktshow.file.dataStrcuture.IFile;
	import org.spzktshow.moumoon.sunshine.controller.file.FileCommand;
	import org.spzktshow.moumoon.sunshine.view.fileBar.ui.FileBar;
	
	import starling.events.Event;
	
	public class FileBarMediator extends Mediator
	{
		public static const NAME:String = "fileBarMediatorName";
		
		public function FileBarMediator(viewComponent:Object)
		{
			super(NAME, viewComponent);
		}
		
		public function get fileBar():FileBar
		{
			return viewComponent as FileBar;
		}
		
		override public function onRegister():void
		{
			fileBar.dataProvider = new ListCollection;
			fileBar.addEventListener(Event.CHANGE, onFileBarChangeHandler);
		}
		
		override public function onRemove():void
		{
			fileBar.removeEventListener(Event.CHANGE, onFileBarChangeHandler);
			fileBar.dispose();
		}
		
		override public function listNotificationInterests():Array
		{
			return [FileCommand.ADDED_FILE];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			if (notification.getName() == FileCommand.ADDED_FILE)
			{
				var file:IFile = notification.getBody() as IFile;
				this.fileBar.dataProvider.push({label:file.name});
				this.fileBar.selectedIndex = this.fileBar.dataProvider.length - 1;
			}
		}
		
		private function onFileBarChangeHandler(e:Event):void
		{
			var fileBar:FileBar = e.currentTarget as FileBar;
			var selectItem:Object = fileBar.selectedItem;
			if (selectItem)
				this.sendNotification(FileCommand.FOCUS_FILE, selectItem.label);
		}
	}
}