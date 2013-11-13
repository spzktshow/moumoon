package org.spzktshow.moumoon.young.theme
{
	import flash.text.TextFormat;
	
	import feathers.controls.Header;
	import feathers.controls.TextInput;
	import feathers.display.Scale9Image;
	import feathers.themes.MetalWorksMobileTheme;
	
	import org.spzktshow.moumoon.young.label.AlertLabel;
	
	import starling.display.DisplayObjectContainer;
	
	public class MoumoonYoungTheme extends MetalWorksMobileTheme
	{
		public function MoumoonYoungTheme(container:DisplayObjectContainer=null, scaleToDPI:Boolean=true)
		{
			super(container, scaleToDPI);
		}
		
		override protected function initialize():void
		{
			super.initialize();
			
			const fontNames:String = "Helvetica Neue,Helvetica,Roboto,Arial,_sans";
			this.headerTextFormat = new TextFormat(fontNames, Math.round(24 * this.scale), LIGHT_TEXT_COLOR, true);
			
			this.setInitializerForClass(AlertLabel, labelInitializer);
		}
		
		override protected function headerInitializer(header:Header):void
		{
			super.headerInitializer(header);
			header.titleProperties.embedFonts = false;
		}
		
		override protected function headerWithoutBackgroundInitializer(header:Header):void
		{
			super.headerWithoutBackgroundInitializer(header);
			header.titleProperties.embedFonts = false;
		}
		
		override protected function textInputInitializer(input:TextInput):void
		{
			const backgroundSkin:Scale9Image = new Scale9Image(this.backgroundSkinTextures, this.scale);
			backgroundSkin.width = 264 * this.scale;
			backgroundSkin.height = 60 * this.scale;
			input.backgroundSkin = backgroundSkin;
			
			const backgroundDisabledSkin:Scale9Image = new Scale9Image(this.backgroundDisabledSkinTextures, this.scale);
			backgroundDisabledSkin.width = 264 * this.scale;
			backgroundDisabledSkin.height = 60 * this.scale;
			input.backgroundDisabledSkin = backgroundDisabledSkin;
			
			const backgroundFocusedSkin:Scale9Image = new Scale9Image(this.backgroundFocusedSkinTextures, this.scale);
			backgroundFocusedSkin.width = 264 * this.scale;
			backgroundFocusedSkin.height = 60 * this.scale;
			input.backgroundFocusedSkin = backgroundFocusedSkin;
			
			input.minWidth = input.minHeight = 60 * this.scale;
			input.minTouchWidth = input.minTouchHeight = 88 * this.scale;
			input.paddingTop = 1 * this.scale;//12
			input.paddingBottom = 1 * this.scale;//10
			input.paddingLeft = input.paddingRight = 2 * this.scale;//14
			input.textEditorProperties.fontFamily = "Helvetica";
			input.textEditorProperties.fontSize = 24 * this.scale;//24
			input.textEditorProperties.color = LIGHT_TEXT_COLOR;
			
			input.promptProperties.textFormat = this.smallLightTextFormat;
			input.promptProperties.embedFonts = true;
		}
	}
}