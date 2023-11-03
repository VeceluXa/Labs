package domain.model

data class Distance(var a: Point, var b: Point) {
    val length: Double = a.distanceTo(b)
}
