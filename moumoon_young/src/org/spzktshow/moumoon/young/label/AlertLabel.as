package org.spzktshow.moumoon.young.label
{
	import feathers.controls.Label;
	
	public class AlertLabel extends Label
	{
		public function AlertLabel()
		{
			super();
		}
		
		override protected function layout():void
		{
			super.layout();
			
			this.x = this.parent.width * .5 - this.width * .5;
			this.y = this.parent.height * .5 - this.height * .5;
		}
	}
}