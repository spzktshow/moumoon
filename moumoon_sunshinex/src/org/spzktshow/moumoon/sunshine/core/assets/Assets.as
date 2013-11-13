package org.spzktshow.moumoon.sunshine.core.assets
{
	import flash.display.Bitmap;
	
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	/**
	 *全局资源管理器 
	 * @author rocklee
	 * 
	 */	
	public class Assets
	{
		public function Assets()
		{
		}
		
		private static var _instance:Assets;
		public static function getInstance():Assets
		{
			if (!_instance)
			{
				_instance = new Assets;
			}
			return _instance;
		}
		
		//
		[Embed(source="assets/icon.png", mimeType="image/png")]
		public var iconPng:Class;
		
		[Embed(source="assets/icon.xml", mimeType="application/octet-stream")]
		public var iconXml:Class;
		
		public var iconSource:TextureAtlas;
		/**
		 *眼镜 
		 */		
		public static const EYE:String = "eye";
		/**
		 *是否打开 
		 */		
		public static const IS_OPEN:String = "isOpen";
		/**
		 *锁 
		 */		
		public static const LOCK:String = "lock";
		/**
		 *未打开 
		 */		
		public static const NO_OPEN:String = "noOpen";
		
		
		public function registerGlobal():void
		{
			var bitmap:Bitmap = new iconPng() as Bitmap;
			var texture:Texture = Texture.fromBitmap(bitmap);
			var xml:XML = XML(new iconXml());
			iconSource = new TextureAtlas(texture, xml);
		}
	}
}