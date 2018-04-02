// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//com.company.assembleegameclient.util.MusicProxy

package com.company.assembleegameclient.util
{
import com.company.assembleegameclient.sound.IMusic;
import com.company.assembleegameclient.sound.Music;

public class MusicProxy implements IMusic
    {


        public function load():void
        {
            Music.load();
        }


    }
}//package com.company.assembleegameclient.util

