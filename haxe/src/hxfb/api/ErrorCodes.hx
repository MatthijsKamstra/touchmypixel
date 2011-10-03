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
 * ErrorCodes
 * @author Guntur Sarwohadi
 */

package hxfb.api;

class ErrorCodes 
{
	public static inline var API_EC_SUCCESS:Int = 0;
	
	/*
	* GENERAL ERRORS
	*/
	public static inline var API_EC_UNKNOWN:Int = 1;
	public static inline var API_EC_SERVICE:Int = 2;
	public static inline var API_EC_METHOD:Int = 3;
	public static inline var API_EC_TOO_MANY_CALLS:Int = 4;
	public static inline var API_EC_BAD_IP:Int = 5;
	public static inline var API_EC_HOST_API:Int = 6;
	public static inline var API_EC_HOST_UP:Int = 7;
	public static inline var API_EC_SECURE:Int = 8;
	public static inline var API_EC_RATE:Int = 9;
	public static inline var API_EC_PERMISSION_DENIED:Int = 10;
	public static inline var API_EC_DEPRECATED:Int = 11;
	public static inline var API_EC_VERSION:Int = 12;
	public static inline var API_EC_INTERNAL_FQL_ERROR:Int = 13;
	public static inline var API_EC_HOST_PUP:Int = 14;
	public static inline var API_EC_SESSION_SECRET_NOT_ALLOWED:Int = 15;
	public static inline var API_EC_HOST_READONLY:Int = 16;
	
	
	/*
	* PARAMETER ERRORS
	*/
	public static inline var API_EC_PARAM:Int = 100;
	public static inline var API_EC_PARAM_API_KEY:Int = 101;
	public static inline var API_EC_PARAM_SESSION_KEY:Int = 102;
	public static inline var API_EC_PARAM_CALL_ID:Int = 103;
	public static inline var API_EC_PARAM_SIGNATURE:Int = 104;
	public static inline var API_EC_PARAM_TOO_MANY:Int = 105;
	public static inline var API_EC_PARAM_USER_ID:Int = 110;
	public static inline var API_EC_PARAM_USER_FIELD:Int = 111;
	public static inline var API_EC_PARAM_SOCIAL_FIELD:Int = 112;
	public static inline var API_EC_PARAM_EMAIL:Int = 113;
	public static inline var API_EC_PARAM_USER_ID_LIST:Int = 114;
	public static inline var API_EC_PARAM_FIELD_LIST:Int = 115;
	public static inline var API_EC_PARAM_ALBUM_ID:Int = 120;
	public static inline var API_EC_PARAM_PHOTO_ID:Int = 121;
	public static inline var API_EC_PARAM_FEED_PRIORITY:Int = 130;
	public static inline var API_EC_PARAM_CATEGORY:Int = 140;
	public static inline var API_EC_PARAM_SUBCATEGORY:Int = 141;
	public static inline var API_EC_PARAM_TITLE:Int = 142;
	public static inline var API_EC_PARAM_DESCRIPTION:Int = 143;
	public static inline var API_EC_PARAM_BAD_JSON:Int = 144;
	public static inline var API_EC_PARAM_BAD_EID:Int = 150;
	public static inline var API_EC_PARAM_UNKNOWN_CITY:Int = 151;
	public static inline var API_EC_PARAM_BAD_PAGE_TYPE:Int = 152;
	public static inline var API_EC_PARAM_BAD_LOCALE:Int = 170;
	public static inline var API_EC_PARAM_BLOCKED_NOTIFICATION:Int = 180;

	/*
	* USER PERMISSIONS ERRORS
	*/
	public static inline var API_EC_PERMISSION:Int = 200;
	public static inline var API_EC_PERMISSION_USER:Int = 210;
	public static inline var API_EC_PERMISSION_NO_DEVELOPERS:Int = 211;
	public static inline var API_EC_PERMISSION_OFFLINE_ACCESS:Int = 212;
	public static inline var API_EC_PERMISSION_ALBUM:Int = 220;
	public static inline var API_EC_PERMISSION_PHOTO:Int = 221;
	public static inline var API_EC_PERMISSION_MESSAGE:Int = 230;
	public static inline var API_EC_PERMISSION_OTHER_USER:Int = 240;
	public static inline var API_EC_PERMISSION_STATUS_UPDATE:Int = 250;
	public static inline var API_EC_PERMISSION_PHOTO_UPLOAD:Int = 260;
	public static inline var API_EC_PERMISSION_VIDEO_UPLOAD:Int = 261;
	public static inline var API_EC_PERMISSION_SMS:Int = 270;
	public static inline var API_EC_PERMISSION_CREATE_LISTING:Int = 280;
	public static inline var API_EC_PERMISSION_CREATE_NOTE:Int = 281;
	public static inline var API_EC_PERMISSION_SHARE_ITEM:Int = 282;
	public static inline var API_EC_PERMISSION_EVENT:Int = 290;
	public static inline var API_EC_PERMISSION_LARGE_FBML_TEMPLATE:Int = 291;
	public static inline var API_EC_PERMISSION_LIVEMESSAGE:Int = 292;
	public static inline var API_EC_PERMISSION_CREATE_EVENT:Int = 296;
	public static inline var API_EC_PERMISSION_RSVP_EVENT:Int = 299;

	/*
	* DATA EDIT ERRORS
	*/
	public static inline var API_EC_EDIT:Int = 300;
	public static inline var API_EC_EDIT_USER_DATA:Int = 310;
	public static inline var API_EC_EDIT_PHOTO:Int = 320;
	public static inline var API_EC_EDIT_ALBUM_SIZE:Int = 321;
	public static inline var API_EC_EDIT_PHOTO_TAG_SUBJECT:Int = 322;
	public static inline var API_EC_EDIT_PHOTO_TAG_PHOTO:Int = 323;
	public static inline var API_EC_EDIT_PHOTO_FILE:Int = 324;
	public static inline var API_EC_EDIT_PHOTO_PENDING_LIMIT:Int = 325;
	public static inline var API_EC_EDIT_PHOTO_TAG_LIMIT:Int = 326;
	public static inline var API_EC_EDIT_ALBUM_REORDER_PHOTO_NOT_IN_ALBUM:Int = 327;
	public static inline var API_EC_EDIT_ALBUM_REORDER_TOO_FEW_PHOTOS:Int = 328;

	public static inline var API_EC_MALFORMED_MARKUP:Int = 329;
	public static inline var API_EC_EDIT_MARKUP:Int = 330;

	public static inline var API_EC_EDIT_FEED_TOO_MANY_USER_CALLS:Int = 340;
	public static inline var API_EC_EDIT_FEED_TOO_MANY_USER_ACTION_CALLS:Int = 341;
	public static inline var API_EC_EDIT_FEED_TITLE_LINK:Int = 342;
	public static inline var API_EC_EDIT_FEED_TITLE_LENGTH:Int = 343;
	public static inline var API_EC_EDIT_FEED_TITLE_NAME:Int = 344;
	public static inline var API_EC_EDIT_FEED_TITLE_BLANK:Int = 345;
	public static inline var API_EC_EDIT_FEED_BODY_LENGTH:Int = 346;
	public static inline var API_EC_EDIT_FEED_PHOTO_SRC:Int = 347;
	public static inline var API_EC_EDIT_FEED_PHOTO_LINK:Int = 348;

	public static inline var API_EC_EDIT_VIDEO_SIZE:Int = 350;
	public static inline var API_EC_EDIT_VIDEO_INVALID_FILE:Int = 351;
	public static inline var API_EC_EDIT_VIDEO_INVALID_TYPE:Int = 352;
	public static inline var API_EC_EDIT_VIDEO_FILE:Int = 353;

	public static inline var API_EC_EDIT_FEED_TITLE_ARRAY:Int = 360;
	public static inline var API_EC_EDIT_FEED_TITLE_PARAMS:Int = 361;
	public static inline var API_EC_EDIT_FEED_BODY_ARRAY:Int = 362;
	public static inline var API_EC_EDIT_FEED_BODY_PARAMS:Int = 363;
	public static inline var API_EC_EDIT_FEED_PHOTO:Int = 364;
	public static inline var API_EC_EDIT_FEED_TEMPLATE:Int = 365;
	public static inline var API_EC_EDIT_FEED_TARGET:Int = 366;
	public static inline var API_EC_EDIT_FEED_MARKUP:Int = 367;

	/**
	* SESSION ERRORS
	*/
	public static inline var API_EC_SESSION_TIMED_OUT:Int = 450;
	public static inline var API_EC_SESSION_METHOD:Int = 451;
	public static inline var API_EC_SESSION_INVALID:Int = 452;
	public static inline var API_EC_SESSION_REQUIRED:Int = 453;
	public static inline var API_EC_SESSION_REQUIRED_FOR_SECRET:Int = 454;
	public static inline var API_EC_SESSION_CANNOT_USE_SESSION_SECRET:Int = 455;


	/**
	* FQL ERRORS
	*/
	public static inline var FQL_EC_UNKNOWN_ERROR:Int = 600;
	public static inline var FQL_EC_PARSER:Int = 601; // backwards compatibility
	public static inline var FQL_EC_PARSER_ERROR:Int = 601;
	public static inline var FQL_EC_UNKNOWN_FIELD:Int = 602;
	public static inline var FQL_EC_UNKNOWN_TABLE:Int = 603;
	public static inline var FQL_EC_NOT_INDEXABLE:Int = 604; // backwards compatibility
	public static inline var FQL_EC_NO_INDEX:Int = 604;
	public static inline var FQL_EC_UNKNOWN_FUNCTION:Int = 605;
	public static inline var FQL_EC_INVALID_PARAM:Int = 606;
	public static inline var FQL_EC_INVALID_FIELD:Int = 607;
	public static inline var FQL_EC_INVALID_SESSION:Int = 608;
	public static inline var FQL_EC_UNSUPPORTED_APP_TYPE:Int = 609;
	public static inline var FQL_EC_SESSION_SECRET_NOT_ALLOWED:Int = 610;
	public static inline var FQL_EC_DEPRECATED_TABLE:Int = 611;
	public static inline var FQL_EC_EXTENDED_PERMISSION:Int = 612;
	public static inline var FQL_EC_RATE_LIMIT_EXCEEDED:Int = 613;
	public static inline var FQL_EC_UNRESOLVED_DEPENDENCY:Int = 614;
	public static inline var FQL_EC_INVALID_SEARCH:Int = 615;
	public static inline var FQL_EC_CONTAINS_ERROR:Int = 616;

	public static inline var API_EC_REF_SET_FAILED:Int = 700;

	/**
	* DATA STORE API ERRORS
	*/
	public static inline var API_EC_DATA_UNKNOWN_ERROR:Int = 800;
	public static inline var API_EC_DATA_INVALID_OPERATION:Int = 801;
	public static inline var API_EC_DATA_QUOTA_EXCEEDED:Int = 802;
	public static inline var API_EC_DATA_OBJECT_NOT_FOUND:Int = 803;
	public static inline var API_EC_DATA_OBJECT_ALREADY_EXISTS:Int = 804;
	public static inline var API_EC_DATA_DATABASE_ERROR:Int = 805;
	public static inline var API_EC_DATA_CREATE_TEMPLATE_ERROR:Int = 806;
	public static inline var API_EC_DATA_TEMPLATE_EXISTS_ERROR:Int = 807;
	public static inline var API_EC_DATA_TEMPLATE_HANDLE_TOO_LONG:Int = 808;
	public static inline var API_EC_DATA_TEMPLATE_HANDLE_ALREADY_IN_USE:Int = 809;
	public static inline var API_EC_DATA_TOO_MANY_TEMPLATE_BUNDLES:Int = 810;
	public static inline var API_EC_DATA_MALFORMED_ACTION_LINK:Int = 811;
	public static inline var API_EC_DATA_TEMPLATE_USES_RESERVED_TOKEN:Int = 812;

	/*
	* APPLICATION INFO ERRORS
	*/
	public static inline var API_EC_NO_SUCH_APP:Int = 900;

	/*
	* BATCH ERRORS
	*/
	public static inline var API_EC_BATCH_TOO_MANY_ITEMS:Int = 950;
	public static inline var API_EC_BATCH_ALREADY_STARTED:Int = 951;
	public static inline var API_EC_BATCH_NOT_STARTED:Int = 952;
	public static inline var API_EC_BATCH_METHOD_NOT_ALLOWED_IN_BATCH_MODE:Int = 953;

	/*
	* EVENT API ERRORS
	*/
	public static inline var API_EC_EVENT_INVALID_TIME:Int = 1000;
	public static inline var API_EC_EVENT_NAME_LOCKED :Int = 1001;

	/*
	* INFO BOX ERRORS
	*/
	public static inline var API_EC_INFO_NO_INFORMATION:Int = 1050;
	public static inline var API_EC_INFO_SET_FAILED:Int = 1051;

	/*
	* LIVEMESSAGE API ERRORS
	*/
	public static inline var API_EC_LIVEMESSAGE_SEND_FAILED:Int = 1100;
	public static inline var API_EC_LIVEMESSAGE_EVENT_NAME_TOO_LONG:Int = 1101;
	public static inline var API_EC_LIVEMESSAGE_MESSAGE_TOO_LONG:Int = 1102;

	/*
	* PAYMENTS API ERRORS
	*/
	public static inline var API_EC_PAYMENTS_UNKNOWN:Int = 1150;
	public static inline var API_EC_PAYMENTS_APP_INVALID:Int = 1151;
	public static inline var API_EC_PAYMENTS_DATABASE:Int = 1152;
	public static inline var API_EC_PAYMENTS_PERMISSION_DENIED:Int = 1153;
	public static inline var API_EC_PAYMENTS_APP_NO_RESPONSE:Int = 1154;
	public static inline var API_EC_PAYMENTS_APP_ERROR_RESPONSE:Int = 1155;
	public static inline var API_EC_PAYMENTS_INVALID_ORDER:Int = 1156;
	public static inline var API_EC_PAYMENTS_INVALID_PARAM:Int = 1157;
	public static inline var API_EC_PAYMENTS_INVALID_OPERATION:Int = 1158;
	public static inline var API_EC_PAYMENTS_PAYMENT_FAILED:Int = 1159;
	public static inline var API_EC_PAYMENTS_DISABLED:Int = 1160;

	/*
	* CONNECT SESSION ERRORS
	*/
	public static inline var API_EC_CONNECT_FEED_DISABLED:Int = 1300;

	/*
	* Platform tag bundles errors
	*/
	public static inline var API_EC_TAG_BUNDLE_QUOTA:Int = 1400;

	/*
	* SHARE
	*/
	public static inline var API_EC_SHARE_BAD_URL:Int = 1500;

	/*
	* NOTES
	*/
	public static inline var API_EC_NOTE_CANNOT_MODIFY:Int = 1600;

	/*
	* COMMENTS
	*/
	public static inline var API_EC_COMMENTS_UNKNOWN:Int = 1700;
	public static inline var API_EC_COMMENTS_POST_TOO_LONG:Int = 1701;
	public static inline var API_EC_COMMENTS_DB_DOWN:Int = 1702;
	public static inline var API_EC_COMMENTS_INVALID_XID:Int = 1703;
	public static inline var API_EC_COMMENTS_INVALID_UID:Int = 1704;
	public static inline var API_EC_COMMENTS_INVALID_POST:Int = 1705;
	public static inline var API_EC_COMMENTS_INVALID_REMOVE:Int = 1706;

	/*
	* GIFTS
	*/
	public static inline var API_EC_GIFTS_UNKNOWN:Int = 1900;

	/*
	* APPLICATION MORATORIUM ERRORS
	*/
	public static inline var API_EC_DISABLED_ALL:Int = 2000;
	public static inline var API_EC_DISABLED_STATUS:Int = 2001;
	public static inline var API_EC_DISABLED_FEED_STORIES:Int = 2002;
	public static inline var API_EC_DISABLED_NOTIFICATIONS:Int = 2003;
	public static inline var API_EC_DISABLED_REQUESTS:Int = 2004;
	public static inline var API_EC_DISABLED_EMAIL:Int = 2005;
	
	public static function apiErrorDescription(type:Int):String
	{
		switch(type)
		{
			case API_EC_SUCCESS: return "Success";
			case API_EC_UNKNOWN: return "An unknown error occurred";
			case API_EC_SERVICE: return "Service temporarily unavailable";
			case API_EC_METHOD: return "Unknown method";
			case API_EC_TOO_MANY_CALLS: return "Application request limit reached";
			case API_EC_BAD_IP: return "Unauthorized source IP address";
			case API_EC_PARAM: return "Invalid parameter";
			case API_EC_PARAM_API_KEY: return "Invalid API key";
			case API_EC_PARAM_SESSION_KEY: return "Session key invalid or no longer valid";
			case API_EC_PARAM_CALL_ID: return "Call_id must be greater than previous";
			case API_EC_PARAM_SIGNATURE: return "Incorrect signature";
			case API_EC_PARAM_USER_ID: return "Invalid user id";
			case API_EC_PARAM_USER_FIELD: return "Invalid user info field";
			case API_EC_PARAM_SOCIAL_FIELD: return "Invalid user field";
			case API_EC_PARAM_USER_ID_LIST: return "Invalid user id list";
			case API_EC_PARAM_FIELD_LIST: return "Invalid field list";
			case API_EC_PARAM_ALBUM_ID: return "Invalid album id";
			case API_EC_PARAM_BAD_EID: return "Invalid eid";
			case API_EC_PARAM_UNKNOWN_CITY: return "Unknown city";
			case API_EC_PERMISSION: return "Permissions error";
			case API_EC_PERMISSION_USER: return "User not visible";
			case API_EC_PERMISSION_NO_DEVELOPERS: return "Application has no developers";
			case API_EC_PERMISSION_ALBUM: return "Album not visible";
			case API_EC_PERMISSION_PHOTO: return "Photo not visible";
			case API_EC_PERMISSION_EVENT: return "Creating and modifying events required the extended permission create_event";
			case API_EC_PERMISSION_RSVP_EVENT: return "RSVPing to events required the extended permission rsvp_event";
			case API_EC_EDIT_ALBUM_SIZE: return "Album is full";
			case FQL_EC_PARSER: return "FQL: Parser Error";
			case FQL_EC_UNKNOWN_FIELD: return "FQL: Unknown Field";
			case FQL_EC_UNKNOWN_TABLE: return "FQL: Unknown Table";
			case FQL_EC_NOT_INDEXABLE: return "FQL: Statement not indexable";
			case FQL_EC_UNKNOWN_FUNCTION: return "FQL: Attempted to call unknown function";
			case FQL_EC_INVALID_PARAM: return "FQL: Invalid parameter passed in";
			case API_EC_DATA_UNKNOWN_ERROR: return "Unknown data store API error";
			case API_EC_DATA_INVALID_OPERATION: return "Invalid operation";
			case API_EC_DATA_QUOTA_EXCEEDED: return "Data store allowable quota was exceeded";
			case API_EC_DATA_OBJECT_NOT_FOUND: return "Specified object cannot be found";
			case API_EC_DATA_OBJECT_ALREADY_EXISTS: return "Specified object already exists";
			case API_EC_DATA_DATABASE_ERROR: return "A database error occurred. Please try again";
			case API_EC_BATCH_ALREADY_STARTED: return "begin_batch already called, please make sure to call end_batch first";
			case API_EC_BATCH_NOT_STARTED: return "end_batch called before begin_batch";
			case API_EC_BATCH_METHOD_NOT_ALLOWED_IN_BATCH_MODE: return "This method is not allowed in batch mode";
		}
		
		return "";
	}
	
	public function new() { }
	
}