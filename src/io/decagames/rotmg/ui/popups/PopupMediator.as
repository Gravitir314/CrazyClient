// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//io.decagames.rotmg.ui.popups.PopupMediator

package io.decagames.rotmg.ui.popups
{
import io.decagames.rotmg.ui.popups.signals.CloseAllPopupsSignal;
import io.decagames.rotmg.ui.popups.signals.CloseCurrentPopupSignal;
import io.decagames.rotmg.ui.popups.signals.ClosePopupSignal;
import io.decagames.rotmg.ui.popups.signals.RemoveLockFade;
import io.decagames.rotmg.ui.popups.signals.ShowLockFade;
import io.decagames.rotmg.ui.popups.signals.ShowPopupSignal;

import robotlegs.bender.bundles.mvcs.Mediator;

public class PopupMediator extends Mediator 
    {

        [Inject]
        public var view:PopupView;
        [Inject]
        public var showPopupSignal:ShowPopupSignal;
        [Inject]
        public var closePopupSignal:ClosePopupSignal;
        [Inject]
        public var closeCurrentPopupSignal:CloseCurrentPopupSignal;
        [Inject]
        public var closeAllPopupsSignal:CloseAllPopupsSignal;
        [Inject]
        public var removeLockFade:RemoveLockFade;
        [Inject]
        public var showLockFade:ShowLockFade;
        private var popups:Vector.<BasePopup>;

        public function PopupMediator()
        {
            this.popups = new Vector.<BasePopup>();
        }

        override public function initialize():void
        {
            this.showPopupSignal.add(this.showPopupHandler);
            this.closePopupSignal.add(this.closePopupHandler);
            this.closeCurrentPopupSignal.add(this.closeCurrentPopupHandler);
            this.closeAllPopupsSignal.add(this.closeAllPopupsHandler);
            this.removeLockFade.add(this.onRemoveLock);
            this.showLockFade.add(this.onShowLock);
        }

        private function closeCurrentPopupHandler():void
        {
            var _local_1:BasePopup = this.popups.pop();
            this.view.removeChild(_local_1);
        }

        private function onShowLock():void{
            this.view.showFade();
        }

        private function onRemoveLock():void{
            this.view.removeFade();
        }

        private function closeAllPopupsHandler():void
        {
            var _local_1:BasePopup;
            for each (_local_1 in this.popups)
            {
                this.view.removeChild(_local_1);
            }
            this.popups = new Vector.<BasePopup>();
        }

        private function showPopupHandler(_arg_1:BasePopup):void
        {
            this.view.addChild(_arg_1);
            this.popups.push(_arg_1);
            if (_arg_1.showOnFullScreen)
            {
                if (_arg_1.overrideSizePosition != null)
                {
                    _arg_1.x = Math.round(((800 - _arg_1.overrideSizePosition.width) / 2));
                    _arg_1.y = Math.round(((600 - _arg_1.overrideSizePosition.height) / 2));
                }
                else
                {
                    _arg_1.x = Math.round(((800 - _arg_1.width) / 2));
                    _arg_1.y = Math.round(((600 - _arg_1.height) / 2));
                }
            }
            this.drawPopupBackground(_arg_1);
        }

        private function closePopupHandler(_arg_1:BasePopup):void
        {
            var _local_2:int = this.popups.indexOf(_arg_1);
            if (_local_2 >= 0)
            {
                this.view.removeChild(this.popups[_local_2]);
                this.popups.splice(_local_2, 1);
            }
        }

        private function drawPopupBackground(_arg_1:BasePopup):void
        {
            _arg_1.graphics.beginFill(_arg_1.popupFadeColor, _arg_1.popupFadeAlpha);
            _arg_1.graphics.drawRect(-(_arg_1.x), -(_arg_1.y), 800, 600);
            _arg_1.graphics.endFill();
        }

        override public function destroy():void
        {
            this.showPopupSignal.remove(this.showPopupHandler);
            this.closePopupSignal.remove(this.closePopupHandler);
            this.closeCurrentPopupSignal.remove(this.closeCurrentPopupHandler);
            this.removeLockFade.remove(this.onRemoveLock);
            this.showLockFade.remove(this.onShowLock);
        }


    }
}//package io.decagames.rotmg.ui.popups

