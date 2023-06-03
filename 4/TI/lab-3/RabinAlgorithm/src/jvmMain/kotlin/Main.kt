import androidx.compose.desktop.ui.tooling.preview.Preview
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.selection.selectable
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.foundation.text.KeyboardOptions
import androidx.compose.material.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.toAwtImage
import androidx.compose.ui.res.loadImageBitmap
import androidx.compose.ui.res.useResource
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.input.KeyboardType
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.compose.ui.window.Window
import androidx.compose.ui.window.application
import java.awt.Dimension
import java.io.File
import java.math.BigInteger
import javax.swing.JFileChooser
import javax.swing.UIManager

const val MIN_WIDTH = 700
const val MIN_HEIGHT = 350

var fileInput: File? = null
var fileOutput: File? = null

var p: BigInteger? = null
var q: BigInteger? = null
var b: BigInteger? = null

val vm = ViewModel()

var option = "Fast"

@Composable
@Preview
fun App() {
    MaterialTheme {
        Layout()
    }
}

@Composable
fun Layout() {
    Column(
        horizontalAlignment = Alignment.CenterHorizontally,
        modifier = Modifier
            .fillMaxSize()
//            .requiredWidth(700.dp)
    ) {
        Text(
            text = "Алгоритм Рабина",
            fontSize = 30.sp,
            fontWeight = FontWeight.Bold,
            modifier = Modifier
                .padding(10.dp)
        )
        Row(
            horizontalArrangement = Arrangement.SpaceEvenly,
            modifier = Modifier
                .fillMaxWidth()
                .padding(10.dp)
        ) {
            Variable("p") {
                p = it.toBigIntegerOrNull()
            }
            Variable("q") {
                q = it.toBigIntegerOrNull()
            }
            Variable("b") {
                b = it.toBigIntegerOrNull()
            }
        }
        FileButtons()
        CryptButtons()

    }

}


data class AlertDialogArgs(
    val title: String,
    val text: String
)

@Composable
fun CryptButtons() {
    var stateCrypt by remember { mutableStateOf(0) }

    if (stateCrypt == 1) {
        MyAlertDialog(
            AlertDialogArgs(
                title = "Encryption",
                text= "Success!"
            )
        ) {}
    } else if (stateCrypt == 2) {
        MyAlertDialog(
            AlertDialogArgs(
                title = "Decryption",
                text= "Success!"
            )
        ) {}
    }


    Row(
        horizontalArrangement = Arrangement.Center,
        modifier = Modifier
            .fillMaxWidth()
    ) {
        CryptButton("Encrypt") {
            encrypt(it) {
                stateCrypt = 1
            }
        }
        CryptButton("Decrypt") {
            decrypt(it) {
                stateCrypt = 2
            }
        }
    }
}

@Composable
fun CryptButton(text: String, cryptFun: (CryptArgs) -> Unit) {
    var alertDialogArgs by remember { mutableStateOf<AlertDialogArgs?>(null) }

    if (alertDialogArgs != null) {
        MyAlertDialog(alertDialogArgs!!) {
            alertDialogArgs = null
        }
    }

    Button(
        onClick = {
            val args = vm.checkInput(CheckArgs(
                p = p,
                q = q,
                b = b,
                fileInput = fileInput,
                fileOutput = fileOutput
            ))
            if (args.title != "" && args.text != "") {
                alertDialogArgs = AlertDialogArgs(args.title, args.text)
                return@Button
            }

            cryptFun(CryptArgs(
                p = p!!,
                q = q!!,
                b = b!!,
                fileInput = fileInput!!,
                fileOutput = fileOutput!!
            ))
        },
        modifier = Modifier
            .padding(horizontal = 10.dp)
    ) {
        Text(
            text = text,
            fontSize = 18.sp,
        )
    }
}

fun encrypt(cryptArgs: CryptArgs, showDialog: () -> Unit) {
    println("Encrypt $cryptArgs")
    val encryptor = Encryptor(cryptArgs.p, cryptArgs.q, cryptArgs.b, cryptArgs.fileInput, cryptArgs.fileOutput)

    encryptor.execute()

    showDialog()
}

fun decrypt(cryptArgs: CryptArgs, showDialog: () -> Unit) {
    println("Decrypt $cryptArgs")
    val decryptor = Decryptor(cryptArgs.p, cryptArgs.q, cryptArgs.b, cryptArgs.fileInput, cryptArgs.fileOutput)

    decryptor.execute()

    showDialog()
}


@Composable
fun FileButtons() {
    Row(
        horizontalArrangement = Arrangement.Center,
        modifier = Modifier
            .fillMaxWidth()
    ) {
        Button(
            onClick = {
                fileInput = selectFile("input")
                println("Input: $fileInput")
            },
            modifier = Modifier
                .padding(horizontal = 10.dp)
        ) {
            Text(
                text = "Select Input File",
                fontSize = 18.sp,
            )
        }

        Button(
            onClick = {
                fileOutput = selectFile("output")
                println("Output: $fileOutput")
            },
            modifier = Modifier
                .padding(horizontal = 10.dp)
        ) {
            Text(
                text = "Select Output File",
                fontSize = 18.sp,
            )
        }
    }
}

@OptIn(ExperimentalMaterialApi::class)
@Composable
fun MyAlertDialog(args: AlertDialogArgs, onDismissed: () -> Unit) {
    var isDialogDisplayed by remember { mutableStateOf(true) }
    if (isDialogDisplayed) {
        AlertDialog(onDismissRequest = {
            isDialogDisplayed = false
            onDismissed() },
            title = { Text(args.title) },
            text = { Text(args.text) },
            confirmButton = {
                Button(onClick = {
                    isDialogDisplayed = false
                    onDismissed()
                }) {
                    Text("Okay")
                }
            },
            modifier = Modifier
                .width(200.dp)
        )
    }
}

private fun selectFile(label: String): File? {
    val fileChooser = JFileChooser("/").apply {
        fileSelectionMode = JFileChooser.FILES_ONLY
        dialogTitle = "Select $label file"
        approveButtonText = "Select"
        approveButtonToolTipText = "Select current file as $label file"
    }
    fileChooser.showOpenDialog(null)
    return fileChooser.selectedFile
}

@Composable
fun Variable(label: String, onValueChange: (String) -> Unit) {
    var textState by remember { mutableStateOf("") }
    OutlinedTextField(
        value = textState,
        onValueChange = {newValue ->
            if (newValue.matches(Regex("\\d*"))) {
                textState = newValue
                onValueChange(newValue)
            }
                        },
        label = { Text(label) },
        keyboardOptions = KeyboardOptions(
            keyboardType = KeyboardType.Number
        ),
        singleLine = true,
        modifier = Modifier
            .width(200.dp)
            .padding(horizontal = 5.dp)
    )
}

fun main() = application {
    UIManager.setLookAndFeel(UIManager.getSystemLookAndFeelClassName())
    Window(
        onCloseRequest = ::exitApplication,
    ) {
        window.minimumSize = Dimension(MIN_WIDTH, MIN_HEIGHT)
        window.title = "Данилов Фёдор, 151004. Лабораторная работа №3"
        window.iconImage = useResource("icon.png") { loadImageBitmap(it) }.toAwtImage()
        App()
    }
}
