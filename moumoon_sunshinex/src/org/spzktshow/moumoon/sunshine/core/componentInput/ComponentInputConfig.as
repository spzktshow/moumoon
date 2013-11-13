package org.spzktshow.moumoon.sunshine.core.componentInput
{

	/**
	 *组件属性输入方式配置表 
	 * @author rocklee
	 * 
	 */	
	public class ComponentInputConfig
	{
		private static var _instance:ComponentInputConfig;
		
		public static function getInstance():ComponentInputConfig
		{
			if (!_instance)
			{
				_instance = new ComponentInputConfig;
			}
			return _instance;
		}
		
		private var _list:Vector.<IComponentInput>;
		
		public function ComponentInputConfig()
		{
			initData();
		}
		
		private function initData():void
		{
			_list = new Vector.<IComponentInput>;
			var componentInput:ComponentInput = new ComponentInput;
			componentInput.type = ComponentInputEnum.TEXT_INPUT;
			_list.push(componentInput);
			componentInput = new ComponentInput;
			componentInput.type = ComponentInputEnum.COLOR;
			_list.push(componentInput);
			componentInput = new ComponentInput;
			componentInput.type = ComponentInputEnum.TEXTURE;
			_list.push(componentInput);
		}
		/**
		 *获取相应类型的组件输入方式 
		 * @param type
		 * @return 
		 * 
		 */		
		public function getComponentInput(type:String):IComponentInput
		{
			for each(var ci:IComponentInput in _list)
			{
				if (ci.type == type)
				{
					return ci;
				}
			}
			return null;
		}
	}
}