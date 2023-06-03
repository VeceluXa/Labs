package client

import client.exceptions.SocketException
import java.io.*
import java.net.Socket

class SMTPClient {
    fun sendMessage(message: String): String? {
        val socket: Socket

        try {
            socket = Socket("localhost", 2525)
        } catch (exception: IOException) {
            throw SocketException("Can't access server. Check if server is started.")
        }

        val writer = BufferedWriter(OutputStreamWriter(socket.getOutputStream()))
        val reader = BufferedReader(InputStreamReader(socket.getInputStream()))

        writer.appendLine(message)
        writer.flush()
        val response =  reader.readLine()
        socket.close()
        return response
    }
}