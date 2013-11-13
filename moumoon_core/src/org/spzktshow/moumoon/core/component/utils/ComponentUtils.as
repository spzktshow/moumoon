package org.spzktshow.moumoon.core.component.utils
{
	import org.spzktshow.moumoon.core.component.IComponent;

	/**
	 *组件工具 
	 * @author rocklee
	 * 
	 */	
	public class ComponentUtils
	{
		public function ComponentUtils()
		{
		}
		//get
		/**
		 *根据名称获取子组件 
		 * @param component
		 * @param name
		 * @return 
		 * 
		 */		
		public static function getChildByName(parent:IComponent, name:String):IComponent
		{
			if (parent.children && parent.children.length > 0)
			{
				for each(var tempComponent:IComponent in parent.children)
				{
					if (tempComponent.name == name) return tempComponent;
				}
			}
			return null;
		}
		/**
		 *根据名字获取组件在父级中的索引 
		 * @param parent
		 * @param name
		 * @return 
		 * 
		 */		
		public static function getIndexByName(parent:IComponent, name:String):int
		{
			if (parent.children && parent.children.length > 0)
			{
				var index:int = 0;
				for each(var tempComponent:IComponent in parent.children)
				{
					if (tempComponent.name == name)
					{
						return index;
					}
					index ++;
				}
			}
			return -1;
		}
		/**
		 *从整个树状结构中获取子组件 
		 * @param component
		 * @param name
		 * @return 
		 * 
		 */		
		public static function getTotalChildByName(parent:IComponent, name:String):IComponent
		{
			if (parent.name == name) return parent;
			return roundTotalChildByName(parent, name);	
		}
		
		private static function roundTotalChildByName(component:IComponent, name:String):IComponent
		{
			if (component.children && component.children.length > 0)
			{
				for each(var tempComponent:IComponent in component.children)
				{
					if (tempComponent.name == name) return tempComponent;
					tempComponent = roundTotalChildByName(tempComponent, name);
					if (tempComponent) return tempComponent;
				}
			}
			return null;
		}
		/**
		 *循环遍历树状结构获取子组件 
		 * @param parent
		 * @param name
		 * @return 
		 * 
		 */		
		public static function getTotalChildByName1(parent:IComponent, name:String):IComponent
		{
			if (parent.name == name) return parent;
			//组装当前的currentList
			var currentList:Vector.<IComponent> = parent.children;
			while(currentList.length > 0)
			{
				var replaceList:Vector.<IComponent> = new Vector.<IComponent>;
				for each(var component:IComponent in currentList)
				{
					if (component.name == name)
					{
						return component;
					}
					for each(var tempComponent:IComponent in component.children)
					{
						replaceList.push(tempComponent);
					}
				}
				currentList = replaceList;
			}
			return null;
		}
		
		//add
		/**
		 *给定父级组件，子组件，为子组件添加组件 
		 * @param component
		 * @param parent
		 * @return 
		 * 
		 */		
		public static function addChild(component:IComponent, parent:IComponent):IComponent
		{
			var tempComponent:IComponent = getChildByName(parent, component.name);
			if (tempComponent) return tempComponent;
			parent.children.push(component);
			component.parent = parent;
			return component;
		}
		
		/**
		 *给定父级组件，子组件，索引 
		 * @param component
		 * @param index
		 * @param parent
		 * @return 
		 * 
		 */		
		public static function addChildAt(component:IComponent, index:uint, parent:IComponent):int
		{
			var i:int = getIndexByName(parent, component.name);
			if (i != -1) return i;
			if (index >= parent.children.length) index = parent.children.length - 1;
			if (index < 0) index = 0;
			parent.children.splice(index, 0, component);
			component.parent = parent;
			return index;
		}
		
		//change
		/**
		 *更换索引 
		 * @param component
		 * @param index
		 * @return 
		 * 
		 */		
		public static function changeIndex(component:IComponent, index:uint, parent:IComponent):int
		{
			if (!component.parent) throw new Error("error component");
			removeChildByName(component.parent, component.name);
			return addChildAt(component, index, parent);
		}
		
		//remove
		/**
		 *给定父级组件，根据名称移除子级组件中相应的组件 
		 * @param parent
		 * @param name
		 * @return 
		 * 
		 */		
		public static function removeChildByName(parent:IComponent, name:String):IComponent
		{
			var index:int = 0;
			for each(var tempComponent:IComponent in parent.children)
			{
				if (tempComponent.name == name)
				{
					return parent.children.splice(index, 1)[0];
				}
				index ++;
			}
			return null;
		}
	}
}