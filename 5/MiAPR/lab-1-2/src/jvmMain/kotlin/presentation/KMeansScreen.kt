package presentation

import androidx.compose.foundation.Canvas
import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.Button
import androidx.compose.material.MaterialTheme
import androidx.compose.material.Text
import androidx.compose.runtime.*
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.geometry.Offset
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.SolidColor
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import domain.centroidOf
import domain.model.Cluster
import domain.model.Point
import domain.splitForClusters
import kotlinx.coroutines.delay
import utils.*
import java.util.*

@Composable
fun KMeansScreen() {
    val random = Random()

    var isStartButtonEnabled by remember { mutableStateOf(true) }
    var iterationCounter by remember { mutableStateOf(0) }

    var clusters by remember { mutableStateOf<List<Cluster>?>(null) }
    var points = Array(POINTS_COUNT) { Point(random.nextInt(IMAGE_SIZE), random.nextInt(IMAGE_SIZE)) }
    var sites by remember {
        mutableStateOf(
            Array(CLUSTERS_COUNT) { Point(random.nextInt(IMAGE_SIZE), random.nextInt(IMAGE_SIZE)) }
        )
    }

    // Reset
    if (iterationCounter == 0) {
        points = Array(POINTS_COUNT) { Point(random.nextInt(IMAGE_SIZE), random.nextInt(IMAGE_SIZE)) }
        sites = Array(CLUSTERS_COUNT) { Point(random.nextInt(IMAGE_SIZE), random.nextInt(IMAGE_SIZE)) }
        clusters = null
    }

    LaunchedEffect(iterationCounter) {
        if (iterationCounter > 0 && isStartButtonEnabled) {
            var oldSites = sites
            clusters = splitForClusters(points, sites).toList()
            clusters?.let { clusters ->
                oldSites = sites
                sites = Array(sites.size) { centroidOf(clusters[it].points) }
            }

            if (oldSites.deepEquals(sites) || iterationCounter >= 99) {
                isStartButtonEnabled = false
            }

            delay(DELAY_KMEANS)
            iterationCounter++
        }

    }

    Text(
        text = "Итерация $iterationCounter",
        fontSize = 30.sp,
        fontWeight = FontWeight.Bold
    )

    Spacer(Modifier.height(32.dp))

    Canvas(
        modifier = Modifier
            .size(400.dp)
            .background(color = Color.Transparent, shape = RoundedCornerShape(8.dp))
            .border(
                width = 2.dp,
                brush = SolidColor(MaterialTheme.colors.onBackground),
                shape = RoundedCornerShape(8.dp)
            )
            .clip(RoundedCornerShape(8.dp))
    ) {
        clusters?.let { clusters ->
            clusters.forEachIndexed { i, cluster ->
                cluster.points.forEach { point ->
                    drawCircle(
                        brush = SolidColor(colors[i % colors.size]),
                        radius = 2f,
                        center = Offset(point.x.toFloat(), point.y.toFloat())
                    )
                }

                drawCircle(
                    brush = SolidColor(Color.Black),
                    radius = 7f,
                    center = Offset(cluster.site.x.toFloat(), cluster.site.y.toFloat())
                )
            }
        }
    }

    Spacer(Modifier.height(32.dp))

    Row {
        Button(
            onClick = {
                iterationCounter = 0
                isStartButtonEnabled = true
            }
        ) {
            Text("Reset")
        }

        Spacer(Modifier.width(32.dp))

        Button(
            onClick = {
                iterationCounter++
            },
            enabled = isStartButtonEnabled
        ) {
            Text("Start")
        }
    }
}