using System.Net;
using System.Net.Sockets;
using System.Text;

public class TCPServer
{
    private const int Port = 13;

    public static void Main()
    {
        TcpListener tcpListener = new TcpListener(IPAddress.Any, Port);

        Console.WriteLine("TCP Daytime server started. Listening on port " + Port + "...");
        
        tcpListener.Start();
        
        while (true)
        {
            TcpClient client = tcpListener.AcceptTcpClient();
            
            string dateTimeString = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");
            byte[] responseBuffer = Encoding.ASCII.GetBytes(dateTimeString);

            NetworkStream stream = client.GetStream();
            stream.Write(responseBuffer, 0, responseBuffer.Length);

            client.Close();
        }
    }
}