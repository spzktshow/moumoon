package org.spzktshow.file.behavier
{
	import org.spzktshow.file.dataStrcuture.IFile;
	import org.spzktshow.file.parameter.IFileInputOutputCreateContext;
	import org.spzktshow.file.parameter.IFileInputOutputOpenContext;
	import org.spzktshow.file.parameter.IFileInputOutputSaveAsContext;
	import org.spzktshow.file.parameter.IFileInputOutputSaveContext;

	public interface IFileInputOutputOperation
	{
		/**
		 *打开文件 
		 * @param value
		 * 
		 */		
		function open(value:IFileInputOutputOpenContext):IFile;
		/**
		 *创建文件 
		 * @param value
		 * 
		 */		
		function create(value:IFileInputOutputCreateContext):IFile;
		/**
		 *保存文件 
		 * @param value
		 * 
		 */		
		function save(value:IFileInputOutputSaveContext):Boolean;
		/**
		 *保存为 
		 * @param value
		 * 
		 */		
		function saveAs(value:IFileInputOutputSaveAsContext):Boolean;
	}
}