package org.spzktshow.file.parameter
{
	public class FileInputOutputCreateContext implements IFileInputOutputCreateContext
	{
		public function FileInputOutputCreateContext()
		{
		}
		
		private var _name:String;
		public function set name(value:String):void
		{
			this._name = value;
		}
		
		public function get name():String
		{
			return this._name;
		}
	}
}