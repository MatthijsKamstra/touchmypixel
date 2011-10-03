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
 * Friends API
 * @author Guntur Sarwohadi
 */

package hxfb.api;

import hxfb.HxFb;
import hxjson2.JSONEncoder;

class Friends 
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
	* Returns whether or not pairs of users are friends.
	* Note that the Facebook friend relationship is symmetric.
	*
	* @param array/string $uids1  list of ids (id_1, id_2,...)
	*                       of some length X (csv is deprecated)
	* @param array/string $uids2  list of ids (id_A, id_B,...)
	*                       of SAME length X (csv is deprecated)
	*
	* @return array  An array with uid1, uid2, and bool if friends, e.g.:
	*   array(0 => array('uid1' => id_1, 'uid2' => id_A, 'are_friends' => 1),
	*         1 => array('uid1' => id_2, 'uid2' => id_B, 'are_friends' => 0)
	*         ...)
	* @error
	*    API_EC_PARAM_USER_ID_LIST
	*/
	public function areFriends(uIds1:Array<String>, uIds2:Array<String>):Dynamic
	{
		params.set("uids1", uIds1);
		params.set("uids2", uIds2);
		
		return hnf.callMethod("facebook.friends.areFriends", params);
	}
	
	/**
	* Returns the friends of the current session user.
	*
	* @param int $flid  (Optional) Only return friends on this friend list.
	* @param int $uid   (Optional) Return friends for this user.
	*
	* @return array  An array of friends
	*/
	public function get(?flId:String, ?uId:Int):Dynamic
	{
		if (hnf.getFriendList() != null)
			return hnf.getFriendList();
		
		if (uId == null && hnf.getCanvasUser() != null)
			uId = Std.parseInt(hnf.getCanvasUser());
		
		params.set("uid", uId);
		params.set("flid", flId);
		
		return hnf.callMethod("facebook.friends.get", params);
	}
	
	/**
	* Returns the mutual friends between the target uid and a source uid or
	* the current session user.
	*
	* @param int $target_uid Target uid for which mutual friends will be found.
	* @param int $source_uid (optional) Source uid for which mutual friends will
	*                                   be found. If no source_uid is specified,
	*                                   source_id will default to the session
	*                                   user.
	* @return array  An array of friend uids
	*/
	public function getMutualFriends(targetUID:String, ?sourceUID:String):Dynamic
	{
		params.set("target_uid", targetUID);
		params.set("source_uid", sourceUID);
		
		return hnf.callMethod("facebook.friends.getMutualFriends", params);
	}
	
	/**
	* Returns the set of friend lists for the current session user.
	*
	* @return array  An array of friend list objects
	*/
	public function getLists():Dynamic
	{
		return hnf.callMethod("facebook.friends.getLists");
	}
	
	/**
	* Returns the friends of the session user, who are also users
	* of the calling application.
	*
	* @return array  An array of friends also using the app
	*/
	public function getAppUsers():Dynamic
	{
		return hnf.callMethod("facebook.friends.getAppUsers");
	}
	
}