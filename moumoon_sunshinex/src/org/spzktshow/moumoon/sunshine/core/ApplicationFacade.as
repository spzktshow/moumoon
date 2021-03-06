package org.spzktshow.moumoon.sunshine.core
{
	import org.puremvc.as3.patterns.facade.Facade;
	import org.spzktshow.moumoon.sunshine.controller.component.ComponentCommand;
	import org.spzktshow.moumoon.sunshine.controller.componentList.ComponentListCommand;
	import org.spzktshow.moumoon.sunshine.controller.file.FileCommand;
	import org.spzktshow.moumoon.sunshine.controller.floatlayer.FloatLayerCommand;
	import org.spzktshow.moumoon.sunshine.controller.source.SourceCommand;
	import org.spzktshow.moumoon.sunshine.view.displayLayer.mediator.ActDisplayLayerMediator;
	
	public class ApplicationFacade extends Facade
	{
		public static const DEFAULT_WIDTH:Number = 1000;
		public static const DEFAULT_HEIGHT:Number = 600;
		
		public function ApplicationFacade()
		{
			super();
		}
		
		private static var _applicationFacade:ApplicationFacade;
		
		public static function getInstance():ApplicationFacade
		{
			if (!_applicationFacade)
			{
				_applicationFacade = new ApplicationFacade;
			}
			return _applicationFacade;
		}
		
		override protected function initializeController():void
		{
			super.initializeController();
			this.registerCommand(FileCommand.INIT, FileCommand);
			this.registerCommand(FileCommand.ADD_FILE, FileCommand);
			this.registerCommand(FileCommand.FOCUS_FILE, FileCommand);
			this.registerCommand(FileCommand.DELETE_FILE, FileCommand);
			this.registerCommand(FileCommand.FILE_ADD_SOURCE, FileCommand);
			this.registerCommand(FileCommand.FILE_GOT_SOURCE, FileCommand);
			this.registerCommand(FileCommand.FILE_REMOVE_SOURCE, FileCommand);
			
			this.registerCommand(SourceCommand.ADD_SOURCE, SourceCommand);
			
			this.registerCommand(FloatLayerCommand.FLOAT_SOURCE, FloatLayerCommand);
			this.registerCommand(FloatLayerCommand.FLOAT_COMPONENT, FloatLayerCommand);
			
			this.registerCommand(ComponentListCommand.INIT, ComponentListCommand);
			this.registerCommand(ComponentListCommand.CHANGE_COMPONENT, ComponentListCommand);
			//model层组件操作
			this.registerCommand(ComponentListCommand.CREATE_COMPONENT, ComponentListCommand);
			this.registerCommand(ComponentListCommand.ADD_CHILD, ComponentListCommand);
			this.registerCommand(ComponentListCommand.FOCUS_OEPRATION, ComponentListCommand);
			this.registerCommand(ComponentListCommand.COMPONENT_OPERATION, ComponentListCommand);
			//this.registerCommand(ComponentListCommand.FOCUS_OPERATION_MOVE, ComponentListCommand);
			//显示层组件操作
			this.registerCommand(ComponentListCommand.DISPLAY_LAYER_OPERATION, ComponentListCommand);
			
			this.registerCommand(ComponentCommand.INIT, ComponentCommand);
			this.registerCommand(ComponentCommand.UPDATE, ComponentCommand);
		}
		
		public function start():void
		{
			trace ("framework start");
			this.sendNotification(FileCommand.INIT);
			this.sendNotification(ComponentListCommand.INIT);
			this.sendNotification(ComponentCommand.INIT);
		}
	}
}