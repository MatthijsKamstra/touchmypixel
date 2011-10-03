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
 * Video API
 * @author Guntur Sarwohadi
 */

package hxfb.api;

import hxfb.HxFb;
import hxjson2.JSONEncoder;

class Video 
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
	* Uploads a video.
	*
	* @param  string $file        The location of the video on the local filesystem.
	* @param  string $title       (Optional) A title for the video. Titles over 65 characters in length will be truncated.
	* @param  string $description (Optional) A description for the video.
	*
	* @return array  An array with the video's ID, title, description, and a link to view it on Facebook.
	*/
	public function upload(file:String, ?title:String, ?description:String):Dynamic
	{
		params.set("title", title);
		params.set("description", description);
		
		return hnf.callUploadMethod("facebook.video.upload", params, file, HxFb.getFacebookURL("api-video") + "/restserver.php");
	}
	
	/**
	* Returns an array with the video limitations imposed on the current session's
	* associated user. Maximum length is measured in seconds; maximum size is
	* measured in bytes.
	*
	* @return array  Array with "length" and "size" keys
	*/
	public function getUploadLimits():Dynamic
	{
		return hnf.callMethod("facebook.video.getUploadLimits");
	}
}