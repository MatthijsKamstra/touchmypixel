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
 * Events API
 * @author Guntur Sarwohadi
 */

package hxfb.api;

import hxfb.HxFb;
import hxjson2.JSONEncoder;

class Events 
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
	* Returns events according to the filters specified.
	*
	* @param String $uid            (Optional) User associated with events. A null
	*                            parameter will default to the session user.
	* @param array/string $eids  (Optional) Filter by these event
	*                            ids. A null parameter will get all events for
	*                            the user. (A csv list will work but is deprecated)
	* @param int $start_time     (Optional) Filter with this unix time as lower
	*                            bound.  A null or zero parameter indicates no
	*                            lower bound.
	* @param int $end_time       (Optional) Filter with this UTC as upper bound.
	*                            A null or zero parameter indicates no upper
	*                            bound.
	* @param string $rsvp_status (Optional) Only show events where the given uid
	*                            has this rsvp status.  This only works if you
	*                            have specified a value for $uid.  Values are as
	*                            in events.getMembers.  Null indicates to ignore
	*                            rsvp status when filtering.
	*
	* @return array  The events matching the query.
	*/
	public function get(?uId:String, ?eIds:Array<Int>, ?startTime:Int, ?endTime:Int, ?rsvpStatus:String):Dynamic
	{
		params.set("uid", uId);
		params.set("eids", eIds);
		params.set("start_time", startTime);
		params.set("end_time", endTime);
		params.set("rsvp_status", rsvpStatus);
		
		return hnf.callMethod("facebook.events.get", params);
	}
	
	/**
	* Returns membership list data associated with an event.
	*
	* @param String $eid  event id
	*
	* @return array  An assoc array of four membership lists, with keys
	*                'attending', 'unsure', 'declined', and 'not_replied'
	*/
	public function getMembers(eId:String):Dynamic
	{
		params.set("eid", eId);
		
		return hnf.callMethod("facebook.events.getMembers", params);
	}
	
	/**
	* RSVPs the current user to this event.
	*
	* @param String $eid             event id
	* @param string $rsvp_status  'attending', 'unsure', or 'declined'
	*
	* @return bool  true if successful
	*/
	public function rsvp(eId:String, rsvpStatus:String):Bool
	{
		params.set("eid", eId);
		params.set("rsvp_status", rsvpStatus);
		
		return hnf.callMethod("facebook.events.rsvp", params);
	}
	
	/**
	* Cancels an event. Only works for events where application is the admin.
	*
	* @param String $eid                event id
	* @param string $cancel_message  (Optional) message to send to members of
	*                                the event about why it is cancelled
	*
	* @return bool  true if successful
	*/
	public function cancel(eId:String, ?cancelMessage:String = ""):Dynamic
	{
		params.set("eid", eId);
		params.set("cancel_message", cancelMessage);
		
		return hnf.callMethod("facebook.events.cancel", params);
	}
	
	/**
	* Creates an event on behalf of the user is there is a session, otherwise on
	* behalf of app.  Successful creation guarantees app will be admin.
	*
	* @param assoc array $event_info  json encoded event information
	* @param string $file             (Optional) filename of picture to set
	*
	* @return int  event id
	*/
	public function create(eventInfo:Hash<Dynamic>, ?file:String):Dynamic
	{
		var eventInfoEncoder:JSONEncoder = new JSONEncoder(eventInfo);
		
		params.set("event_info", eventInfoEncoder.getString());
		
		if (file != null)
		{
			return hnf.callUploadMethod("facebook.events.create", params, file, hnf.getPhotoServerAddress());
		}
		else
		{
			return hnf.callMethod("facebook.events.create", params);
		}
		
		return null;
	}
	
	/**
	* Invites users to an event. If a session user exists, the session user
	* must have permissions to invite friends to the event and $uids must contain
	* a list of friend ids. Otherwise, the event must have been
	* created by the app and $uids must contain users of the app.
	* This method requires the 'create_event' extended permission to
	* invite people on behalf of a user.
	*
	* @param $eid   the event id
	* @param $uids  an array of users to invite
	* @param $personal_message  a string containing the user's message
	*                           (text only)
	*
	*/
	public function invite(eId:String, uIds:Array<String>, personalMessage:String):Dynamic
	{
		params.set("eid", eId);
		params.set("uids", uIds);
		params.set("personal_message", personalMessage);
		
		return hnf.callMethod("facebook.events.invite", params);
	}
	
	/**
	* Edits an existing event. Only works for events where application is admin.
	*
	* @param int $eid                 event id
	* @param assoc array $event_info  json encoded event information
	* @param string $file             (Optional) filename of new picture to set
	*
	* @return bool  true if successful
	*/
	public function edit(eId:String, eventInfo:Hash<Dynamic>, ?file:String):Dynamic
	{
		var eventInfoEncoder:JSONEncoder = new JSONEncoder(eventInfo);
		
		params.set("eid", eId);
		params.set("event_info", eventInfoEncoder.getString());
		
		if (file != null)
		{
			return hnf.callUploadMethod("facebook.events.edit", params, file, hnf.getPhotoServerAddress());
		}
		else
		{
			return hnf.callMethod("facebook.events.edit", params);
		}
	}
	
}