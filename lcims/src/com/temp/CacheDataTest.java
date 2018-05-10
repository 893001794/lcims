package com.temp;
import java.util.HashMap;  
import java.util.Map; 
import java.util.Random;  
import java.util.concurrent.locks.ReadWriteLock;  
import java.util.concurrent.locks.ReentrantReadWriteLock;   
public class CacheDataTest {  
	//http://developer.51cto.com/art/201112/307666.htm
	static Map<Integer,Object> dataMap=new HashMap<Integer,Object>();  
	static ReadWriteLock lock=new ReentrantReadWriteLock();//创建读写锁的实例  
	static Object getData(Integer key){  
		lock.readLock().lock();//读取前先上锁  
		Object val=null;  
		try{  
			val=dataMap.get(key);  //集合
			if(val == null){  
		// Must release read lock before acquiring write lock  
				lock.readLock().unlock();  //读取时开锁
				lock.writeLock().lock();   //写取前上锁
				try{
					if(val==null){  
				//dataMap.put(key, "");query  db 
						val=queryDataFromDB(key); 
					}
				}finally{ 
				//Downgrade by acquiring read lock before releasing write lock  
				lock.readLock().lock();  
				// Unlock write, still hold read  
				lock.writeLock().unlock(); 
				} 
			}
		}finally{  
			lock.readLock().unlock();//最后必然不要忘怀开释锁 System.out.println("get data key="+key+">val="+val);  
			return val;
		}
	}
			static Object queryDataFromDB(Integer key){  
			Object val=new Random().nextInt(1000);  
			dataMap.put(key, val);  
			System.out.println("write into data key="+key+">val="+val);  
			return val;  
	}
	public static void main(String[] args) {  
		for(int i=0;i<10;i++){  
			new Thread(new Runnable() {public void run() {getData(new Random().nextInt(5));}}).start();
		} 
	}
}
