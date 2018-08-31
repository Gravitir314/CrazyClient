//kabam.rotmg.dailyLogin.tasks.FetchPlayerCalendarTask

package kabam.rotmg.dailyLogin.tasks
{
import com.company.assembleegameclient.parameters.Parameters;
import com.company.util.MoreObjectUtil;

import kabam.lib.tasks.BaseTask;
import kabam.rotmg.account.core.Account;
import kabam.rotmg.appengine.api.AppEngineClient;
import kabam.rotmg.build.api.BuildData;
import kabam.rotmg.core.signals.SetLoadingMessageSignal;
import kabam.rotmg.dailyLogin.model.CalendarDayModel;
import kabam.rotmg.dailyLogin.model.CalendarTypes;
import kabam.rotmg.dailyLogin.model.DailyLoginModel;

import robotlegs.bender.framework.api.ILogger;

public class FetchPlayerCalendarTask extends BaseTask
{

    [Inject]
    public var account:Account;
    [Inject]
    public var logger:ILogger;
    [Inject]
    public var client:AppEngineClient;
    [Inject]
    public var setLoadingMessage:SetLoadingMessageSignal;
    [Inject]
    public var dailyLoginModel:DailyLoginModel;
    [Inject]
    public var buildData:BuildData;
    private var requestData:Object;


    override protected function startTask():void
    {
        this.logger.info("FetchPlayerCalendarTask start");
        this.requestData = this.makeRequestData();
        this.sendRequest();
    }

    private function sendRequest():void
    {
        this.client.complete.addOnce(this.onComplete);
        this.client.sendRequest("/dailyLogin/fetchCalendar", this.requestData);
    }

    private function onComplete(_arg_1:Boolean, _arg_2:*):void
    {
        if (_arg_1)
        {
            this.onCalendarUpdate(_arg_2);
        }
        else
        {
            this.onTextError(_arg_2);
        }
    }

    private function onCalendarUpdate(data:String):void
    {
        var xmlData:XML;

        try
        {
            xmlData = new XML(data);
        }
        catch(e:Error)
        {
            completeTask(true);
            return;
        }
        this.dailyLoginModel.clear();
        var serverTimestamp:Number = (parseFloat(xmlData.attribute("serverTime")) * 1000);
        this.dailyLoginModel.setServerTime(serverTimestamp);
        if (((!(Parameters.data_.calendarShowOnDay)) || (Parameters.data_.calendarShowOnDay < this.dailyLoginModel.getTimestampDay())))
        {
            this.dailyLoginModel.shouldDisplayCalendarAtStartup = true;
        }
        if (((xmlData.hasOwnProperty("NonConsecutive")) && (xmlData.NonConsecutive..Login.length() > 0)))
        {
            this.parseCalendar(xmlData.NonConsecutive, CalendarTypes.NON_CONSECUTIVE, xmlData.attribute("nonconCurDay"));
        }
        if (((xmlData.hasOwnProperty("Consecutive")) && (xmlData.Consecutive..Login.length() > 0)))
        {
            this.parseCalendar(xmlData.Consecutive, CalendarTypes.CONSECUTIVE, xmlData.attribute("conCurDay"));
        }
        completeTask(true);
    }

    private function parseCalendar(_arg_1:XMLList, _arg_2:String, _arg_3:String):void
    {
        var _local_4:int;
        var _local_5:XML;
        var _local_6:CalendarDayModel;
        for each (_local_5 in _arg_1..Login)
        {
            _local_6 = this.getDayFromXML(_local_5, _arg_2);
            if (_local_5.hasOwnProperty("key"))
            {
                _local_6.claimKey = _local_5.key;
                _local_4 = 0;
                this.account.reportIntStat("NumStars", _local_4);
                if (Parameters.data_.autoClaimCalendar)
                {
                    Parameters.dailyClaimKeys.push(_local_6.claimKey);
                }
            }
            this.dailyLoginModel.addDay(_local_6, _arg_2);
        }
        if (_arg_3)
        {
            this.dailyLoginModel.setCurrentDay(_arg_2, int(_arg_3));
        }
        this.dailyLoginModel.setUserDay(_arg_1.attribute("days"), _arg_2);
        this.dailyLoginModel.calculateCalendar(_arg_2);
    }


    private function getDayFromXML(_arg_1:XML, _arg_2:String):CalendarDayModel
    {
        return (new CalendarDayModel(_arg_1.Days, _arg_1.ItemId, _arg_1.Gold, _arg_1.ItemId.attribute("quantity"), _arg_1.hasOwnProperty("Claimed"), _arg_2));
    }

    private function onTextError(_arg_1:String):void
    {
        completeTask(true);
    }

    public function makeRequestData():Object
    {
        var _local_1:Object = {};
        _local_1.game_net_user_id = this.account.gameNetworkUserId();
        _local_1.game_net = this.account.gameNetwork();
        _local_1.play_platform = this.account.playPlatform();
        _local_1.do_login = Parameters.sendLogin_;
        MoreObjectUtil.addToObject(_local_1, this.account.getCredentials());
        return (_local_1);
    }


}
}//package kabam.rotmg.dailyLogin.tasks

