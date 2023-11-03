package domain

import domain.model.Cluster
import domain.model.Point

// Функция для вычисления центроида (средней точки) класса
fun centroidOf(points: Array<Point>): Point {
    var centerX = 0.0
    var centerY = 0.0
    for ((x, y) in points) {
        centerX += x
        centerY += y
    }
    centerX /= points.size
    centerY /= points.size

    return Point(centerX.toInt(), centerY.toInt())
}

// Функция для разделения точек на кластеры
fun splitForClusters(points: Array<Point>, sites: Array<Point>): Array<Cluster> {
    // Создание массива кластеров
    val clusters = Array(sites.size) { mutableListOf<Point>() }
    // Проход по всем точкам и определение, к какому кластеру они принадлежат
    for (point in points) {
        var n = 0
        for (i in 0..sites.lastIndex) {
            if (sites[i].distanceTo(point) < sites[n].distanceTo(point)) {
                n = i
            }
        }
        clusters[n].add(point)
    }
    // Создание массива кластеров с информацией о кластерах
    return Array(sites.size) { index ->
        Cluster(sites[index], clusters[index].toTypedArray())
    }
}