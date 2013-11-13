package org.spzktshow.moumoon.sunshine.controller.file
{
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	import org.spzktshow.file.dataStrcuture.IFile;
	import org.spzktshow.file.dataStrcuture.IFileSystem;
	import org.spzktshow.moumoon.core.source.ISource;
	import org.spzktshow.moumoon.sunshine.controller.componentList.ComponentListCommand;
	import org.spzktshow.moumoon.sunshine.controller.componentList.ComponentListCommandData;
	import org.spzktshow.moumoon.sunshine.core.file.IEditorFile;
	import org.spzktshow.moumoon.sunshine.model.file.FileModel;
	
	public class FileCommand extends SimpleCommand
	{
		/**
		 *初始化命令 
		 */		
		public static const INIT:String = "fileCommandInit";
		/**
		 *初始化完成 
		 */		
		public static const INITED:String = "fileCommandInited";
		/**
		 *焦点文件 
		 */		
		public static const FOCUS_FILE:String = "fileCommandFocusFile";
		/**
		 *焦点文件完成 
		 */		
		public static const FOCUSED_FILE:String = "fileCommandFocusedFile";
		/**
		 *离焦文件完成 
		 */		
		public static const UNFOCUSED_FILE:String = "fileCommandUnFocusedFile";
		/**
		 * 添加文件
		 */		
		public static const ADD_FILE:String = "fileCommandAddFile";
		/**
		 *添加文件完成
		 */		
		public static const ADDED_FILE:String = "fileCommandAddedFile";
		/**
		 *删除文件 
		 */		
		public static const DELETE_FILE:String = "fileCommandDeleteFile";
		/**
		 *删除文件完成 
		 */		
		public static const DELETED_FILE:String = "fileCommandDeletedFile";
		/**
		 *文件空 
		 */		
		public static const FILE_EMPTY:String = "fileCommandFileEmpty";
		/**
		 *文件不为空 
		 */		
		public static const FILE_UNEMPTY:String = "fileCommandFileUnEmpty";
		/**
		 *向当前编辑的文件添加资源 
		 */		
		public static const FILE_ADD_SOURCE:String = "fileCommandFileAddSource";
		/**
		 * 向当前编辑的文件添加资源完成
		 */		
		public static const FILE_ADDED_SOURCE:String = "fileCommandFileAddedSource";
		/**
		 *从当前编辑的文件移除资源 
		 */		
		public static const FILE_REMOVE_SOURCE:String = "fileCommandFileRemoveSource";
		/**
		 *从当前编辑的文件移除资源完成 
		 */		
		public static const FILE_REMOVED_SOURCE:String = "fileCommandFileRemovedSource";
		/**
		 *从当前文件中获取资源 
		 */		
		public static const FILE_GET_SOURCE:String = "fileCommandGetSource";
		/**
		 *从当前文件中获取资源完成 
		 */		
		public static const FILE_GOT_SOURCE:String = "fileCommandGotSource";
		
		public function FileCommand()
		{
			super();
		}
		
		override public function execute(notification:INotification):void
		{
			if (notification.getName() == INIT)
			{
				var fileModel:FileModel = new FileModel;
				facade.registerProxy(fileModel);
				
				this.sendNotification(INITED);
			}
			else if (notification.getName() == ADD_FILE)
			{
				fileModel = facade.retrieveProxy(FileModel.NAME) as FileModel;
				var name:String = fileModel.createName();
				var file:IFile = fileModel.createFile(name);
				
				addFile(file);
			}
			else if (notification.getName() == FOCUS_FILE)
			{
				fileModel = facade.retrieveProxy(FileModel.NAME) as FileModel;
				var index:int = fileModel.getFileByName(String(notification.getBody()));
				if (index != -1)
				{
					file = fileModel.fileSystem.fileList[index];
					
					fileModel.focusFile(file);
					
					//切换component
					var sComponentListCommandData:ComponentListCommandData = new ComponentListCommandData;
					sComponentListCommandData.editorFile = file as IEditorFile;
					this.sendNotification(ComponentListCommand.CHANGE_COMPONENT, sComponentListCommandData);
				}
			}
			else if (notification.getName() == DELETE_FILE)
			{
				removeFile(String(notification.getBody()));
			}
			else if (notification.getName() == FILE_ADD_SOURCE)
			{
				fileModel = facade.retrieveProxy(FileModel.NAME) as FileModel;
				fileModel.addSource(notification.getBody() as ISource);
			}
			else if (notification.getName() == FILE_REMOVE_SOURCE)
			{
				fileModel = facade.retrieveProxy(FileModel.NAME) as FileModel;
				fileModel.removeSource(String(notification.getBody()));
			}
			else if (notification.getName() == FILE_GET_SOURCE)
			{
				fileModel = facade.retrieveProxy(FileModel.NAME) as FileModel;
				fileModel.getSource(String(notification.getBody()));
			}
		}
		/**
		 *向model层添加File 
		 * @param file
		 * 
		 */		
		private function addFile(file:IFile):void
		{
			var fileModel:FileModel = facade.retrieveProxy(FileModel.NAME) as FileModel;
			fileModel.addFile(file);
			
			fileModel.focusFile(file);//焦点坐标
			
			checkFileList(fileModel.fileSystem);
			
			//组织component
			var sComponentListCommandData:ComponentListCommandData = new ComponentListCommandData;
			sComponentListCommandData.editorFile = file as IEditorFile;
			this.sendNotification(ComponentListCommand.CREATE_COMPONENT, sComponentListCommandData);
		}
		/**
		 *从model层移除File 
		 * @param name
		 * 
		 */		
		private function removeFile(name:String):void
		{
			var fileModel:FileModel = facade.retrieveProxy(FileModel.NAME) as FileModel;
			fileModel.deleteFile(name);
			
			checkFileList(fileModel.fileSystem);
		}
		/**
		 *检测文件列表是否为空 
		 * @param fileSystem
		 * 
		 */		
		private function checkFileList(fileSystem:IFileSystem):void
		{
			if (fileSystem.fileList.length == 0)
			{
				sendNotification(FILE_EMPTY);
			}
			else
			{
				sendNotification(FILE_UNEMPTY);
			}
		}
	}
}