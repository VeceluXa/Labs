package server

import java.io.File
import java.security.MessageDigest
import java.time.LocalDateTime
import kotlin.text.Charsets.UTF_8

// Change dir name on your server
private const val MAILS_DIR_PATH = "/home/danilovfa/BSUIR/Labs/4/KSiS/lab-4/files/mails"
class EmailSender {
    fun send(sender: String, recipient: String, data: String): Boolean {
        val path = md5(LocalDateTime.now().toString()).toHex()
        val emailFile = File("$MAILS_DIR_PATH/$path")

        if (!emailFile.exists())
            emailFile.createNewFile()

        if (!emailFile.canWrite())
            return false

        emailFile.appendText("Sender: $sender\n")
        emailFile.appendText("Recipient: $recipient\n")
        emailFile.appendText("Data:\n")
        data.split("\n").forEach { line ->
            emailFile.appendText("$line\n")
        }

        return true
    }

    private fun md5(str: String): ByteArray = MessageDigest.getInstance("MD5").digest(str.toByteArray(UTF_8))
    private fun ByteArray.toHex() = joinToString(separator = "") { byte -> "%02x".format(byte) }
}