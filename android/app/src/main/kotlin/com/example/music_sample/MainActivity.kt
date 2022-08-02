package com.example.music_sample
import android.Manifest
import android.annotation.SuppressLint
import android.content.ContentUris
import android.content.pm.PackageManager
import android.net.Uri
import android.os.Build
import android.os.Bundle
import android.os.Environment
import android.os.PersistableBundle
import android.provider.MediaStore
import android.util.Log
import android.view.View
import android.widget.Toast
import androidx.annotation.RequiresApi
import androidx.core.app.ActivityCompat
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.io.File
import java.util.*
import kotlin.collections.HashMap


private const val CHANNEL = "search_files_in_storage/search"

class MainActivity: FlutterActivity() {

    private val requestCode = 100

    @SuppressLint("NewApi")
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
                call, result ->
            if(call.method == "search")
            {
                var _result = requestPermissionAndListFiles();
                if(!_result){
                    result.error("401", "No READ_EXTERNAL_STORAGE permission","")
                    return@setMethodCallHandler
                }

                else{
                    Log.i("FILE_CHECKING","Searching for "+call.arguments);
                   val _r =  getAllAudio()
                    if(_r == null)
                    {
                        result.error("404", "FAILED if (Environment.MEDIA_MOUNTED == state || Environment.MEDIA_MOUNTED_READ_ONLY == state)","")
                        return@setMethodCallHandler
                    }else{
                        result.success(_r);
                    }

                }
            }

        }
    }

//    private fun requestRuntimePermission():Boolean {
//        return if (ActivityCompat.checkSelfPermission(
//                this,
//                android.Manifest.permission.READ_EXTERNAL_STORAGE
//            )
//            != PackageManager.PERMISSION_GRANTED
//        ) {
//            ActivityCompat.requestPermissions(
//                this,
//                arrayOf(android.Manifest.permission.READ_EXTERNAL_STORAGE),
//                13
//            )
//            true
//        }else{
//            false
//        }
//    }

    private fun requestPermissionAndListFiles():Boolean {
        Log.e("PERMISSION" , "getting permission status")
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M && checkSelfPermission(Manifest.permission.READ_EXTERNAL_STORAGE) != PackageManager.PERMISSION_GRANTED) {
            //requestPermissions(arrayOf(Manifest.permission.READ_EXTERNAL_STORAGE), requestCode)
            return false;
        } else {
            return true;
        }
    }

    // override fun onRequestPermissionsResult(requestCode: Int, permissions: Array<out String>, grantResults: IntArray) {
    //     if (requestCode == this.requestCode) {
    //         if (grantResults[0] == PackageManager.PERMISSION_GRANTED) {
    //             // Permission is granted
    //             // listExternalStorage()
    //         } else {
    //             Toast.makeText(this, "Until you grant the permission, I cannot list the files", Toast.LENGTH_SHORT)
    //                 .show()
    //         }
    //     }
    // }




//    private fun listExternalStorage(query:List<String>):List<String>? {
//        val state = Environment.getExternalStorageState()
//
//        if (Environment.MEDIA_MOUNTED == state || Environment.MEDIA_MOUNTED_READ_ONLY == state) {
//
//            return listFiles(Environment.getExternalStorageDirectory(),query)
//        }else{
//            return null;
//        }
//    }

    /**
     * Recursively list files from a given directory.
     */
//    private fun listFiles(directory: File,query:List<String>):List<String> {
//        var foundList = arrayListOf<String>()
//        val files = directory.listFiles()
//        if (files != null) {
//            for (file in files) {
//                if (file != null) {
//                    if (file.isDirectory) {
//                        foundList.addAll( listFiles(file,query))
//                    } else {
//                        var path = file.absolutePath;
//                        Log.w("FILE_CHECKING",path + "\n")
//                        query.forEach { extension->
//                            if( path.endsWith(extension))
//                            {
//                                foundList.add(path);
//                            }
//                        }
//                    }
//                }
//            }
//        }
//        return  foundList
//    }




    @SuppressLint("Recycle", "Range")
    @RequiresApi(Build.VERSION_CODES.R)
    private fun getAllAudio(): HashMap<String,List<String>>{
        val tempList =  HashMap<String,List<String>>()
        val title= arrayListOf<String>()
        val id= arrayListOf<String>()
        val album= arrayListOf<String>()
        val artist= arrayListOf<String>()
        val pathss= arrayListOf<String>()
        val durationk= arrayListOf<String>()
        val imagess= arrayListOf<String>()
        val selection = MediaStore.Audio.Media.IS_MUSIC +  " != 0"
        val projection = arrayOf(
            MediaStore.Audio.Media.ALBUM_ID, MediaStore.Audio.Media.TITLE, MediaStore.Audio.Media.ALBUM,
            MediaStore.Audio.Media.ARTIST, MediaStore.Audio.Media.DURATION, MediaStore.Audio.Media.DATE_ADDED,
            MediaStore.Audio.Media.DATA,MediaStore.Audio.Media.ALBUM_ARTIST)

        val cursor = this.contentResolver.query(
            MediaStore.Audio.Media.EXTERNAL_CONTENT_URI, projection,selection,null,
            MediaStore.Audio.Media.DATE_ADDED + " DESC", null)
        if(cursor != null){
            if(cursor.moveToFirst())
                do {
                    val titleC = cursor.getString(cursor.getColumnIndex(MediaStore.Audio.Media.TITLE))
                   var idC = cursor.getLong(cursor.getColumnIndex(MediaStore.Audio.Media.ALBUM_ID))
                    val albumC = cursor.getString(cursor.getColumnIndex(MediaStore.Audio.Media.ALBUM))
                    val artistC = cursor.getString(cursor.getColumnIndex(MediaStore.Audio.Media.ARTIST))
                    val pathC = cursor.getString(cursor.getColumnIndex(MediaStore.Audio.Media.DATA))
                    val durationC = cursor.getString(cursor.getColumnIndex(MediaStore.Audio.Media.DURATION))
                    // String albumImage = String.valueOf(ContentUris.withAppendedId(Uri.parse("content://media/external/audio/albumart"),idC));
                    val albumImage =Uri.parse("content://media/external/audio/albumart")
                    val  images:Uri=  ContentUris.withAppendedId(albumImage ,idC )


//
//
                    title.add(titleC)
//                    id.add(idC)
                    album.add(albumC)
                    artist.add(artistC)
                    pathss.add(pathC)
                    imagess.add(images.path!!)
                   durationk.add(durationC)

                }while (cursor.moveToNext())
            tempList.put("title", title)
            // tempList.put("id",id)
            tempList.put("album",album)
            tempList.put("artist",artist)
            tempList.put("path",pathss)
            tempList.put("image",imagess)
            tempList.put("duration",durationk)
            
            cursor.close()


//            tempList.put("title",id)
            Log.i("array" , title.toString())
        }
        return tempList
    }

}