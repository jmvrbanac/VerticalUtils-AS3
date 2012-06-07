package com.verticalcue.utils.displayobject 
{
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.utils.Dictionary;
	
	/**
	 * A sprite based class that allows for easier cleanup for
	 * garbage collection.
	 * @version 1.0
	 * @author John Vrbanac
	 */
	public class AdvancedSprite extends Sprite 
	{
		private var _listeners:Dictionary = new Dictionary();
		public function AdvancedSprite() 
		{
			super();
		}
		public function removeAllChildren():void
		{
			for (var i:int = 0; i < numChildren; i++) {
				var child:DisplayObject = this.getChildAt(i);
				
				// Dispose bitmaps so they don't just hang in memory
				if (child is Bitmap) {
					Bitmap(child).bitmapData.dispose();
				}
				this.removeChildAt(i);
			}
		}
		public function removeAllListeners():void 
		{
			for each (var key:String in _listeners) {
				this.removeEventListener(key, _listeners[key]);
			}
		}
		override public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void 
		{
			_listeners[type] = listener;
			super.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}
		override public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void 
		{
			_listeners[type] = null;
			super.removeEventListener(type, listener, useCapture);
		}
		
	}

}