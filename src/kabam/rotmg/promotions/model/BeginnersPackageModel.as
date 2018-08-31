//kabam.rotmg.promotions.model.BeginnersPackageModel

package kabam.rotmg.promotions.model{
import com.company.assembleegameclient.util.TimeUtil;
import com.company.assembleegameclient.util.offer.Offer;

import kabam.rotmg.account.core.Account;
import kabam.rotmg.account.core.model.OfferModel;
import kabam.rotmg.promotions.signals.PackageStatusUpdateSignal;

import org.osflash.signals.Signal;

public class BeginnersPackageModel {

    public static const STATUS_CANNOT_BUY:int = 0;
    public static const STATUS_CAN_BUY_SHOW_POP_UP:int = 1;
    public static const STATUS_CAN_BUY_DONT_SHOW_POP_UP:int = 2;
    private static const REALM_GOLD_FOR_BEGINNERS_PKG:int = 2600;
    private static const ONE_WEEK_IN_SECONDS:int = 604800;

    [Inject]
    public var account:Account;
    [Inject]
    public var model:OfferModel;
    [Inject]
    public var packageStatusUpdateSignal:PackageStatusUpdateSignal;
    public var markedAsPurchased:Signal;
    private var _status:int;
    private var beginnersOfferSecondsLeft:Number;
    private var beginnersOfferSetTimestamp:Number;

    public function BeginnersPackageModel(){
        this.markedAsPurchased = new Signal();
        super();
    }
    public function isBeginnerAvailable():Boolean{
        return ((((this._status == STATUS_CAN_BUY_SHOW_POP_UP)) || ((this._status == STATUS_CAN_BUY_DONT_SHOW_POP_UP))));
    }
    private function getNowTimeSeconds():Number{
        var _local_1:Date = new Date();
        return (Math.round((_local_1.time * 0.001)));
    }
    public function getBeginnersOfferSecondsLeft():Number{
        return ((this.beginnersOfferSecondsLeft - (this.getNowTimeSeconds() - this.beginnersOfferSetTimestamp)));
    }
    public function getUserCreatedAt():Number{
        return (((this.getNowTimeSeconds() + this.getBeginnersOfferSecondsLeft()) - ONE_WEEK_IN_SECONDS));
    }
    public function getDaysRemaining():Number{
        return (Math.ceil(TimeUtil.secondsToDays(this.getBeginnersOfferSecondsLeft())));
    }
    public function getOffer():Offer{
        var _local_1:Offer;
        if (!this.model.offers){
            return (null);
        }
        for each (_local_1 in this.model.offers.offerList) {
            if (_local_1.realmGold_ == REALM_GOLD_FOR_BEGINNERS_PKG){
                return (_local_1);
            }
        }
        return (null);
    }
    public function markAsPurchased():void{
        this.markedAsPurchased.dispatch();
    }
    public function get status():int{
        return (this._status);
    }
    public function set status(_arg_1:int):void{
        this._status = _arg_1;
        this.packageStatusUpdateSignal.dispatch();
    }

}
}//package kabam.rotmg.promotions.model

