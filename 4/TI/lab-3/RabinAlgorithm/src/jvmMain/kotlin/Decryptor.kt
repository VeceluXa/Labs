import java.io.File
import java.math.BigInteger

class Decryptor(
    private val p: BigInteger,
    private val q: BigInteger,
    private val b: BigInteger,
    private val fileInput: File,
    private val fileOutput: File
) {
    fun execute(): Boolean {
        val n = p * q
        val fileInput = this.fileInput
        val fileOutput = this.fileOutput

        val line = fileInput.readText()
        val listCipher = line.substring(1, line.length - 1).split(", ").map { it.toBigInteger() }.toList()
        val listDecipher = ArrayList<BigInteger>()

        for (byte in listCipher) {
            val c = BigInteger.valueOf(byte.toLong())
            val d = (b.pow(2) + (BigInteger.valueOf(4) * c)).mod(n)

            val mP = d.modPow((p + BigInteger.ONE) / BigInteger.valueOf(4), p)
            val mQ = d.modPow((q + BigInteger.ONE ) / BigInteger.valueOf(4), q)

            val ypq = Utils.advancedEuclidAlgorithmBI(p, q)
            val yP = ypq.first
            val yQ = ypq.second

            val dS = Array<BigInteger>(4) { BigInteger.valueOf(0) }
            dS[0] = ((yP * p * mQ) + ( yQ * q * mP)).mod(n)
            dS[1] = n - dS[0]
            dS[2] = ((yP * p * mQ) - (yQ * q * mP)).mod(n)
            dS[3] = n - dS[2]

            loop@ for (value in dS) {
                val temp = value - b
                val msg = if (temp.mod(BigInteger.valueOf(2)) == BigInteger.ZERO) {
                    (temp / BigInteger.valueOf(2)).mod(n)
                } else {
                    ((temp + n) / BigInteger.valueOf(2)).mod(n)
                }
                if (msg < BigInteger.valueOf(256)) {
                    listDecipher.add(msg)
                    break@loop
                }
            }
        }
        fileOutput.writeBytes(listDecipher.map { it.toByte() }.toByteArray())

        return true
    }

}