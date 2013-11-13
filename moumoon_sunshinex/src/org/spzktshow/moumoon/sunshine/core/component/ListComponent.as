package org.spzktshow.moumoon.sunshine.core.component
{
	import org.spzktshow.moumoon.core.component.Component;
	
	public class ListComponent extends Component implements IListComponent
	{
		public function ListComponent()
		{
			_isOpen = true;
			_isLock = false;
			_isView = true;
			super();
		}
		
		private var _isOpen:Boolean;
		public function set isOpen(value:Boolean):void
		{
			_isOpen = value;
		}
		
		public function get isOpen():Boolean
		{
			return _isOpen;
		}
		
		private var _isLock:Boolean;
		public function set isLock(value:Boolean):void
		{
			_isLock = value;
		}
		
		public function get isLock():Boolean
		{
			return _isLock;
		}
		
		private var _isView:Boolean;
		public function set isView(value:Boolean):void
		{
			_isView = value;
		}
		
		public function get isView():Boolean
		{
			return _isView;
		}
		
		private var _isFocus:Boolean;
		public function set isFocus(value:Boolean):void
		{
			_isFocus = value;
		}
		
		public function get isFocus():Boolean
		{
			return _isFocus;
		}
		
		private var _isFocusBeContainer:Boolean;
		public function set isFocusBeContainer(value:Boolean):void
		{
			_isFocusBeContainer = value;
		}
		
		public function get isFocusBeContainer():Boolean
		{
			return _isFocusBeContainer;
		}
		
		
	}
}