package org.spzktshow.moumoon.sunshine.core.componentInput
{
	public class ComponentInput implements IComponentInput
	{
		private var _type:String;
		private var _isCreateInject:Boolean;
		public function ComponentInput()
		{
		}
		
		public function set type(value:String):void
		{
			_type = value;
		}
		
		public function get type():String
		{
			return _type;
		}
	}
}