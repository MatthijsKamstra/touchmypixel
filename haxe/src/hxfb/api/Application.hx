/**
 * 
 Copyright (c) 2010 SoybeanSoft

 Permission is hereby granted, free of charge, to any person
 obtaining a copy of this software and associated documentation
 files (the "Software"), to deal in the Software without
 restriction, including without limitation the rights to use,
 copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the
 Software is furnished to do so, subject to the following
 conditions:

 The above copyright notice and this permission notice shall be
 included in all copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 OTHER DEALINGS IN THE SOFTWARE.
 *
 * Application API
 * @author Guntur Sarwohadi
 */

package hxfb.api;

import hxfb.HxFb;

class Application 
{
	private var hnf:HxFb;
	private var params(getParams, null):Hash<Dynamic>;
	private function getParams():Hash<Dynamic>
	{
		return new Hash<Dynamic>();
	}
	
	public function new(hnf:HxFb) 
	{
		this.hnf = hnf;
	}
	
	/**
   * Returns public information for an application (as shown in the application
   * directory) by either application ID, API key, or canvas page name.
   *
   * @param String $application_id           (Optional) app id
   * @param string $application_api_key      (Optional) api key
   * @param string $application_canvas_name  (Optional) canvas name
   *
   * Exactly one argument must be specified, otherwise it is an error.
   *
   * @return array  An array of public information about the application.
   */
	public function getPublicInfo(?applicationId:String, ?applicationAPIKey:String, ?applicationCanvasName:String):Dynamic
	{
		params.set("application_id", applicationId);
		params.set("application_api_key", applicationAPIKey);
		params.set("application_canvas_name", applicationCanvasName);
		
		return hnf.callMethod("facebook.application.getPublicInfo", params);
	}
	
}