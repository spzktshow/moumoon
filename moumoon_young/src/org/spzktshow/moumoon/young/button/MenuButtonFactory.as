package org.spzktshow.moumoon.young.button
{
	import feathers.controls.Button;
	
	public class MenuButtonFactory implements IButtonFactory
	{
		public function MenuButtonFactory()
		{
		}
		
		public function create():Button
		{
			var button:Button = new Button;
			button.height = 35;
			button.label = "menu";
			return button;
		}
	}
}