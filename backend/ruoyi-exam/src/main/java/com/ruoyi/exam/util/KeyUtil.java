package com.ruoyi.exam.util;

import java.util.Base64;
import javax.crypto.Cipher;
import javax.crypto.spec.SecretKeySpec;

// 密钥的简单加密，不让数据库里直接存明文
public class KeyUtil
{
    private static final String KEY = "exam2027key12345";

    public static String encrypt(String text)
    {
        if (text == null || text.isEmpty())
        {
            return "";
        }
        try
        {
            Cipher cipher = Cipher.getInstance("AES");
            cipher.init(Cipher.ENCRYPT_MODE, new SecretKeySpec(KEY.getBytes(), "AES"));
            return Base64.getEncoder().encodeToString(cipher.doFinal(text.getBytes()));
        }
        catch (Exception e)
        {
            throw new RuntimeException("密钥加密失败");
        }
    }

    public static String decrypt(String text)
    {
        if (text == null || text.isEmpty())
        {
            return "";
        }
        try
        {
            Cipher cipher = Cipher.getInstance("AES");
            cipher.init(Cipher.DECRYPT_MODE, new SecretKeySpec(KEY.getBytes(), "AES"));
            return new String(cipher.doFinal(Base64.getDecoder().decode(text)));
        }
        catch (Exception e)
        {
            throw new RuntimeException("密钥解密失败");
        }
    }
}
