// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//io.decagames.rotmg.utils.colors.RandomColorGenerator

package io.decagames.rotmg.utils.colors
{
    import flash.utils.Dictionary;

    public class RandomColorGenerator 
    {

        private var colorDictionary:Dictionary;
        private var seed:int = -1;

        public function RandomColorGenerator(_arg_1:int=-1)
        {
            this.seed = _arg_1;
            this.colorDictionary = new Dictionary();
            this.loadColorBounds();
        }

        public function randomColor(_arg_1:String=""):Array
        {
            var _local_2:int = this.pickHue();
            var _local_3:int = this.pickSaturation(_local_2, _arg_1);
            var _local_4:int = this.pickBrightness(_local_2, _local_3, _arg_1);
            var _local_5:Array = this.HSVtoRGB([_local_2, _local_3, _local_4]);
            return (_local_5);
        }

        private function HSVtoRGB(_arg_1:Array):Array
        {
            var _local_2:Number = _arg_1[0];
            if (_local_2 === 0)
            {
                _local_2 = 1;
            };
            if (_local_2 === 360)
            {
                _local_2 = 359;
            };
            _local_2 = (_local_2 / 360);
            var _local_3:Number = (_arg_1[1] / 100);
            var _local_4:Number = (_arg_1[2] / 100);
            var _local_5:Number = Math.floor((_local_2 * 6));
            var _local_6:Number = ((_local_2 * 6) - _local_5);
            var _local_7:Number = (_local_4 * (1 - _local_3));
            var _local_8:Number = (_local_4 * (1 - (_local_6 * _local_3)));
            var _local_9:Number = (_local_4 * (1 - ((1 - _local_6) * _local_3)));
            var _local_10:Number = 0x0100;
            var _local_11:Number = 0x0100;
            var _local_12:Number = 0x0100;
            switch (_local_5)
            {
                case 0:
                    _local_10 = _local_4;
                    _local_11 = _local_9;
                    _local_12 = _local_7;
                    break;
                case 1:
                    _local_10 = _local_8;
                    _local_11 = _local_4;
                    _local_12 = _local_7;
                    break;
                case 2:
                    _local_10 = _local_7;
                    _local_11 = _local_4;
                    _local_12 = _local_9;
                    break;
                case 3:
                    _local_10 = _local_7;
                    _local_11 = _local_8;
                    _local_12 = _local_4;
                    break;
                case 4:
                    _local_10 = _local_9;
                    _local_11 = _local_7;
                    _local_12 = _local_4;
                    break;
                case 5:
                    _local_10 = _local_4;
                    _local_11 = _local_7;
                    _local_12 = _local_8;
                    break;
            };
            return ([Math.floor((_local_10 * 0xFF)), Math.floor((_local_11 * 0xFF)), Math.floor((_local_12 * 0xFF))]);
        }

        private function pickSaturation(_arg_1:int, _arg_2:*):int
        {
            var _local_3:Array = this.getSaturationRange(_arg_1);
            var _local_4:int = _local_3[0];
            var _local_5:int = _local_3[1];
            switch (_arg_2)
            {
                case "bright":
                    _local_4 = 55;
                    break;
                case "dark":
                    _local_4 = (_local_5 - 10);
                    break;
                case "light":
                    _local_5 = 55;
                    break;
            };
            return (this.randomWithin([_local_4, _local_5]));
        }

        private function getColorInfo(_arg_1:int):Object
        {
            var _local_2:String;
            var _local_3:Object;
            if (((_arg_1 >= 334) && (_arg_1 <= 360)))
            {
                _arg_1 = (_arg_1 - 360);
            };
            for (_local_2 in this.colorDictionary)
            {
                _local_3 = this.colorDictionary[_local_2];
                if ((((_local_3.hueRange) && (_arg_1 >= _local_3.hueRange[0])) && (_arg_1 <= _local_3.hueRange[1])))
                {
                    return (this.colorDictionary[_local_2]);
                };
            };
            return (null);
        }

        internal function getSaturationRange(_arg_1:int):Array
        {
            return (this.getColorInfo(_arg_1).saturationRange);
        }

        internal function pickBrightness(_arg_1:int, _arg_2:int, _arg_3:String):int
        {
            var _local_4:int = this.getMinimumBrightness(_arg_1, _arg_2);
            var _local_5:int = 100;
            switch (_arg_3)
            {
                case "dark":
                    _local_5 = (_local_4 + 20);
                    break;
                case "light":
                    _local_4 = int(((_local_5 + _local_4) / 2));
                    break;
                case "random":
                    _local_4 = 0;
                    _local_5 = 100;
                    break;
            };
            return (this.randomWithin([_local_4, _local_5]));
        }

        internal function getMinimumBrightness(_arg_1:int, _arg_2:int):int
        {
            var _local_5:int;
            var _local_6:int;
            var _local_7:int;
            var _local_8:int;
            var _local_9:Number;
            var _local_10:Number;
            var _local_3:Array = this.getColorInfo(_arg_1).lowerBounds;
            var _local_4:int;
            while (_local_4 < (_local_3.length - 1))
            {
                _local_5 = _local_3[_local_4][0];
                _local_6 = _local_3[_local_4][1];
                _local_7 = _local_3[(_local_4 + 1)][0];
                _local_8 = _local_3[(_local_4 + 1)][1];
                if (((_arg_2 >= _local_5) && (_arg_2 <= _local_7)))
                {
                    _local_9 = ((_local_8 - _local_6) / (_local_7 - _local_5));
                    _local_10 = (_local_6 - (_local_9 * _local_5));
                    return ((_local_9 * _arg_2) + _local_10);
                };
                _local_4++;
            };
            return (0);
        }

        private function randomWithin(_arg_1:Array):int
        {
            var _local_2:*;
            var _local_3:*;
            var _local_4:*;
            if (this.seed == -1)
            {
                return (Math.floor((_arg_1[0] + (Math.random() * ((_arg_1[1] + 1) - _arg_1[0])))));
            };
            _local_2 = ((_arg_1[1]) || (1));
            _local_3 = ((_arg_1[0]) || (0));
            this.seed = (((this.seed * 9301) + 49297) % 233280);
            _local_4 = (this.seed / 233280);
            return (Math.floor((_local_3 + (_local_4 * (_local_2 - _local_3)))));
        }

        internal function pickHue(_arg_1:int=-1):int
        {
            var _local_2:Array = this.getHueRange(_arg_1);
            var _local_3:int = this.randomWithin(_local_2);
            if (_local_3 < 0)
            {
                _local_3 = (360 + _local_3);
            };
            return (_local_3);
        }

        internal function getHueRange(_arg_1:int):Array
        {
            if (((_arg_1 < 360) && (_arg_1 > 0)))
            {
                return ([_arg_1, _arg_1]);
            };
            return ([0, 360]);
        }

        private function defineColor(_arg_1:String, _arg_2:Array, _arg_3:Array):*
        {
            var _local_4:int = _arg_3[0][0];
            var _local_5:int = _arg_3[(_arg_3.length - 1)][0];
            var _local_6:int = _arg_3[(_arg_3.length - 1)][1];
            var _local_7:int = _arg_3[0][1];
            this.colorDictionary[_arg_1] = {
                "hueRange":_arg_2,
                "lowerBounds":_arg_3,
                "saturationRange":[_local_4, _local_5],
                "brightnessRange":[_local_6, _local_7]
            };
        }

        private function loadColorBounds():*
        {
            this.defineColor("monochrome", null, [[0, 0], [100, 0]]);
            this.defineColor("red", [-26, 18], [[20, 100], [30, 92], [40, 89], [50, 85], [60, 78], [70, 70], [80, 60], [90, 55], [100, 50]]);
            this.defineColor("orange", [19, 46], [[20, 100], [30, 93], [40, 88], [50, 86], [60, 85], [70, 70], [100, 70]]);
            this.defineColor("yellow", [47, 62], [[25, 100], [40, 94], [50, 89], [60, 86], [70, 84], [80, 82], [90, 80], [100, 75]]);
            this.defineColor("green", [63, 178], [[30, 100], [40, 90], [50, 85], [60, 81], [70, 74], [80, 64], [90, 50], [100, 40]]);
            this.defineColor("blue", [179, 0x0101], [[20, 100], [30, 86], [40, 80], [50, 74], [60, 60], [70, 52], [80, 44], [90, 39], [100, 35]]);
            this.defineColor("purple", [258, 282], [[20, 100], [30, 87], [40, 79], [50, 70], [60, 65], [70, 59], [80, 52], [90, 45], [100, 42]]);
            this.defineColor("pink", [283, 334], [[20, 100], [30, 90], [40, 86], [60, 84], [80, 80], [90, 75], [100, 73]]);
        }


    }
}//package io.decagames.rotmg.utils.colors

