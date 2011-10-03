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
 * Auth API
 * @author Guntur Sarwohadi
 */

package hxfb.api;

import hxfb.HxFb;

class Auth 
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
	* Creates an authentication token to be used as part of the desktop login
	* flow.  For more information, please see
	* http://wiki.developers.facebook.com/index.php/Auth.createToken.
	*
	* @return string  An authentication token.
	*/
	public function createToken():String
	{
		return hnf.callMethod("facebook.auth.createToken");
	}
	
	/**
	* Expires the session that is currently being used.  If this call is
	* successful, no further calls to the API (which require a session) can be
	* made until a valid session is created.
	*
	* @return bool  true if session expiration was successful, false otherwise
	*/
	public function expireSession():Bool
	{
		return hnf.callMethod("facebook.auth.expireSession");
	}
	
	/**
	* Get public key that is needed to verify digital signature
	* an app may pass to other apps. The public key is only used by
	* other apps for verification purposes.
	* @param  string  API key of an app
	* @return string  The public key for the app.
	*/
	public function getAppPublicKey(targetAppKey:String):String
	{
		params.set("target_app_key", targetAppKey);
		return hnf.callMethod("facebook.auth.getAppPublicKey", params);
	}
	
	/**
	* Returns the session information available after current user logs in.
	*
	* @param string $auth_token the token returned by auth_createToken or
	*               passed back to your callback_url.
	* @param bool $generate_session_secret whether the session returned should
	*             include a session secret
	* @param string $host_url the connect site URL for which the session is
	*               being generated.  This parameter is optional, unless
	*               you want Facebook to determine which of several base domains
	*               to choose from.  If this third argument isn't provided but
	*               there are several base domains, the first base domain is
	*               chosen.
	*
	* @return array  An assoc array containing session_key, uid
	*/
	public function getSession(authToken:String, ?generateSessionSecret:Bool, ?hostURL:String):Hash<String>
	{
		if (!hnf.getPendingBatch())
		{
			params.set("auth_token", authToken);
			params.set("generate_session_secret", generateSessionSecret);
			params.set("host_url", hostURL);
			
			var result:Dynamic = hnf.callMethod("facebook.auth.getSession", params);
			
			hnf.sessionKey = cast(Reflect.field(result, "session_key"), String);
			if (Reflect.hasField(result, "secret") && (generateSessionSecret == null || generateSessionSecret == false))
			{
				hnf.secret = cast(Reflect.field(result, "secret"), String);
			}
			
			var resultHash:Hash<String> = new Hash<String>();
			for (key in Reflect.fields(result))
			{
				resultHash.set(key, Reflect.field(result, key));
			}
			
			return resultHash;
		}
		
		return null;
	}
	
	/**
	* Get a structure that can be passed to another app
	* as proof of session. The other app can verify it using public
	* key of this app.
	*
	* @return signed public session data structure.
	*/
	public function getSignedPublicSessionData():Dynamic
	{
		return hnf.callMethod("facebook.auth.getSignedPublicSessionData", new Hash<Dynamic>());
	}
	
	/**
	* Generates a session-specific secret. This is for integration with
	* client-side API calls, such as the JS library.
	*
	* @return array  A session secret for the current promoted session
	*
	* @error API_EC_PARAM_SESSION_KEY
	*        API_EC_PARAM_UNKNOWN
	*/
	public function promoteSession():Dynamic
	{
		return hnf.callMethod("facebook.auth.promoteSession");
	}
	
	/**
	* Revokes the user's agreement to the Facebook Terms of Service for your
	* application.  If you call this method for one of your users, you will no
	* longer be able to make API requests on their behalf until they again
	* authorize your application.  Use with care.  Note that if this method is
	* called without a user parameter, then it will revoke access for the
	* current session's user.
	*
	* @param String $uid  (Optional) User to revoke
	*
	* @return bool  true if revocation succeeds, false otherwise
	*/
	public function revokeAuthorization(?uid:String):Dynamic
	{
		if (uid != null)
			params.set("uid", uid);
		
		return hnf.callMethod("facebook.auth.revokeAuthorization", params);
	}
	
	/**
	*  Revokes the given extended permission that the user granted at some
	*  prior time (for instance, offline_access or email).  If no user is
	*  provided, it will be revoked for the user of the current session.
	*
	*  @param  string  $perm  The permission to revoke
	*  @param  String  $uid   The user for whom to revoke the permission.
	*/
	public function revokeExtendedPermission(perm:String, ?uid:String):Dynamic
	{
		params.set("perm", perm);
		params.set("uid", uid);
		
		return hnf.callMethod("facebook.auth.revokeExtendedPermission", params);
	}
	
}