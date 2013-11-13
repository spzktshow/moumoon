package org.spzktshow.moumoon.young.button
{
	import feathers.controls.Button;
	
	public class MenuBackButtonFactory implements IButtonFactory
	{
		public function MenuBackButtonFactory()
		{
		}
		
		public function create():Button
		{
			var button:Button = new Button;
			button.label = "back";
			button.width = 60;
			button.height = 15;
			return button;
		}
	}
}