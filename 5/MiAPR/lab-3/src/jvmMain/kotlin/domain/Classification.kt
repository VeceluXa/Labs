package domain

import java.util.*
import kotlin.math.exp
import kotlin.math.pow
import kotlin.math.sqrt

object Classification {
    private val random = Random()
    fun doubleArrayFromRange(start: Float, end: Float, step: Float): FloatArray {
        val list = emptyList<Float>().toMutableList()
        var x = start
        while (x <= end) {
            list.add(x)
            x += step
        }
        return list.toFloatArray()
    }

    private fun gaussianRandomNumber(mean: Float, derivation: Float): Float = random.nextGaussian().toFloat() * derivation + mean

    fun generateVector(length: Int, mean: Float, derivation: Float): FloatArray {
        return FloatArray(length) { gaussianRandomNumber(mean, derivation) }
    }

    fun getInterval(firstVector: FloatArray, secondVector: FloatArray): Pair<Float, Float> {
        val allPoints = firstVector.plus(secondVector)
        return allPoints.min() to allPoints.max()
    }

    private fun gaussian(x: Float, mean: Float, derivation: Float): Float {
        var result = 1 / (derivation * sqrt(2 * Math.PI))
        result *= exp(-0.5 * ((x - mean) / derivation).pow(2.0f))
        return result.toFloat()
    }

    fun generateProbabilityDensityFunction(
        vectorMean: Float, vectorDerivation: Float, probability: Float
    ): (Float) -> Float {
        return { x: Float -> gaussian(x, vectorMean, vectorDerivation) * probability }
    }

    fun getAreas(y1Values: FloatArray, y2Values: FloatArray, step: Float): Pair<Float, Float> {
        var detectionMistake = 0.0f
        var falsePositive = 0.0f
        for (i in y1Values.indices) {
            if (y1Values[i] > y2Values[i]) {
                detectionMistake += y1Values[i] * step
            } else {
                falsePositive += y2Values[i] * step
            }
        }
        return detectionMistake to falsePositive
    }
}