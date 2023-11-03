package domain.model

import utils.EQUAL_THRESHOLD
import kotlin.math.abs
import kotlin.math.hypot

data class Point(val x: Int, val y: Int) {

    fun distanceTo(p: Point): Double = distanceTo(p.x, p.y)

    private fun distanceTo(x: Int, y: Int): Double = hypot((this.x - x).toDouble(), (this.y - y).toDouble())

    fun farthestPointOf(points: Array<Point>): Point = points.maxBy { this.distanceTo(it) }

    override fun equals(other: Any?): Boolean {
        return when {
            other !is Point -> false
            (!(abs(x - other.x) <= EQUAL_THRESHOLD && abs(y - other.y) <= EQUAL_THRESHOLD)) -> false
            else -> true
        }
    }

    override fun hashCode(): Int {
        var result = x
        result = 31 * result + y
        return result
    }
}