//ru.inspirit.net.MultipartURLLoader

package ru.inspirit.net
{
import flash.errors.IllegalOperationError;
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.HTTPStatusEvent;
import flash.events.IOErrorEvent;
import flash.events.ProgressEvent;
import flash.events.SecurityErrorEvent;
import flash.net.URLLoader;
import flash.net.URLLoaderDataFormat;
import flash.net.URLRequest;
import flash.net.URLRequestHeader;
import flash.net.URLRequestMethod;
import flash.utils.ByteArray;
import flash.utils.Dictionary;
import flash.utils.Endian;
import flash.utils.clearInterval;
import flash.utils.setTimeout;

import ru.inspirit.net.events.MultipartURLLoaderEvent;

public class MultipartURLLoader extends EventDispatcher 
    {

        public static var BLOCK_SIZE:uint = (64 * 0x0400);//65536

        private var _loader:URLLoader;
        private var _boundary:String;
        private var _variableNames:Array;
        private var _fileNames:Array;
        private var _variables:Dictionary;
        private var _files:Dictionary;
        private var _async:Boolean = false;
        private var _path:String;
        private var _data:ByteArray;
        private var _prepared:Boolean = false;
        private var asyncWriteTimeoutId:Number;
        private var asyncFilePointer:uint = 0;
        private var totalFilesSize:uint = 0;
        private var writtenBytes:uint = 0;
        public var requestHeaders:Array;

        public function MultipartURLLoader()
        {
            this._fileNames = [];
            this._files = new Dictionary();
            this._variableNames = [];
            this._variables = new Dictionary();
            this._loader = new URLLoader();
            this.requestHeaders = [];
        }

        public function get bytesLoaded():uint
        {
            return (this._loader.bytesLoaded);
        }

        public function set bytesLoaded(_arg_1:uint):void
        {
        }

        public function get data():*
        {
            return (this._loader.data);
        }

        public function set data(_arg_1:*):void
        {
        }

        public function load(_arg_1:String, _arg_2:Boolean=false):void
        {
            if (((_arg_1 == null) || (_arg_1 == "")))
            {
                throw (new IllegalOperationError("You cant load without specifing PATH"));
            }
            this._path = _arg_1;
            this._async = _arg_2;
            if (this._async)
            {
                if (!this._prepared)
                {
                    this.constructPostDataAsync();
                }
                else
                {
                    this.doSend();
                }
            }
            else
            {
                this._data = this.constructPostData();
                this.doSend();
            }
        }

        public function startLoad():void
        {
            if ((((this._path == null) || (this._path == "")) || (this._async == false)))
            {
                throw (new IllegalOperationError("You can use this method only if loading asynchronous."));
            }
            if (((!(this._prepared)) && (this._async)))
            {
                throw (new IllegalOperationError("You should prepare data before sending when using asynchronous."));
            }
            this.doSend();
        }

        public function prepareData():void
        {
            this.constructPostDataAsync();
        }

        public function close():void
        {
            try
            {
                this._loader.close();
            }
            catch(e:Error)
            {
            }
        }

        public function addVariable(_arg_1:String, _arg_2:Object=""):void
        {
            if (this._variableNames.indexOf(_arg_1) == -1)
            {
                this._variableNames.push(_arg_1);
            }
            this._variables[_arg_1] = _arg_2;
            this._prepared = false;
        }

        public function addFile(_arg_1:ByteArray, _arg_2:String, _arg_3:String="Filedata", _arg_4:String="application/octet-stream"):void
        {
            var _local_5:FilePart;
            if (this._fileNames.indexOf(_arg_2) == -1)
            {
                this._fileNames.push(_arg_2);
                this._files[_arg_2] = new FilePart(_arg_1, _arg_2, _arg_3, _arg_4);
                this.totalFilesSize = (this.totalFilesSize + _arg_1.length);
            }
            else
            {
                _local_5 = (this._files[_arg_2] as FilePart);
                this.totalFilesSize = (this.totalFilesSize - _local_5.fileContent.length);
                _local_5.fileContent = _arg_1;
                _local_5.fileName = _arg_2;
                _local_5.dataField = _arg_3;
                _local_5.contentType = _arg_4;
                this.totalFilesSize = (this.totalFilesSize + _arg_1.length);
            }
            this._prepared = false;
        }

        public function clearVariables():void
        {
            this._variableNames = [];
            this._variables = new Dictionary();
            this._prepared = false;
        }

        public function clearFiles():void
        {
            var _local_1:String;
            for each (_local_1 in this._fileNames)
            {
                (this._files[_local_1] as FilePart).dispose();
            }
            this._fileNames = [];
            this._files = new Dictionary();
            this.totalFilesSize = 0;
            this._prepared = false;
        }

        public function dispose():void
        {
            clearInterval(this.asyncWriteTimeoutId);
            this.removeListener();
            this.close();
            this._loader = null;
            this._boundary = null;
            this._variableNames = null;
            this._variables = null;
            this._fileNames = null;
            this._files = null;
            this.requestHeaders = null;
            this._data = null;
        }

        public function getBoundary():String
        {
            var _local_1:int;
            if (this._boundary == null)
            {
                this._boundary = "";
                _local_1 = 0;
                while (_local_1 < 32)
                {
                    this._boundary = (this._boundary + String.fromCharCode(int((97 + (Math.random() * 25)))));
                    _local_1++;
                }
            }
            return (this._boundary);
        }

        public function get ASYNC():Boolean
        {
            return (this._async);
        }

        public function get PREPARED():Boolean
        {
            return (this._prepared);
        }

        public function get dataFormat():String
        {
            return (this._loader.dataFormat);
        }

        public function set dataFormat(_arg_1:String):void
        {
            if ((((!(_arg_1 == URLLoaderDataFormat.BINARY)) && (!(_arg_1 == URLLoaderDataFormat.TEXT))) && (!(_arg_1 == URLLoaderDataFormat.VARIABLES))))
            {
                throw (new IllegalOperationError("Illegal URLLoader Data Format"));
            }
            this._loader.dataFormat = _arg_1;
        }

        public function get loader():URLLoader
        {
            return (this._loader);
        }

        private function doSend():void
        {
            var _local_1:URLRequest = new URLRequest();
            _local_1.url = this._path;
            _local_1.method = URLRequestMethod.POST;
            _local_1.data = this._data;
            _local_1.requestHeaders.push(new URLRequestHeader("Content-Type", ("multipart/form-data; boundary=" + this.getBoundary())));
            if (this.requestHeaders.length)
            {
                _local_1.requestHeaders = _local_1.requestHeaders.concat(this.requestHeaders);
            }
            this.addListener();
            this._loader.load(_local_1);
        }

        private function constructPostDataAsync():void
        {
            clearInterval(this.asyncWriteTimeoutId);
            this._data = new ByteArray();
            this._data.endian = Endian.BIG_ENDIAN;
            this._data = this.constructVariablesPart(this._data);
            this.asyncFilePointer = 0;
            this.writtenBytes = 0;
            this._prepared = false;
            if (this._fileNames.length)
            {
                this.nextAsyncLoop();
            }
            else
            {
                this._data = this.closeDataObject(this._data);
                this._prepared = true;
                dispatchEvent(new MultipartURLLoaderEvent(MultipartURLLoaderEvent.DATA_PREPARE_COMPLETE));
            }
        }

        private function constructPostData():ByteArray
        {
            var _local_1:ByteArray = new ByteArray();
            _local_1.endian = Endian.BIG_ENDIAN;
            _local_1 = this.constructVariablesPart(_local_1);
            _local_1 = this.constructFilesPart(_local_1);
            return (this.closeDataObject(_local_1));
        }

        private function closeDataObject(_arg_1:ByteArray):ByteArray
        {
            _arg_1 = this.BOUNDARY(_arg_1);
            return (this.DOUBLEDASH(_arg_1));
        }

        private function constructVariablesPart(_arg_1:ByteArray):ByteArray
        {
            var _local_2:uint;
            var _local_3:String;
            var _local_4:String;
            for each (_local_4 in this._variableNames)
            {
                _arg_1 = this.BOUNDARY(_arg_1);
                _arg_1 = this.LINEBREAK(_arg_1);
                _local_3 = (('Content-Disposition: form-data; name="' + _local_4) + '"');
                _local_2 = 0;
                while (_local_2 < _local_3.length)
                {
                    _arg_1.writeByte(_local_3.charCodeAt(_local_2));
                    _local_2++;
                }
                _arg_1 = this.LINEBREAK(_arg_1);
                _arg_1 = this.LINEBREAK(_arg_1);
                _arg_1.writeUTFBytes(this._variables[_local_4]);
                _arg_1 = this.LINEBREAK(_arg_1);
            }
            return (_arg_1);
        }

        private function constructFilesPart(_arg_1:ByteArray):ByteArray
        {
            var _local_2:uint;
            var _local_3:String;
            var _local_4:String;
            if (this._fileNames.length)
            {
                for each (_local_4 in this._fileNames)
                {
                    _arg_1 = this.getFilePartHeader(_arg_1, (this._files[_local_4] as FilePart));
                    _arg_1 = this.getFilePartData(_arg_1, (this._files[_local_4] as FilePart));
                    if (_local_2 != (this._fileNames.length - 1))
                    {
                        _arg_1 = this.LINEBREAK(_arg_1);
                    }
                    _local_2++;
                }
                _arg_1 = this.closeFilePartsData(_arg_1);
            }
            return (_arg_1);
        }

        private function closeFilePartsData(_arg_1:ByteArray):ByteArray
        {
            var _local_2:uint;
            var _local_3:String;
            _arg_1 = this.LINEBREAK(_arg_1);
            _arg_1 = this.BOUNDARY(_arg_1);
            _arg_1 = this.LINEBREAK(_arg_1);
            _local_3 = 'Content-Disposition: form-data; name="Upload"';
            _local_2 = 0;
            while (_local_2 < _local_3.length)
            {
                _arg_1.writeByte(_local_3.charCodeAt(_local_2));
                _local_2++;
            }
            _arg_1 = this.LINEBREAK(_arg_1);
            _arg_1 = this.LINEBREAK(_arg_1);
            _local_3 = "Submit Query";
            _local_2 = 0;
            while (_local_2 < _local_3.length)
            {
                _arg_1.writeByte(_local_3.charCodeAt(_local_2));
                _local_2++;
            }
            return (this.LINEBREAK(_arg_1));
        }

        private function getFilePartHeader(_arg_1:ByteArray, _arg_2:FilePart):ByteArray
        {
            var _local_3:uint;
            var _local_4:String;
            _arg_1 = this.BOUNDARY(_arg_1);
            _arg_1 = this.LINEBREAK(_arg_1);
            _local_4 = 'Content-Disposition: form-data; name="Filename"';
            _local_3 = 0;
            while (_local_3 < _local_4.length)
            {
                _arg_1.writeByte(_local_4.charCodeAt(_local_3));
                _local_3++;
            }
            _arg_1 = this.LINEBREAK(_arg_1);
            _arg_1 = this.LINEBREAK(_arg_1);
            _arg_1.writeUTFBytes(_arg_2.fileName);
            _arg_1 = this.LINEBREAK(_arg_1);
            _arg_1 = this.BOUNDARY(_arg_1);
            _arg_1 = this.LINEBREAK(_arg_1);
            _local_4 = (('Content-Disposition: form-data; name="' + _arg_2.dataField) + '"; filename="');
            _local_3 = 0;
            while (_local_3 < _local_4.length)
            {
                _arg_1.writeByte(_local_4.charCodeAt(_local_3));
                _local_3++;
            }
            _arg_1.writeUTFBytes(_arg_2.fileName);
            _arg_1 = this.QUOTATIONMARK(_arg_1);
            _arg_1 = this.LINEBREAK(_arg_1);
            _local_4 = ("Content-Type: " + _arg_2.contentType);
            _local_3 = 0;
            while (_local_3 < _local_4.length)
            {
                _arg_1.writeByte(_local_4.charCodeAt(_local_3));
                _local_3++;
            }
            _arg_1 = this.LINEBREAK(_arg_1);
            return (this.LINEBREAK(_arg_1));
        }

        private function getFilePartData(_arg_1:ByteArray, _arg_2:FilePart):ByteArray
        {
            _arg_1.writeBytes(_arg_2.fileContent, 0, _arg_2.fileContent.length);
            return (_arg_1);
        }

        private function onProgress(_arg_1:ProgressEvent):void
        {
            dispatchEvent(_arg_1);
        }

        private function onComplete(_arg_1:Event):void
        {
            this.removeListener();
            dispatchEvent(_arg_1);
        }

        private function onIOError(_arg_1:IOErrorEvent):void
        {
            this.removeListener();
            dispatchEvent(_arg_1);
        }

        private function onSecurityError(_arg_1:SecurityErrorEvent):void
        {
            this.removeListener();
            dispatchEvent(_arg_1);
        }

        private function onHTTPStatus(_arg_1:HTTPStatusEvent):void
        {
            dispatchEvent(_arg_1);
        }

        private function addListener():void
        {
            this._loader.addEventListener(Event.COMPLETE, this.onComplete, false, 0, false);
            this._loader.addEventListener(ProgressEvent.PROGRESS, this.onProgress, false, 0, false);
            this._loader.addEventListener(IOErrorEvent.IO_ERROR, this.onIOError, false, 0, false);
            this._loader.addEventListener(HTTPStatusEvent.HTTP_STATUS, this.onHTTPStatus, false, 0, false);
            this._loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onSecurityError, false, 0, false);
        }

        private function removeListener():void
        {
            this._loader.removeEventListener(Event.COMPLETE, this.onComplete);
            this._loader.removeEventListener(ProgressEvent.PROGRESS, this.onProgress);
            this._loader.removeEventListener(IOErrorEvent.IO_ERROR, this.onIOError);
            this._loader.removeEventListener(HTTPStatusEvent.HTTP_STATUS, this.onHTTPStatus);
            this._loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onSecurityError);
        }

        private function BOUNDARY(_arg_1:ByteArray):ByteArray
        {
            var _local_3:int;
            var _local_2:int = this.getBoundary().length;
            _arg_1 = this.DOUBLEDASH(_arg_1);
            while (_local_3 < _local_2)
            {
                _arg_1.writeByte(this._boundary.charCodeAt(_local_3));
                _local_3++;
            }
            return (_arg_1);
        }

        private function LINEBREAK(_arg_1:ByteArray):ByteArray
        {
            _arg_1.writeShort(3338);
            return (_arg_1);
        }

        private function QUOTATIONMARK(_arg_1:ByteArray):ByteArray
        {
            _arg_1.writeByte(34);
            return (_arg_1);
        }

        private function DOUBLEDASH(_arg_1:ByteArray):ByteArray
        {
            _arg_1.writeShort(0x2D2D);
            return (_arg_1);
        }

        private function nextAsyncLoop():void
        {
            var _local_1:FilePart;
            if (this.asyncFilePointer < this._fileNames.length)
            {
                _local_1 = (this._files[this._fileNames[this.asyncFilePointer]] as FilePart);
                this._data = this.getFilePartHeader(this._data, _local_1);
                this.asyncWriteTimeoutId = setTimeout(this.writeChunkLoop, 10, this._data, _local_1.fileContent, 0);
                this.asyncFilePointer++;
            }
            else
            {
                this._data = this.closeFilePartsData(this._data);
                this._data = this.closeDataObject(this._data);
                this._prepared = true;
                dispatchEvent(new MultipartURLLoaderEvent(MultipartURLLoaderEvent.DATA_PREPARE_PROGRESS, this.totalFilesSize, this.totalFilesSize));
                dispatchEvent(new MultipartURLLoaderEvent(MultipartURLLoaderEvent.DATA_PREPARE_COMPLETE));
            }
        }

        private function writeChunkLoop(_arg_1:ByteArray, _arg_2:ByteArray, _arg_3:uint=0):void
        {
            var _local_4:uint = Math.min(BLOCK_SIZE, (_arg_2.length - _arg_3));
            _arg_1.writeBytes(_arg_2, _arg_3, _local_4);
            if (((_local_4 < BLOCK_SIZE) || ((_arg_3 + _local_4) >= _arg_2.length)))
            {
                _arg_1 = this.LINEBREAK(_arg_1);
                this.nextAsyncLoop();
                return;
            }
            _arg_3 = (_arg_3 + _local_4);
            this.writtenBytes = (this.writtenBytes + _local_4);
            if (((this.writtenBytes % BLOCK_SIZE) * 2) == 0)
            {
                dispatchEvent(new MultipartURLLoaderEvent(MultipartURLLoaderEvent.DATA_PREPARE_PROGRESS, this.writtenBytes, this.totalFilesSize));
            }
            this.asyncWriteTimeoutId = setTimeout(this.writeChunkLoop, 10, _arg_1, _arg_2, _arg_3);
        }


    }
}//package ru.inspirit.net

import flash.utils.ByteArray;

class FilePart 
{

    public var fileContent:ByteArray;
    public var fileName:String;
    public var dataField:String;
    public var contentType:String;

    public function FilePart(_arg_1:ByteArray, _arg_2:String, _arg_3:String="Filedata", _arg_4:String="application/octet-stream")
    {
        this.fileContent = _arg_1;
        this.fileName = _arg_2;
        this.dataField = _arg_3;
        this.contentType = _arg_4;
    }

    public function dispose():void
    {
        this.fileContent = null;
        this.fileName = null;
        this.dataField = null;
        this.contentType = null;
    }


}


