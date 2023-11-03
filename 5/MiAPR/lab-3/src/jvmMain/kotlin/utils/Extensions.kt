package utils

import io.github.koalaplot.core.line.Point
import kotlin.math.sqrt

fun FloatArray.mean() = sum() / this.size

fun FloatArray.standardDeviation(): Float = sqrt(variance(this))

private fun variance(input: FloatArray): Float {
    val mean = input.mean()
    val variance = input.indices.map { input[it] - mean }.sumOf { it.toDouble() * it }
    return (variance / input.size).toFloat()
}

fun Pair<Float, Float>.toPoint() = Point(first, second)