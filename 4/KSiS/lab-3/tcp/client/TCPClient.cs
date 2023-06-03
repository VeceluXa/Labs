using System;
using System.Net.Sockets;
using System.Text;

public class TCPClient
{
    private const int Port = 13;
    private const string ServerRemoteIP = "time-a-g.nist.gov";
    private const string ServerLocalIP = "127.0.0.1";
    private const string ServerIP = ServerRemoteIP;

    public static void Main()
    {
        TcpClient tcpClient = new TcpClient(ServerIP, Port);

        NetworkStream stream = tcpClient.GetStream();
        byte[] receiveBuffer = new byte[1024];
        int bytesRead = stream.Read(receiveBuffer, 0, receiveBuffer.Length);

        string response = Encoding.ASCII.GetString(receiveBuffer, 0, bytesRead);
        Console.WriteLine("Received from server: " + response);

        tcpClient.Close();
    }
}