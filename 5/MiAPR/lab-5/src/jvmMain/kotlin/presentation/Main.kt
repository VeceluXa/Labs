package presentation

import androidx.compose.material.MaterialTheme
import androidx.compose.desktop.ui.tooling.preview.Preview
import androidx.compose.runtime.Composable
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.window.Window
import androidx.compose.ui.window.application
import java.awt.Dimension

@Composable
@Preview
fun App() {
    MaterialTheme {
        MainScreen()
    }
}

fun main() = application {
    Window(
        icon = painterResource("icon.png"),
        title = "МиАПР, лабораторная работа №3. Данилов Фёдор, 151004.",
        onCloseRequest = ::exitApplication
    ) {
        window.minimumSize = Dimension(800, 600)
        App()
    }
}
