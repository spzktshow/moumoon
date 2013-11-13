package org.spzktshow.moumoon.core.group
{
	public class Group implements IGroup
	{
		protected var _items:Vector.<IGroupItem>;
		
		public function Group()
		{
			_items = new Vector.<IGroupItem>;
		}
		
		public function addItem(value:IGroupItem):int
		{
			var index:int = checkItem(value.name);
			if (index != -1) return -1;
			return _items.push(value);
		}
		
		public function removeItem(name:String):IGroupItem
		{
			var index:int = checkItem(name);
			if (index != -1) return _items.splice(index, 1)[0];
			return null;
		}
		
		public function checkItem(name:String):int
		{
			var index:int = 0;
			for each(var item:IGroupItem in _items)
			{
				if (item.name == name)
				{
					return index;
				}
				index ++;
			}
			return -1;
		}
		
		public function getItem(name:String):IGroupItem
		{
			var index:int = checkItem(name);
			if (index != -1) return _items[index] as IGroupItem;
			return null;
		}
		
		public function get total():Vector.<IGroupItem>
		{
			return _items;
		}
	}
}