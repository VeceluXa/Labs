import java.io.File
import java.math.BigInteger

class Encryptor(
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

        val listPlain = fileInput.readBytes().map { (it.toInt() and 0xFF) }

        val listCipher = ArrayList<BigInteger>()
        for (byte in listPlain) {
            val m = BigInteger.valueOf(byte.toLong())
            val c = (m * (m + b)).mod(n)
            listCipher.add(c)
        }
        fileOutput.writeText(listCipher.toString())

        return true
    }
}