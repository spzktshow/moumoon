package org.spzktshow.moumoon.sunshine.model.source
{
	import org.puremvc.as3.patterns.proxy.Proxy;
	import org.spzktshow.moumoon.core.group.IGroup;
	import org.spzktshow.moumoon.core.group.IGroupItem;
	import org.spzktshow.moumoon.core.source.ISourceOperation;
	import org.spzktshow.moumoon.core.source.SourceOperation;
	import org.spzktshow.moumoon.sunshine.controller.source.SourceCommand;
	
	public class SourceModel extends Proxy implements IGroup
	{
		public static const NAME:String = "sourceModelName";
		
		private var _sourceOperation:ISourceOperation;
		
		public function SourceModel()
		{
			_sourceOperation = new SourceOperation;
			super(NAME);
		}
		
		override public function onRegister():void
		{
			
		}
		
		override public function onRemove():void
		{
			
		}
		
		public function get total():Vector.<IGroupItem>
		{
			return _sourceOperation.total;
		}
		
		public function addItem(value:IGroupItem):int
		{
			var index:int = _sourceOperation.addItem(value);
			this.sendNotification(SourceCommand.ADDED_SOURCE, value);
			return index;
		}
		
		public function checkItem(name:String):int
		{
			return checkItem(name);
		}
		
		public function getItem(name:String):IGroupItem
		{
			return getItem(name);
		}
		
		public function removeItem(name:String):IGroupItem
		{
			var groupItem:IGroupItem = _sourceOperation.removeItem(name);
			this.sendNotification(SourceCommand.REMOVED_SOURCE, groupItem);
			return groupItem;
		}	
		
	}
}