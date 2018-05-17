//kabam.rotmg.news.services.GetInGameNewsTask

package kabam.rotmg.news.services
{
import kabam.lib.tasks.BaseTask;
import kabam.rotmg.appengine.api.AppEngineClient;
import kabam.rotmg.dialogs.control.OpenDialogSignal;
import kabam.rotmg.news.model.InGameNews;
import kabam.rotmg.news.model.NewsModel;

import robotlegs.bender.framework.api.ILogger;

public class GetInGameNewsTask extends BaseTask 
    {

        [Inject]
        public var logger:ILogger;
        [Inject]
        public var client:AppEngineClient;
        [Inject]
        public var model:NewsModel;
        [Inject]
        public var openDialogSignal:OpenDialogSignal;
        private var requestData:Object;


        override protected function startTask():void
        {
            this.logger.info("GetInGameNewsTask start");
            this.requestData = this.makeRequestData();
            this.sendRequest();
        }

        public function makeRequestData():Object
        {
            return ({});
        }

        private function sendRequest():void
        {
            this.client.complete.addOnce(this.onComplete);
            this.client.sendRequest("/inGameNews/getNews", this.requestData);
        }

        private function onComplete(_arg_1:Boolean, _arg_2:*):void
        {
            this.logger.info(("String response from GetInGameNewsTask: " + _arg_2));
            if (_arg_1)
            {
                this.parseNews(_arg_2);
            }
            else
            {
                completeTask(true);
            }
        }

        private function parseNews(_arg_1:String):*
        {
            var _local_2:Object;
            var _local_3:Object;
            var _local_4:InGameNews;
            this.logger.info("Parsing news");
            try
            {
                _local_2 = JSON.parse(_arg_1);
                for each (_local_3 in _local_2)
                {
                    this.logger.info("Parse single news");
                    _local_4 = new InGameNews();
                    _local_4.newsKey = _local_3.newsKey;
                    _local_4.showAtStartup = _local_3.showAtStartup;
                    _local_4.startTime = _local_3.startTime;
                    _local_4.text = _local_3.text;
                    _local_4.title = _local_3.title;
                    _local_4.platform = _local_3.platform;
                    _local_4.weight = _local_3.weight;
                    this.model.addInGameNews(_local_4);
                }
            }
            catch(e:Error)
            {
            }
            var _local_5:InGameNews = this.model.getFirstNews();
            completeTask(true);
        }


    }
}//package kabam.rotmg.news.services

