package org.spzktshow.moumoon.sunshine.model.file
{
	import org.puremvc.as3.patterns.proxy.Proxy;
	import org.spzktshow.file.behavier.FileSystemOperation;
	import org.spzktshow.file.behavier.IFileSystemOperation;
	import org.spzktshow.file.dataStrcuture.FileSystem;
	import org.spzktshow.file.dataStrcuture.IFile;
	import org.spzktshow.file.dataStrcuture.IFileSystem;
	import org.spzktshow.moumoon.core.source.ISource;
	import org.spzktshow.moumoon.sunshine.controller.file.FileCommand;
	import org.spzktshow.moumoon.sunshine.core.file.EditorFile;
	import org.spzktshow.moumoon.sunshine.core.file.EditorFileOperation;
	import org.spzktshow.moumoon.sunshine.core.file.IEditorFile;
	import org.spzktshow.moumoon.sunshine.core.file.IEditorFileOperation;
	
	public class FileModel extends Proxy implements IFileSystemOperation, IEditorFileOperation
	{
		public static const NAME:String = "fileModelName";
		
		public static const DEFAULT_CREATE_NAME:String = "newFile";
		
		private var _fileOperation:IFileSystemOperation;
		
		private var _fileSystem:IFileSystem;
		
		private var _editorFileOperation:IEditorFileOperation;

		private var _nameCacheList:Vector.<FileNameCacheData>;
		
		public function FileModel()
		{
			super(NAME);
		}
		
		override public function onRegister():void
		{
			_nameCacheList = new Vector.<FileNameCacheData>;
			_fileSystem = new FileSystem;
			_fileOperation = new FileSystemOperation;
			_fileOperation.fileSystem = _fileSystem;
			_editorFileOperation = new EditorFileOperation;
		}
		
		override public function onRemove():void
		{
			_editorFileOperation = null;
			_fileOperation = null;
			_fileSystem = null;
			_nameCacheList = null;
		}
		
		public function get editorFileOperation():IEditorFileOperation
		{
			return _editorFileOperation;
		}
		
		public function get fileSystem():IFileSystem
		{
			return _fileSystem;
		}
		
		public function get fileOperation():IFileSystemOperation
		{
			return _fileOperation;
		}
		
		//fileOperation
		
		public function addFile(value:IFile):int
		{
			var index:int = _fileOperation.addFile(value);
			if (index != -1)
			{
				this.sendNotification(FileCommand.ADDED_FILE, value);
			}
			return index;
		}
		
		public function addFileAt(value:IFile, index:int):int
		{
			index = _fileOperation.addFileAt(value, index);
			if (index != -1) this.sendNotification(FileCommand.ADDED_FILE, value);
			return index;
		}
		
		public function changeFileIndex(file:IFile, newIndex:int):int
		{
			return _fileOperation.changeFileIndex(file, newIndex);
		}
		
		public function deleteFile(name:String):IFile
		{
			var file:IFile = _fileOperation.deleteFile(name);
			if (file) sendNotification(FileCommand.DELETED_FILE, file);
			return file;
		}
		
		public function set fileSystem(value:IFileSystem):void
		{
			_fileOperation.fileSystem = value;
		}
		
		public function focusFile(value:IFile):IFile
		{
			var file:IFile = _fileOperation.focusFile(value);
			if (file) 
			{
				_editorFileOperation.editorFile = file as IEditorFile;
				sendNotification(FileCommand.FOCUSED_FILE, file);
			}
			return file;
		}
		
		public function getFileByName(name:String):int
		{
			return _fileOperation.getFileByName(name);
		}
		
		public function unFocusFile():IFile
		{
			var file:IFile = _fileOperation.unFocusFile();
			if (file) sendNotification(FileCommand.UNFOCUSED_FILE, file);
			return file;
		}
		
		//create file
		/**
		 *创建一个文件 
		 * @param name
		 * @return 
		 * 
		 */		
		public function createFile(name:String):IFile
		{
			var file:EditorFile = new EditorFile;
			file.name = name;
			return file;
		}
		//name===========
		/**
		 *根据名称创建不重复的名称 
		 * @param name
		 * @return 
		 * 
		 */		
		public function createName(name:String = null):String
		{
			if (!name) name = DEFAULT_CREATE_NAME;
			var cacheName:FileNameCacheData = this.getcacheNameData(name);
			if (cacheName)
			{
				cacheName.index ++;
			}
			else
			{
				cacheName = new FileNameCacheData;
				cacheName.name = name;
				_nameCacheList.push(cacheName);
			}
			return createNameByCacheName(cacheName);
		}
		
		public function getcacheNameData(name:String):FileNameCacheData
		{
			for each(var data:FileNameCacheData in _nameCacheList)
			{
				if (data.name == name)
				{
					return data;
				}
			}
			return null;
		}
		
		protected function createNameByCacheName(cacheNameData:FileNameCacheData):String
		{
			if (cacheNameData.index != 0)
			{
				return cacheNameData.name + "(" + String(cacheNameData.index) + ")";
			}
			else
			{
				return cacheNameData.name;
			}
		}
		
		//editorFileOperation
		public function addSource(value:ISource):int
		{
			var index:int = _editorFileOperation.addSource(value);
			sendNotification(FileCommand.FILE_ADDED_SOURCE, value);
			return index;
		}
		
		public function get editorFile():IEditorFile
		{
			return _editorFileOperation.editorFile;
		}
		
		public function set editorFile(value:IEditorFile):void
		{
			_editorFileOperation.editorFile = value;
		}
		
		public function getSource(value:String):ISource
		{
			var source:ISource = _editorFileOperation.getSource(value);
			sendNotification(FileCommand.FILE_GOT_SOURCE, source);
			return source;
		}
		
		public function getSourceIndex(value:String):int
		{
			return _editorFileOperation.getSourceIndex(value);
		}
		
		public function removeSource(value:String):ISource
		{
			var source:ISource = _editorFileOperation.removeSource(value);
			if (source) sendNotification(FileCommand.FILE_REMOVED_SOURCE, source);
			return source;
		}
		
		//component
		public function createComponentDefaultName():String
		{
			return _editorFileOperation.createComponentDefaultName();
		}
	}
}