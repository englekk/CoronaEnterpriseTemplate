package com.wonhada.EnterpriseExample;

import com.naef.jnlua.LuaState;

import android.os.Environment;
import android.app.Activity;
import android.widget.Toast;

import java.io.File;
import java.io.FileOutputStream;
import java.io.BufferedInputStream;
import java.io.InputStream;
import java.net.URLConnection;
import java.net.MalformedURLException;
import java.net.URL;

/**
 * Implements the printString() function in Lua.
 * <p>
 * Demonstrates how to fetch a string argument from a Lua function.
 */
public class DownloadFileFunction implements com.naef.jnlua.NamedJavaFunction {
	/**
	 * Gets the name of the Lua function as it would appear in the Lua script.
	 * @return Returns the name of the custom Lua function.
	 */
	@Override
	public String getName() {
		return "downloadFile";
	}
	
	/**
	 * This method is called when the Lua function is called.
	 * <p>
	 * Warning! This method is not called on the main UI thread.
	 * @param luaState Reference to the Lua state.
	 *                 Needed to retrieve the Lua function's parameters and to return values back to Lua.
	 * @return Returns the number of values to be returned by the Lua function.
	 */
	@Override
	public int invoke(LuaState luaState) {
		/* CALL TEST
        luaState.checkType(3, com.naef.jnlua.LuaType.FUNCTION);
        luaState.pushString("TEST!!");
        luaState.call(1, 0); -- function onLoadComplete(e) 이고 리턴값이 없으므로 1(매개변수 갯수), 0(리턴 갯수)
        */
        
        String url = luaState.checkString(1);
        String downloadFolder = luaState.checkString(2);
        String fileName = luaState.checkString(3);
        
        luaState.checkType(4, com.naef.jnlua.LuaType.FUNCTION);
		int luaFunctionReferenceKey = luaState.ref(LuaState.REGISTRYINDEX);
		
        download(url, downloadFolder, fileName, luaState, luaFunctionReferenceKey);
        
		return 0;
	}

	private void download(final String url, final String downloadFolder, final String fileName, final LuaState luaState, final int luaFunctionReferenceKey)
	{
		Thread th = new Thread(){
			@Override
			public void run()
			{
				try
		        {
		            URL serverUrl = new URL(url);
		            URLConnection conn = serverUrl.openConnection();
		            conn.connect();
		            
		            int lenghtOfFile = conn.getContentLength();
		            
		            BufferedInputStream input = new BufferedInputStream(serverUrl.openStream());
		            FileOutputStream output = new FileOutputStream(downloadFolder + File.separator + fileName);
		            
		            byte data[] = new byte[1024];
		            
		            long total = 0;
		            
		            int count;
		            while ((count = input.read(data)) != -1) {
		                total += count;
		                output.write(data, 0, count);
		            }
		            
		            output.flush();
		            output.close();
		            input.close();

		            //---------------------------------
			        // Callback
			        luaState.rawGet(LuaState.REGISTRYINDEX, luaFunctionReferenceKey);
			        luaState.unref(LuaState.REGISTRYINDEX, luaFunctionReferenceKey);
			        luaState.pushString(downloadFolder + File.separator);
			        luaState.pushString(fileName);
			        luaState.call(2, 0);// value count, 0
			        //---------------------------------
		        }
		        catch (Exception e)
		        {
		        	//---------------------------------
			        // Callback
			        luaState.rawGet(LuaState.REGISTRYINDEX, luaFunctionReferenceKey);
			        luaState.unref(LuaState.REGISTRYINDEX, luaFunctionReferenceKey);
			        luaState.pushString("error");
			        luaState.pushString("error");
			        luaState.call(2, 0);// value count, 0
			        //---------------------------------
		        }

		        try
		        {
		        	this.interrupt();
		        }
		        catch (Exception e)
		        {
		        }
			}
		};
		th.start();
	}
}
