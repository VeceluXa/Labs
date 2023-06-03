package server

import java.io.File

// Change path of files on your server
private const val ADDRESSES_FILE_PATH = "/home/danilovfa/BSUIR/Labs/4/KSiS/lab-4/files/addresses.txt"


class EmailValidator {
    private val addressesFile = File(ADDRESSES_FILE_PATH)

    fun verify(email: String): Boolean {
        if (!addressesFile.exists())
            return false

        val emails = addressesFile.readText()
        val emailList = emails.split("\n")
        println(emailList)

        return emailList.contains(email)
    }

    fun verifyList(name: String): String {
        val emails = addressesFile.readText()
        val emailList = emails.split("\n")

        val filteredList = emailList.filter { it.contains(name) }
        return filteredList.joinToString()
    }
}