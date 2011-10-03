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
 * Admin API
 * @author Guntur Sarwohadi
 */

package hxfb.api;

import hxfb.HxFb;
import hxjson2.JSONDecoder;
import hxjson2.JSONEncoder;

class Admin 
{
	private var hnf:HxFb;
	private var jsonEncoder:JSONEncoder;
	private var jsonDecoder:JSONDecoder;
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
     * Bans a list of users from the app. Banned users can't
     * access the app's canvas page and forums.
     *
     * @param array $uids an array of user ids
     * @return bool true on success
     */
	public function banUsers(uids:Array<String>):Bool
	{
		jsonEncoder = new JSONEncoder(uids);
		params.set("uids", jsonEncoder.getString());
		return hnf.callMethod("facebook.admin.banUsers", params);
	}
	
	/**
     * Returns the allocation limit value for a specified integration point name
     * Integration point names are defined in lib/api/karma/constants.php in the
     * limit_map.
     *
     * @param string $integration_point_name  Name of an integration point
     *                                        (see developer wiki for list).
     * @param int    $uid                     Specific user to check the limit.
     *
     * @return int  Integration point allocation value
     */
	public function getAllocation(integrationPointName:String, ?uid:String):Dynamic
	{
		params.set("integration_point_name", integrationPointName);
		params.set("uid", uid);
		
		return hnf.callMethod("facebook.admin.getAllocation", params);
	}
	
	/**
     * Get the properties that you have set for an app.
     *
     * @param properties  List of properties names to fetch
     *
     * @return array  A map from property name to value
     */
	public function getAppProperties(properties:Array<String>):Dynamic
	{
		jsonEncoder = new JSONEncoder(properties);
		params.set("properties", jsonEncoder.getString());
		
		var response:Dynamic = hnf.callMethod("facebook.admin.getAppProperties", params);
		jsonDecoder = new JSONDecoder(response, true);
		
		return jsonDecoder.getValue();
	}
	
	/**
     * Gets the list of users that have been banned from the application.
     * $uids is an optional parameter that filters the result with the list
     * of provided user ids. If $uids is provided,
     * only banned user ids that are contained in $uids are returned.
     *
     * @param array $uids an array of user ids to filter by
     * @return bool true on success
     */
	public function getBannedUsers(?uids:Array<String>):Array<String>
	{
		if (uids != null)
			jsonEncoder = new JSONEncoder(uids);
		
		params.set("uids", (uids != null)? jsonEncoder.getString() : null);
		
		return hnf.callMethod("facebook.admin.getBannedUsers", params);
	}
	
	/**
     * Gets href and text for a Live Stream Box xid's via link
     *
     * @param  string  $xid  xid of the Live Stream
     *
     * @return Array  Associative array with keys 'via_href' and 'via_text'
     *                False if there was an error.
     */
	public function getLiveStreamViaLink(xid:String):Dynamic
	{
		params.set("xi", xid);
		return hnf.callMethod("facebook.admin.getLiveStreamViaLink", params);
	}
	
	/**
     * Returns values for the specified metrics for the current application, in
     * the given time range.  The metrics are collected for fixed-length periods,
     * and the times represent midnight at the end of each period.
     *
     * @param start_time  unix time for the start of the range
     * @param end_time    unix time for the end of the range
     * @param period      number of seconds in the desired period
     * @param metrics     list of metrics to look up
     *
     * @return array  A map of the names and values for those metrics
     */
	public function getMetrics(startTime:Int, endTime:Int, period:Int, metrics:Array<String>):Dynamic
	{
		jsonEncoder = new JSONEncoder(metrics);
		
		params.set("start_time", startTime);
		params.set("end_time", endTime);
		params.set("period", period);
		params.set("metrics", jsonEncoder.getString());
		
		return hnf.callMethod("facebook.admin.getMetrics", params);
	}
	
	/**
     * Gets application restriction info.
     *
     * Applications can restrict themselves to only a limited user demographic
     * based on users' age and/or location or based on static predefined types
     * specified by facebook for specifying diff age restriction for diff
     * locations.
     *
     * @return array  The age restriction settings for this application.
     */
	public function getRestrictionInfo():Dynamic
	{
		var response:Dynamic = hnf.callMethod("facebook.admin.getRestrictionInfo");
		jsonDecoder = new JSONDecoder(response, true);
		return jsonDecoder.getValue();
	}
	
	/**
     * Set properties for an app.
     *
     * @param properties  A map from property names to values
     *
     * @return bool  true on success
     */
	public function setAppProperties(properties:Dynamic):Dynamic
	{
		jsonEncoder = new JSONEncoder(properties);
		
		params.set("properties", jsonEncoder.getString());
		
		return hnf.callMethod("facebook.admin.setAppProperties", params);
	}
	
	/**
     * Sets href and text for a Live Stream Box xid's via link
     *
     * @param  string  $xid       xid of the Live Stream
     * @param  string  $via_href  Href for the via link
     * @param  string  $via_text  Text for the via link
     *
     * @return boolWhether the set was successful
     */
	public function setLiveStreamViaLink(xid:String, viaHref:String, viaText:String):Dynamic
	{
		params.set("xid", xid);
		params.set("via_href", viaHref);
		params.set("via_text", viaText);
		
		return hnf.callMethod("facebook.admin.setLiveStreamViaLink", params);
	}
	
	/**
     * Sets application restriction info.
     *
     * Applications can restrict themselves to only a limited user demographic
     * based on users' age and/or location or based on static predefined types
     * specified by facebook for specifying diff age restriction for diff
     * locations.
     *
     * @param array $restriction_info  The age restriction settings to set.
     *
     * @return bool  true on success
     */
	public function setRestrictionInfo(?restrictionInfo:Array<String>):Bool
	{
		if (restrictionInfo != null)
		{
			jsonEncoder = new JSONEncoder(restrictionInfo);
			var restrictionString:String = jsonEncoder.getString();
			
			params.set("restriction_str", restrictionString);
			
			return hnf.callMethod("facebook.admin.setRestrictionInfo", params);
		}
		
		return false;
	}
	
	/**
     * Unban users that have been previously banned with
     * admin_banUsers().
     *
     * @param array $uids an array of user ids
     * @return bool true on success
     */
	public function unbanUsers(uids:Array<String>):Bool
	{
		jsonEncoder = new JSONEncoder(uids);
		
		params.set("uids", jsonEncoder.getString());
		
		return hnf.callMethod("facebook.admin.unbanUsers", params);
	}
	
}