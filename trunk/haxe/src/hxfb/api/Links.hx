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
 * Links API
 * @author Guntur Sarwohadi
 */

package hxfb.api;

import hxfb.HxFb;
import hxjson2.JSONEncoder;

class Links 
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
	* Retrieves links posted by the given user.
	*
	* @param String    $uid      The user whose links you wish to retrieve
	* @param int    $limit    The maximimum number of links to retrieve
	* @param array $link_ids (Optional) Array of specific link
	*                          IDs to retrieve by this user
	*
	* @return array  An array of links.
	*/
	public function get(uId:String, limit:Int, ?linkIds:Array<Int>):Dynamic
	{
		params.set("uid", uId);
		params.set("limit", limit);
		params.set("link_ids", linkIds);
		
		return hnf.callMethod("facebook.links.get", params);
	}
	
	public function post(url:String, ?comment:String = "", ?uId:String):Bool
	{
		params.set("uid", uId);
		params.set("url", url);
		params.set("comment", comment);
		
		return hnf.callMethod("facebook.links.post", params);
	}
	
}