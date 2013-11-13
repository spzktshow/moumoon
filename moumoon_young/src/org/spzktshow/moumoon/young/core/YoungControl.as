package org.spzktshow.moumoon.young.core
{
	import feathers.core.FeathersControl;
	
	public class YoungControl extends FeathersControl
	{	
		public function YoungControl()
		{
			init();
		}
		
		override public function dispose():void
		{
			this.removeListeners();
			super.dispose();
		}
		/**
		 *添加ui事件监听 
		 * 
		 */		
		protected function addListeners():void
		{
			
		}
		/**
		 *移除ui事件监听 
		 * 
		 */		
		protected function removeListeners():void
		{
			
		}
		
		override protected function initialize():void
		{
			addListeners();
		}
		
		protected function init():void
		{
			
		}
	}
}