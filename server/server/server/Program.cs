using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Sockets;
using System.Text;
using System.Threading.Tasks;


namespace server
{
    
    
    internal class Program
    {
        public static HttpListener listener;
        public static string url = "http://localhost:8000/";
        public static SqlConnection sqlConnection = new SqlConnection("Server=localhost;Database=test;Trusted_Connection=True;");
        public static async Task HandleIncomingConnections()
        {
            bool runServer = true;

           
            while (runServer)
            {
                
                HttpListenerContext ctx = await listener.GetContextAsync();

               
                HttpListenerRequest req = ctx.Request;
                HttpListenerResponse resp = ctx.Response;

           
               

                
                if((req.HttpMethod == "GET") && (req.Url.AbsolutePath == "/getCake"))
                {
                    Console.WriteLine("Получение тортов");
                    Console.WriteLine(req.Url.Query);

                    
                    
                    
                    SqlCommand command = new SqlCommand("SELECT * FROM Model", sqlConnection);
                    SqlDataReader reader = command.ExecuteReader();

                    String response = "[";
                    while(reader.Read())
                    {
                        response += "{";
                       response += String.Format("" +
                           "\"idModel\":\"{0}\"," +
                           "\"cost\":\"{1}\"," +
                           "\"weight\":\"{2}\"," +
                           "\"productionTime\":\"{3}\"," +
                           "\"name\":\"{4}\"," +
                           "\"type\":\"{5}\"," +
                           "\"idModel\":\"{6}\",", reader["idModel"].ToString(), reader["cost"].ToString(), reader["weight"].ToString(), reader["productionTime"].ToString()
                            , reader["name"].ToString(), reader["type"].ToString(), reader["patch"].ToString());

                        response += "},";
                    }
                    response += "]";
                    reader.Close();
                    string data = response;
                    byte[] buffer = Encoding.UTF8.GetBytes(data);
                    resp.ContentLength64 = buffer.Length;

               
                    resp.OutputStream.Write(buffer, 0, buffer.Length);
                   
                }

                if ((req.HttpMethod == "GET") && (req.Url.AbsolutePath == "/showCakeByCost"))
                {
                    string cost = req.Url.Query.Split('=').Last();

                    SqlCommand command = new SqlCommand(String.Format("SELECT * FROM Model WHERE cost BETWEEN 0 AND {0}", cost), sqlConnection);
                    SqlDataReader reader = command.ExecuteReader();
                    String response = "[";
                    while (reader.Read()) {
                        response += "{";
                        response += String.Format("" +
                            "\"idModel\":\"{0}\"," +
                            "\"cost\":\"{1}\"," +
                            "\"weight\":\"{2}\"," +
                            "\"productionTime\":\"{3}\"," +
                            "\"name\":\"{4}\"," +
                            "\"type\":\"{5}\"," +
                            "\"idModel\":\"{6}\"", reader["idModel"].ToString(), reader["cost"].ToString(), reader["weight"].ToString(), reader["productionTime"].ToString()
                             , reader["name"].ToString(), reader["type"].ToString(), reader["patch"].ToString());

                        response += "},";
                    }
                    response += "]";
                    reader.Close();
                    Console.WriteLine("Получение тортов по цене" + cost);

                    string data = response;
                    byte[] buffer = Encoding.UTF8.GetBytes(data);
                    resp.ContentLength64 = buffer.Length;


                    resp.OutputStream.Write(buffer, 0, buffer.Length);
                }

                if ((req.HttpMethod == "GET") && (req.Url.AbsolutePath == "/showOrderByIndividualClient"))
                {
                    string idClient = req.Url.Query.Split('=').Last();

                    SqlCommand command = new SqlCommand(String.Format("SELECT * FROM Orders o LEFT JOIN Model m ON m.idModel = o.idModel WHERE o.idClient = {0}", idClient), sqlConnection);
                    SqlDataReader reader = command.ExecuteReader();
                    String response = "[";
                    while (reader.Read())
                    {
                        response += "{";
                        response += String.Format("" +
                            "\"idOrder\":\"{0}\"," +
                            "\"registrationDate\":\"{1}\"," +
                            "\"presumptiveDate\":\"{2}\"," +
                            "\"idModel\":\"{3}\"," +
                            "\"idClient\":\"{4}\"," +
                            "\"costOrder\":\"{5}\"," +
                            "\"prepayment\":\"{6}\"," +
                             "\"statusOrder\":\"{7}\"," +
                           "\"idModel_\":\"{8}\"," +
                         "\"cost\":\"{9}\"," +
                          "\"weight\":\"{10}\"," +
                          "\"productionTime\":\"{11}\"," +
                          "\"name\":\"{12}\"," +
                           "\"type\":\"{13}\"," +
                         "\"patch\":\"{14}\"" +
                            "", reader["idOrder"].ToString(), reader["registrationDate"].ToString(), reader["presumptiveDate"].ToString(), reader["idModel"].ToString()
                             , reader["idClient"].ToString(), reader["costOrder"].ToString(), reader["prepayment"].ToString()
                             , reader["statusOrder"].ToString()
                             , reader["idModel_"].ToString()
                             , reader["cost"].ToString()
                             , reader["weight"].ToString()
                             , reader["productionTime"].ToString()
                             , reader["name"].ToString()
                              , reader["type"].ToString()
                               , reader["patch"].ToString());

                        response += "},";
                    }
                    response += "]";
                    reader.Close();
                    string data = response;
                    byte[] buffer = Encoding.UTF8.GetBytes(data);
                    resp.ContentLength64 = buffer.Length;


                    resp.OutputStream.Write(buffer, 0, buffer.Length);
                    Console.WriteLine("Показ заказов для клиента");
                }

                if ((req.HttpMethod == "GET") && (req.Url.AbsolutePath == "/assignment"))
                {
                    Console.WriteLine("Назначение мастера");
                }

                if ((req.HttpMethod == "GET") && (req.Url.AbsolutePath == "/auth"))
                {
                    string[] parametrs = req.Url.Query.Split('=');
                   
                    string number = parametrs[1].Substring(0, parametrs[1].IndexOf('&'));
                    string email = parametrs.Last();
                    Console.WriteLine(number);
                    Console.WriteLine(email);

                    string quwery = String.Format("SELECT * FROM Client WHERE phoneNumber = {0}", number);

                    SqlCommand command = new SqlCommand(quwery, sqlConnection);
                    SqlDataReader reader = command.ExecuteReader();
                    if (reader.HasRows)
                    {
                        string data = "вы успешно вошли";
                        byte[] buffer = Encoding.UTF8.GetBytes(data);
                        resp.ContentLength64 = buffer.Length;


                        resp.OutputStream.Write(buffer, 0, buffer.Length);

                    }
                    else
                    {
                        string no = "вы не вошли";
                        byte[] buffers = Encoding.UTF8.GetBytes(no);
                        resp.ContentLength64 = buffers.Length;


                        resp.OutputStream.Write(buffers, 0, buffers.Length);

                        Console.WriteLine("Войти");
                    }

                    reader.Close();
                }







                // Write the response info
                string disableSubmit = !runServer ? "disabled" : "";
               // byte[] data = Encoding.UTF8.GetBytes(String.Format(pageData, pageViews, disableSubmit));
               // resp.ContentType = "text/html";
               // resp.ContentEncoding = Encoding.UTF8;
               // resp.ContentLength64 = data.LongLength;

                // Write out to the response stream (asynchronously), then close it
               // await resp.OutputStream.WriteAsync(data, 0, data.Length);
                resp.Close();
            }
        }

        static void Main(string[] args)
        {
            /*SqlConnection sqlConnection = new SqlConnection("Server=localhost;Database=test;Trusted_Connection=True;");
            sqlConnection.Open();
            SqlCommand command = new SqlCommand();
            command.CommandText = "CREATE TABLE Test (Id INT PRIMARY KEY IDENTITY, Age INT NOT NULL, Name NVARCHAR(100) NOT NULL)";
            command.Connection = sqlConnection;
            command.ExecuteNonQueryAsync();*/
            sqlConnection.Open();
            listener = new HttpListener();
            listener.Prefixes.Add(url);
            listener.Start();
            Console.WriteLine("Listening for connections on {0}", url);

            // Handle requests
            Task listenTask = HandleIncomingConnections();
            listenTask.GetAwaiter().GetResult();

            // Close the listener
            listener.Close();

        }
    }
}
