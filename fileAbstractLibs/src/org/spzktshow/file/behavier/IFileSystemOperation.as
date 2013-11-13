package org.spzktshow.file.behavier
{
	import org.spzktshow.file.dataStrcuture.IFile;
	import org.spzktshow.file.dataStrcuture.IFileSystem;

	public interface IFileSystemOperation
	{
		/**
		 *增加文件列表 
		 * @param value
		 * 
		 */		
		function addFile(value:IFile):int;
		/**
		 *增加文件到列表中特定的索引 
		 * @param value
		 * @param index
		 * 
		 */		
		function addFileAt(value:IFile, index:int):int;
		/**
		 *改变文件在列表中的索引
		 * @param file
		 * @param newIndex
		 * @return 
		 * 
		 */		
		function changeFileIndex(file:IFile, newIndex:int):int;
		/**
		 *根据名称获取文件在列表中的索引，如果没有则返回-1 
		 * @param name
		 * @return 
		 * 
		 */		
		function getFileByName(name:String):int;
		/**
		 *删除文件，返回删除的文件 
		 * @param name
		 * @return 
		 * 
		 */		
		function deleteFile(name:String):IFile;
		/**
		 *当前操作的文件系统 
		 * @param value
		 * 
		 */		
		function set fileSystem(value:IFileSystem):void;
		function get fileSystem():IFileSystem;
		/**
		 *焦点某个文件 
		 * @param value
		 * 
		 */		
		function focusFile(value:IFile):IFile;
		/**
		 * 解除焦点
		 * 
		 */		
		function unFocusFile():IFile;
	}
}