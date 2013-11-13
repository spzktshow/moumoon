package org.spzktshow.moumoon.sunshine.controller.source
{
	import flash.filesystem.File;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	import org.spzktshow.loader.QueueLoaderManager;
	import org.spzktshow.loader.context.BitmapLoaderContext;
	import org.spzktshow.loader.event.LoaderContextEvent;
	import org.spzktshow.moumoon.core.source.ISource;
	import org.spzktshow.moumoon.core.source.Source;
	import org.spzktshow.moumoon.sunshine.controller.file.FileCommand;
	import org.spzktshow.moumoon.sunshine.model.source.SourceModel;
	
	import starling.textures.Texture;
	
	public class SourceCommand extends SimpleCommand
	{
		/**
		 *初始化 
		 */		
		public static const INIT:String = "sourceCommandInit";
		/**
		 *初始化完成 
		 */		
		public static const INITED:String = "sourceCommandInited";
		/**
		 *添加资源 
		 */		
		public static const ADD_SOURCE:String = "sourceCommandAddSource";
		/**
		 *添加资源完成 
		 */		
		public static const ADDED_SOURCE:String = "sourceCommandAddedSource";
		/**
		 *移除资源 
		 */		
		public static const REMOVE_SOURCE:String = "sourceCommandRemoveSource";
		/**
		 *移除资源完成 
		 */		
		public static const REMOVED_SOURCE:String = "sourceCommandRemovedSource";
		
		public function SourceCommand()
		{
			super();
		}
		
		override public function execute(notification:INotification):void
		{
			if (notification.getName() == INIT)
			{
				var model:SourceModel = new SourceModel;
				facade.registerProxy(model);
			}
			else if (notification.getName() == ADD_SOURCE)
			{
				var list:Vector.<File> = notification.getBody() as Vector.<File>;
				model = facade.retrieveProxy(SourceModel.NAME) as SourceModel;
				
				for each(var file:File in list)
				{
					var bitmapLoaderContext:BitmapLoaderContext = new BitmapLoaderContext;
					bitmapLoaderContext.key = file.name;
					bitmapLoaderContext.path = file.url;
					
					var queueLoaderManager:QueueLoaderManager = QueueLoaderManager.getInstance();
					queueLoaderManager.push(bitmapLoaderContext);
					bitmapLoaderContext.eventDispatcher.addEventListener(LoaderContextEvent.PROGRESS_UPDATE, onProgressUpdate);
					bitmapLoaderContext.eventDispatcher.addEventListener(LoaderContextEvent.LOAD_COMPLETE, onLoaderComplete);
					queueLoaderManager.start();
				}
			}
		}
		
		private function onLoaderComplete(e:LoaderContextEvent):void
		{
			e.target.removeEventListener(LoaderContextEvent.PROGRESS_UPDATE, onProgressUpdate);
			e.target.removeEventListener(LoaderContextEvent.LOAD_COMPLETE, onLoaderComplete);
			
			var bitmapLoaderContext:BitmapLoaderContext = e.loaderContext as BitmapLoaderContext;
			var source:ISource = this.convertLoaderContextToSource(bitmapLoaderContext);
			
			this.sendNotification(FileCommand.FILE_ADD_SOURCE, source);
		}
		
		private function onProgressUpdate(e:LoaderContextEvent):void
		{
			
		}
		
		private function convertLoaderContextToSource(loaderContext:BitmapLoaderContext):ISource
		{
			var source:Source = new Source;
			source.name = loaderContext.key;
			source.data = Texture.fromBitmap(loaderContext.bitmapData);
			return source;
		}
	}
}