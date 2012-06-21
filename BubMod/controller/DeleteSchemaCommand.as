﻿package BubMod.controller {	import org.puremvc.as3.interfaces.ICommand;    import org.puremvc.as3.interfaces.INotification;    import org.puremvc.as3.patterns.command.SimpleCommand;	import BubMod.model.*;	import BubMod.utilities.*;	import BubMod.view.components.*;	import flash.geom.*;	import flash.events.*;	import flash.net.*;	import flash.utils.Dictionary;		public class DeleteSchemaCommand extends SimpleCommand implements ICommand {		//Private members		private var schemaDataProxy:SchemaDataProxy;		private var entityDataProxy:EntityDataProxy;		private var xmlLoader:URLLoader;		private var xmlData:XML;		private var schemaId:Number;					override public function execute(note:INotification):void { 			//Retrieve the schema id from the notification			schemaId = note.getBody() as Number;			//Retrieve the required data proxies			schemaDataProxy = facade.retrieveProxy( SchemaDataProxy.NAME ) as SchemaDataProxy;			entityDataProxy = facade.retrieveProxy( EntityDataProxy.NAME ) as EntityDataProxy;						//Create the variables to add to the url request to the server			var variables:URLVariables = new URLVariables();   			variables.schemaId = schemaId; 						//Create the urlrequest to be sent to the server side php script			var xmlURLReq:URLRequest = new URLRequest("http://compsoc.nuigalway.ie/~derm116/Boilgeog/deleteSchema.php");			xmlURLReq.data = variables;			xmlURLReq.method = URLRequestMethod.POST;						//Create the URL Loader which will send the request to the server			//Two event listeners are specified to listen for an IO error and 			//a completion response from the server			var xmlSendLoad:URLLoader = new URLLoader();			xmlSendLoad.dataFormat = URLLoaderDataFormat.VARIABLES;			xmlSendLoad.addEventListener(Event.COMPLETE, ClearStage);			xmlSendLoad.addEventListener(IOErrorEvent.IO_ERROR, onIOError);			xmlSendLoad.load(xmlURLReq);		}				//Completion event which clears the stage if the server returns		//a successful response		private function ClearStage(e:Event):void {			var loader:URLLoader = URLLoader(e.target);			//Checks that there is some data returned from the server			if (loader.data.length > 0) {				//Cast the results to a URL Variables object. This splits them into				//their individual variables making them easier to work with				var variables:URLVariables = new URLVariables( loader.data );				//If there is no error message returned from the server then it				//operated correctly and we return true				if (variables.errorMsg == undefined)				{					var successMsg:String = variables.msg;										//Check if there are any entities on the stage					if (schemaDataProxy.getEntitiesArray() != null) {						if(schemaDataProxy.getEntitiesArray().length > 0) {							var entitiesArray:Array = schemaDataProxy.getEntitiesArray();							//Loop through each entity and send a notification to the stage to remove it							for(var i:int = 0; i<entitiesArray.length; i++) {								sendNotification(ApplicationFacade.STAGE_REMOVE_BUBBLE, entitiesArray[i]);							}						}					}					//Remove the schema from the schema dictionary					var schemaDict:Dictionary = schemaDataProxy.getSchemaDictionary();					delete schemaDict[schemaId];					//Let the user know that the schema was successfully deleted					sendNotification(ApplicationFacade.SHOW_ALERT, successMsg);				}				//Show the user the exact error that occurred on the server				else				{					sendNotification(ApplicationFacade.SHOW_ALERT, variables.errorMsg);				}			}			//no data returned from the server so output a generic error message			else 			{				sendNotification(ApplicationFacade.SHOW_ALERT, "An unexpected error occurred. Please try saving again.");			}		}				//Catches any IO Errors - could generally be an issue connecting with the server		private function onIOError(event:IOErrorEvent):void {			sendNotification(ApplicationFacade.SHOW_ALERT, "Error loading URL. Please ensure that your security settings allow scripts from compsoc.nuigalway.ie/~derm116/Boilgeog");		}	}	}