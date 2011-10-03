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
 * Users API
 * @author Guntur Sarwohadi
 */

package hxfb.api;

import hxfb.HxFb;

class Users 
{
	private var hnf:HxFb;
	private var isUser:Bool;
	
	public function new(hnf:HxFb) 
	{
		this.hnf = hnf;
	}
	
	/**
     * Returns the requested info fields for the requested set of users.
     *
     * @param Array<String>   uids    An array of user ids (csv is deprecated)
     * @param Array<String> fields  An array of info field names desired (csv is deprecated)
     *
     * @return Dynamic              User objects
     */
	public function getInfo(uids:Array<String>, fields:Array<String>):Dynamic
	{
		var params:Hash<Dynamic> = new Hash<Dynamic>();
		params.set("uids", uids);
		params.set("fields", fields);
		
		return hnf.callMethod("facebook.users.getInfo", params);
	}
	
	/**
     * Returns the user corresponding to the current session object.
     *
     * @return String	User id
     */
	public function getLoggedInUser():String
	{
		return hnf.callMethod("facebook.users.getLoggedInUser");
	}
	
	/**
     * Returns the requested info fields for the requested set of users. A
     * session key must not be specified. Only data about users that have
     * authorized your application will be returned.
     *
     * Check the wiki for fields that can be queried through this API call.
     * Data returned from here should not be used for rendering to application
     * users, use users.getInfo instead, so that proper privacy rules will be
     * applied.
     *
     * @param Array<String>	uids    An array of user ids (csv is deprecated)
     * @param Array<String> fields  An array of info field names desired (csv is deprecated)
     *
     * @return Dynamic              User objects
     */
	public function getStandardInfo(uids:Array<String>, fields:Array<String>):Dynamic
	{
		var params:Hash<Dynamic> = new Hash<Dynamic>();
		params.set("uids", uids);
		params.set("fields", fields);
		
		return hnf.callMethod("facebook.users.getStandardInfo", params);
	}
	
	/**
     * Returns 1 if the user has the specified permission, 0 otherwise.
     * http://wiki.developers.facebook.com/index.php/Users.hasAppPermission
     *
     * @return integer  1 or 0
     */
	public function hasAppPermission(ext_perm:String, ?uid:String):Int
	{
		var params:Hash<Dynamic> = new Hash<Dynamic>();
		params.set("ext_perm", ext_perm);
		params.set("uid", uid);
		
		return hnf.callMethod("facebook.users.hasAppPermission", params);
	}
	
	/**
     * Returns whether or not the user corresponding to the current
     * session object has the give the app basic authorization.
     *
     * @return Bool  true if the user has authorized the app
     */
	public function isAppUser(?uid:String):Bool
	{
		if (uid == null && isUser != null)
			return isUser;
		
		var params:Hash<Dynamic> = new Hash<Dynamic>();
		params.set("uid", uid);
		
		return hnf.callMethod("facebook.users.isAppUser", params);
	}
	
	/**
     * Returns whether or not the user corresponding to the current
     * session object is verified by Facebook. See the documentation
     * for Users.isVerified for details.
     *
     * @return boolean  true if the user is verified
     */
	public function isVerified():Bool
	{
		return hnf.callMethod("facebook.users.isVerified");
	}
	
	/**
     * Sets the users' current status message. Message does NOT contain the
     * word "is" , so make sure to include a verb.
     *
     * Example: setStatus("is loving the API!")
     * will produce the status "Luke is loving the API!"
     *
     * @param String status                 text-only message to set
     * @param String uid                    user to set for (defaults to the
     *                                      logged-in user)
     * @param Bool   clear                  whether or not to clear the status,
     *                                      instead of setting it
     * @param Bool   statusIncludesVerb     if true, the word "is" will *not* be
     *                                      prepended to the status message
     *
     * @return boolean
     */
	public function setStatus(status:String, ?uid:String, ?clear:Bool, ?statusIncludesVerb:Bool):Bool
	{
		var params:Hash<Dynamic> = new Hash<Dynamic>();
		params.set("status", status);
		params.set("uid", uid);
		params.set("clear", (clear == null)? false : clear);
		params.set("status_includes_verb", (statusIncludesVerb == null)? false : statusIncludesVerb);
		
		return hnf.callMethod("facebook.users.setStatus", params);
	}
	
}