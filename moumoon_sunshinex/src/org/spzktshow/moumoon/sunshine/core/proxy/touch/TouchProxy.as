package org.spzktshow.moumoon.sunshine.core.proxy.touch
{
	import flash.geom.Point;
	
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;

	/**
	 *mouse事件模拟 
	 * @author rocklee
	 * 
	 */
	public class TouchProxy
	{
		protected var _displayObject:DisplayObject;
		
		protected var _isOver:Boolean;
		
		public function TouchProxy(displayObject:DisplayObject)
		{
			_displayObject = displayObject;
			
			addListeners();
		}
		
		public function get displayObject():DisplayObject
		{
			return _displayObject;
		}

		public function dispose():void
		{
			removeListeners();
			
			_displayObject = null;
		}
		
		protected function addListeners():void
		{
			_displayObject.addEventListener(TouchEvent.TOUCH, onTouchHandler);
		}
		
		protected function removeListeners():void
		{
			_displayObject.removeEventListener(TouchEvent.TOUCH, onTouchHandler);
		}
		
		protected function onTouchHandler(e:TouchEvent):void
		{
			if (!e.getTouch(this._displayObject))
			{
				_isOver = false;
				mouseEvent = new MouseEvent(MouseEvent.MOUSE_OUT);
				this._displayObject.dispatchEvent(mouseEvent);
				return;
			}
			var touch:Touch = e.touches[0];
			trace ("touchHandler: " + touch.phase);
			if (touch)
			{
				var mouseEvent:MouseEvent;
				if (touch.phase == TouchPhase.HOVER)
				{
					//mouseOver or mouseOut or rollOver or rollOut
					if (_isOver)//是否划过
					{
						if (_displayObject.hitTest(new Point(Starling.current.nativeStage.mouseX, Starling.current.nativeStage.mouseY)))//和鼠标有接触
						{
							return;
						}
						else//和鼠标没接触
						{
						}
					}
					else
					{
						if (_displayObject.hitTest(new Point(Starling.current.nativeStage.mouseX, Starling.current.nativeStage.mouseY)))//和鼠标有接触
						{
							_isOver = true;
							mouseEvent = new MouseEvent(MouseEvent.MOUSE_OVER);
							this._displayObject.dispatchEvent(mouseEvent);
						}
						else//和鼠标没接触
						{
							return;
						}
					}
				}
				else if (touch.phase == TouchPhase.BEGAN)
				{
					//mouseDown
					trace ("mouseDown");
					mouseEvent = new MouseEvent(MouseEvent.MOUSE_DOWN);
					_displayObject.dispatchEvent(mouseEvent);
				}
				else if (touch.phase == TouchPhase.MOVED)
				{
					//mouseMove
					trace ("mouseMove");
					mouseEvent = new MouseEvent(MouseEvent.MOUSE_MOVE);
					_displayObject.dispatchEvent(mouseEvent);
				}
				else if (touch.phase == TouchPhase.ENDED)
				{
					//mouseUp
					trace ("mouseUp");
					mouseEvent = new MouseEvent(MouseEvent.MOUSE_UP);
					_displayObject.dispatchEvent(mouseEvent);
					mouseEvent = new MouseEvent(MouseEvent.MOUSE_CLICK);
					_displayObject.dispatchEvent(mouseEvent);
				}
			}
		}
	}
}