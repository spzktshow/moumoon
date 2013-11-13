package org.spzktshow.moumoon.sunshine.view.sourcePanel.mediator
{
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import feathers.controls.Callout;
	import feathers.controls.Label;
	import feathers.controls.Panel;
	import feathers.controls.Scroller;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	import org.spzktshow.moumoon.core.source.ISource;
	import org.spzktshow.moumoon.sunshine.controller.file.FileCommand;
	import org.spzktshow.moumoon.sunshine.controller.floatlayer.FloatLayerCommand;
	import org.spzktshow.moumoon.sunshine.controller.floatlayer.FloatLayerCommandData;
	import org.spzktshow.moumoon.sunshine.core.file.IEditorFile;
	import org.spzktshow.moumoon.sunshine.core.proxy.touch.MouseEvent;
	import org.spzktshow.moumoon.sunshine.core.proxy.touch.TouchProxy;
	import org.spzktshow.moumoon.sunshine.core.uitls.ImageUtils;
	
	import starling.core.Starling;
	import starling.display.Image;
	
	public class SourcePanelMediator extends Mediator
	{
		public static const NAME:String = "sourcePanelMediatorName";
		
		private static const HEIGHT:Number = 160;
		private static const WIDHT:Number = 160;
		private static const GAP:Number = 10;
		
		private var _sourceTotal:int;
		private var _sourceList:Vector.<ISource>;
		private var _touchProxyList:Vector.<TouchProxy>;
		/**
		 *当前得tip文字 
		 */		
		private var _label:Label;
		/**
		 *当前得tip 
		 */		
		private var _callOut:Callout;
		/**
		 *当前资源名称 
		 */		
		private var _currentSourceName:String;
		
		public function SourcePanelMediator(viewComponent:Object=null)
		{
			super(NAME, viewComponent);
		}
		
		override public function onRegister():void
		{
			_sourceList = new Vector.<ISource>;
			_touchProxyList = new Vector.<TouchProxy>;
			sourcePanel.interactionMode = Scroller.INTERACTION_MODE_MOUSE;
			sourcePanel.scrollBarDisplayMode = Scroller.SCROLL_BAR_DISPLAY_MODE_FIXED;
		}
		
		override public function onRemove():void
		{
			Starling.current.nativeStage.addEventListener(flash.events.MouseEvent.MOUSE_UP, onMouseStageUpHandler);
			_sourceList = null;
			_touchProxyList = null;
		}
		
		override public function listNotificationInterests():Array
		{
			return [FileCommand.FILE_ADDED_SOURCE, FileCommand.FOCUSED_FILE];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			if (notification.getName() == FileCommand.FOCUSED_FILE)
			{
				_sourceTotal = 0;
				_sourceList = new Vector.<ISource>;//清空数组
				_touchProxyList = new Vector.<TouchProxy>;
				sourcePanel.removeChildren();
				var editorFile:IEditorFile = notification.getBody() as IEditorFile;
				for each(var source:ISource in editorFile.sources)
				{
					addSource(source);
				}
			}
			else if (notification.getName() == FileCommand.FILE_ADDED_SOURCE)
			{
				addSource(notification.getBody() as ISource);
			}
		}
		/**
		 *添加资源 
		 * @param source
		 * 
		 */		
		private function addSource(source:ISource):void
		{
			_sourceList.push(source);
			var image:Image = new Image(source.data);
			image.name = source.name;
			image.addEventListener(org.spzktshow.moumoon.sunshine.core.proxy.touch.MouseEvent.MOUSE_OVER, onMouseOverHandler);
			image.addEventListener(org.spzktshow.moumoon.sunshine.core.proxy.touch.MouseEvent.MOUSE_OUT, onMouseOutHandler);
			image.addEventListener(org.spzktshow.moumoon.sunshine.core.proxy.touch.MouseEvent.MOUSE_DOWN, onMouseDownHandler);
			sourcePanel.addChild(image);
			ImageUtils.calculateImage(image, HEIGHT);
			image.y = _sourceTotal * HEIGHT + _sourceTotal * GAP;
			image.x = sourcePanel.width * .5 - 160 * .5;
			
			var touchProxy:TouchProxy = new TouchProxy(image);
			_touchProxyList.push(touchProxy);
			
			_sourceTotal ++;
		}
		
		private function onMouseOverHandler(e:org.spzktshow.moumoon.sunshine.core.proxy.touch.MouseEvent):void
		{
			trace ("MouseOver");
		}
		
		private function onMouseOutHandler(e:org.spzktshow.moumoon.sunshine.core.proxy.touch.MouseEvent):void
		{
			trace ("MouseOut");
		}
		
		private function onMouseDownHandler(e:org.spzktshow.moumoon.sunshine.core.proxy.touch.MouseEvent):void
		{
			trace ("mouseDown");
			//发送浮动资源
			_currentSourceName = Image(e.currentTarget).name;
			var data:FloatLayerCommandData = new FloatLayerCommandData();
			data.sourceName = Image(e.currentTarget).name;
			data.point = new Point(Starling.current.nativeStage.mouseX, Starling.current.nativeStage.mouseY);
			this.sendNotification(FloatLayerCommand.FLOAT_SOURCE, data);
		}
		
		private function onMouseStageMoveHandler(e:flash.events.MouseEvent):void
		{
			trace ("mouseMover");
		}
		
		private function onMouseStageUpHandler(e:flash.events.MouseEvent):void
		{
			trace ("mouseUp");
			Starling.current.nativeStage.removeEventListener(flash.events.MouseEvent.MOUSE_MOVE, onMouseStageMoveHandler);
			Starling.current.nativeStage.removeEventListener(flash.events.MouseEvent.MOUSE_UP, onMouseStageUpHandler);
			if (!sourcePanel.hitTest(new Point(e.stageX, e.stageY)))
			{
				
			}
		}
		
		public function get sourcePanel():Panel
		{
			return this.viewComponent as Panel;
		}
	}
}