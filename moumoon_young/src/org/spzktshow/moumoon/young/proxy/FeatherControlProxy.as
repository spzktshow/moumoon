package org.spzktshow.moumoon.young.proxy
{
	import feathers.core.IFeathersControl;

	public class FeatherControlProxy implements IFeatherControlProxy
	{
		protected var _featherControl:IFeathersControl;
		
		public function FeatherControlProxy(featherControl:IFeathersControl)
		{
			_featherControl = featherControl;
			this.createUI();
			this.addListeners();
		}
		
		public function dispose():void
		{
			this.removeListeners();
			this.disposeUI();
		}
		
		protected function createUI():void
		{
			
		}
		
		protected function disposeUI():void
		{
			
		}
		
		protected function addListeners():void
		{
			
		}
		
		protected function removeListeners():void
		{
			
		}
	}
}