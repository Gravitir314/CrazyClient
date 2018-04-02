// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//kabam.rotmg.ui.model.HUDModel

package kabam.rotmg.ui.model
{
import com.company.assembleegameclient.game.GameSprite;
import com.company.assembleegameclient.parameters.Parameters;

public class HUDModel
    {

        public var gameSprite:GameSprite;


        public function getPlayerName():String
        {
            return ((this.gameSprite.model.getName()) ? this.gameSprite.model.getName() : this.gameSprite.map.player_.name_);
        }

        public function getButtonType():String
        {
            return ((this.gameSprite.gsc_.gameId_ == Parameters.NEXUS_GAMEID) ? "OPTIONS_BUTTON" : "NEXUS_BUTTON");
        }


    }
}//package kabam.rotmg.ui.model

