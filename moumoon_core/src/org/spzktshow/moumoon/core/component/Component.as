package org.spzktshow.moumoon.core.component
{
	import org.spzktshow.moumoon.core.componentTemplate.IComponentTemplate;
	import org.spzktshow.moumoon.core.componentValue.IComponentValueList;
	import org.spzktshow.moumoon.core.source.ISource;
	
	import starling.display.DisplayObject;

	public class Component implements IComponent
	{	
		public function Component()
		{
			_children = new Vector.<IComponent>;
		}
		
		private var _parent:IComponent;
		public function set parent(value:IComponent):void
		{
			_parent = value;
		}
		
		public function get parent():IComponent
		{
			return _parent;
		}
		
		private var _children:Vector.<IComponent>;
		public function set children(value:Vector.<IComponent>):void
		{
			_children = value;
		}
		
		public function get children():Vector.<IComponent>
		{
			return _children;
		}
		
		private var _type:String;
		public function set type(value:String):void
		{
			_type = value;
		}
		
		public function get type():String
		{
			return _type;
		}
		
		private var _name:String;
		public function set name(value:String):void
		{
			_name = value;
		}
		
		public function get name():String
		{
			return _name;
		}
		
		private var _x:Number;
		public function set x(value:Number):void
		{
			_x = value
		}
		
		public function get x():Number
		{
			return _x;
		}
		
		private var _y:Number;
		public function set y(value:Number):void
		{
			_y = value;
		}
		
		public function get y():Number
		{
			return _y;
		}
		
		private var _width:Number;
		public function set width(value:Number):void
		{
			_width = value
		}
		
		public function get width():Number
		{
			return _width;
		}
		
		private var _height:Number;
		public function set height(value:Number):void
		{
			_height = value;
		}
		
		public function get height():Number
		{
			return _height;
		}
		
		private var _source:ISource;
		public function set source(value:ISource):void
		{
			_source = value;
		}
		
		public function get source():ISource
		{
			return _source;
		}
		
		private var _componentTemplate:IComponentTemplate;
		public function set componentTemplate(value:IComponentTemplate):void
		{
			_componentTemplate = value;
		}
		
		public function get componentTemplate():IComponentTemplate
		{
			return _componentTemplate;
		}
		
		private var _componentValueList:IComponentValueList;
		public function set componentValueList(value:IComponentValueList):void
		{
			_componentValueList = value;
		}
		
		public function get componentValueList():IComponentValueList
		{
			return _componentValueList;
		}
		
		private var _entity:DisplayObject;
		public function set entity(value:DisplayObject):void
		{
			_entity = value;
		}
		
		public function get entity():DisplayObject
		{
			return _entity;
		}
		
		
	}
}