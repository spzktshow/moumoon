package org.spzktshow.moumoon.young.alert
{
	import feathers.controls.Panel;
	import feathers.core.FeathersControl;
	
	import org.spzktshow.moumoon.young.core.YoungControl;
	
	public class BaseAlert extends YoungControl
	{
		/**
		 *面板 
		 */		
		protected var _panel:Panel;
		
		/**
		 *标题 
		 * @param value
		 * 
		 */
		protected var _title:String;
		
		public function BaseAlert(title:String)
		{
			_title = title;
			super();
		}
		
		override protected function initialize():void
		{
			_panel = new Panel();
			_panel.headerProperties.title = _title;
			addChild(_panel);
			
			this.layoutPanel();
			
			super.initialize();
		}
		
		override protected function draw():void
		{
			const sizeFlag:Boolean = this.isInvalid(FeathersControl.INVALIDATION_FLAG_SIZE);
			if (sizeFlag)
			{
				this.layoutPanel();
			}
		}
		
		protected function layoutPanel():void
		{
			_panel.width = this.width;
			_panel.height = this.height;
		}
	}
}