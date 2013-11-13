package org.spzktshow.file.parameter
{
	import org.spzktshow.file.dataStrcuture.IFile;

	public class FileInputOutputSaveAsContext implements IFileInputOutputSaveAsContext
	{
		public function FileInputOutputSaveAsContext()
		{
		}
		
		private var _file:IFile;
		public function set file(value:IFile):void
		{
			this._file = value;
		}
		
		public function get file():IFile
		{
			return this._file;
		}
		
		private var _asFileName:String;
		public function set asFileName(value:String):void
		{
			this._asFileName = value;
		}
		
		public function get asFileName():String
		{
			return this._asFileName;
		}
	}
}