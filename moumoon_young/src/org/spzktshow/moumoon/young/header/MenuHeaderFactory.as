package org.spzktshow.moumoon.young.header
{
	import feathers.controls.Header;
	
	public class MenuHeaderFactory implements IHeaderFactory
	{
		public function MenuHeaderFactory()
		{
		}
		
		public function create():Header
		{
			var header:Header = new Header;
			header.height = 20;
			return header;
		}
	}
}