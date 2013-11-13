package org.spzktshow.moumoon.sunshine.core.file
{
	import org.spzktshow.file.dataStrcuture.IFile;
	import org.spzktshow.moumoon.core.component.IComponentGroup;
	import org.spzktshow.moumoon.core.source.ISource;
	import org.spzktshow.moumoon.sunshine.core.component.IListComponent;
	
	public interface IEditorFile extends IFile
	{
		/**
		 *源文件资源列表 
		 * @param value
		 * 
		 */		
		function get sources():Vector.<ISource>;
		/**
		 * 
		 * @param value
		 * 
		 */		
		function set component(value:IListComponent):void;
		/**
		 * 
		 * @return 
		 * 
		 */		
		function get component():IListComponent;
		/**
		 *默认名称的索引，在文件的生命周期内无限增长 
		 * @return 
		 * 
		 */	
		function get defaultNameIndex():int;
		/**
		 *组建小组,包含整个显示列表 
		 * @param value
		 * 
		 */		
		function set componentGroup(value:IComponentGroup):void;
		function get componentGroup():IComponentGroup;
	}
}