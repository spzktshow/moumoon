package org.spzktshow.moumoon.sunshine.controller.floatlayer
{
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	import org.spzktshow.moumoon.core.source.ISource;
	import org.spzktshow.moumoon.sunshine.model.file.FileModel;
	
	public class FloatLayerCommand extends SimpleCommand
	{
		/**
		 *浮动资源 
		 */		
		public static const FLOAT_SOURCE:String = "floatLayerCommandFloatSource";
		/**
		 *浮动资源获取完成 
		 */		
		public static const FLOATED_SOURCE:String = "floatLayerCommandFloatedSource";
		/**
		 *浮动组件 
		 */		
		public static const FLOAT_COMPONENT:String = "floatLayerCommandFloatComponent";
		/**
		 *浮动组建完成 
		 */		
		public static const FLOATED_COMPONENT:String = "floatLayerCommandFloatedComponent";
		
		public function FloatLayerCommand()
		{
			super();
		}
		
		override public function execute(notification:INotification):void
		{
			if (notification.getName() == FLOAT_SOURCE)
			{
				var fileModel:FileModel = facade.retrieveProxy(FileModel.NAME) as FileModel;
				var handlerData:FloatLayerCommandData = notification.getBody() as FloatLayerCommandData;
				var source:ISource = fileModel.editorFileOperation.getSource(handlerData.sourceName);
				if (source)
				{
					var sendData:FloatLayerCommandData = new FloatLayerCommandData;
					sendData.source = source;
					sendData.point = handlerData.point;
					sendData.sourceName = handlerData.sourceName;
					this.sendNotification(FLOATED_SOURCE, sendData);
				}
			}
			else if (notification.getName() == FLOAT_COMPONENT)
			{
				handlerData = notification.getBody() as FloatLayerCommandData;
				//no operation
				this.sendNotification(FLOATED_COMPONENT, handlerData);
			}
		}
	}
}