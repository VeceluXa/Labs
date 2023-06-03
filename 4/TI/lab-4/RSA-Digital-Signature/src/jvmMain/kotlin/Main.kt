import Utils.checkInput
import Utils.getHash
import androidx.compose.material.MaterialTheme
import androidx.compose.desktop.ui.tooling.preview.Preview
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.text.KeyboardOptions
import androidx.compose.material.Button
import androidx.compose.material.OutlinedTextField
import androidx.compose.material.Text
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.toAwtImage
import androidx.compose.ui.res.loadImageBitmap
import androidx.compose.ui.res.useResource
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.input.KeyboardType
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.compose.ui.window.Window
import androidx.compose.ui.window.application
import composables.MyAlertDialog
import composables.OutputField
import composables.Variable
import rsa.RSA
import java.io.File
import java.math.BigInteger
import javax.swing.JFileChooser

var p: BigInteger? = null
var q: BigInteger? = null
var key: BigInteger? = null
var file: File? = null

var globalSignature = ""



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
        verticalArrangement = Arrangement.Center,
        modifier = Modifier
            .fillMaxSize()
    ) {
        Text(
            text = "Цифровая подпись RSA",
            fontSize = 32.sp,
            fontWeight = FontWeight.Bold,
            modifier = Modifier
                .padding(10.dp)
        )

        var hash by remember { mutableStateOf("") }
        var signature by remember { mutableStateOf("") }
        var signedMessage by remember { mutableStateOf("") }

        InputRow()
        OutputRow(hash, signature, signedMessage) {
            signature = it
            globalSignature = it
        }
        SignatureRow() {
            hash = it.first
            signature = it.second
            globalSignature = it.second
            signedMessage = it.third
        }
    }
}

@Composable
fun InputRow() {
    Row(
        horizontalArrangement = Arrangement.SpaceEvenly,
        modifier = Modifier
            .fillMaxWidth()
            .padding(12.dp)
    ) {
        Variable("p", "") {
            p = it.toBigIntegerOrNull()
        }
        Variable("q", "") {
            q = it.toBigIntegerOrNull()
        }
        Variable("key", "") {
            key = it.toBigIntegerOrNull()
        }
    }
}

@Composable
fun OutputRow(hash: String, signature: String, signedMessage: String, callback: (newSignature: String) -> Unit) {
    Row(
        horizontalArrangement = Arrangement.SpaceEvenly,
        modifier = Modifier
            .fillMaxWidth()
            .padding(12.dp)
    ) {
        OutputField(text = hash, label = "Hash")

        OutlinedTextField(
            value = signature,
            onValueChange = {newValue ->
                if (newValue.matches(Regex("\\d*"))) {
                    callback(newValue)
                }
            },
            label = { Text("Signature") },
            keyboardOptions = KeyboardOptions(
                keyboardType = KeyboardType.Number
            ),
            singleLine = true,
            modifier = Modifier
                .width(200.dp)
                .padding(horizontal = 5.dp)
        )


        OutputField(text = signedMessage, label = "Signed message")
    }
}

@Composable
fun SignatureRow(callback: (args: Triple<String, String, String>) -> Unit) {
    Row(
        modifier = Modifier
            .padding(10.dp)
    ) {
        ButtonChooseFile()
        ButtonSignFile() {
            callback(it)
        }
        ButtonVerifyFile()
    }
}

@Composable
fun ButtonChooseFile() {
    Button(
        onClick = {
            file = selectFile()
            println(file)
        },
        modifier = Modifier
            .padding(horizontal = 8.dp)
    ) {
        Text("Choose file")
    }
}

private fun selectFile(): File? {
    val fileChooser = JFileChooser("/").apply {
        fileSelectionMode = JFileChooser.FILES_ONLY
        dialogTitle = "Select file"
        approveButtonText = "Select"
        approveButtonToolTipText = "Select current file"
    }
    fileChooser.showOpenDialog(null)
    return fileChooser.selectedFile
}

@Composable
fun ButtonSignFile(callback: (args: Triple<String, String, String>) -> Unit) {
    var alertDialogArgs by remember { mutableStateOf<Pair<String, String>?>(null) }

    if (alertDialogArgs != null) {
        MyAlertDialog(alertDialogArgs!!.first, alertDialogArgs!!.second) {
            alertDialogArgs = null
        }
    }

    Button(
        onClick = {
            val args = checkInput(p, q, key, file)
            if (args.first != "" && args.second != "") {
                alertDialogArgs = args
                return@Button
            }
            val argsOut = signFile()
            callback(argsOut)
                  },
        modifier = Modifier
            .padding(horizontal = 8.dp)
    ) {
        Text("Sign")
    }
}

private fun signFile(): Triple<String, String, String> {
    val bytes = file!!.readBytes()
    val hash = getHash(p!! * q!!, bytes)
    val rsa = RSA(p!!, q!!, key!!.toLong(), bytes)

    val signaturePair = rsa.getSignature()
    println(signaturePair)
    val data = signaturePair.first.toList().toString()
    val message = "{$data, ${signaturePair.second}}"

    return Triple(hash.toString(), signaturePair.second.toString(), message)
}

@Composable
fun ButtonVerifyFile() {
    var alertDialogArgs by remember { mutableStateOf<Pair<String, String>?>(null) }

    if (alertDialogArgs != null) {
        MyAlertDialog(alertDialogArgs!!.first, alertDialogArgs!!.second) {
            alertDialogArgs = null
        }
    }

    Button(
        onClick = {
            val args = checkInput(p, q, key, file)
            if (args.first != "" && args.second != "") {
                alertDialogArgs = args
                return@Button
            }
            alertDialogArgs = verifyFile()
                  },
        modifier = Modifier
            .padding(horizontal = 8.dp)
    ) {
        Text("Verify")
    }
}

private fun verifyFile(): Pair<String, String> {
    val bytes = file!!.readBytes()
    val rsa = RSA(p!!, q!!, key!!.toLong(), bytes)
    val message = rsa.verifySignature(globalSignature.toLongOrNull() ?: 0)
    return Pair("Verification", message)
}

fun main() = application {
    Window(onCloseRequest = ::exitApplication) {
        window.title = "Данилов Фёдор, 151004. Лабораторная работа №4"
        window.iconImage = useResource("icon.png") { loadImageBitmap(it) }.toAwtImage()
        App()
    }
}
