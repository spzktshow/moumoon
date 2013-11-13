package org.spzktshow.moumoon.core.componentTemplate.configData
{
	public class ComponentProperty implements IComponentProperty
	{
		private var _name:String;
		private var _propertyValue:Object;
		private var _isCreateInject:Boolean;
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
		
		public function set propertyValue(value:Object):void
		{
			_propertyValue = value;
		}
		
		public function get propertyValue():Object
		{
			return _propertyValue;
		}
		
		public function set isCreateInject(value:Boolean):void
		{
			_isCreateInject = value;
		}
		
		public function get isCreateInject():Boolean
		{
			return _isCreateInject;
		}
	}
}