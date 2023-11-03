package presentation

import androidx.compose.foundation.background
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.*
import androidx.compose.material.MaterialTheme
import androidx.compose.material.Text
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.SolidColor
import androidx.compose.ui.text.TextStyle
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import domain.Classification.doubleArrayFromRange
import domain.Classification.generateProbabilityDensityFunction
import domain.Classification.generateVector
import domain.Classification.getAreas
import domain.Classification.getInterval
import io.github.koalaplot.core.ChartLayout
import io.github.koalaplot.core.legend.LegendLocation
import io.github.koalaplot.core.line.LineChart
import io.github.koalaplot.core.line.Point
import io.github.koalaplot.core.util.ExperimentalKoalaPlotApi
import io.github.koalaplot.core.xychart.*
import utils.*
import kotlin.math.max

@Composable
fun MainScreen() {
    var displayChartCounter by remember { mutableStateOf(0) }

    var xValues by remember { mutableStateOf(floatArrayOf()) }
    var y1Values by remember { mutableStateOf(floatArrayOf()) }
    var y2Values by remember { mutableStateOf(floatArrayOf()) }
    var areas by remember { mutableStateOf(Pair(0.0f, 0.0f)) }

    LaunchedEffect(displayChartCounter) {
        if (displayChartCounter > 0) {
            val firstVector = generateVector(NUMBERS_COUNT, MEAN_1, DERIVATION_1)
            val secondVector = generateVector(NUMBERS_COUNT, MEAN_2, DERIVATION_2)

            val firstFunction = generateProbabilityDensityFunction(
                firstVector.mean(), firstVector.standardDeviation(), PROBABILITY_1
            )
            val secondFunction = generateProbabilityDensityFunction(
                secondVector.mean(), secondVector.standardDeviation(), PROBABILITY_2
            )

            val interval = getInterval(firstVector, secondVector)

            xValues = doubleArrayFromRange(interval.first, interval.second, STEP)
            y1Values = xValues.map(firstFunction).toFloatArray()
            y2Values = xValues.map(secondFunction).toFloatArray()

            areas = getAreas(y1Values, y2Values, STEP)
        }
    }

    Column(
        modifier = Modifier
            .fillMaxSize(),
        horizontalAlignment = Alignment.CenterHorizontally,
        verticalArrangement = Arrangement.SpaceBetween
    ) {
        Spacer(modifier = Modifier.height(64.dp))

        Box(
            modifier = Modifier
                .fillMaxWidth()
                .padding(horizontal = 32.dp)
                .weight(1f)
        ) {
            if (displayChartCounter > 0 && xValues.isNotEmpty() && y1Values.isNotEmpty() && y2Values.isNotEmpty()) {
                ClassificationChart(
                    xValues = xValues,
                    y1Values = y1Values,
                    y2Values = y2Values,
                    modifier = Modifier
                        .fillMaxSize()
                )
            }
        }

        Spacer(Modifier.height(16.dp))

        ChartLegend(areas)

        Spacer(modifier = Modifier.height(64.dp))

        Box(
            modifier = Modifier
                .fillMaxWidth()
                .height(50.dp)
                .background(color = MaterialTheme.colors.primary)
                .clickable { displayChartCounter++ },
            contentAlignment = Alignment.Center
        ) {
            Text(
                text = "Generate charts",
                style = TextStyle(
                    color = MaterialTheme.colors.onPrimary,
                    fontWeight = FontWeight.Bold,
                    fontSize = 24.sp
                )
            )
        }
    }
}

@OptIn(ExperimentalKoalaPlotApi::class)
@Composable
private fun ClassificationChart(
    xValues: FloatArray,
    y1Values: FloatArray,
    y2Values: FloatArray,
    modifier: Modifier = Modifier
) {
    val minX = xValues.min() - AXIS_X_ADDITION
    val maxX = xValues.max() + AXIS_X_ADDITION
    val xAxis = LinearAxisModel(
        range = minX..maxX,
        allowZooming = true,
        allowPanning = true
    )

    val maxY = max(y1Values.max(), y2Values.max()) + AXIS_Y_ADDITION
    val yAxis = LinearAxisModel(
        range = 0f..maxY,
        allowZooming = true,
        allowPanning = true,
        minimumMajorTickIncrement = 0.01f
    )

    ChartLayout {
        XYChart(
            xAxisModel = xAxis,
            yAxisModel = yAxis,
            xAxisStyle = AxisStyle(),
            modifier = modifier
        ) {
            val y1Points = xValues.zip(y1Values).map { it.toPoint() }
            val y2Points = xValues.zip(y2Values).map { it.toPoint() }

            LineChart(
                data = y1Points,
                color = Color.Red
            )

            LineChart(
                data = y2Points,
                color = Color.Blue
            )
        }
    }
}

@Composable
private fun ChartLegend(areas: Pair<Float, Float>) {
    Row(Modifier.height(32.dp)) {
        if (!(areas.first == 0f && areas.second == 0f)) {
            println(areas)
            val detectionMistake = "Detection mistake: ${String.format("%.3f", (areas.first - 0.6f) * 100)}%"
            val falsePositive = "False positive: ${String.format("%.3f", areas.second * 100)}%"
            val summaryMistake = "Summary mistake: ${String.format("%.3f", (areas.first - 0.6f + areas.second) * 100)}%"

            Text(detectionMistake)
            Spacer(Modifier.width(12.dp))
            Text(falsePositive)
            Spacer(Modifier.width(12.dp))
            Text(summaryMistake)
        }
    }
}

@Composable
private fun XYChartScope<Float, Float>.LineChart(
    data: List<Point<Float, Float>>,
    color: Color
) {
    LineChart(
        data = data,
        lineStyle = LineStyle(
            brush = SolidColor(color),
            strokeWidth = 2.dp
        )
    )
}