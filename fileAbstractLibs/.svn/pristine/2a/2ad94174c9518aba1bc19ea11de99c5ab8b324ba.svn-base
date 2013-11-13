package org.spzktshow.file.behavier
{
	import org.spzktshow.file.dataStrcuture.File;
	import org.spzktshow.file.dataStrcuture.IFile;
	import org.spzktshow.file.dataStrcuture.IFileSystem;
	
	public class FileSystemOperation implements IFileSystemOperation
	{
		public function FileSystemOperation()
		{
		}
		
		public function addFile(value:IFile):int
		{
			if (!this.fileSystem) return -1;
			if (this.getFileByName(value.name) != -1) return -1;
			this.fileSystem.fileList.push(value);
			return this.fileSystem.fileList.length - 1;
		}
		
		public function addFileAt(value:IFile, index:int):int
		{
			if (!this.fileSystem) return -1;
			if (this.getFileByName(value.name) != -1) return -1;
			if (index >= this.fileSystem.fileList.length)
			{
				this.fileSystem.fileList.push(value);
				return this.fileSystem.fileList.length - 1;
			}
			else
			{
				this.fileSystem.fileList.splice(index, 0, value);
				return index;
			}
			return - 1;
		}
		
		public function changeFileIndex(file:IFile, newIndex:int):int
		{
			var index:int = this.getFileByName(file.name);
			if (index == -1)
			{
				return this.addFileAt(file, newIndex);
			}
			else
			{
				return this.addFileAt(this.deleteFile(file.name), newIndex);
			}
			return -1;
		}
		
		public function getFileByName(name:String):int
		{
			if (!this.fileSystem) return -1;
			var i:int;
			var n:int = this.fileSystem.fileList.length;
			for (i = 0; i < n; i ++)
			{
				var file:File = this.fileSystem.fileList[i] as File;
				if (file.name == name)
				{
					return i;
				}
			}
			return -1;
		}
		
		public function deleteFile(name:String):IFile
		{
			var index:int = this.getFileByName(name);
			if (index != -1) 
			{
				if (this.fileSystem.focusFile.name == name)
				{
					this.fileSystem.focusFile = null;
				}
				return this.fileSystem.fileList.splice(index, 1)[0] as IFile;
			}
			return null;
		}
		
		private var _fileSystem:IFileSystem;
		public function set fileSystem(value:IFileSystem):void
		{
			this._fileSystem = value;
		}
		
		public function get fileSystem():IFileSystem
		{
			return this._fileSystem;
		}
		
		public function focusFile(value:IFile):IFile
		{
			if (!this.fileSystem) return null;
			this.fileSystem.focusFile = value;
			return value;
		}
		
		public function unFocusFile():IFile
		{
			if (!this.fileSystem) return null;
			var file:IFile = this.fileSystem.focusFile;
			this.fileSystem.focusFile = null;
			return file;
		}
		
		
	}
}