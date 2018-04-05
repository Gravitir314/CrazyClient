// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//kabam.rotmg.arena.component.AbridgedPlayerTooltip

package kabam.rotmg.arena.component
{
import com.company.assembleegameclient.ui.GuildText;
import com.company.assembleegameclient.ui.panels.itemgrids.EquippedGrid;
import com.company.assembleegameclient.ui.tooltip.ToolTip;

import flash.display.Bitmap;

import kabam.rotmg.arena.model.ArenaLeaderboardEntry;
import kabam.rotmg.text.view.StaticTextDisplay;
import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;

public class AbridgedPlayerTooltip extends ToolTip 
    {

        public function AbridgedPlayerTooltip(_arg_1:ArenaLeaderboardEntry)
        {
            var _local_2:StaticTextDisplay;
            var _local_3:GuildText;
            var _local_4:Bitmap = new Bitmap();
            _local_4.bitmapData = _arg_1.playerBitmap;
            _local_4.scaleX = 0.75;
            _local_4.scaleY = 0.75;
            _local_4.y = 5;
            addChild(_local_4);
            _local_2 = new StaticTextDisplay();
            _local_2.setSize(14).setBold(true).setColor(0xFFFFFF);
            _local_2.setStringBuilder(new StaticStringBuilder(_arg_1.name));
            _local_2.x = 40;
            _local_2.y = 5;
            addChild(_local_2);
            if (_arg_1.guildName)
            {
                _local_3 = new GuildText(_arg_1.guildName, _arg_1.guildRank);
                _local_3.x = 40;
                _local_3.y = 20;
                addChild(_local_3);
            }
            super(0x363636, 0.5, 0xFFFFFF, 1);
            var _local_5:EquippedGrid = new EquippedGrid(null, _arg_1.slotTypes, null);
            _local_5.x = 5;
            _local_5.y = ((_local_3) ? ((_local_3.y + _local_3.height) - 5) : 55);
            _local_5.setItems(_arg_1.equipment);
            addChild(_local_5);
        }

    }
}//package kabam.rotmg.arena.component

