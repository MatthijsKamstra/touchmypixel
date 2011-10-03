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
 * Notifications API
 * @author Guntur Sarwohadi
 */

package hxfb.api;

import hxfb.HxFb;
import hxjson2.JSONEncoder;

class Notifications 
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
	* Returns the outstanding notifications for the session user.
	*
	* @return array An assoc array of notification count objects for
	*               'messages', 'pokes' and 'shares', a uid list of
	*               'friend_requests', a gid list of 'group_invites',
	*               and an eid list of 'event_invites'
	*/
	public function get():Dynamic
	{
		return hnf.callMethod("facebook.notifications.get");
	}
	
	/**
	* Sends a notification to the specified users.
	*
	* @return A comma separated list of successful recipients
	* @error
	*    API_EC_PARAM_USER_ID_LIST
	*/
	public function send(toIds:Array<Int>, notification:String, type:String):Dynamic
	{
		params.set("to_ids", toIds);
		params.set("notification", notification);
		params.set("type", type);
		
		return hnf.callMethod("facebook.notifications.send", params);
	}
	
	public function sendEmail(recipients:Array<String>, subject:String, text:String, fbml:String):String
	{
		params.set("recipients", recipients);
		params.set("subject", subject);
		params.set("text", text);
		params.set("fbml", fbml);
		
		return hnf.callMethod("facebook.notifications.sendEmal", params);
	}
	
}