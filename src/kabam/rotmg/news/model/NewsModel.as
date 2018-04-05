// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//kabam.rotmg.news.model.NewsModel

package kabam.rotmg.news.model
{
import com.company.assembleegameclient.parameters.Parameters;

import kabam.rotmg.account.core.Account;
import kabam.rotmg.news.controller.NewsButtonRefreshSignal;
import kabam.rotmg.news.controller.NewsDataUpdatedSignal;
import kabam.rotmg.news.view.NewsModalPage;

public class NewsModel
    {

        private static const COUNT:int = 3;
        public static const MODAL_PAGE_COUNT:int = 4;

        [Inject]
        public var update:NewsDataUpdatedSignal;
        [Inject]
        public var updateNoParams:NewsButtonRefreshSignal;
        [Inject]
        public var account:Account;
        public var news:Vector.<NewsCellVO>;
        public var modalPages:Vector.<NewsModalPage>;
        public var modalPageData:Vector.<NewsCellVO>;
        private var inGameNews:Vector.<InGameNews> = new Vector.<InGameNews>();


        public function addInGameNews(_arg_1:InGameNews):void
        {
            if (this.isValidForPlatform(_arg_1))
            {
                this.inGameNews.push(_arg_1);
            }
            this.sortNews();
        }

        private function sortNews():*
        {
            this.inGameNews.sort(function (_arg_1:InGameNews, _arg_2:InGameNews):*
            {
                if (_arg_1.weight > _arg_2.weight)
                {
                    return (-1);
                }
                if (_arg_1.weight == _arg_2.weight)
                {
                    return (0);
                }
                return (1);
            });
        }

        public function markAsRead():void
        {
            var _local_1:InGameNews = this.getFirstNews();
            if (_local_1 != null)
            {
                Parameters.data_["lastNewsKey"] = _local_1.newsKey;
                Parameters.save();
            }
        }

        public function hasUpdates():Boolean
        {
            var _local_1:InGameNews = this.getFirstNews();
            if (((_local_1 == null) || (Parameters.data_["lastNewsKey"] == _local_1.newsKey)))
            {
                return (false);
            }
            return (true);
        }

        public function getFirstNews():InGameNews
        {
            if (((this.inGameNews) && (this.inGameNews.length > 0)))
            {
                return (this.inGameNews[0]);
            }
            return (null);
        }

        public function initNews():void
        {
            var _local_1:int;
            this.news = new Vector.<NewsCellVO>(COUNT, true);
            while (_local_1 < COUNT)
            {
                this.news[_local_1] = new DefaultNewsCellVO(_local_1);
                _local_1++;
            }
        }

        public function updateNews(_arg_1:Vector.<NewsCellVO>):void
        {
            var _local_2:NewsCellVO;
            var _local_3:int;
            var _local_4:int;
            this.initNews();
            var _local_5:Vector.<NewsCellVO> = new Vector.<NewsCellVO>();
            this.modalPageData = new Vector.<NewsCellVO>(4, true);
            for each (_local_2 in _arg_1)
            {
                if (_local_2.slot <= 3)
                {
                    _local_5.push(_local_2);
                }
                else
                {
                    _local_3 = (_local_2.slot - 4);
                    _local_4 = (_local_3 + 1);
                    this.modalPageData[_local_3] = _local_2;
                    if (Parameters.data_[("newsTimestamp" + _local_4)] != _local_2.endDate)
                    {
                        Parameters.data_[("newsTimestamp" + _local_4)] = _local_2.endDate;
                        Parameters.data_[("hasNewsUpdate" + _local_4)] = true;
                    }
                }
            }
            this.sortByPriority(_local_5);
            this.update.dispatch(this.news);
            this.updateNoParams.dispatch();
        }

        private function sortByPriority(_arg_1:Vector.<NewsCellVO>):void
        {
            var _local_2:NewsCellVO;
            for each (_local_2 in _arg_1)
            {
                if (((this.isNewsTimely(_local_2)) && (this.isValidForPlatformGlobal(_local_2))))
                {
                    this.prioritize(_local_2);
                }
            }
        }

        private function prioritize(_arg_1:NewsCellVO):void
        {
            var _local_2:uint = (_arg_1.slot - 1);
            if (this.news[_local_2])
            {
                _arg_1 = this.comparePriority(this.news[_local_2], _arg_1);
            }
            this.news[_local_2] = _arg_1;
        }

        private function comparePriority(_arg_1:NewsCellVO, _arg_2:NewsCellVO):NewsCellVO
        {
            return ((_arg_1.priority < _arg_2.priority) ? _arg_1 : _arg_2);
        }

        private function isNewsTimely(_arg_1:NewsCellVO):Boolean
        {
            var _local_2:Number = new Date().getTime();
            return ((_arg_1.startDate < _local_2) && (_local_2 < _arg_1.endDate));
        }

        public function hasValidNews():Boolean
        {
            return (((!(this.news[0] == null)) && (!(this.news[1] == null))) && (!(this.news[2] == null)));
        }

        public function hasValidModalNews():Boolean
        {
            return (this.inGameNews.length > 0);
        }

        public function get numberOfNews():int
        {
            return (this.inGameNews.length);
        }

        public function getModalPage(_arg_1:int):NewsModalPage
        {
            var _local_2:InGameNews;
            if (this.hasValidModalNews())
            {
                _local_2 = this.inGameNews[(_arg_1 - 1)];
                return (new NewsModalPage(_local_2.title, _local_2.text));
            }
            return (new NewsModalPage("No new information", "Please check back later."));
        }

        private function isValidForPlatformGlobal(_arg_1:NewsCellVO):Boolean
        {
            var _local_2:String = this.account.gameNetwork();
            return (!(_arg_1.networks.indexOf(_local_2) == -1));
        }

        private function isValidForPlatform(_arg_1:InGameNews):Boolean
        {
            var _local_2:String = this.account.gameNetwork();
            return (!(_arg_1.platform.indexOf(_local_2) == -1));
        }


    }
}//package kabam.rotmg.news.model

