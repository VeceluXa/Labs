package server

class Responses {
    companion object {
        const val BAD_INPUT = "500 Syntax error, command unrecognized"
        const val BAD_ADDRESS = "252 Cannot verify the user"
        const val OK = "250 OK"
        const val QUIT = "221 Closing transmission channel"
        const val SEND_FAIL = "554 Transaction has failed"
        const val START_INPUT = "354 Start mail input. End with <CRLF>.<CRLF>"
        const val NOT_ACTIVE = "421 Service not available, closing transmission channel"
        const val FILL_DATA = "451 Requested action aborted: enter recipient, sender and data"
    }
}