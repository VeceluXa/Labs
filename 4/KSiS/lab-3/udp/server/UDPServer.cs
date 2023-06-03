using System;
using System.Net;
using System.Net.Sockets;
using System.Text;

public class UDPServer
{
    private const int Port = 13;

    public static void Main()
    {
        UdpClient udpServer = new UdpClient(Port);

        Console.WriteLine("UDP Daytime server started. Listening on port " + Port + "...");
        
        while (true)
        {
            IPEndPoint clientEndPoint = new IPEndPoint(IPAddress.Any, Port);
            byte[] receiveBuffer = udpServer.Receive(ref clientEndPoint);

            string dateTimeString = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");
            byte[] responseBuffer = Encoding.ASCII.GetBytes(dateTimeString);

            udpServer.Send(responseBuffer, responseBuffer.Length, clientEndPoint);
        }
    }
}