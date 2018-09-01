//kabam.rotmg.application.impl.Testing2Setup

package kabam.rotmg.application.impl
{
import com.company.assembleegameclient.parameters.Parameters;

import kabam.rotmg.application.api.ApplicationSetup;

public class Testing2Setup implements ApplicationSetup
{

	private const SERVER:String = "test2.realmofthemadgod.com";
	private const UNENCRYPTED:String = ("http://" + SERVER);
	private const ENCRYPTED:String = ("https://" + SERVER);
	private const ANALYTICS:String = "UA-11236645-6";
	private const BUILD_LABEL:String = "<font color='#FF0000'>TESTING 2 </font> #{VERSION}";


	public function getAppEngineUrl(_arg_1:Boolean = false):String
	{
		return (this.ENCRYPTED);
	}

	public function getAnalyticsCode():String
	{
		return (this.ANALYTICS);
	}

	public function getBuildLabel():String
	{
		var _local_1:String = ((Parameters.BUILD_VERSION + ".") + Parameters.MINOR_VERSION);
		return (this.BUILD_LABEL.replace("{VERSION}", _local_1));
	}

	public function useLocalTextures():Boolean
	{
		return (true);
	}

	public function isToolingEnabled():Boolean
	{
		return (true);
	}

	public function isServerLocal():Boolean
	{
		return (false);
	}

	public function isGameLoopMonitored():Boolean
	{
		return (true);
	}

	public function areErrorsReported():Boolean
	{
		return (false);
	}

	public function useProductionDialogs():Boolean
	{
		return (true);
	}

	public function areDeveloperHotkeysEnabled():Boolean
	{
		return (false);
	}

	public function isDebug():Boolean
	{
		return (false);
	}

	public function getServerDomain():String
	{
		return (this.SERVER);
	}


}
}//package kabam.rotmg.application.impl

