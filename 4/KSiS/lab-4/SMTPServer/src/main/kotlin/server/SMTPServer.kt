package server


import server.exceptions.PortException
import java.io.BufferedReader
import java.io.BufferedWriter
import java.io.IOException
import java.io.InputStreamReader
import java.io.OutputStreamWriter
import java.net.ServerSocket
import java.net.Socket
import java.util.*

const val PORT = 2525

class SMTPServer {
    private var server: ServerSocket
    private lateinit var socket: Socket
    private lateinit var reader: BufferedReader
    private lateinit var writer: BufferedWriter

    private val emailValidator = EmailValidator()
    private val emailSender = EmailSender()

    private var isTransmissionActive = false
    private var isDataActive = false

    private var recipient = ""
    private var sender = ""
    private var data = ""

    init {
        try {
            server = ServerSocket(2525)
        } catch (exception: IOException) {
            throw PortException("Can't access port $PORT. Check if running as administrator.")
        }
    }

    fun start() {
        println("Start server. Listening on port $PORT.")
        while (true) {
            socket = server.accept()
            reader = BufferedReader(InputStreamReader(socket.getInputStream()))
            writer = BufferedWriter(OutputStreamWriter(socket.getOutputStream()))

            val message = reader.readLine()
            println("C: $message")

            if (isDataActive) {
                processData(message)
            } else {
                val response = handleCommand(message)
                println("S: $response")
                writer.appendLine(response)
                writer.flush()
            }
            socket.close()
        }
    }

    private fun processData(str: String) {
        if (isDataActive) {
            if (str != ".")
                data += "$str\n"
            else
                isDataActive = false
        }
    }

    private fun handleCommand(command: String): String {


        val parsedCommand = command.trim().split(" ", limit = 2)
        val param = parsedCommand.getOrNull(1) ?: ""
        return when (parsedCommand[0].uppercase(Locale.getDefault())) {
            "HELO", "EHLO" -> handleHeloEhlo()
            "MAIL" -> handleMail(param)
            "RCPT" -> handleRcpt(param)
            "DATA" -> handleData()
            "RSET" -> handleRset()
            "SEND" -> handleSend(param)
            "SOML" -> handleSoml(param)
            "SAML" -> handleSaml(param)
            "VRFY" -> handleVrfy(param)
            "EXPN" -> handleExpn(param)
            "HELP" -> handleHelp(parsedCommand.getOrNull(1))
            "NOOP" -> handleNoop()
            "QUIT" -> handleQuit()
            else -> handleBadInput()
        }
    }

    private fun handleHeloEhlo(): String {
        isTransmissionActive = true
        return "250 ${socket.inetAddress.hostAddress} is ready"
    }

    private fun handleMail(from: String): String {
        if (!isTransmissionActive)
            return Responses.NOT_ACTIVE

        if (!from.startsWith("FROM:"))
            return Responses.BAD_INPUT

        val address = from.removePrefix("FROM:")
        if (!emailValidator.verify(address))
            return Responses.BAD_ADDRESS

        sender = address
        return Responses.OK
    }

    private fun handleRcpt(to: String): String {
        if (!isTransmissionActive)
            return Responses.NOT_ACTIVE

        if (!to.startsWith("TO:"))
            return Responses.BAD_INPUT

        val address = to.removePrefix("TO:")
        if (!emailValidator.verify(address))
            return Responses.BAD_ADDRESS

        recipient = address
        return Responses.OK
    }

    private fun handleData(): String {
        if (!isTransmissionActive)
            return Responses.NOT_ACTIVE

        isDataActive = true
        return Responses.START_INPUT
    }

    private fun handleRset(): String {
        if (!isTransmissionActive)
            return Responses.NOT_ACTIVE

        recipient = ""
        sender = ""
        data = ""
        return Responses.OK
    }

    private fun handleSend(from: String): String {
        return sendMail(from)
    }

    private fun handleSoml(from: String): String {
        return sendMail(from)
    }

    private fun handleSaml(from: String): String {
        return sendMail(from)
    }

    private fun sendMail(from: String): String {
        if (!isTransmissionActive)
            return Responses.NOT_ACTIVE

        if (from == "" || sender == "" || data == "")
            return Responses.FILL_DATA

        val response = emailSender.send(from, sender, data)
        return if (response)
            Responses.OK
        else
            Responses.SEND_FAIL
    }

    private fun handleVrfy(str: String): String {
        if (!isTransmissionActive)
            return Responses.NOT_ACTIVE

        return if (!emailValidator.verify(str))
            Responses.BAD_ADDRESS
        else
            Responses.OK
    }

    private fun handleExpn(str: String): String {
        if (!isTransmissionActive)
            return Responses.NOT_ACTIVE

        val response = emailValidator.verifyList(str)
        return "${Responses.OK} $response"
    }

    private fun handleHelp(str: String?): String {
        if (!isTransmissionActive)
            return Responses.NOT_ACTIVE

        if (str == null) {
            return "Available commands: HELO/EHLO, MAIL, RCPT, DATA, " +
                    "RSET, SEND, SOML, SAML, VRFY, EXPN, HELP, NOOP, QUIT"
        }
        return when (str.uppercase(Locale.getDefault())) {
            "HELO", "EHLO" -> "HELO/EHLO <domain>"
            "MAIL" -> "MAIL FROM:<reverse-path>"
            "RCPT" -> "RCPT TO:<forward-path>"
            "DATA" -> "DATA"
            "RSET" -> "RSET"
            "SEND" -> "SEND FROM:<reverse-path>"
            "SOML" -> "SOML FROM:<reverse-path>"
            "SAML" -> "SAML FROM:<reverse-path>"
            "VRFY" -> "VRFY <string>"
            "EXPN" -> "EXPN <string>"
            "HELP" -> "HELP <string>?"
            "NOOP" -> "NOOP"
            "QUIT" -> "QUIT"
            else -> "Command unsupported."
        }
    }

    private fun handleNoop(): String {
        if (!isTransmissionActive)
            return Responses.NOT_ACTIVE

        return Responses.OK
    }

    private fun handleQuit(): String {
        if (!isTransmissionActive)
            return Responses.NOT_ACTIVE

        isTransmissionActive = false
        handleRset()
        return Responses.QUIT
    }

    private fun handleBadInput(): String {
        return Responses.BAD_INPUT
    }
}
