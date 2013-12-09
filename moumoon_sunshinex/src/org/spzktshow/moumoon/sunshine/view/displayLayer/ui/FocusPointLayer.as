package org.spzktshow.moumoon.sunshine.view.displayLayer.ui
{	
	import org.spzktshow.moumoon.sunshine.view.displayList.mediator.DisplayItemFactory;
	import org.spzktshow.moumoon.young.core.YoungControl;
	
	import starling.display.Image;
	import starling.textures.Texture;
	
	public class FocusPointLayer extends YoungControl
	{
		public var focusPoint:Image;
		
		public function FocusPointLayer()
		{
			super();
		}
		
		override protected function init():void
		{
			this.visible = false;
			var texture:Texture = DisplayItemFactory.EYE;
			focusPoint = new Image(texture);
			addChild(focusPoint);
		}
	}
}