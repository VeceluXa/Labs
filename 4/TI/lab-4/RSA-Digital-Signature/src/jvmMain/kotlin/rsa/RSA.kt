package rsa

import Utils.getHash
import Utils.powMod
import java.math.BigInteger

class RSA(
    val p: BigInteger,
    val q: BigInteger,
    val privateKey: Long,
    val data: ByteArray
) {
    private val r = p * q
    fun getSignature(): Pair<ByteArray, Long> {
        val m = getHash(p * q, data)
        println("Hash: $m")
        val s = powMod(m.toLong(), privateKey, r.toLong())

        return Pair(data, s)
    }

    fun verifySignature(signature: Long): String {
        val sPrivate = getSignature().second

        if (signature != sPrivate)
            return "Signatures are not identical ($signature and $sPrivate). Signature is not verified."

        return "Signature verified."
    }
}