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
 * Data API
 * @author Guntur Sarwohadi
 */

package hxfb.api;

import hxfb.HxFb;
import hxjson2.JSONEncoder;

class Data 
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
	* Set a user preference.
	*
	* @param  pref_id    preference identifier (0-200)
	* @param  value      preferece's value
	* @param  uid        the user id (defaults to current session user)
	* @error
	*    API_EC_DATA_DATABASE_ERROR
	*    API_EC_PARAM
	*    API_EC_DATA_QUOTA_EXCEEDED
	*    API_EC_DATA_UNKNOWN_ERROR
	*    API_EC_PERMISSION_OTHER_USER
	*/
	public function setUserPreference(prefId:Int, value:String, ?uId:String):Dynamic
	{
		params.set("pref_id", prefId);
		params.set("value", value);
		params.set("uid", uId);
		
		return hnf.callMethod("facebook.data.setUserPreference", params);
	}
	
	/**
	* Set a user's all preferences for this application.
	*
	* @param  values     preferece values in an associative arrays
	* @param  replace    whether to replace all existing preferences or
	*                    merge into them.
	* @param  uId        the user id (defaults to current session user)
	* @error
	*    API_EC_DATA_DATABASE_ERROR
	*    API_EC_PARAM
	*    API_EC_DATA_QUOTA_EXCEEDED
	*    API_EC_DATA_UNKNOWN_ERROR
	*    API_EC_PERMISSION_OTHER_USER
	*/
	public function setUserPreferences(values:Array<String>, ?replace:Bool = false, ?uId:String):Dynamic
	{
		var valuesEncoder:JSONEncoder = new JSONEncoder(values);
		
		params.set("values", valuesEncoder.getString());
		params.set("replace", replace);
		params.set("uid", hnf.getUID(uId));
		
		return hnf.callMethod("facebook.data.setUserPreferences", params);
	}
	
	/**
	* Get a user preference.
	*
	* @param  pref_id    preference identifier (0-200)
	* @param  uId        the user id (defaults to current session user)
	* @return            preference's value
	* @error
	*    API_EC_DATA_DATABASE_ERROR
	*    API_EC_PARAM
	*    API_EC_DATA_QUOTA_EXCEEDED
	*    API_EC_DATA_UNKNOWN_ERROR
	*    API_EC_PERMISSION_OTHER_USER
	*/
	public function getUserPreference(prefId:String, ?uId:String):Dynamic
	{
		params.set("pref_id", prefId);
		params.set("uid", uId);
		
		return hnf.callMethod("facebook.data.getUserPreference", params);
	}
	
	/**
	* Get a user preference.
	*
	* @param  uId        the user id (defaults to current session user)
	* @return            preference values
	* @error
	*    API_EC_DATA_DATABASE_ERROR
	*    API_EC_DATA_QUOTA_EXCEEDED
	*    API_EC_DATA_UNKNOWN_ERROR
	*    API_EC_PERMISSION_OTHER_USER
	*/
	public function getUserPreferences(?uId:String):Dynamic
	{
		params.set("uid", uId);
		
		return hnf.callMethod("facebook.data.getUserPreferences", params);
	}
	
	/**
	* Create a new object type.
	*
	* @param  name       object type's name
	* @error
	*    API_EC_DATA_DATABASE_ERROR
	*    API_EC_DATA_OBJECT_ALREADY_EXISTS
	*    API_EC_PARAM
	*    API_EC_PERMISSION
	*    API_EC_DATA_INVALID_OPERATION
	*    API_EC_DATA_QUOTA_EXCEEDED
	*    API_EC_DATA_UNKNOWN_ERROR
	*/
	public function createObjectType(name:String):Dynamic
	{
		params.set("name", name);
		return hnf.callMethod("facebook.data.createObjectType", params);
	}
	
	/**
	* Delete an object type.
	*
	* @param  obj_type       object type's name
	* @error
	*    API_EC_DATA_DATABASE_ERROR
	*    API_EC_DATA_OBJECT_NOT_FOUND
	*    API_EC_PARAM
	*    API_EC_PERMISSION
	*    API_EC_DATA_INVALID_OPERATION
	*    API_EC_DATA_QUOTA_EXCEEDED
	*    API_EC_DATA_UNKNOWN_ERROR
	*/
	public function dropObjectType(objType:String):Dynamic
	{
		params.set("obj_type", objType);
		return hnf.callMethod("facebook.data.dropObjectType", params);
	}
	
	/**
	* Rename an object type.
	*
	* @param  obj_type       object type's name
	* @param  new_name       new object type's name
	* @error
	*    API_EC_DATA_DATABASE_ERROR
	*    API_EC_DATA_OBJECT_NOT_FOUND
	*    API_EC_DATA_OBJECT_ALREADY_EXISTS
	*    API_EC_PARAM
	*    API_EC_PERMISSION
	*    API_EC_DATA_INVALID_OPERATION
	*    API_EC_DATA_QUOTA_EXCEEDED
	*    API_EC_DATA_UNKNOWN_ERROR
	*/
	public function renameObjectType(objType:String, newName:String):Dynamic
	{
		params.set("obj_type", objType);
		params.set("new_name", newName);
		
		return hnf.callMethod("facebook.data.renameObjectType", params);
	}
	
	/**
	* Add a new property to an object type.
	*
	* @param  obj_type       object type's name
	* @param  prop_name      name of the property to add
	* @param  prop_type      1: integer; 2: string; 3: text blob
	* @error
	*    API_EC_DATA_DATABASE_ERROR
	*    API_EC_DATA_OBJECT_ALREADY_EXISTS
	*    API_EC_PARAM
	*    API_EC_PERMISSION
	*    API_EC_DATA_INVALID_OPERATION
	*    API_EC_DATA_QUOTA_EXCEEDED
	*    API_EC_DATA_UNKNOWN_ERROR
	*/
	public function defineObjectProperty(objType:String, propName:String, propType:Int):Dynamic
	{
		params.set("obj_type", objType);
		params.set("prop_name", propName);
		params.set("prop_type", propType);
		
		return hnf.callMethod("facebook.data.defineObjectProperty", params);
	}
	
	/**
	* Remove a previously defined property from an object type.
	*
	* @param  obj_type      object type's name
	* @param  prop_name     name of the property to remove
	* @error
	*    API_EC_DATA_DATABASE_ERROR
	*    API_EC_DATA_OBJECT_NOT_FOUND
	*    API_EC_PARAM
	*    API_EC_PERMISSION
	*    API_EC_DATA_INVALID_OPERATION
	*    API_EC_DATA_QUOTA_EXCEEDED
	*    API_EC_DATA_UNKNOWN_ERROR
	*/
	public function undefineObjectProperty(objType:String, propName:String):Dynamic
	{
		params.set("obj_type", objType);
		params.set("prop_name", propName);
		
		return hnf.callMethod("facebook.data.undefineObjectProperty", params);
	}
	
	/**
	* Rename a previously defined property of an object type.
	*
	* @param  obj_type      object type's name
	* @param  prop_name     name of the property to rename
	* @param  new_name      new name to use
	* @error
	*    API_EC_DATA_DATABASE_ERROR
	*    API_EC_DATA_OBJECT_NOT_FOUND
	*    API_EC_DATA_OBJECT_ALREADY_EXISTS
	*    API_EC_PARAM
	*    API_EC_PERMISSION
	*    API_EC_DATA_INVALID_OPERATION
	*    API_EC_DATA_QUOTA_EXCEEDED
	*    API_EC_DATA_UNKNOWN_ERROR
	*/
	public function renameObjectProperty(objType:String, propName:String, newName:String):Dynamic
	{
		params.set("obj_type", objType);
		params.set("prop_name", propName);
		params.set("new_name", newName);
		
		return hnf.callMethod("facebook.data.renameObjectProperty", params);
	}
	
	/**
	* Retrieve a list of all object types that have defined for the application.
	*
	* @return               a list of object type names
	* @error
	*    API_EC_DATA_DATABASE_ERROR
	*    API_EC_PERMISSION
	*    API_EC_DATA_QUOTA_EXCEEDED
	*    API_EC_DATA_UNKNOWN_ERROR
	*/
	public function getObjectTypes():Dynamic
	{
		return hnf.callMethod("facebook.data.getObjectTypes");
	}
	
	/**
	* Get definitions of all properties of an object type.
	*
	* @param obj_type       object type's name
	* @return               pairs of property name and property types
	* @error
	*    API_EC_DATA_DATABASE_ERROR
	*    API_EC_PARAM
	*    API_EC_PERMISSION
	*    API_EC_DATA_OBJECT_NOT_FOUND
	*    API_EC_DATA_QUOTA_EXCEEDED
	*    API_EC_DATA_UNKNOWN_ERROR
	*/
	public function getObjectType(objType:String):Dynamic
	{
		params.set("obj_type", objType);
		return hnf.callMethod("facebook.data.getObjectType", params);
	}
	
	/**
	* Create a new object.
	*
	* @param  obj_type      object type's name
	* @param  properties    (optional) properties to set initially
	* @return               newly created object's id
	* @error
	*    API_EC_DATA_DATABASE_ERROR
	*    API_EC_PARAM
	*    API_EC_PERMISSION
	*    API_EC_DATA_INVALID_OPERATION
	*    API_EC_DATA_QUOTA_EXCEEDED
	*    API_EC_DATA_UNKNOWN_ERROR
	*/
	public function createObject(objType:String, ?properties:Array<Dynamic>):Int
	{
		var propertiesEncoder:JSONEncoder = new JSONEncoder(properties);
		params.set("obj_type", objType);
		params.set("properties", propertiesEncoder.getString());
		
		return hnf.callMethod("facebook.data.createObject", params);
	}
	
	/**
	* Update an existing object.
	*
	* @param  obj_id        object's id
	* @param  properties    new properties
	* @param  replace       true for replacing existing properties;
	*                       false for merging
	* @error
	*    API_EC_DATA_DATABASE_ERROR
	*    API_EC_DATA_OBJECT_NOT_FOUND
	*    API_EC_PARAM
	*    API_EC_PERMISSION
	*    API_EC_DATA_INVALID_OPERATION
	*    API_EC_DATA_QUOTA_EXCEEDED
	*    API_EC_DATA_UNKNOWN_ERROR
	*/
	public function updateObject(objId:Int, properties:Array<String>, ?replace:Bool = false):Dynamic
	{
		var propertiesEncoder:JSONEncoder = new JSONEncoder(properties);
		
		params.set("obj_id", objId);
		params.set("properties", propertiesEncoder.getString());
		params.set("replace", replace);
		
		return hnf.callMethod("facebook.data.updateObject", params);
	}
	
	/**
	* Delete an existing object.
	*
	* @param  obj_id        object's id
	* @error
	*    API_EC_DATA_DATABASE_ERROR
	*    API_EC_DATA_OBJECT_NOT_FOUND
	*    API_EC_PARAM
	*    API_EC_PERMISSION
	*    API_EC_DATA_INVALID_OPERATION
	*    API_EC_DATA_QUOTA_EXCEEDED
	*    API_EC_DATA_UNKNOWN_ERROR
	*/
	public function deleteObject(objId:Int):Dynamic
	{
		params.set("obj_id", objId);
		return hnf.callMethod("facebook.data.deleteObject", params);
	}
	
	/**
	* Delete a list of objects.
	*
	* @param  obj_ids       objects to delete
	* @error
	*    API_EC_DATA_DATABASE_ERROR
	*    API_EC_PARAM
	*    API_EC_PERMISSION
	*    API_EC_DATA_INVALID_OPERATION
	*    API_EC_DATA_QUOTA_EXCEEDED
	*    API_EC_DATA_UNKNOWN_ERROR
	*/
	public function deleteObjects(objIds:Array<Int>):Dynamic
	{
		var objIdsEncoder:JSONEncoder = new JSONEncoder(objIds);
		
		params.set("obj_ids", objIdsEncoder.getString());
		
		return hnf.callMethod("facebook.data.deleteObjects", params);
	}
	
	/**
	  * Get a single property value of an object.
	  *
	  * @param  obj_id        object's id
	  * @param  prop_name     individual property's name
	  * @return               individual property's value
	  * @error
	  *    API_EC_DATA_DATABASE_ERROR
	  *    API_EC_DATA_OBJECT_NOT_FOUND
	  *    API_EC_PARAM
	  *    API_EC_PERMISSION
	  *    API_EC_DATA_INVALID_OPERATION
	  *    API_EC_DATA_QUOTA_EXCEEDED
	  *    API_EC_DATA_UNKNOWN_ERROR
	  */
	public function getObjectProperty(objType:String, propName:String):Dynamic
	{
		params.set("obj_type", objType);
		params.set("prop_name", propName);
		return hnf.callMethod("facebook.data.getObjectProperty", params);
	}
	
	/**
	* Get properties of an object.
	*
	* @param  obj_id      object's id
	* @param  prop_names  (optional) properties to return; null for all.
	* @return             specified properties of an object
	* @error
	*    API_EC_DATA_DATABASE_ERROR
	*    API_EC_DATA_OBJECT_NOT_FOUND
	*    API_EC_PARAM
	*    API_EC_PERMISSION
	*    API_EC_DATA_INVALID_OPERATION
	*    API_EC_DATA_QUOTA_EXCEEDED
	*    API_EC_DATA_UNKNOWN_ERROR
	*/
	public function getObject(objId:Int, ?propNames:Array<String>):Dynamic
	{
		var propNamesENcoder:JSONEncoder = new JSONEncoder(propNames);
		params.set("obj_id", objId);
		params.set("prop_names", propNamesENcoder.getString());
		return hnf.callMethod("facebook.data.getObject", params);
	}
	
	/**
	* Get properties of a list of objects.
	*
	* @param  obj_ids     object ids
	* @param  prop_names  (optional) properties to return; null for all.
	* @return             specified properties of an object
	* @error
	*    API_EC_DATA_DATABASE_ERROR
	*    API_EC_DATA_OBJECT_NOT_FOUND
	*    API_EC_PARAM
	*    API_EC_PERMISSION
	*    API_EC_DATA_INVALID_OPERATION
	*    API_EC_DATA_QUOTA_EXCEEDED
	*    API_EC_DATA_UNKNOWN_ERROR
	*/
	public function getObjects(objIds:Array<Int>, ?propNames:Array<String>):Dynamic
	{
		var objIdsEncoder:JSONEncoder = new JSONEncoder(objIds);
		var propNamesEncoder:JSONEncoder = new JSONEncoder(propNames);
		params.set("obj_ids", objIdsEncoder.getString());
		params.set("prop_names", propNamesEncoder.getString());
		
		return hnf.callMethod("facebook.data.getObjects", params);
	}
	
	/**
	* Set a single property value of an object.
	*
	* @param  obj_id        object's id
	* @param  prop_name     individual property's name
	* @param  prop_value    new value to set
	* @error
	*    API_EC_DATA_DATABASE_ERROR
	*    API_EC_DATA_OBJECT_NOT_FOUND
	*    API_EC_PARAM
	*    API_EC_PERMISSION
	*    API_EC_DATA_INVALID_OPERATION
	*    API_EC_DATA_QUOTA_EXCEEDED
	*    API_EC_DATA_UNKNOWN_ERROR
	*/
	public function setObjectProperty(objId:Int, propName:String, propValue:String):Dynamic
	{
		params.set("obj_id", objId);
		params.set("prop_name", propName);
		params.set("prop_value", propValue);
		
		return hnf.callMethod("facebook.data.setObjectProperty", params);
	}
	
	/**
	* Read hash value by key.
	*
	* @param  obj_type      object type's name
	* @param  key           hash key
	* @param  prop_name     (optional) individual property's name
	* @return               hash value
	* @error
	*    API_EC_DATA_DATABASE_ERROR
	*    API_EC_PARAM
	*    API_EC_PERMISSION
	*    API_EC_DATA_INVALID_OPERATION
	*    API_EC_DATA_QUOTA_EXCEEDED
	*    API_EC_DATA_UNKNOWN_ERROR
	*/
	public function getHashValue(objType:String, key:String, ?propName:String):Dynamic
	{
		params.set("obj_type", objType);
		params.set("key", key);
		params.set("prop_name", propName);
		return hnf.callMethod("facebook.data.getHashValue", params);
	}
	
	/**
	* Write hash value by key.
	*
	* @param  obj_type      object type's name
	* @param  key           hash key
	* @param  value         hash value
	* @param  prop_name     (optional) individual property's name
	* @error
	*    API_EC_DATA_DATABASE_ERROR
	*    API_EC_PARAM
	*    API_EC_PERMISSION
	*    API_EC_DATA_INVALID_OPERATION
	*    API_EC_DATA_QUOTA_EXCEEDED
	*    API_EC_DATA_UNKNOWN_ERROR
	*/
	public function setHashValue(objType:String, key:String, value:String, ?propName:String):Dynamic
	{
		params.set("obj_type", objType);
		params.set("key", key);
		params.set("value", value);
		params.set("prop_name", propName);
		
		return hnf.callMethod("facebook.data.setHashValue", params);
	}
	
	/**
	* Increase a hash value by specified increment atomically.
	*
	* @param  obj_type      object type's name
	* @param  key           hash key
	* @param  prop_name     individual property's name
	* @param  increment     (optional) default is 1
	* @return               incremented hash value
	* @error
	*    API_EC_DATA_DATABASE_ERROR
	*    API_EC_PARAM
	*    API_EC_PERMISSION
	*    API_EC_DATA_INVALID_OPERATION
	*    API_EC_DATA_QUOTA_EXCEEDED
	*    API_EC_DATA_UNKNOWN_ERROR
	*/
	public function incHashValue(objType:String, key:String, propName:String, ?increment:Int = 1):Dynamic
	{
		params.set("obj_type", objType);
		params.set("key", key);
		params.set("prop_name", propName);
		params.set("increment", increment);
		
		return hnf.callMethod("facebook.data.incHashValue", params);
	}
	
	/**
	* Remove a hash key and its values.
	*
	* @param  obj_type    object type's name
	* @param  key         hash key
	* @error
	*    API_EC_DATA_DATABASE_ERROR
	*    API_EC_PARAM
	*    API_EC_PERMISSION
	*    API_EC_DATA_INVALID_OPERATION
	*    API_EC_DATA_QUOTA_EXCEEDED
	*    API_EC_DATA_UNKNOWN_ERROR
	*/
	public function removeHashKey(objType:String, key:String):Dynamic
	{
		params.set("obj_type", objType);
		params.set("key", key);
		
		return hnf.callMethod("facebook.data.removeHashKey", params);
	}
	
	/**
	* Remove hash keys and their values.
	*
	* @param  obj_type    object type's name
	* @param  keys        hash keys
	* @error
	*    API_EC_DATA_DATABASE_ERROR
	*    API_EC_PARAM
	*    API_EC_PERMISSION
	*    API_EC_DATA_INVALID_OPERATION
	*    API_EC_DATA_QUOTA_EXCEEDED
	*    API_EC_DATA_UNKNOWN_ERROR
	*/
	public function removeHashKeys(objType:String, keys:Array<String>):Dynamic
	{
		var keysEncoder:JSONEncoder = new JSONEncoder(keys);
		params.set("obj_type", objType);
		params.set("keys", keysEncoder.getString());
		
		return hnf.callMethod("facebook.data.removeHashKeys", params);
	}
	
	/**
	* Define an object association.
	*
	* @param  name        name of this association
	* @param  assoc_type  1: one-way 2: two-way symmetric 3: two-way asymmetric
	* @param  assoc_info1 needed info about first object type
	* @param  assoc_info2 needed info about second object type
	* @param  inverse     (optional) name of reverse association
	* @error
	*    API_EC_DATA_DATABASE_ERROR
	*    API_EC_DATA_OBJECT_ALREADY_EXISTS
	*    API_EC_PARAM
	*    API_EC_PERMISSION
	*    API_EC_DATA_INVALID_OPERATION
	*    API_EC_DATA_QUOTA_EXCEEDED
	*    API_EC_DATA_UNKNOWN_ERROR
	*/
	public function defineAssociation(name:String, assocType:Int, assocInfo1:Dynamic, assocInfo2:Dynamic, ?inverse:String):Dynamic
	{
		var assocInfo1Encoder:JSONEncoder = new JSONEncoder(assocInfo1);
		var assocInfo2Encoder:JSONEncoder = new JSONEncoder(assocInfo2);
		
		params.set("name", name);
		params.set("assoc_type", assocType);
		params.set("assoc_info1", assocInfo1Encoder.getString());
		params.set("assoc_info2", assocInfo2Encoder.getString());
		params.set("inverse", inverse);
		
		return hnf.callMethod("facebook.data.defineAssociation", params);
	}
	
	/**
	* Undefine an object association.
	*
	* @param  name        name of this association
	* @error
	*    API_EC_DATA_DATABASE_ERROR
	*    API_EC_DATA_OBJECT_NOT_FOUND
	*    API_EC_PARAM
	*    API_EC_PERMISSION
	*    API_EC_DATA_INVALID_OPERATION
	*    API_EC_DATA_QUOTA_EXCEEDED
	*    API_EC_DATA_UNKNOWN_ERROR
	*/
	public function undefineAssociation(name:String):Dynamic
	{
		params.set("name", name);
		
		return hnf.callMethod("facebook.data.undefineAssociation", params);
	}
	
	/**
	* Rename an object association or aliases.
	*
	* @param  name        name of this association
	* @param  new_name    (optional) new name of this association
	* @param  new_alias1  (optional) new alias for object type 1
	* @param  new_alias2  (optional) new alias for object type 2
	* @error
	*    API_EC_DATA_DATABASE_ERROR
	*    API_EC_DATA_OBJECT_ALREADY_EXISTS
	*    API_EC_DATA_OBJECT_NOT_FOUND
	*    API_EC_PARAM
	*    API_EC_PERMISSION
	*    API_EC_DATA_INVALID_OPERATION
	*    API_EC_DATA_QUOTA_EXCEEDED
	*    API_EC_DATA_UNKNOWN_ERROR
	*/
	public function renameAssociation(name:String, newName:String, ?newAlias1:String, ?newAlias2:String):Dynamic
	{
		params.set("name", name);
		params.set("new_name", newName);
		params.set("new_alias1", newAlias1);
		params.set("new_alias2", newAlias2);
		
		return hnf.callMethod("facebook.data.renameAssociation", params);
	}
	
	/**
	* Get definition of an object association.
	*
	* @param  name        name of this association
	* @return             specified association
	* @error
	*    API_EC_DATA_DATABASE_ERROR
	*    API_EC_DATA_OBJECT_NOT_FOUND
	*    API_EC_PARAM
	*    API_EC_PERMISSION
	*    API_EC_DATA_QUOTA_EXCEEDED
	*    API_EC_DATA_UNKNOWN_ERROR
	*/
	public function getAssociationDefinition(name:String):Dynamic
	{
		params.set("name", name);
		return hnf.callMethod("facebook.data.getAssociationDefinition", params);
	}
	
	/**
	* Get definition of all associations.
	*
	* @return             all defined associations
	* @error
	*    API_EC_DATA_DATABASE_ERROR
	*    API_EC_PERMISSION
	*    API_EC_DATA_QUOTA_EXCEEDED
	*    API_EC_DATA_UNKNOWN_ERROR
	*/
	public function getAssociationDefinitions():Dynamic
	{
		return hnf.callMethod("facebook.data.getAssociationDefinition");
	}
	
	/**
	* Create or modify an association between two objects.
	*
	* @param  name        name of association
	* @param  obj_id1     id of first object
	* @param  obj_id2     id of second object
	* @param  data        (optional) extra string data to store
	* @param  assoc_time  (optional) extra time data; default to creation time
	* @error
	*    API_EC_DATA_DATABASE_ERROR
	*    API_EC_PARAM
	*    API_EC_PERMISSION
	*    API_EC_DATA_INVALID_OPERATION
	*    API_EC_DATA_QUOTA_EXCEEDED
	*    API_EC_DATA_UNKNOWN_ERROR
	*/
	public function setAssociation(name:String, objId1:String, objId2:String, ?data:String, ?assocTime:Int):Dynamic
	{
		params.set("name", name);
		params.set("obj_id1", objId1);
		params.set("obj_id2", objId2);
		params.set("data", data);
		params.set("assoc_time", assocTime);
		
		return hnf.callMethod("facebook.data.setAssociation", params);
	}
	
	/**
	* Create or modify associations between objects.
	*
	* @param  assocs      associations to set
	* @param  name        (optional) name of association
	* @error
	*    API_EC_DATA_DATABASE_ERROR
	*    API_EC_PARAM
	*    API_EC_PERMISSION
	*    API_EC_DATA_INVALID_OPERATION
	*    API_EC_DATA_QUOTA_EXCEEDED
	*    API_EC_DATA_UNKNOWN_ERROR
	*/
	public function setAssociations(assocs:Array<String>, ?name:String):Dynamic
	{
		var assocsEncoder:JSONEncoder = new JSONEncoder(assocs);
		params.set("assocs", assocsEncoder.getString());
		params.set("name", name);
		
		return hnf.callMethod("facebook.data.setAssociations", params);
	}
	
	/**
	* Remove an association between two objects.
	*
	* @param  name        name of association
	* @param  obj_id1     id of first object
	* @param  obj_id2     id of second object
	* @error
	*    API_EC_DATA_DATABASE_ERROR
	*    API_EC_DATA_OBJECT_NOT_FOUND
	*    API_EC_PARAM
	*    API_EC_PERMISSION
	*    API_EC_DATA_QUOTA_EXCEEDED
	*    API_EC_DATA_UNKNOWN_ERROR
	*/
	public function removeAssociation(name:String, objId1:Int, objId2:Int):Dynamic
	{
		params.set("name", name);
		params.set("obj_id1", objId1);
		params.set("obj_id2", objId2);
		
		return hnf.callMethod("facebook.data.removeAssociation", params);
	}
	
	/**
	* Remove associations between objects by specifying one object id.
	*
	* @param  name        name of association
	* @param  obj_id      who's association to remove
	* @error
	*    API_EC_DATA_DATABASE_ERROR
	*    API_EC_DATA_OBJECT_NOT_FOUND
	*    API_EC_PARAM
	*    API_EC_PERMISSION
	*    API_EC_DATA_INVALID_OPERATION
	*    API_EC_DATA_QUOTA_EXCEEDED
	*    API_EC_DATA_UNKNOWN_ERROR
	*/
	public function removeAssociations(assocs:Array<String>, ?name:String):Dynamic
	{
		var assocsEncoder:JSONEncoder = new JSONEncoder(assocs);
		params.set("assocs", assocsEncoder.getString());
		params.set("name", name);
		
		return hnf.callMethod("facebook.data.removeAssociations", params);
	}
	
	/**
	* Remove associations between objects by specifying one object id.
	*
	* @param  name        name of association
	* @param  obj_id      who's association to remove
	* @error
	*    API_EC_DATA_DATABASE_ERROR
	*    API_EC_DATA_OBJECT_NOT_FOUND
	*    API_EC_PARAM
	*    API_EC_PERMISSION
	*    API_EC_DATA_INVALID_OPERATION
	*    API_EC_DATA_QUOTA_EXCEEDED
	*    API_EC_DATA_UNKNOWN_ERROR
	*/
	public function removeAssociatedObjects(name:String, objId:Int):Dynamic
	{
		params.set("name", name);
		params.set("obj_id", objId);
		
		return hnf.callMethod("facebook.data.removeAssociatedObjects", params);
	}
	
	/**
	* Retrieve a list of associated objects.
	*
	* @param  name        name of association
	* @param  obj_id      who's association to retrieve
	* @param  no_data     only return object ids
	* @return             associated objects
	* @error
	*    API_EC_DATA_DATABASE_ERROR
	*    API_EC_DATA_OBJECT_NOT_FOUND
	*    API_EC_PARAM
	*    API_EC_PERMISSION
	*    API_EC_DATA_INVALID_OPERATION
	*    API_EC_DATA_QUOTA_EXCEEDED
	*    API_EC_DATA_UNKNOWN_ERROR
	*/
	public function getAssociatedObjects(name:String, objId:Int, ?noData:Bool):Dynamic
	{
		params.set("name", name);
		params.set("obj_id", objId);
		params.set("no_data", noData);
		return hnf.callMethod("facebook.data.getAssociatedObjects", params);
	}
	
	/**
	* Count associated objects.
	*
	* @param  name        name of association
	* @param  obj_id      who's association to retrieve
	* @return             associated object's count
	* @error
	*    API_EC_DATA_DATABASE_ERROR
	*    API_EC_DATA_OBJECT_NOT_FOUND
	*    API_EC_PARAM
	*    API_EC_PERMISSION
	*    API_EC_DATA_INVALID_OPERATION
	*    API_EC_DATA_QUOTA_EXCEEDED
	*    API_EC_DATA_UNKNOWN_ERROR
	*/
	public function getAssociatedObjectCount(name:String, objId:Int):Dynamic
	{
		params.set("name", name);
		params.set("obj_id", objId);
		return hnf.callMethod("facebook.data.getAssociatedObjectCount", params);
	}
	
	/**
	* Get a list of associated object counts.
	*
	* @param  name        name of association
	* @param  obj_ids     whose association to retrieve
	* @return             associated object counts
	* @error
	*    API_EC_DATA_DATABASE_ERROR
	*    API_EC_DATA_OBJECT_NOT_FOUND
	*    API_EC_PARAM
	*    API_EC_PERMISSION
	*    API_EC_DATA_INVALID_OPERATION
	*    API_EC_DATA_QUOTA_EXCEEDED
	*    API_EC_DATA_UNKNOWN_ERROR
	*/
	public function getAssociatedObjectCounts(name:String, objIds:Array<Int>):Dynamic
	{
		var objIdsEncoder:JSONEncoder = new JSONEncoder(objIds);
		params.set("name", name);
		params.set("obj_id", objIdsEncoder.getString());
		return hnf.callMethod("facebook.data.getAssociatedObjectCounts", params);
	}
	
	/**
	* Find all associations between two objects.
	*
	* @param  obj_id1     id of first object
	* @param  obj_id2     id of second object
	* @param  no_data     only return association names without data
	* @return             all associations between objects
	* @error
	*    API_EC_DATA_DATABASE_ERROR
	*    API_EC_PARAM
	*    API_EC_PERMISSION
	*    API_EC_DATA_QUOTA_EXCEEDED
	*    API_EC_DATA_UNKNOWN_ERROR
	*/
	public function getAssociations(objId1:Int, objId2:Int, ?noData = true):Dynamic
	{
		params.set("obj_id1", objId1);
		params.set("obj_id2", objId2);
		params.set("no_data", noData);
		return hnf.callMethod("facebook.data.getAssociations", params);
	}
	
	/**
	* Returns cookies according to the filters specified.
	*
	* @param String $uid     User for which the cookies are needed.
	* @param string $name (Optional) A null parameter will get all cookies
	*                     for the user.
	*
	* @return array  Cookies!  Nom nom nom nom nom.
	*/
	public function getCookies(uId:String, name:String):Dynamic
	{
		params.set("uid", uId);
		params.set("name", name);
		return hnf.callMethod("facebook.data.getCookies", params);
	}
	
	/**
	* Sets cookies according to the params specified.
	*
	* @param String $uId       User for which the cookies are needed.
	* @param string $name   Name of the cookie
	* @param string $value  (Optional) if expires specified and is in the past
	* @param int $expires   (Optional) Expiry time
	* @param string $path   (Optional) Url path to associate with (default is /)
	*
	* @return bool  true on success
	*/
	public function setCookie(uId:String, name:String, value:String, ?expires:Int, ?path:String = "/"):Dynamic
	{
		params.set("uid", uId);
		params.set("name", name);
		params.set("value", value);
		params.set("expires", expires);
		params.set("path", path);
		
		return hnf.callMethod("facebook.data.setCookie", params);
	}
	
}