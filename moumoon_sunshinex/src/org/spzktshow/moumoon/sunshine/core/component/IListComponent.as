package org.spzktshow.moumoon.sunshine.core.component
{
	import org.spzktshow.moumoon.core.component.IComponent;

	public interface IListComponent extends IComponent
	{
		//======================display layer operation========================
		/**
		 *是否在显示列表中打开状态
		 * @param value
		 * 
		 */		
		function set isOpen(value:Boolean):void;
		function get isOpen():Boolean;
		/**
		 *是否显示 
		 * @param value
		 * 
		 */		
		function set isView(value:Boolean):void;
		function get isView():Boolean;
		/**
		 *isLock 
		 * @param value
		 * 
		 */		
		function set isLock(value:Boolean):void;
		function get isLock():Boolean;
		//======================focus
		/**
		 *是否是当前的焦点组件 
		 * @param value
		 * 
		 */		
		function set isFocus(value:Boolean):void;
		function get isFocus():Boolean;
		/**
		 *是否作为容器焦点 
		 * @param value
		 * 
		 */		
		function set isFocusBeContainer(value:Boolean):void;
		function get isFocusBeContainer():Boolean;
	}
}