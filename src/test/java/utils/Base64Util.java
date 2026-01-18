package utils;

import java.util.Base64;

public class Base64Util {

    /** Encode a string to Base64 */
    public static String encode(String input) {
        if (input == null) {
            return null;
        }
        return Base64.getEncoder().encodeToString(input.getBytes());
    }

    /** Decode a Base64 string */
    public static String decode(String base64) {
        if (base64 == null) {
            return null;
        }
        byte[] decodedBytes = Base64.getDecoder().decode(base64);
        return new String(decodedBytes);
    }
}