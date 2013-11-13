package org.spzktshow.moumoon.core.source
{
	import org.spzktshow.moumoon.core.group.IGroupItem;
	
	import starling.textures.Texture;

	/**
	 *最小单位的资源 
	 * @author rocklee
	 * 
	 */
	public interface ISource extends IGroupItem
	{
		/**
		 *资源数据 
		 * @param value
		 * 
		 */		
		function set data(value:Texture):void;
		function get data():Texture;
	}
}