package composables

import androidx.compose.foundation.layout.width
import androidx.compose.material.AlertDialog
import androidx.compose.material.Button
import androidx.compose.material.ExperimentalMaterialApi
import androidx.compose.material.Text
import androidx.compose.runtime.*
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp

@OptIn(ExperimentalMaterialApi::class)
@Composable
fun MyAlertDialog(title: String, text: String, onDismissed: () -> Unit) {
    var isDialogDisplayed by remember { mutableStateOf(true) }
    if (isDialogDisplayed) {
        AlertDialog(onDismissRequest = {
            isDialogDisplayed = false
            onDismissed() },
            title = { Text(title) },
            text = { Text(text) },
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