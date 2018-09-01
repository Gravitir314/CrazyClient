//io.decagames.rotmg.tos.popups.buttons.RefuseButton

package io.decagames.rotmg.tos.popups.buttons
{
import io.decagames.rotmg.ui.buttons.SliceScalingButton;
import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;
import io.decagames.rotmg.ui.texture.TextureParser;

public class RefuseButton extends SliceScalingButton
{

	public function RefuseButton()
	{
		super(TextureParser.instance.getSliceScalingBitmap("UI", "generic_green_button"));
		setLabel("Refuse", DefaultLabelFormat.defaultButtonLabel);
		width = 100;
	}

}
}//package io.decagames.rotmg.tos.popups.buttons

