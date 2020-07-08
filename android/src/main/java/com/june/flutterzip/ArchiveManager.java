package com.june.flutterzip;

import android.text.TextUtils;
import android.util.Log;


import org.zeroturnaround.zip.ZipEntryCallback;
import org.zeroturnaround.zip.ZipInfoCallback;
import org.zeroturnaround.zip.ZipUtil;
import org.zeroturnaround.zip.commons.FileUtils;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.charset.Charset;
import java.util.HashMap;
import java.util.Map;
import java.util.zip.ZipEntry;
import java.util.zip.ZipFile;
import java.util.zip.ZipInputStream;

import io.flutter.plugin.common.MethodChannel;

public class ArchiveManager {
    static private  long unziplong=0;
    static private  long filesize=0;
    static void unzip(String unzipPath, final String outPath ,final MethodChannel channel){
                     unziplong=0;
//        ZipUtil.unpack(new File(unzipPath), new File(outPath), Charset.forName("GBK"));
        //判断编码
        String s=null;
        try {
             s = codeString(unzipPath);
            Log.e("test","编码为="+s);
        } catch (Exception e) {
            e.printStackTrace();
        }
        if(TextUtils.isEmpty(s)){
            s="GBK";
        }
        //获取大小
        File file = new File(unzipPath);
        try {
            ZipFile zf=   new ZipFile(unzipPath);
            int size = zf.size();
            filesize=size;
            Log.e("test","文件数量="+size);
        } catch (IOException e) {
            e.printStackTrace();
        }
        //解压
        ZipUtil.iterate(file, new ZipEntryCallback() {
            @Override
            public void process(InputStream in, ZipEntry zipEntry) throws IOException {
                unziplong++;
                File file = new File(outPath,zipEntry.getName());
                    if (zipEntry.isDirectory()) {
                        FileUtils.forceMkdir(file);
                    } else {
                        FileUtils.forceMkdir(file.getParentFile());
                        FileUtils.copy(in, file);
                    }
                Map<String,Long> map=new HashMap<>();

                map.put("total",filesize);
                map.put("percent",unziplong);
                channel.invokeMethod("process",map);
            }
        },Charset.forName(s));
        //

    }


    private static String codeString(String fileName) throws Exception {

        BufferedInputStream bin = new BufferedInputStream(new FileInputStream(

                fileName));

        int p = (bin.read() << 8) + bin.read();

        String code = null;



        switch (p) {

            case 0xefbb:

                code = "UTF-8";

                break;

            case 0xfffe:

                code = "Unicode";

                break;

            case 0xfeff:

                code = "UTF-16BE";

                break;

            default:

                code = "GBK";

        }



        return code;

    }


}
