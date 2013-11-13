package org.spzktshow.file.dataStrcuture
{
	public class File implements IFile
	{
		public function File()
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