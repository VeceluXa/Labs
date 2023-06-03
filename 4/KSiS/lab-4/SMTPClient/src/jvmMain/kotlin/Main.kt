import androidx.compose.desktop.ui.tooling.preview.Preview
import androidx.compose.foundation.gestures.Orientation
import androidx.compose.foundation.gestures.ScrollableState
import androidx.compose.foundation.gestures.scrollable
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.foundation.lazy.rememberLazyListState
import androidx.compose.material.*
import androidx.compose.runtime.*
import androidx.compose.runtime.saveable.rememberSaveable
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.toAwtImage
import androidx.compose.ui.res.loadImageBitmap
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.res.useResource
import androidx.compose.ui.unit.dp
import androidx.compose.ui.window.Window
import androidx.compose.ui.window.application
import client.SMTPClient
import client.exceptions.SocketException
import kotlinx.coroutines.launch

@Composable
@Preview
fun App() {
    MaterialTheme {
        Column(
            modifier = Modifier
                .fillMaxSize()
        ) {
            val messages = remember { mutableStateListOf<String>("Client started. Type HELO/EHLO to start transmission.") }

            OutputField(
                modifier = Modifier
                    .weight(1f),
                messages = messages
            )
            InputField() { message ->
                messages.add(message)
            }
        }
    }
}

@Composable
fun OutputField(modifier: Modifier = Modifier, messages: List<String>) {
    val lazyColumnListState = rememberLazyListState()
    val coroutineScope = rememberCoroutineScope()
    LazyColumn(
        userScrollEnabled = true,
        state = lazyColumnListState,
        modifier = modifier
            .fillMaxWidth()
    ) {
        coroutineScope.launch {
            lazyColumnListState.scrollToItem(messages.lastIndex)
        }
        items(messages) { message ->
            Text(
                text = message,
                modifier = Modifier
                    .fillMaxWidth()
            )
        }
    }
}

@Composable
fun InputField(sendMessage: (message: String) -> Unit) {
    Row(
        modifier = Modifier
            .fillMaxWidth()
    ) {
        var text by rememberSaveable{ mutableStateOf("") }
        OutlinedTextField(
            value = text,
            onValueChange = { text = it },
            maxLines = 1,
            modifier = Modifier
                .weight(1f)
                .height(60.dp)
        )
        OutlinedButton(
            content = { Icon(
                painter = painterResource("send_black_24dp.svg"),
                contentDescription = "Send",
            ) },
            onClick = {
                sendClick(text) { message ->
                    sendMessage(message)
                }
                text = ""
            },
            modifier = Modifier
                .width(60.dp)
                .height(60.dp)
        )
    }
}

private fun sendClick(text: String, sendMessage: (message: String) -> Unit) {
    sendMessage("C: $text")
    try {
        val client = SMTPClient()
        val response = client.sendMessage(text)
        response?.let { sendMessage("S: $it") }
    } catch (exception: SocketException) {
        sendMessage(exception.message.toString())
    }

}

fun main() = application {
    Window(onCloseRequest = ::exitApplication) {
        window.title = "SMTP Client"
        window.iconImage = useResource("icon.png") { loadImageBitmap(it).toAwtImage() }
        App()
    }
}
