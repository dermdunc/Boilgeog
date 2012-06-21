﻿package BubMod.model {		import org.puremvc.as3.interfaces.IProxy;    import org.puremvc.as3.patterns.proxy.Proxy;	import BubMod.view.components.*;	import flash.utils.Dictionary;		public class SchemaDataProxy extends Proxy implements IProxy{				// Cannonical name of the Proxy        public static const NAME:String = 'SchemaDataProxy';		// Public Properties:		// Private Properties:		private static var _tableLocations:Array = null;		private static var _camera:SchemaCamera = null;		private static var _entitiesArray:Array = null;		private static var _schemaName:String = "New Schema";		private static var _schemaDictionary:Dictionary = null;		private static var _schemaId:int = 0;				private var _entityCount:int = 0;			// Initialization:		// Constructor         public function SchemaDataProxy() {            super(NAME); // pass the cannonical name to the superclass        }				//Function which adds a schema to the dictionary		public function addSchemaToDictionary(schemaId:int, schemaName:String) {			//Initialize the schema dictionary if it's null			if (_schemaDictionary == null)				_schemaDictionary = new Dictionary();			_schemaDictionary[schemaId] = schemaName;		}				//Constructor which returns the schema dictionary		public function getSchemaDictionary():Dictionary {			return _schemaDictionary;		}				//Constructors which get and set the schema name		public function getSchemaName():String {			return _schemaName;	  	}				public function setSchemaName(schemaName:String):void {			_schemaName = schemaName;	  	}			//Constructors which get and set the schema id	  	public function setSchemaId(schemaId:int):void {			_schemaId = schemaId;	  	}				public function getSchemaId():int {			return _schemaId;	  	}				//Constructors which gets and sets the table location		public function getTableLocations():Array {			return _tableLocations;	  	}		  	public function setTableLocations(tableLocations:Array):void {			_tableLocations = tableLocations;	  	}				//Constructors which gets and sets the schema camera		public function getCamera():SchemaCamera {			return _camera;	  	}		  	public function setCamera(camera:SchemaCamera):void {			_camera = camera;	  	}				//Constructors which gets and sets the entities array		public function getEntitiesArray():Array {			return _entitiesArray;	  	}		  	public function setEntitiesArray(entitiesArray:Array):void {			_entitiesArray = entitiesArray;	  	}				//Function to add an entity to the entities array		public function addEntity(entity:EntityMC):void {			//Initialize the entities array if it's null			if (_entitiesArray == null)				_entitiesArray = new Array();							_entitiesArray.push(entity);		}				//Function to retrieve an entity based on its name		public function getEntityByName(entityName:String):EntityMC {			//Make sure there's some entities in the array			if (_entitiesArray != null)			{				//Loop through each entity in the array  and match based on name passed in				for (var i:int = 0; i < _entitiesArray.length; i++)				{					if (_entitiesArray[i].getName() == entityName)					{						return _entitiesArray[i];					}				}			}			return null;		}				//Function to retrieve and entity based on its id		public function getEntityById(entityId:int):EntityMC {			//Make sure there's some entities in the array			if (_entitiesArray != null)			{				//Loop through each entity in the array  and match based on id passed in				for (var i:int = 0; i < _entitiesArray.length; i++)				{					if (_entitiesArray[i].getEntityId() == entityId)					{						return _entitiesArray[i];					}				}			}			return null;		}				public function removeEntity(entity:EntityMC):void {			//Make sure there's some entities in the array			if (_entitiesArray != null)			{				//Create a new temp array which will be populated with all the entities not to be removed				var _tempEntities:Array = new Array();				//Loop through each entity and if it is not to be deleted then add it to the temp array				for each (var ent:EntityMC in _entitiesArray)				{					if (ent != entity)					{						_tempEntities.push(ent);					}				}				//Replace the entities array with the temp array.				_entitiesArray = _tempEntities;			}		}				//Constructors to get and set the entity count		public function getEntityCount():int {			return _entityCount		}				public function setEntityCount(entityCount:int):void {			_entityCount = entityCount;		}	}	}