package org.spzktshow.moumoon.core.componentTemplate.componetProperty
{
	public class ComponentProperty implements IComponentProperty
	{
		private var _name:String;
		private var _propertyValue:Object;
		private var _isStructureDepend:Boolean;
		private var _isDispensable:Boolean;
		private var _structureDependIndex:int;
		
		public function ComponentProperty()
		{
		}
		
		public function set name(value:String):void
		{
			_name = value;
		}
		
		public function get name():String
		{
			return _name;
		}
		
		public function set isDispensable(value:Boolean):void
		{
			_isDispensable = value;
		}
		
		public function get isDispensable():Boolean
		{
			return _isDispensable;
		}
		
		public function set isStructureDepend(value:Boolean):void
		{
			_isStructureDepend = value;
		}
		
		public function get isStructureDepend():Boolean
		{
			return _isStructureDepend;
		}
		
		public function set structureDependIndex(value:int):void
		{
			_structureDependIndex = value;
		}
		
		public function get structureDependIndex():int
		{
			return _structureDependIndex;
		}
	}
}