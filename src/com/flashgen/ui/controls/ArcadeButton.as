package com.flashgen.ui.controls
{
	import flash.display.Sprite;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	import flash.events.TouchEvent;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.system.Capabilities;
	import flash.events.Event;
	
	public class ArcadeButton extends Sprite
	{
		public static const BUTTON_A		:String = "buttonA";
		public static const BUTTON_B		:String = "buttonB";
		
		private var _emulateKeyboard		:Boolean = false;
		private var _keyCode				:uint = 0;
		private var _charCode				:uint = 0;
		
		private var _btn					:Sprite;
		private var _btnA					:Sprite;
		private var _btnB					:Sprite;

		public function ArcadeButton() 
		{
			_btn = boundary;
			
			_btnA = buttonA;
			_btnB = buttonB;
			
			if(Capabilities.cpuArchitecture == "ARM")
			{
				Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
				_btn.addEventListener(TouchEvent.TOUCH_BEGIN, onTouchDown);
				_btn.addEventListener(TouchEvent.TOUCH_END, onTouchUp);
			}
			else
			{
				_btn.addEventListener(MouseEvent.MOUSE_DOWN, onTestTouchDown);
				_btn.addEventListener(MouseEvent.MOUSE_UP, onTestTouchUp);
			}
		}
		
		protected function dispatchKeyboardEvent(eventType:String, event:Event):void
		{
			if(_emulateKeyboard)
				dispatchEvent(new KeyboardEvent(eventType, true, false, _charCode, _keyCode));
			else
				dispatchEvent(event);
		}
		
		protected function onTouchDown(event:TouchEvent):void
		{
			dispatchKeyboardEvent(KeyboardEvent.KEY_DOWN, event);
		}
		
		protected function onTouchUp(event:TouchEvent):void
		{
			dispatchKeyboardEvent(KeyboardEvent.KEY_UP, event);			
		}
		
		protected function onTestTouchDown(event:MouseEvent):void
		{
			dispatchKeyboardEvent(KeyboardEvent.KEY_DOWN, event);
		}
		
		protected function onTestTouchUp(event:MouseEvent):void
		{
			dispatchKeyboardEvent(KeyboardEvent.KEY_UP, event);			
		}
		
		public function set emulateKeyboard(value:Boolean):void
		{
			_emulateKeyboard = value;
		}
		
		public function get emulateKeyboard():Boolean
		{
			return _emulateKeyboard;
		}
		
		public function set keyCodeValue(value:uint):void
		{
			_keyCode = value;
		}
				
		public function get keyCodeValue():uint
		{
			return _keyCode;
		}
		
		public function set charCodeValue(value:uint):void
		{
			_charCode = value;
		}
				
		public function get charCodeValue():uint
		{
			return _charCode;
		}
		
		public function set buttonVersion(value:String):void
		{
			if(value == BUTTON_A)
			{
				_btnA.visible = true;
				_btnB.visible = false;
			}
			else
			{
				_btnA.visible = false;
				_btnB.visible = true;
			}
		}
	}	
}
