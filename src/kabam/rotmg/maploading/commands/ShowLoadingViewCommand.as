// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//kabam.rotmg.maploading.commands.ShowLoadingViewCommand

package kabam.rotmg.maploading.commands
{
import kabam.rotmg.core.view.Layers;
import kabam.rotmg.maploading.view.MapLoadingView;

public class ShowLoadingViewCommand
    {

        [Inject]
        public var layers:Layers;
        [Inject]
        public var view:MapLoadingView;


        public function execute():void
        {
            this.layers.top.addChild(this.view);
        }


    }
}//package kabam.rotmg.maploading.commands

