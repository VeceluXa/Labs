import java.math.BigInteger
import java.util.*
import kotlin.math.ceil
import kotlin.math.log2

object Utils {
    fun advancedEuclidAlgorithmBI(a: BigInteger, b: BigInteger): Pair<BigInteger, BigInteger> {
        var d0 = a
        var d1 = b
        var d2: BigInteger
        var x0 = BigInteger.valueOf(1)
        var x1 = BigInteger.valueOf(0)
        var x2: BigInteger
        var y0 = BigInteger.valueOf(0)
        var y1 = BigInteger.valueOf(1)
        var y2: BigInteger
        var q: BigInteger
        while (d1 > BigInteger.valueOf(1)) {
            q = d0 / d1
            d2 = d0.mod(d1)
            x2 = x0 - (q * x1)
            y2 = y0 - (q * y1)
            d0 = d1
            d1 = d2
            x0 = x1
            x1 = x2
            y0 = y1
            y1 = y2
        }
        return Pair(x1, y1)
    }

    // Modular exponentiation
    fun powMod(a: Long, b: Long, m: Long): Long {
        var a1 = a
        var exp = b
        var res = 1L
        while (exp != 0L) {
            while (exp % 2 == 0L) {
                exp /= 2
                a1 = (a1 * a1) % m
            }
            exp--
            res = (res * a1) % m
        }
        return res
    }


    // Fermat's test
    fun isPrime(n: BigInteger): Boolean {
        val epsilon = 1e-9
        val k = ceil(log2((1 / epsilon))).toInt()
        // Check if n is less than 2, which is not a prime number
        if (n < BigInteger.valueOf(2)) {
            return false
        }

        // Check if n is 2 or 3, which are prime numbers
        if (n == BigInteger.valueOf(2) || n == BigInteger.valueOf(3)) {
            return true
        }

        // Perform k iterations of the Fermat primality test
        repeat(k) {
            // Generate a random base between 2 and n-2
            val a = BigInteger(n.bitLength(), Random()).mod(n - BigInteger.valueOf(3)) + BigInteger.valueOf(2)

            // Check if a^(n-1) mod n is not equal to 1
            if (a.modPow(n - BigInteger.ONE, n) != BigInteger.ONE) {
                return false
            }
        }

        // If n passes all k iterations of the Fermat test, it is likely a prime number
        return true
    }
}