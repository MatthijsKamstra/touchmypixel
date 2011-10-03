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
 * Permissions API
 * @author Guntur Sarwohadi
 */

package hxfb.api;

import hxfb.HxFb;
import hxjson2.JSONEncoder;

class Permissions 
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
	* Checks API-access granted by self to the specified application.
	*
	* @param string $permissions_apikey  Other application key
	*
	* @return array  API methods/namespaces which are allowed access
	*/
	public function checkGrantedApiAccess(permissionsAPIKey:String):Dynamic
	{
		params.set("permissions_apikey", permissionsAPIKey);
		return hnf.callMethod("facebook.permissions.checkGrantedApiAccess", params);
	}
	
	/**
	* Checks API-access granted to self by the specified application.
	*
	* @param string $permissions_apikey  Other application key
	*
	* @return array  API methods/namespaces which are allowed access
	*/
	public function checkAvailableApiAccess(permissionsAPIKey:String):Dynamic
	{
		params.set("permissions_apikey", permissionsAPIKey);
		return hnf.callMethod("facebook.permissions.checkAvailableApiAccess", params);
	}
	
	/**
	* Grant API-access to the specified methods/namespaces to the specified
	* application.
	*
	* @param string $permissions_apikey  Other application key
	* @param array(string) $method_arr   (Optional) API methods/namespaces
	*                                    allowed
	*
	* @return array  API methods/namespaces which are allowed access
	*/
	public function grantApiAccess(permissionsAPIKey:String, methodArr:Array<String>):Dynamic
	{
		params.set("permissions_apikey", permissionsAPIKey);
		params.set("method_arr", methodArr);
		return hnf.callMethod("facebook.permissions.grantApiAccess", params);
	}
	
	/**
	* Revoke API-access granted to the specified application.
	*
	* @param string $permissions_apikey  Other application key
	*
	* @return bool  true on success
	*/
	public function revokeApiAccess(permissionsAPIKey:String):Dynamic
	{
		params.set("permissions_apikey", permissionsAPIKey);
		return hnf.callMethod("facebook.permissions.revokeApiAccess", params);
	}
	
}