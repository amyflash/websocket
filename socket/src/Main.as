package
{
	import com.worlize.websocket.WebSocket;
	import com.worlize.websocket.WebSocketErrorEvent;
	import com.worlize.websocket.WebSocketEvent;
	import com.worlize.websocket.WebSocketMessage;
	import flash.display.Sprite;
	//import flash.events.Event;
	
	
   import flash.events.*;
   import flash.net.Socket;
	
	/**
	 * ...
	 * @author amyflash.com
	 */
	public class Main extends Sprite 
	{
		private var token:String = "eyJhbGciOiJLTVNFUzI1NiIsInR5cCI6IkpXVCJ9.eyJhdWQiOiJiZXRhLXVzZXJzIiwiZXhwIjoxNTQyOTg0MTMzLCJqdGkiOiIyMTMxMzZiMS0xNTQzLTQ2MWUtOGM2OC0yZjdmMzE2NDIwM2IiLCJpYXQiOjE1NDAzOTIxMzMsImlzcyI6ImRmdXNlLmlvIiwic3ViIjoibmJsbHFAcXEuY29tIiwic2NvcGVzIjoiKiIsIm9yaWdpbiI6IioifQ.81jBQd9oVps_77yf2ceAnmXTxICnXxi52Idg-qAx4lypWQ_FSJzcfzn8R7Qq9L8YOz-UmDmZDwR8cpX7ytf7vQ";
		public function Main() 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			kaishi();
		}
		
		private var websocket:WebSocket;
		private var f:face ;
		private function kaishi():void{
			f = new face();
			addChild(f);
			f.linkbtn.addEventListener(MouseEvent.CLICK, doConnect);
			f.dislinkbtn.addEventListener(MouseEvent.CLICK, disConnect);
			f.submitbtn.addEventListener(MouseEvent.CLICK, sendMessage);	
		}
		
		private function doConnect(e:MouseEvent):void{
			//测试用socket服务器地址:"ws://coolaf.com:9010/ajaxchattest"
			//wss://api.huobipro.com/ws
			var url:String = encodeURI(f.urltxt.text);
			websocket = new WebSocket(url,"*");
			websocket.debug = true;
			websocket.connect();
			websocket.addEventListener(WebSocketEvent.CLOSED, handleWebSocketClosed);
			websocket.addEventListener(WebSocketEvent.OPEN, handleWebSocketOpen);
			websocket.addEventListener(WebSocketEvent.MESSAGE, handleWebSocketMessage);
			websocket.addEventListener(IOErrorEvent.IO_ERROR, handleIOError);
			websocket.addEventListener(SecurityErrorEvent.SECURITY_ERROR, handleSecurityError);
			websocket.addEventListener(WebSocketErrorEvent.CONNECTION_FAIL, handleConnectionFail);
		}
		
		private function disConnect(e:MouseEvent):void{
			trace( "关闭socket连接" );
			websocket.close();
		}
		
		private function sendMessage( event:MouseEvent ):void {
			trace( "向socket服务器发送消息" );
			websocket.sendUTF(f.message.text);
		}
		
		private function handleWebSocketOpen( event:WebSocketEvent ):void {
			trace( "socket连接成功" );
			f.backmessage.text = "socket连接成功";
		}
		
		private function handleWebSocketMessage(event:WebSocketEvent):void {	
			//	trace(event.message.utf8Data);
			f.backmessage.text = "socket连接成功,等待返回值:"+event.message.utf8Data;	
		}
		
		private function handleWebSocketClosed(event:WebSocketEvent):void {
			trace("Websocket closed.");
				
		}
		
		private function handleIOError(event:IOErrorEvent):void {
			trace("IOErrorEvent");
		}
			
		private function handleSecurityError(event:SecurityErrorEvent):void {
			trace("SecurityErrorEvent");
		}
		
		private function handleConnectionFail(event:WebSocketErrorEvent):void {
			trace("Connection Failure: " + event.text);
		}
		
	}
	
}