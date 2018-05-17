//kabam.rotmg.account.core.control.IsAccountRegisteredToBuyGoldGuard

package kabam.rotmg.account.core.control
{
    public class IsAccountRegisteredToBuyGoldGuard extends IsAccountRegisteredGuard 
    {


        override protected function getString():String
        {
            return ("Dialog.registerToUseGold");
        }


    }
}//package kabam.rotmg.account.core.control

