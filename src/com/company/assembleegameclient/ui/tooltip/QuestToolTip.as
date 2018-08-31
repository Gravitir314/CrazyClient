//com.company.assembleegameclient.ui.tooltip.QuestToolTip

package com.company.assembleegameclient.ui.tooltip{
import com.company.assembleegameclient.objects.GameObject;
import com.company.assembleegameclient.ui.GameObjectListItem;

import flash.filters.DropShadowFilter;

import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;

public class QuestToolTip extends ToolTip {

    private var gameObject:GameObject;
    public var enemyGOLI_:GameObjectListItem;

    public function QuestToolTip(_arg_1:GameObject){
        super(6036765, 1, 16549442, 1, false);
        this.gameObject = _arg_1;
        this.init();
    }
    private function init():void{
        var _local_1:TextFieldDisplayConcrete;
        _local_1 = new TextFieldDisplayConcrete().setSize(22).setColor(16549442).setBold(true);
        _local_1.setStringBuilder(new LineBuilder().setParams("Bounty!"));
        _local_1.filters = [new DropShadowFilter(0, 0, 0)];
        _local_1.x = 0;
        _local_1.y = 0;
        waiter.push(_local_1.textChanged);
        addChild(_local_1);
        this.enemyGOLI_ = new GameObjectListItem(0xFFFFFF, true, this.gameObject);
        this.enemyGOLI_.x = 0;
        this.enemyGOLI_.y = 32;
        waiter.push(this.enemyGOLI_.textReady);
        addChild(this.enemyGOLI_);
        filters = [];
    }

}
}//package com.company.assembleegameclient.ui.tooltip

