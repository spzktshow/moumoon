package org.spzktshow.moumoon.sunshine.controller.componentList
{
	import flash.geom.Point;
	
	import org.spzktshow.moumoon.core.componentValue.IComponentValueList;
	import org.spzktshow.moumoon.sunshine.core.component.IListComponent;
	import org.spzktshow.moumoon.sunshine.core.file.IEditorFile;

	/**
	 *组件列表命令的参数数据结构 
	 * @author rocklee
	 * 
	 */	
	public class ComponentListCommandData
	{
		public function ComponentListCommandData()
		{
		}
		/**
		 *编辑文件数据结构 
		 */		
		public var editorFile:IEditorFile;
		/**
		 *组件数据结构 
		 */		
		public var component:IListComponent;
		/**
		 *当前焦点的容器 
		 */		
		public var containerFocus:IListComponent;
		/**
		 *当前的焦点 
		 */		
		public var focus:IListComponent;
		/**
		 *组件名称 
		 */		
		public var componentName:String;
		/**
		 *资源雷星，创建组件时用 
		 */		
		public var sourceType:String;
		/**
		 *资源名称 ，创建组件时用 
		 */		
		public var sourceName:String;
		/**
		 *坐标 
		 */		
		public var globalMousePoint:Point;
		/**
		 *素材坐标 
		 */		
		public var componentPoint:Point;
		/**
		 *组建模板的类型 
		 */		
		public var componentTemplateType:String;
		/**
		 *组建值列表 
		 */		
		public var componentPropertyValueList:IComponentValueList;
	}
}