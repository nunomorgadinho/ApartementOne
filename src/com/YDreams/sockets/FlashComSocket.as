 /**
 * $Id: ZoneActivitySocket.as 87 2007-05-23 hsilveira $
 * 
 */ 
 package com.YDreams.sockets
 {
 	import com.YDreams.events.SocketEvent;
 	import flash.events.ProgressEvent;
 	import flash.events.DataEvent;
 	
 	/**
    * <img src = "http://www.iilab.com/flashdocs/logo.png" /> 
    * 
	* <p><strong>About</strong><br /><br />
	* For use with the COM server.<br /><br />
	* 
	* About the COM server:<br /><br />
	* 
	* Das várias utilizações com a porta COM, descobri (ivan.valadares) que o Zinc as vezes perde instruções na porta COM.
	* Portanto reuni os vários servers que andavam por ai (modificações bilou, hugo, etc) e criei um completo.
	* Aconselha-se então a usar este server para todas as aplicações que comuniquem com a porta COM.
	* Este permite comunicação de ambos os lados (recebe e envia).
	* No xml convém configurar:<br /><br />
	* 
	*    <add key="socketPort" value="3343" />  -> Porta socket a usar<br />
	*    <add key="comPort" value="4" /> ->  Porta com a usar<br />
	*    <add key="eol" value="\0" /> -> fim de linha que vem da com.<br />
	*    <add key="debug" value="True"/> ->Permite ver o que foi recebido e enviado da com e da socket (Desligar em versões para o cliente)<br />
	*    <add key="persistConnection" value="True"/> ->Tenta a todo o custo ligar-se a com! -> caso seja desligado/ou haja problemas<br />
	*    <add key="persistConnectionTimer" value="2000"/> ->Tempo entre tentativas<br /><br />
	*
	* Nota: Quando existem problemas com a COM, o server envia para o flash a string "COMERROR". <br />
	* Esta informação deve ser tratada de alguma maneira.<br />
	* Nota: Em instalações com os pcs ligados a UPS, quando existe uma quebra de tensão este não se desliga,
	* mas o circuito ligado à COM sim. Da parte do server, não existe problemas, pois quando o circuito se
	* volta a ligar, o server volta-se a ligar a este. Este enquanto a placa teve desligada mantem-se a 
	* mandar "COMERROR" para o flash. Portanto o que se aconselha é quando se receba esta mensagem a aplicação
	* de Flash faça restart de modo a evitar comportamentos e estados impossíveis.<br /><br />
	* 	 
	* This class extends the AbstractSocket class.<br /><br />
	*
	* <p><strong>Usage</strong><br /><br />
	* No usage has been provided.
	*
	* @example <listing version="3.0">
	* See the SegmentPositionSocket example.
	* </listing>
	* 
	*/ 
 	public class FlashComSocket extends AbstractSocket
 	{ 		
				
	 	public function FlashComSocket():void
 		{
 			super(); 			
 		}
 		
 		override public function onTextSocketData(data_event:DataEvent):void
		{
			try
			{ 
				var src:String = data_event.data;
				
		        var event:SocketEvent = new SocketEvent(SocketEvent.DATA_RECEIVED);
	    	    event.event = src;
	        	dispatchEvent(event);
	        	
	  		} catch (e:Error) {
	  		 	this.log.error("Error " + e);
	  		}
		}
 		
 		override public function onSocketData(e:ProgressEvent):void
		{
			try
			{ 
				var src:String = this.socket.readUTFBytes(this.socket.bytesAvailable);
				
		        var event:SocketEvent = new SocketEvent(SocketEvent.DATA_RECEIVED);
	    	    event.event = src;
	        	dispatchEvent(event);
	        	
	  		} catch (e:Error) {
	  		 	this.log.error("Error " + e);
	  		}
		}
		
 	}
 }