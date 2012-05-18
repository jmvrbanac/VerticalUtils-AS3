package com.verticalcue.errors 
{
	/**
	 * @author John Vrbanac
	 */
	public class NotImplementedError extends Error 
	{
		
		public function NotImplementedError(message:*="", id:*=0) 
		{
			super("This feature hasn't been implemented - " + message, id);
			
		}
		
	}

}