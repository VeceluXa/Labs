package utils

import androidx.compose.ui.Modifier
import androidx.compose.ui.composed
import androidx.compose.ui.draw.drawBehind
import androidx.compose.ui.geometry.Offset
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.unit.Dp
import androidx.compose.ui.unit.dp
import domain.model.Point
import kotlin.random.Random

// сравниваем содержимое массивов
fun Array<Point>.deepEquals(other: Array<Point>): Boolean {
    if (size != other.size) return false

    var isEqual = true
    forEachIndexed { index, point ->
        if (point != other[index]) {
            isEqual = false
            return@forEachIndexed
        }
    }

    return isEqual
}

fun randomInt(bound: Int = Int.MAX_VALUE): Int = Random.nextInt(bound)

fun <T> Array<T>.randomElement(): T? = (if (this.isEmpty()) null else this[randomInt(this.size)])

fun Modifier.drawBottomLine(
    doDraw: Boolean = true,
    strokeWidth: Dp = 3.dp,
    strokeColor: Color
): Modifier = composed(
    factory = {
        this.then(
            Modifier.drawBehind {
                if (doDraw.not()) return@drawBehind
                val strokeWidthPx = strokeWidth.toPx()
                val y = size.height - strokeWidthPx / 2

                drawLine(
                    color = strokeColor,
                    start = Offset(0f, y),
                    end = Offset(size.width, y),
                    strokeWidth = strokeWidthPx
                )
            }
        )
    }
)