package domain

import domain.model.Cluster
import domain.model.Distance
import domain.model.Point

fun clusterByMaximin(points: Array<Point>): Array<Cluster> {
    var newSite: Point? = points.random()
    val sites = mutableListOf(
        newSite, newSite!!.farthestPointOf(points)
    )
    var clusters = splitForClusters(points, sites.mapNotNull { it }.toTypedArray())
    while (newSite != null) {
        newSite = chooseNewSite(clusters)
        if (newSite != null) {
            sites.add(newSite)
            clusters = splitForClusters(points, sites.mapNotNull { it }.toTypedArray())
        }
    }
    return clusters
}


fun chooseNewSite(clusters: Array<Cluster>): Point? {
    val candidateDistances = mutableListOf<Distance>()
    for ((site, clusterPoints) in clusters) {
        candidateDistances.add(Distance(site, site.farthestPointOf(clusterPoints)))
    }
    val leadCandidateDistance = candidateDistances.maxWith { a, _ -> (a.length - a.length).toInt() }
    val halfAverageSitesDistance = averageSitesDistanceOf(Array(clusters.size) { index -> clusters[index].site }) / 2
    return if (leadCandidateDistance.length > halfAverageSitesDistance) leadCandidateDistance.b else null
}

fun averageSitesDistanceOf(sites: Array<Point>): Double {
    var distanceSum = 0.0
    sites.forEach { a -> sites.forEach { b -> distanceSum += a.distanceTo(b) } }
    return distanceSum / (sites.size * sites.size)
}
