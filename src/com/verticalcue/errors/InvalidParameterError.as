package com.verticalcue.errors 
{
	/**
	 * @author John Vrbanac
	 */
	public class InvalidParameterError extends Error 
	{
		
		public function InvalidParameterError(message:*="", id:*=0) 
		{
			super("Invalid Parameter(s) - " + message, id);
		}
		
	}

}