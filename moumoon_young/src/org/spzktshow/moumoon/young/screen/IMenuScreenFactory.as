package org.spzktshow.moumoon.young.screen
{
	import feathers.controls.ScreenNavigator;
	
	import org.spzktshow.moumoon.young.menu.IMenuListContext;

	public interface IMenuScreenFactory
	{
		function create(menuListContext:IMenuListContext):ScreenNavigator;
	}
}