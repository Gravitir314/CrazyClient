// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//kabam.rotmg.packages.IsAccountRegisteredToBuyPackageGuard

package kabam.rotmg.packages
{
import kabam.rotmg.account.core.control.IsAccountRegisteredGuard;

public class IsAccountRegisteredToBuyPackageGuard extends IsAccountRegisteredGuard
    {


        override protected function getString():String
        {
            return ("Dialog.registerToBuyPackage");
        }


    }
}//package kabam.rotmg.packages

