package org.spzktshow.moumoon.sunshine.controller.floatlayer
{
	import flash.geom.Point;
	
	import org.spzktshow.moumoon.core.source.ISource;

	public class FloatLayerCommandData
	{
		public function FloatLayerCommandData()
		{
		}
		
		//
		/**
		 *资源名称 
		 */		
		public var sourceName:String;
		/**
		 *资源坐标 
		 */		
		public var point:Point;
		/**
		 *资源 
		 */		
		public var source:ISource;
		/**
		 *组件模板类型,在componentModel查找唯一的组建模板
		 */		
		public var componentName:String
	}
}