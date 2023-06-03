package composables

import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.text.KeyboardOptions
import androidx.compose.material.OutlinedTextField
import androidx.compose.material.Text
import androidx.compose.runtime.*
import androidx.compose.ui.Modifier
import androidx.compose.ui.text.input.KeyboardType
import androidx.compose.ui.unit.dp

@Composable
fun Variable(label: String, initialText: String, onValueChange: (String) -> Unit) {
    var textState by remember { mutableStateOf(initialText) }
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