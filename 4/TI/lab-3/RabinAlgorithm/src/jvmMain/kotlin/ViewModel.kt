import java.math.BigInteger

class ViewModel {

    fun checkInput(args: CheckArgs): AlertDialogArgs {
        if (fileInput == null)
            return AlertDialogArgs("Error", "Select input file!")
        if (fileOutput == null)
            return AlertDialogArgs("Error", "Select output file!")

        if (args.p == null)
            return AlertDialogArgs("Error", "Enter p!")
        val pMessage = isPValid(p!!)
        if (pMessage != "")
            return AlertDialogArgs("Error", pMessage)

        if (args.q == null)
            return AlertDialogArgs("Error", "Enter q!")
        val qMessage = isQValid(p!!, q!!)
        if (qMessage != "")
            return AlertDialogArgs("Error", qMessage)

        if (args.b == null)
            return AlertDialogArgs("Error", "Enter b!")
        val bMessage = isBValid(p!!, q!!, b!!)
        if (bMessage != "")
            return AlertDialogArgs("Error", bMessage)

        return AlertDialogArgs("", "")
    }

    private fun isPValid(p: BigInteger): String {
        println(p)
        println(p.toLong())
        if (!isPrime(p))
            return "Argument p is not prime!"
        if (p.mod((4).toBigInteger()) != (3).toBigInteger())
            return "Argument p is not valid! (P % 4 != 3)"
        return ""
    }

    private fun isQValid(p: BigInteger, q: BigInteger): String {
        if (!isPrime(q))
            return "Argument q is not prime!"
        if (q.mod((4).toBigInteger()) != (3).toBigInteger())
            return "Argument q is not valid! (Q % 4 != 3)"

        return ""
    }

    private fun isBValid(p: BigInteger, q: BigInteger, b: BigInteger): String {
        val n = p * q
        if (b > n)
            return "Argument b is not valid! (Bigger than $n)"
        return ""
    }

    private fun isPrime(n: BigInteger): Boolean {
        return Utils.isPrime(n)
    }
}

