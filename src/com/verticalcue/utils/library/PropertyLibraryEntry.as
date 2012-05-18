package com.verticalcue.utils.library 
{
	/**
	 * Storage class
	 * @author John Vrbanac
	 */
	public class PropertyLibraryEntry 
	{
		private var _payload:*
		private var _name:String;
		public function PropertyLibraryEntry() 
		{
			
		}
		
		public function get payload():* 
		{
			return _payload;
		}
		
		public function set payload(value:*):void 
		{
			_payload = value;
		}
		
		public function get name():String 
		{
			return _name;
		}
		
		public function set name(value:String):void 
		{
			_name = value;
		}
		
	}

}