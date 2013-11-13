package org.spzktshow.moumoon.sunshine.model.componentList
{
	import org.puremvc.as3.patterns.proxy.Proxy;
	import org.spzktshow.moumoon.sunshine.controller.componentList.ComponentListCommand;
	import org.spzktshow.moumoon.sunshine.core.component.IListComponent;
	import org.spzktshow.moumoon.sunshine.core.file.IEditorFile;
	
	public class ComponentListModel extends Proxy
	{
		public static const NAME:String = "componentListModelName";
		
		private var _editorFile:IEditorFile;
		
		private var _currentFocus:IListComponent;
		
		private var _currentContainerFocus:IListComponent;
		
		public function ComponentListModel()
		{
			super(NAME);
		}

		override public function onRegister():void
		{
			this.sendNotification(ComponentListCommand.INITED);
		}
		
		/**
		 *对当前操作的editorFile的引用，每当fileModel的focus发生改变，editorFile的值也相应的改变 
		 */
		public function get editorFile():IEditorFile
		{
			return _editorFile;
		}
		
		/**
		 * @private
		 */
		public function set editorFile(value:IEditorFile):void
		{
			_editorFile = value;
		}
		
		public function get currentFocus():IListComponent
		{
			return _currentFocus;
		}
		/**
		 *当前的焦点组件 
		 * @param value
		 * 
		 */		
		public function set currentFocus(value:IListComponent):void
		{
			_currentFocus = value;
		}
		
		/**
		 * @private
		 */
		public function get currentContainerFocus():IListComponent
		{
			return _currentContainerFocus;
		}
		/**
		 * 当前作为容器焦点的组件
		 * @param value
		 * 
		 */		
		public function set currentContainerFocus(value:IListComponent):void
		{
			_currentContainerFocus = value;
		}
	}
}