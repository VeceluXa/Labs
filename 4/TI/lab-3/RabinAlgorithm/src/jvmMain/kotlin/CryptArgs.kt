import java.io.File
import java.math.BigInteger

data class CryptArgs(
    val p: BigInteger,
    val q: BigInteger,
    val b: BigInteger,
    val fileInput: File,
    val fileOutput: File
)

data class CheckArgs(
    val p: BigInteger?,
    val q: BigInteger?,
    val b: BigInteger?,
    val fileInput: File?,
    val fileOutput: File?
)