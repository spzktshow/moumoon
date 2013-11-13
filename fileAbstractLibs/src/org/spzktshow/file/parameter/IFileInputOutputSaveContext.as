package org.spzktshow.file.parameter
{
	import org.spzktshow.file.dataStrcuture.IFile;

	public interface IFileInputOutputSaveContext
	{
		/**
		 *保存的文件 
		 * @param value
		 * 
		 */		
		function set file(value:IFile):void;
		function get file():IFile;
	}
}