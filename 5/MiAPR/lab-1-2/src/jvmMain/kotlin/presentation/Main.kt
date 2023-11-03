package presentation

import androidx.compose.desktop.ui.tooling.preview.Preview
import androidx.compose.foundation.BorderStroke
import androidx.compose.foundation.border
import androidx.compose.foundation.layout.*
import androidx.compose.material.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.drawBehind
import androidx.compose.ui.geometry.Offset
import androidx.compose.ui.graphics.Shape
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.compose.ui.window.Window
import androidx.compose.ui.window.application
import utils.drawBottomLine
import java.awt.Dimension

@Composable
@Preview
fun App() {
    MaterialTheme {
        Column(
            modifier = Modifier
                .fillMaxSize(),
            horizontalAlignment = Alignment.CenterHorizontally,
        ) {
            var selectedId by remember { mutableStateOf(0) }

            Row(
                modifier = Modifier
                    .height(50.dp)
                    .fillMaxWidth(),
                verticalAlignment = Alignment.CenterVertically,
            ) {
                TextButton(
                    onClick = {
                        selectedId = 0
                    },
                    modifier = Modifier
                        .weight(1f)
                        .fillMaxHeight()
                        .drawBottomLine(
                            doDraw = selectedId == 0,
                            strokeWidth = 3.dp,
                            strokeColor = MaterialTheme.colors.primary
                        ),
                ) {
                    Text(
                        text = "K-Means",
                        fontSize = 24.sp,
                        fontWeight = FontWeight.Bold,
                        color = MaterialTheme.colors.onBackground
                    )
                }

                TextButton(
                    onClick = {
                        selectedId = 1
                    },
                    modifier = Modifier
                        .weight(1f)
                        .fillMaxHeight()
                        .drawBottomLine(
                            doDraw = selectedId == 1,
                            strokeWidth = 3.dp,
                            strokeColor = MaterialTheme.colors.primary
                        )
                ) {
                    Text(
                        text = "Maximin",
                        fontSize = 24.sp,
                        fontWeight = FontWeight.Bold,
                        color = MaterialTheme.colors.onBackground
                    )
                }
            }

            when (selectedId) {
                0 -> KMeansScreen()
                else -> MaximinScreen()
            }
        }
    }
}

fun main() = application {
    Window(
        onCloseRequest = ::exitApplication,
        title = "МиАПР Лабораторные Работа 1 и 2. Данилов Фёдор 151004.",
        icon = painterResource("icon.png")
    ) {
        window.minimumSize = Dimension(800, 650)
        App()
    }
}
