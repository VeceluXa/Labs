import server.SMTPServer

fun main(args: Array<String>) {
    val server = SMTPServer()
    server.start()
}