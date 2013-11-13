package org.spzktshow.moumoon.sunshine.core.source
{
	import flash.display.BitmapData;
	
	import org.spzktshow.moumoon.core.source.Source;
	
	public class BitmapSource extends Source
	{
		private var _bitmapUrl:String;
		private var _bitmapData:BitmapData;
		
		public function BitmapSource()
		{
			super();
		}

		/**
		 *位图路径 
		 */
		public function get bitmapUrl():String
		{
			return _bitmapUrl;
		}

		/**
		 * @private
		 */
		public function set bitmapUrl(value:String):void
		{
			_bitmapUrl = value;
		}

		/**
		 *位图资源 
		 */
		public function get bitmapData():BitmapData
		{
			return _bitmapData;
		}

		/**
		 * @private
		 */
		public function set bitmapData(value:BitmapData):void
		{
			_bitmapData = value;
		}


	}
}