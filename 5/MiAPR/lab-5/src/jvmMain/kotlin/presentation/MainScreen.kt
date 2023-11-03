package presentation

import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.runtime.*
import androidx.compose.ui.Modifier
import domain.ClassifiedPoint

val trainSet1 = listOf(
    ClassifiedPoint(-1.0, 1.0, 1),
    ClassifiedPoint(1.0, 1.0, 1),
    ClassifiedPoint(2.0, 0.0, 2),
    ClassifiedPoint(-1.0, 2.0, 2)
)

val trainSet2 = listOf(
    ClassifiedPoint(-1.0, 0.0, 1),
    ClassifiedPoint(1.0, 1.0, 1),
    ClassifiedPoint(2.0, 0.0, 2),
    ClassifiedPoint(1.0, -2.0, 2)
)

val trainSet3 = listOf(
    ClassifiedPoint(-1.0, -1.0, 1),
    ClassifiedPoint(1.0, 1.0, 1),
    ClassifiedPoint(-1.0, 1.0, 2),
    ClassifiedPoint(1.0, -1.0, 2)
)

@Composable
fun MainScreen() {
    var dataSets by remember {
        mutableStateOf<List<List<ClassifiedPoint>>>(emptyList())
    }

    var counter by remember { mutableStateOf(0) }

    LaunchedEffect(counter) {
        if (counter > 0) {
            dataSets = listOf(trainSet1, trainSet2, trainSet3)

            dataSets.forEachIndexed { index, classifiedPoints ->

            }
        }
    }

    Column(
        modifier = Modifier
            .fillMaxSize()
    ) {
    }
}