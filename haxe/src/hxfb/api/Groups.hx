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
 * Groups API
 * @author Guntur Sarwohadi
 */
 
package hxfb.api;

import hxfb.HxFb;
import hxjson2.JSONEncoder;

class Groups 
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
	* Returns groups according to the filters specified.
	*
	* @param String $uid     (Optional) User associated with groups.  A null
	*                     parameter will default to the session user.
	* @param array/string $gids (Optional) Array of group ids to query. A null
	*                     parameter will get all groups for the user.
	*                     (csv is deprecated)
	*
	* @return array  An array of group objects
	*/
	public function get(?uId:String, ?gIds:Array<String>):Dynamic
	{
		params.set("uid", uId);
		params.set("gids", gIds);
		
		return hnf.callMethod("facebook.groups.get", params);
	}
	
	/**
	* Returns the membership list of a group.
	*
	* @param String $gid  Group id
	*
	* @return array  An array with four membership lists, with keys 'members',
	*                'admins', 'officers', and 'not_replied'
	*/
	public function getMembers(gId:String):Dynamic
	{
		params.set("gid", gId);
		
		return hnf.callMethod("facebook.groups.getMembers", params);
	}
	
}