package composables

import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.width
import androidx.compose.material.OutlinedTextField
import androidx.compose.material.Text
import androidx.compose.runtime.*
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp

@Composable
fun OutputField(text: String, label: String) {
    OutlinedTextField(
        value = text,
        onValueChange = {},
        label = { Text(label) },
        singleLine = true,
        modifier = Modifier
            .width(200.dp)
            .padding(horizontal = 5.dp)
    )
}
