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
 * haXe/Neko FacebookAPI
 * Based on the PHP FacebookAPI.
 * @author Guntur Sarwohadi
 */

package hxfb;

import hxfb.api.Admin;
import hxfb.api.Application;
import hxfb.api.Auth;
import hxfb.api.Comments;
import hxfb.api.Connect;
import hxfb.api.Data;
import hxfb.api.ErrorCodes;
import hxfb.api.Events;
import hxfb.api.Fbml;
import hxfb.api.Feed;
import hxfb.api.Fql;
import hxfb.api.Friends;
import hxfb.api.Gifts;
import hxfb.api.Groups;
import hxfb.api.Intl;
import hxfb.api.Links;
import hxfb.api.Notes;
import hxfb.api.Notifications;
import hxfb.api.Pages;
import hxfb.api.Payments;
import hxfb.api.Permissions;
import hxfb.api.Photos;
import hxfb.api.Profile;
import hxfb.api.Stream;
import hxfb.api.Users;
import hxfb.api.Video;
import haxe.BaseCode;
import haxe.Http;
import haxe.Md5;
import hxjson2.JSONDecoder;
import hxjson2.JSONEncoder;
import php.FileSystem;
import php.io.File;
import php.Lib;
import php.Sys;
import php.Web;

class HxFb 
{
	private var useSSLResources:Bool;
	private var lastCallId:Float;
	private var baseDomain:String;
	
	private var batchQueue:Hash<Dynamic>;
	private var pendingBatch:Bool;
	private var pendingBatchIsReadOnly:Bool;
	private var callAsAPIKey:String;
	public var format:String;
	private var usingSessionSecret:Bool;
	private var rawData:String;
	private var sessionExpires:Int;
	
	private var http:Http;
	private var jsonDecoder:JSONDecoder;
	private var jsonEncoder:JSONEncoder;
	
	public var apiKey:String;
	public var secret:String;
	public var generateSessionSecret:Bool;
	public var sessionKey:String;
	public var batchMode:Int;
	
	public var fbParams:Hash<String>;
	public var user:String;
	public var profileUser:String;
	public var canvasUser:String;
	public var extPerms:Array<String>;
	
	public var friendList:Array<String>;
	public var added:Bool; // to save making the pages.isAppAdded api call, this will get prepopulated on canvas pages
	public var isUser:Bool;
	
	/*
	 * API instances
	 */
	public var admin:Admin;
	public var application:Application;
	public var auth:Auth;
	public var comments:Comments;
	public var connect:Connect;
	public var data:Data;
	public var events:Events;
	public var fbml:Fbml;
	public var feed:Feed;
	public var fql:Fql;
	public var friends:Friends;
	public var gifts:Gifts;
	public var groups:Groups;
	public var intl:Intl;
	public var links:Links;
	public var notes:Notes;
	public var notifications:Notifications;
	public var pages:Pages;
	public var payments:Payments;
	public var permissions:Permissions;
	public var photos:Photos;
	public var profile:Profile;
	public var stream:Stream;
	public var users:Users;
	public var video:Video;
	
	public static inline var FACEBOOK_API_VALIDATION_ERROR:Int = 1;
	public static inline var BATCH_MODE_DEFAULT:Int = 0;
	public static inline var BATCH_MODE_SERVER_PARALLEL:Int = 0;
	public static inline var BATCH_MODE_SERIAL_ONLY:Int = 2;
	
	/**
	 * Create a Facebook client like this:
	 *
	 * var fb:HxNekoFace = new HxNekoFace(API_KEY, SECRET);
	 *
	 * This will automatically pull in any parameters, validate them against the
	 * session signature, and chuck them in the public $fb_params member variable.
	 *
	 * @param apiKey					your Developer API key
	 * @param secret					your Developer API secret
	 * @param generateSessionSecret		whether to automatically generate a session
	 * 									if the user doesn't have one, but
	 * 									there is an auth token present in the url,
	 */
	public function new(apiKey:String, secret:String, ?generateSessionSecret:Bool) 
	{
		this.apiKey = apiKey;
		this.secret = secret;
		this.generateSessionSecret = (generateSessionSecret == null)? false : generateSessionSecret;
		
		lastCallId = 0;
		callAsAPIKey = "";
		batchMode = BATCH_MODE_DEFAULT;
		
		// create api instances
		admin = new Admin(this);
		application = new Application(this);
		auth = new Auth(this);
		comments = new Comments(this);
		connect = new Connect(this);
		data = new Data(this);
		events = new Events(this);
		fbml = new Fbml(this);
		feed = new Feed(this);
		fql = new Fql(this);
		friends = new Friends(this);
		gifts = new Gifts(this);
		groups = new Groups(this);
		intl = new Intl(this);
		links = new Links(this);
		notes = new Notes(this);
		notifications = new Notifications(this);
		pages = new Pages(this);
		payments = new Payments(this);
		permissions = new Permissions(this);
		photos = new Photos(this);
		profile = new Profile(this);
		stream = new Stream(this);
		users = new Users(this);
		video = new Video(this);
	}
	
	public function initialize():Void
	{
		validateFBParams();
		
		// print js
		var js:StringBuf = new StringBuf();
		js.add("<script type=\"text/javascript\">");
		js.add("	var types = ['params', 'xml', 'php', 'sxml'];");
		js.add("	function getStyle(elem, style) {");
		js.add("		if (elem.getStyle) {");
		js.add("			return elem.getStyle(style);");
		js.add("		} else {");
		js.add("			return elem.style[style];");
		js.add("		}");
		js.add("	}");
		js.add("	function setStyle(elem, style, value) {");
		js.add("		if (elem.setStyle) {");
		js.add("			elem.setStyle(style, value);");
		js.add("		} else {");
		js.add("			elem.style[style] = value;");
		js.add("		}");
		js.add("	}");
		js.add("	function toggleDisplay(id, type) {");
		js.add("	  for (var i = 0; i < types.length; i++) {");
		js.add("		var t = types[i];");
		js.add("		var pre = document.getElementById(t + id);");
		js.add("		if (pre) {");
		js.add("		  if (t != type || getStyle(pre, 'display') == 'block') {");
		js.add("			setStyle(pre, 'display', 'none');");
		js.add("		  } else {");
		js.add("			setStyle(pre, 'display', 'block');");
		js.add("		  }");
		js.add("		}");
		js.add("	  }");
		js.add("	  return false;");
		js.add("	}");
		js.add("</script>");
		Lib.print(js.toString());
		
		var defaultUser:String = (user != null)? user : (profileUser != null)? profileUser : (canvasUser != null)? canvasUser : "";
		
		user = defaultUser;
		
		if (fbParams.exists("friends"))
		{
			var _friends:Array<String> = fbParams.get("friends").split(",");
			var _friendList:List<String> = Lambda.list(_friends).filter(filterList);
			friendList = Lambda.array(_friendList);
		}
		
		if (fbParams.exists("added"))
		{
			var _added:String = fbParams.get("added");
			added = (_added == "true" || _added == "1");
		}
		
		if (fbParams.exists("canvas_user"))
		{
			canvasUser = fbParams.get("canvas_user");
		}
	}
	
	/*
	* Validates that the parameters passed in were sent from Facebook. It does so
	* by validating that the signature matches one that could only be generated
	* by using your application's secret key.
	*
	* Facebook-provided parameters will come from $_POST, $_GET, or $_COOKIE,
	* in that order. $_POST and $_GET are always more up-to-date than cookies,
	* so we prefer those if they are available.
	*
	* For nitty-gritty details of when each of these is used, check out
	* http://wiki.developers.facebook.com/index.php/Verifying_The_Signature
	*
	* @param bool  resolve_auth_token  convert an auth token into a session
	*/
	public function validateFBParams(?resolveAuthToken:Bool = true):Bool
	{
		fbParams = getValidFBParams(Web.getParams(), 48 * 3600, "fb_sig");
		var cookies = getValidFBParams(Web.getCookies(), null, apiKey);
		var expires:Int = null;
		
		// Okay, something came in via POST or GET
		if (fbParams != null)
		{
			user = (fbParams.exists("user"))? fbParams.get("user") : null;
			profileUser = (fbParams.exists("profile_user"))? fbParams.get("profile_user") : null;
			canvasUser = (fbParams.exists("canvas_user"))? fbParams.get("canvas_user") : null;
			baseDomain = (fbParams.exists("base_domain"))? fbParams.get("base_domain") : null;
			extPerms = (fbParams.exists("ext_perms"))? fbParams.get("ext_perms").split(",") : new Array<String>();
			
			var sessionKey:String = (fbParams.exists("session_key"))? fbParams.get("session_key") : (fbParams.exists("profile_session_key"))? fbParams.get("profile_session_key") : null;
			expires = (fbParams.exists("expires"))? Std.parseInt(fbParams.get("expires")) : null;
			
			setUser(user, sessionKey, expires);
		}
		// if no Facebook parameters were found in the GET or POST variables,
		// then fall back to cookies, which may have cached user information
		// Cookies are also used to receive session data via the Javascript API
		else if (cookies != null)
		{
			var baseDomainCookie:String = "base_domain" + apiKey;
			if (Web.getCookies().exists(baseDomainCookie))
				baseDomain = Web.getCookies().get(baseDomainCookie);
			
			// use $api_key . '_' as a prefix for the cookies in case there are
			// multiple facebook clients on the same domain.
			expires = (Web.getCookies().exists("expires"))? Std.parseInt(Web.getCookies().get("expires")) : null;
			
			setUser(user, sessionKey, expires);
		}
		else if (resolveAuthToken && Web.getParams().exists("auth_token"))
		{
			//var session:String = 
		}
		
		return !Lambda.empty(fbParams);
	}
	
	// Store a temporary session secret for the current session
	// for use with the JS client library
	public function promoteSession():Dynamic
	{
		try
		{
			var sessionSecret:Dynamic = auth.promoteSession();
			if (fbParams != null && fbParams.exists("in_canvas"))
			{
				setCookies(user, sessionKey, sessionExpires, sessionSecret);
			}
			return sessionSecret;
		}
		catch (e:FBRESTClientException)
		{
			// API_EC_PARAM means we don't have a logged in user, otherwise who
			// knows what it means, so just throw it.
			if (e.code != ErrorCodes.API_EC_PARAM)
				throw e;
		}
		
		return null;
	}
	
	public function doGetSession(authToken:String):Dynamic
	{
		try 
		{
			return auth.getSession(authToken, generateSessionSecret);
		}
		catch (e:FBRESTClientException)
		{
			// API_EC_PARAM means we don't have a logged in user, otherwise who
			// knows what it means, so just throw it.
			if (e.code != ErrorCodes.API_EC_PARAM)
				throw e;
		}
		
		return null;
	}
	
	// Invalidate the session currently being used, and clear any state associated
  // with it. Note that the user will still remain logged into Facebook.
	public function expireSession():Bool
	{
		try
		{
			if (auth.expireSession())
			{
				clearCookieState();
				return true;
			}
			else
			{
				return false;
			}
		}
		catch (e:Dynamic)
		{
			clearCookieState();
		}
		
		return false;
	}
	
	/** Logs the user out of all temporary application sessions as well as their
	* Facebook session.  Note this will only work if the user has a valid current
	* session with the application.
	*
	* @param string  $next  URL to redirect to upon logging out
	*
	*/
	public function logout(next:String):Void
	{
		var logoutURL:String = getLogoutURL(next);
		clearCookieState();
		redirect(logoutURL);
	}
	
	/**
	*  Clears any persistent state stored about the user, including
	*  cookies and information related to the current session in the
	*  client.
	*
	*/
	public function clearCookieState():Void
	{
		if (fbParams != null && fbParams.exists("in_canvas") && Web.getCookies().exists(apiKey + "_user"))
		{
			var cookies:Array<String> = new Array<String>();
			cookies.push("user");
			cookies.push("session_key");
			cookies.push("expires");
			cookies.push("ss");
			
			for (key in cookies)
			{
				Web.setCookie(apiKey + "_" + key, "false", DateTools.delta(Date.now(), -3600), "", baseDomain);
				Web.getCookies().remove(apiKey + "_" + key);
			}
		}
		
		user = "0";
		sessionKey = "0";
	}
	
	public function redirect(url:String):Void
	{
		var ereg:EReg = ~/^https?:\/\/([^\/]*\.)?facebook\.com(:\d+)?/i;
		if (inFBCanvas())
		{
			Lib.print("<fb:redirect url=\"" + url + "\"/>");
		}
		else if (ereg.match(url))
		{
			// make sure facebook.com url's load in the full frame so that we don't
			// get a frame within a frame.
			Lib.print("<script type=\"text/javascript\">\ntop.location.href = \"" + url + "\";\n</script>");
		}
		else
		{
			Web.redirect(url);
		}
	}
	
	public function inFrame():Bool
	{
		return (fbParams != null && (fbParams.exists("in_canvas") || fbParams.exists("in_iframe")));
	}
	
	public function inFBCanvas():Bool
	{
		return (fbParams != null && fbParams.exists("in_canvas"));
	}
	
	public function getLoggedInUser():String
	{
		return user;
	}
	
	public function getCanvasUser():String
	{
		return canvasUser;
	}
	
	public function getProfileUser():String
	{
		return profileUser;
	}
	
	public function currentURL():String
	{
		return "http://" + Web.getHostName() + Web.getURI();
	}
	
	/**
	 * require_add and require_install have been removed.
	 * @link http://developer.facebook.com/news.php?blog=1&story=116
	 * @return user string if user != null
	 */ 
	public function requireLogin(?requiredPermissons:String = ""):String
	{
		user = getLoggedInUser();
		var hasPermissions:Bool = true;
		
		if (requiredPermissons != "")
		{
			requireFrame();
			var permissions:Array < String > = requiredPermissons.split(",");
			var permission:String;
			for (permission in permissions)
			{
				permission = StringTools.trim(permission);
				if (!Lambda.has(extPerms, permission))
				{
					hasPermissions = false;
					break;
				}
			}
		}
		
		if ((user != "") && hasPermissions)
		{
			return user;
		}
		
		var url:String = getLoginURL(currentURL(), inFrame(), requiredPermissons);
		redirect(url);
		
		return "";
	}
	
	public function requireFrame():Void
	{
		if (!inFrame())
		{
			redirect(getLoginURL(currentURL(), true));
		}
	}
	
	public static function getFacebookURL(?subdomain:String):String
	{
		return "http://" + ((subdomain == null)? "www" : subdomain) + ".facebook.com";
	}
	
	public function getInstallURL(?next:String):String
	{
		return getAddURL(next);
	}
	
	public function getAddURL(?next:String):String
	{
		var page:String = getFacebookURL() + "/add.php";
		var params:Hash<String> = new Hash<String>();
		params.set("api_key", apiKey);
		
		if (next != null)
			params.set("next", next);
		
		var paramString:String = "";
		var key:String = "";
		for (key in params.keys())
		{
			paramString += key + "=" + params.get(key) + ((params.iterator().hasNext())? "&" : "");
		}
		
		return page + "?" + paramString;
	}
	
	public function getLoginURL(next:String, canvas:Bool, ?reqPerms:String = ""):String
	{
		var page:String = getFacebookURL() + "/login.php";
		var params:Hash<String> = new Hash<String>();
		params.set("api_key", apiKey);
		params.set("v", "1.0");
		params.set("req_perms", reqPerms);
		
		if (next != null)
			params.set("next", next);
		
		if (canvas)
			params.set("canvas", "1");
		
		var paramString:String = "";
		var key:String = "";
		for (key in params.keys())
		{
			paramString += key + "=" + params.get(key) + ((params.iterator().hasNext())? "&" : "");
		}
		
		return page + "?" + paramString;
	}
	
	public function getLogoutURL(next:String):String
	{
		var page:String = getFacebookURL() + "/logout.php";
		var params:Hash<String> = new Hash<String>();
		params.set("api_key", apiKey);
		params.set("session_key", sessionKey);
		
		if (next != null)
		{
			params.set("connect_next", "1");
			params.set("next", next);
		}
		
		var paramString:String = "";
		var key:String = "";
		for (key in params.keys())
		{
			paramString += key + "=" + params.get(key) + ((params.iterator().hasNext())? "&" : "");
		}
		
		return page + "?" + paramString;
	}
	
	public function setUser(user:String, sessionKey:String, ?expires:Int, ?sessionSecret:String):Void
	{
		var cookieName:String = apiKey + "_user";
		if (fbParams.exists("in_canvas") && (Web.getCookies().exists(cookieName) || Web.getCookies().get(cookieName) != user))
		{
			setCookies(user, sessionKey, expires, sessionSecret);
		}
		this.user = user;
		this.sessionKey = sessionKey;
		sessionExpires = expires;
	}
	
	public function setCookies(user:String, sessionKey:String, ?expires:Int, ?sessionSecret:String):Void
	{
		var cookies:Hash<String> = new Hash<String>();
		cookies.set("user", user);
		cookies.set("session_key", sessionKey);
		
		if (expires != null)
			cookies.set("expires", Std.string(expires));
		if (sessionSecret != null)
			cookies.set("ss", sessionSecret);
		
		var ckey:String = "";
		for (ckey in cookies.keys())
		{
			Web.setCookie(apiKey + "_" + ckey, cookies.get(ckey), DateTools.delta(Date.now(), expires), baseDomain);
		}
		var sig:String = generateSignature(cookies, secret);
		Web.setCookie(apiKey, sig, DateTools.delta(Date.now(), expires), baseDomain);
		
		if (baseDomain != null)
		{
			var baseDomainCookie:String = "base_domain_" + apiKey;
			Web.setCookie(baseDomainCookie, baseDomain, DateTools.delta(Date.now(), expires), baseDomain);
		}
	}
	
	/*
	* Get the signed parameters that were sent from Facebook. Validates the set
	* of parameters against the included signature.
	*
	* Since Facebook sends data to your callback URL via unsecured means, the
	* signature is the only way to make sure that the data actually came from
	* Facebook. So if an app receives a request at the callback URL, it should
	* always verify the signature that comes with against your own secret key.
	* Otherwise, it's possible for someone to spoof a request by
	* pretending to be someone else, i.e.:
	*      www.your-callback-url.com/?fb_user=10101
	*
	* This is done automatically by verify_fb_params.
	*
	* @param  assoc  $params     a full array of external parameters.
	*                            presumed $_GET, $_POST, or $_COOKIE
	* @param  int    $timeout    number of seconds that the args are good for.
	*                            Specifically good for forcing cookies to expire.
	* @param  string $namespace  prefix string for the set of parameters we want
	*                            to verify. i.e., fb_sig or fb_post_sig
	*
	* @return  assoc the subset of parameters containing the given prefix,
	*                and also matching the signature associated with them.
	*          OR    an empty array if the params do not validate
	*/
	public function getValidFBParams(params:Hash<String>, ?timeout:Int, ?namespace:String):Hash<String>
	{
		namespace = (namespace == null)? namespace : "fb_sig";
		
		var emptyHash:Hash<String> = new Hash<String>();
		var prefix:String = namespace + "_";
		
		if (Lambda.empty(params))
			return emptyHash;
		
		fbParams = new Hash<String>();
		var key:String;
		for (key in params.keys())
		{
			var value:String = params.get(key);
			if (key.indexOf(prefix) > -1)
			{
				var filteredKey:String = key.substr(prefix.length, key.length - prefix.length);
				fbParams.set(filteredKey, value);
			}
		}
		
		var timeCheck:Bool = (timeout != null && (!fbParams.exists("time") || Sys.time() - Std.parseFloat(fbParams.get("time")) > timeout));
		if (timeCheck)
			return emptyHash;
		
		var signature:String = (params.exists(namespace))? params.get(namespace) : null;
		if (signature == null || !verifySignature(fbParams, signature))
			return emptyHash;
		
		return fbParams;
	}
	
	/**
	*  Validates the account that a user was trying to set up an
	*  independent account through Facebook Connect.
	*
	*  @param  user The user attempting to set up an independent account.
	*  @param  hash The hash passed to the reclamation URL used.
	*  @return bool True if the user is the one that selected the
	*               reclamation link.
	*/
	public function verifyAccountReclamation(user:String, hash:String):Bool
	{
		return hash == Md5.encode(user + secret);
	}
	
	/**
	* Validates that a given set of parameters match their signature.
	* Parameters all match a given input prefix, such as "fb_sig".
	*
	* @param hash     		an array of all Facebook-sent parameters,
	*                       not including the signature itself
	* @param signature		the expected result to check against
	*/
	public function verifySignature(hash:Hash<String>, signature:String):Bool
	{
		return (generateSignature(hash, secret) == signature);
	}
	
	/**
	* Validate the given signed public session data structure with
	* public key of the app that
	* the session proof belongs to.
	*
	* @param $signed_data the session info that is passed by another app
	* @param string $public_key Optional public key of the app. If this
	*               is not passed, function will make an API call to get it.
	* return true if the session proof passed verification.
	*/
	public function verifySignedPublicSessionData(signedData:Dynamic, ?publicKey:String):Bool
	{
		// If public key is not already provided, we need to get it through API
		if (publicKey == null)
		{
			publicKey = auth.getAppPublicKey(Std.string(Reflect.field(signedData, "api_key")));
		}
		
		// Create data to verify
		var dataToSerialize:Dynamic = signedData;
		Reflect.deleteField(dataToSerialize, "sig");
		var serializedData:String = StringTools.replace(Reflect.fields(dataToSerialize).join("_"), "=", "");
		
		// Decode signature
		var signature:String = BaseCode.decode(serializedData, "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/");
		var result:Int = 0; // TODO: access via openssl. From the PHP client: openssl_verify(serializedData, signature, publicKey, OPENSSL_ALGO_SHA1);
		
		return (result == 1);
	}
	
	/*
	* Generate a signature using the application secret key.
	*
	* The only two entities that know your secret key are you and Facebook,
	* according to the Terms of Service. Since nobody else can generate
	* the signature, you can rely on it to verify that the information
	* came from Facebook.
	*
	* @param $params_array   an array of all Facebook-sent parameters,
	*                        NOT INCLUDING the signature itself
	* @param $secret         your app's secret key
	*
	* @return a hash to be checked against the signature provided by Facebook
	*/
	public static function generateSignature(hash:Hash<String>, secret:String):String
	{
		var string:String = "";
		var arrayKeys:Array<String> = new Array<String>();
		
		for (key in hash.keys())
		{
			arrayKeys.push(key);
		}
		arrayKeys.sort(sortKeyNames);
		
		for (i in 0...arrayKeys.length)
		{
			var add:String = (arrayKeys[i] + "=" + hash.get(arrayKeys[i]));
			string += add;
		}
		string += secret;
		
		return Md5.encode(string);
	}
	
	public function encodeValidationError(summary:String, message:String):String
	{
		var errors:Hash<Dynamic> = new Hash<Dynamic>();
		errors.set("errorCode", FACEBOOK_API_VALIDATION_ERROR);
		errors.set("errorTitle", summary);
		errors.set("errorMessage", message);
		var errorsEncoder:JSONEncoder = new JSONEncoder(errors);
		
		return errorsEncoder.getString();
	}
	
	public function encodeMultiFeedStory(feed:String, next:String):String
	{
		var contents:Hash<String> = new Hash<String>();
		contents.set("next", next);
		contents.set("feed", feed);
		var feeds:Hash<Dynamic> = new Hash<Dynamic>();
		feeds.set("method", "multiFeedStory");
		feeds.set("content", contents);
		var feedsEncoder:JSONEncoder = new JSONEncoder(feeds);
		
		return feedsEncoder.getString();
	}
	
	public function encodeFeedStory(feed:String, next:String):String
	{
		var contents:Hash<String> = new Hash<String>();
		contents.set("next", next);
		contents.set("feed", feed);
		var feeds:Hash<Dynamic> = new Hash<Dynamic>();
		feeds.set("method", "feedStory");
		feeds.set("content", contents);
		var feedsEncoder:JSONEncoder = new JSONEncoder(feeds);
		
		return feedsEncoder.getString();
	}
	
	public function createTemplatizedFeedStory(titleTemplate:String, ?titleData:Dynamic, ?bodyTemplate:String, ?bodyData:Dynamic, ?bodyGeneral:Dynamic, ?image1:String, ?image1Link:String, ?image2:String, ?image2Link:String, ?image3:String, ?image3Link:String, ?image4:String, ?image4Link:String):Hash<String>
	{
		var templateHash:Hash<String> = new Hash<String>();
		templateHash.set("title_template", titleTemplate);
		templateHash.set("title_data", titleData);
		templateHash.set("body_template", bodyTemplate);
		templateHash.set("body_data", bodyData);
		templateHash.set("body_general", bodyGeneral);
		templateHash.set("image_1", image1);
		templateHash.set("image_1_link", image1Link);
		templateHash.set("image_2", image2);
		templateHash.set("image_2_link", image2Link);
		templateHash.set("image_3", image3);
		templateHash.set("image_3_link", image3Link);
		templateHash.set("image_4", image4);
		templateHash.set("image_4_link", image4Link);
		
		return templateHash;
	}
	
	public function log(message:String):Void
	{
		Lib.print("<p><tt>" + message + "</tt></p>");
	}
	
	/**
	* Switch to use the session secret instead of the app secret,
	* for desktop and unsecured environment
	*/
	public function useSessionSecret(sessionSecret:String):Void
	{
		secret = sessionSecret;
		usingSessionSecret = true;
	}
	
	/**
	* Start a batch operation.
	*/
	public function beginBatch():Void
	{
		if (pendingBatch)
		{
			throw new FBRESTClientException(ErrorCodes.API_EC_BATCH_ALREADY_STARTED);
		}
		
		batchQueue = new Hash<Dynamic>();
		pendingBatch = true;
	}
	
	/*
	* End current batch operation
	*/
	public function endBatch():Void
	{
		if (!pendingBatch)
		{
			throw new FBRESTClientException(ErrorCodes.API_EC_BATCH_NOT_STARTED);
		}
		
		pendingBatch = false;
		
		batchQueue = null;
	}
	
	public function beginPermissionMode(permissionsApiKey:String):Void
	{
		callAsAPIKey = permissionsApiKey;
	}
	
	public function endPermissionMode():Void
	{
		callAsAPIKey = "";
	}
	
	/*
	* If a page is loaded via HTTPS, then all images and static
	* resources need to be printed with HTTPS urls to avoid
	* mixed content warnings. If your page loads with an HTTPS
	* url, then call set_use_ssl_resources to retrieve the correct
	* urls.
	*/
	public function setUseSSLResources(?isSSL:Bool = true):Void
	{
		useSSLResources = isSSL;
	}
	
	public function callMethod(name:String, ?params:Hash<Dynamic>):Dynamic
	{
		params = (params == null)? new Hash<Dynamic>() : params;
		
		if (format != null)
			params.set("format", format);
		
		var result:Dynamic = { };
		if (!pendingBatch)
		{
			if (callAsAPIKey != null)
				params.set("call_as_apikey", Std.string(callAsAPIKey));
			
			// Request (output)
			postRequest(name, params);
			
			// Response (input)
			result = convertResult(rawData, name, params);
		}
		return result;
	}
	
	public function callUploadMethod(name:String, params:Hash<Dynamic>, file:String, ?serverAddress:String):Dynamic
	{
		var code:Int;
		var desc:String;
		
		var result:Dynamic = { };
		if (!pendingBatch)
		{
			if (!FileSystem.exists(file))
			{
				throw new FBRESTClientException(ErrorCodes.API_EC_PARAM);
			}
			
			if (format != null)
				params.set("format", format);
			
			// Request (output)
			postRequest(name, params, serverAddress, file);
			
			// Response (input)
			result = convertResult(rawData, name, params);
			
			if (Reflect.hasField(result, "error_code"))
				throw new FBRESTClientException(Reflect.field(result, "error_code"));
		}
		else
		{
			throw new FBRESTClientException(ErrorCodes.API_EC_BATCH_METHOD_NOT_ALLOWED_IN_BATCH_MODE);
		}
		
		return result;
	}
	
	public function getServerAddress():String
	{
		return getFacebookURL("api") + "/restserver.php";
	}
	
	public function getPhotoServerAddress():String
	{
		return getFacebookURL("api-photo") + "/restserver.php";
	}
	
	/**
	* are we currently queueing up calls for a batch?
	*/
	public function getPendingBatch():Bool
	{
		return pendingBatch;
	}
	
	public function getFriendList():Array<String>
	{
		return friendList;
	}
	
	public function getUID(uId:String):String
	{
		return (uId != null)? uId : user;
	}
	
	public function setFormat(format:String):HxFb
	{
		this.format = format;
		return this;
	}
	
	public function getFormat():String
	{
		return format;
	}
	
	private function postRequest(method:String, params:Hash<Dynamic>, ?serverAddress:String, ?file:String):Void
	{
		serverAddress = (serverAddress != null)? serverAddress : getServerAddress();
		
		var standardParams:Hash<String> = finalizeParams(method, params);
		
		// the format of this message is specified in RFC1867/RFC1341.
		// we add twenty pseudo-random digits to the end of the boundary string.
		var boundary:String = "--------------------------FbMuLtIpArT" + Std.string(Std.random(100000)) + Std.string(Std.random(100000)) + Std.string(Std.random(100000)) + Std.string(Std.random(100000));
		var contentType:String = (file == null) ? "application/x-www-form-urlencoded" : ("multipart/form-data; boundary=" + boundary);
		
		runHTTPPostTransaction(contentType, standardParams, serverAddress, file);
	}
	
	private function runHTTPPostTransaction(contentType:String, params:Hash<String>, serverAddress:String, ?file:String):Void
	{
		var userAgent:String = "HxNekoFace -- Facebook API HaXe/Neko Client";
		var paramString:String = createURLString(params);
		
		//log("PREPARING HTTP..");
		//log("params after finalized: " + params.toString());
		//log("paramString: " + paramString);
		
		http = new Http(serverAddress);
		http.setHeader("Content-Type", contentType);
		http.setHeader("Content-Length", Std.string(paramString.length));
		http.setHeader("User-Agent", userAgent);
		for (key in params.keys())
		{
			http.setParameter(key, params.get(key));
		}
		
		if (file != null)
		{
			http.fileTransfert("Content-Type: application/octet-stream", file, File.read(file, false), FileSystem.stat(file).size);
		}
		
		http.onData = onHTTPResponseData;
		http.onError = onHTTPResponseError;
		http.request(true);
	}
	
	private function onHTTPResponseError(data:String):Void
	{
		//log("ERROR: " + data);
	}
	
	private function onHTTPResponseData(data:String):Void
	{
		//log("RESPONSE: " + data);
		rawData = data;
	}
	
	private function convertResult(data:String, method:String, params:Hash<Dynamic>):Dynamic
	{
		var paramFormat:String = "";
		var hasFormat:Bool = params.exists("format");
		if (hasFormat)
			paramFormat = params.get("format").toLowerCase();
		
		var isXML:Bool = (!hasFormat || paramFormat != "json");
		if (jsonDecoder == null)
			jsonDecoder = new JSONDecoder(data, true);
		
		return (isXML)? convertXMLToResult(data, method, params) : jsonDecoder.getValue();
	}
	
	private function convertXMLToResult(data:String, method:String, params:Hash<Dynamic>):String
	{
		var xml:Xml = Xml.parse(data);
		return "";
	}
	
	private function createURLString(params:Hash<String>):String
	{
		var postParams:Array<String> = new Array<String>();
		var key:String;
		for (key in params.keys())
		{
			var encodedValue:String = StringTools.urlEncode(params.get(key));
			postParams.push(key + "=" + encodedValue);
		}
		return postParams.join("&");
	}
	
	private function finalizeParams(method:String, params:Hash<Dynamic>):Hash<String>
	{
		var convertedParams:Hash<String> = convertArrayValuesToJSON(params);
		var standardParams:Hash<String> = addStandardParams(method, convertedParams);
		standardParams.set("sig", generateSignature(standardParams, secret));
		
		return standardParams;
	}
	
	private function convertArrayValuesToJSON(params:Hash<Dynamic>):Hash<String>
	{
		var convertedParams:Hash<String> = new Hash<String>();
		for (key in params.keys())
		{
			var value:Dynamic = params.get(key);
			//log("[" + key + "] " + value);
			//log("Value is Array? " + Std.is(value, Array));
			if (Std.is(value, Array))
			{
				jsonEncoder = new JSONEncoder(value);
				value = jsonEncoder.getString();
			}
			convertedParams.set(key, Std.string(value));
		}
		return convertedParams;
	}
	
	private function addStandardParams(method:String, params:Hash<String>):Hash<String>
	{
		if (callAsAPIKey != null)
			params.set("call_as_apikey", Std.string(callAsAPIKey));
		
		if (usingSessionSecret)
			params.set("ss", "1");
		
		params.set("method", method);
		params.set("session_key", (sessionKey == null)? "" : sessionKey);
		params.set("api_key", apiKey);
		
		params.set("call_id", Std.string(Sys.time()));
		if (Std.parseFloat(params.get("call_id")) <= lastCallId)
			params.set("call_id", Std.string(lastCallId + 0.001));
		lastCallId = Std.parseFloat(params.get("call_id"));
		
		if (!params.exists("v"))
			params.set("v", "1.0");
		
		if (useSSLResources)
			params.set("return_ssl_resources", Std.string(useSSLResources));
		
		return params;
	}
	
	private function executeServerSideBatch():Void
	{
		var itemCount:Int = Lambda.count(batchQueue);
		var methodFeed:Array<String> = new Array<String>();
		for (key in batchQueue.keys())
		{
			var batchItem:Dynamic = batchQueue.get(key);
			var method:String = (Reflect.hasField(batchItem, "m"))? Reflect.field(batchItem, "m") : "";
			var itemParams:Dynamic = (Reflect.hasField(batchItem, "p"))? Reflect.field(batchItem, "p") : { };
			var params:Hash<Dynamic> = new Hash<Dynamic>();
			for (ikey in Reflect.fields(itemParams))
			{
				params.set(ikey, Reflect.field(itemParams, ikey));
			}
			var finalized:Hash<String> = finalizeParams(method, params);
			methodFeed.push(createURLString(finalized));
		}
		
		var serialOnly:Bool = (batchMode == BATCH_MODE_SERIAL_ONLY);
		var methodFeedEncoder:JSONEncoder = new JSONEncoder(methodFeed);
		
		var batchParams:Hash<Dynamic> = new Hash<Dynamic>();
		batchParams.set("method_feed", methodFeedEncoder.getString());
		batchParams.set("serial_only", serialOnly);
		batchParams.set("format", format);
		
		var result:Dynamic = callMethod("facebook.batch.run", batchParams);
		
		if (Reflect.hasField(result, "error_code"))
			throw new FBRESTClientException(Reflect.field(result, "error_code"));
		
		for (key in batchQueue.keys())
		{
			var batchItem:Dynamic = batchQueue.get(key);
			if (Reflect.hasField(batchItem, "p"))
			{
				Reflect.setField(Reflect.field(batchItem, "p"), "format", format);
			}
			var batchItemResult:Dynamic = convertResult(Std.string(Reflect.field(result, key)), Std.string(Reflect.field(batchItem, "m")), Reflect.field(batchItem, "p"));
			
			if (Reflect.hasField(batchItemResult, "error_code"))
				throw new FBRESTClientException(Reflect.field(batchItemResult, "error_code"));
			
			Reflect.setField(batchItem, "r", batchItemResult);
		}
	}
	
	private static function sortKeyNames(x:String, y:String):Int
	{
		if (x > y)
			return 1;
		
		if (y > x)
			return -1;
		
		return 0;
	}
	
	private function filterList(value:String):Bool
	{
		return (value != null || value != '' || value != 'false' || value != 'null');
	}
	
}

class FBRESTClientException
{
	public var code:Int;
	public var desc:String;
	
	public function new(code:Int)
	{
		this.code = code;
		desc = ErrorCodes.apiErrorDescription(code);
		
		throw "[ERROR " + code + "] " + desc;
	}
}