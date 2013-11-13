package org.spzktshow.file.dataStrcuture
{
	public class FileSystem implements IFileSystem
	{
		public function FileSystem()
		{
			this._fileList = new Vector.<IFile>;
		}
		
		private var _fileList:Vector.<IFile>;
		public function get fileList():Vector.<IFile>
		{
			return this._fileList;
		}
		
		private var _focusFile:IFile;
		public function set focusFile(value:IFile):void
		{
			this._focusFile = value;
		}
		
		public function get focusFile():IFile
		{
			return this._focusFile;
		}
	}
}