package utils 
{
	public class Singleton 
	{	
		static private var instance:Singleton;
		
		public function Singleton(singletonEnforcer:SingletonEnforcer) {}
		
		public static function getInstance():Singleton {
			if(Singleton.instance == null) {
				Singleton.instance = new Singleton(new SingletonEnforcer());
			}
			return Singleton.instance;	
		}				
		
	}
	
}

class SingletonEnforcer {}