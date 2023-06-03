using System;
using System.Net;
using System.Net.Sockets;
using System.Text;

public class UDPClient
{
    private const int Port = 13;
    private const string ServerRemoteName = "tick.mit.edu";
    private const string ServerLocalName = "localhost";

    public static void Main()
    {
        IPAddress[] serverIPAddresses = Dns.GetHostAddresses(ServerRemoteName);

        UdpClient udpClient = new UdpClient();
        IPEndPoint serverEndPoint = new IPEndPoint(serverIPAddresses[0], Port);

        byte[] requestBuffer = Encoding.ASCII.GetBytes("Time?");
        udpClient.Send(requestBuffer, requestBuffer.Length, serverEndPoint);

        byte[] receiveBuffer = udpClient.Receive(ref serverEndPoint);
        string response = Encoding.ASCII.GetString(receiveBuffer);

        Console.WriteLine("Received from server: " + response);

        udpClient.Close();
    }
}