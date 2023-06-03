import java.io.File
import java.math.BigInteger
import java.util.*
import kotlin.math.ceil
import kotlin.math.log2

object Utils {
    private const val h0 = 100
    // Modular exponentiation
    fun powMod(a: Long, exp: Long, m: Long): Long {
        var _a = a
        var _exp = exp
        var res = 1L
        while (_exp != 0L) {
            while (_exp % 2 == 0L) {
                _exp /= 2
                _a = (_a * _a) % m
            }
            _exp--
            res = (res * _a) % m
        }
        return res
    }

    /**
     * Get hash of string
     * @param n p * q, where p and q are prime numbers
     * @param message message to get hash of
     * @return hash of message
     */
    fun getHash(n: BigInteger, message: ByteArray): BigInteger {
        var h = h0.toBigInteger()
        message.forEach { byte ->
            val bigByte = byte.toInt().toBigInteger()
            h = ((h + bigByte) * (h + bigByte)).mod(n)
        }
        return h
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

    fun extendedEuclideanAlgorithm(a: Long, b: Long): Pair<Long, Long> {
        var x0 = 1L
        var x1 = 0L
        var y0 = 0L
        var y1 = 1L
        var r0 = a
        var r1 = b

        while (r1 != 0L) {
            val quotient = r0 / r1

            val newR = r0 - quotient * r1
            r0 = r1
            r1 = newR

            val newX = x0 - quotient * x1
            x0 = x1
            x1 = newX

            val newY = y0 - quotient * y1
            y0 = y1
            y1 = newY
        }

        return Pair(x0, y0)
    }

    fun checkInput(p: BigInteger?, q: BigInteger?, key: BigInteger?, file: File?): Pair<String, String> {
        if (p == null)
            return Pair("Error", "Enter p")

        if (!isPrime(p))
            return Pair("Error", "p is not a prime number")

        if (q == null)
            return Pair("Error", "Enter q")

        if (!isPrime(q))
            return Pair("Error", "q is not a prime number")

        if (key == null)
            return Pair("Error", "Enter key")

//        if (!isPrime(key))
//            return Pair("Error", "key is not a prime number")

        if (file == null)
            return Pair("Error", "Select file")

        return Pair("", "")
    }

}