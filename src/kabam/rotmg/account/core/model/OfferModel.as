// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//kabam.rotmg.account.core.model.OfferModel

package kabam.rotmg.account.core.model
{
import com.company.assembleegameclient.util.offer.Offers;

public class OfferModel
    {

        public static const TIME_BETWEEN_REQS:int = ((5 * 60) * 1000);//300000

        public var lastOfferRequestTime:int;
        public var lastOfferRequestGUID:String;
        public var offers:Offers;


    }
}//package kabam.rotmg.account.core.model

