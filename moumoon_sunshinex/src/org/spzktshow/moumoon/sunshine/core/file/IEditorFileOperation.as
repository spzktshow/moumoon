package org.spzktshow.moumoon.sunshine.core.file
{
	import org.spzktshow.moumoon.core.source.ISource;

	public interface IEditorFileOperation
	{
		/**
		 *添加source，如果检测已经有资源返回-1，否则返回添加到列表的索引 
		 * @param value
		 * @return 
		 * 
		 */		
		function addSource(value:ISource):int;
		/**
		 *获取资源在列表中的索引，如果不在列表中则返回-1 
		 * @param value
		 * @return 
		 * 
		 */		
		function getSourceIndex(value:String):int;
		/**
		 *获取列表中的资源，如果不存在返回null 
		 * @param value
		 * @return 
		 * 
		 */		
		function getSource(value:String):ISource;
		/**
		 * 移除资源，返回移除的资源
		 * @param value
		 * @return 
		 * 
		 */		
		function removeSource(value:String):ISource;
		/**
		 *返回当前操作的editorFile 
		 * @return 
		 * 
		 */		
		function get editorFile():IEditorFile;
		/**
		 *设置当前操作的editorFile 
		 * @param value
		 * 
		 */		
		function set editorFile(value:IEditorFile):void;
		//
		/**
		 *创建一个默认名称 
		 * @return 
		 * 
		 */	
		function createComponentDefaultName():String;
	}
}