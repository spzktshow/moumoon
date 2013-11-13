package org.spzktshow.moumoon.sunshine.view.applicationMain.mediator
{
	import flash.desktop.ClipboardFormats;
	import flash.desktop.NativeDragManager;
	import flash.display.DisplayObject;
	import flash.display.InteractiveObject;
	import flash.events.NativeDragEvent;
	import flash.filesystem.File;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	import org.spzktshow.moumoon.sunshine.controller.file.FileCommand;
	import org.spzktshow.moumoon.sunshine.controller.invoke.InvokeCommand;
	import org.spzktshow.moumoon.sunshine.controller.keyboard.KeyboardCommand;
	import org.spzktshow.moumoon.sunshine.controller.source.SourceCommand;
	import org.spzktshow.moumoon.sunshine.core.uitls.FileCheck;
	
	public class ApplicationMediator extends Mediator
	{
		public static const NAME:String = "applicationMediatorName";
		
		public function ApplicationMediator(viewComponent:Object=null)
		{
			super(NAME, viewComponent);
		}
		
		override public function onRegister():void
		{
			this.sendNotification(InvokeCommand.INIT);
			this.sendNotification(KeyboardCommand.INIT);
		}
		
		override public function onRemove():void
		{
			application.removeEventListener(NativeDragEvent.NATIVE_DRAG_ENTER, onNativeDragEnterHandler);
			application.removeEventListener(NativeDragEvent.NATIVE_DRAG_DROP, onNativeDragDropHandler);
		}
		
		override public function listNotificationInterests():Array
		{
			return [FileCommand.FILE_EMPTY, FileCommand.FILE_UNEMPTY];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			if (FileCommand.FILE_EMPTY == notification.getName())
			{
				application.removeEventListener(NativeDragEvent.NATIVE_DRAG_ENTER, onNativeDragEnterHandler);
				application.removeEventListener(NativeDragEvent.NATIVE_DRAG_DROP, onNativeDragDropHandler);
			}
			else if (FileCommand.FILE_UNEMPTY == notification.getName())
			{
				application.addEventListener(NativeDragEvent.NATIVE_DRAG_DROP, onNativeDragDropHandler);
				application.addEventListener(NativeDragEvent.NATIVE_DRAG_ENTER, onNativeDragEnterHandler);
			}
		}
		
		private function onNativeDragDropHandler(e:NativeDragEvent):void
		{
			var files:Array = e.clipboard.getData( ClipboardFormats.FILE_LIST_FORMAT ) as Array;
			var list:Vector.<File> = this.buildDragFile(files);
			if (list.length > 0)
			{
				var fileList:Vector.<File> = new Vector.<File>;
				for each(var file:File in list)
				{
					fileList.push(file);
				}
				this.sendNotification(SourceCommand.ADD_SOURCE, fileList);
			}
		}
		
		private function onNativeDragEnterHandler(e:NativeDragEvent):void
		{
			var files:Array = e.clipboard.getData(ClipboardFormats.FILE_LIST_FORMAT) as Array;
			if (checkFile(files))
			{
				NativeDragManager.acceptDragDrop(application as InteractiveObject);
			}
		}
		/**
		 *检测file是否匹配 
		 * @param files
		 * @return 
		 * 
		 */		
		private function checkFile(files:Array):Boolean
		{
			for each(var file:File in files)
			{
				if (FileCheck.check(file, "png"))
				{
					return true;
				}
				if (FileCheck.check(file, "jpg"))
				{
					return true;
				}
			}
			return false;
		}
		/**
		 *创建dragFiles 
		 * @param files
		 * @return 
		 * 
		 */		
		private function buildDragFile(files:Array):Vector.<File>
		{
			var list:Vector.<File> = new Vector.<File>;
			for each(var file:File in files)
			{
				if (FileCheck.check(file, "png"))
				{
					list.push(file);
				}
				else if (FileCheck.check(file, "jpg"))
				{
					list.push(file);
				}
			}
			return list;
		}
		
		public function get application():DisplayObject
		{
			return viewComponent as DisplayObject;
		}
	}
}