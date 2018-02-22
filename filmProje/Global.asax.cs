using System;
using System.Collections.Generic;
using System.IO;
using System.IO.Compression;
using System.Linq;
using System.Web;
using System.Web.Optimization;
using System.Web.Routing;
using System.Web.Security;
using System.Web.SessionState;
using System.Web.UI;

namespace filmProje
{
    public class Global : HttpApplication
    {
        void Application_Start(object sender, EventArgs e)
        {
            // Code that runs on application startup
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            BundleConfig.RegisterBundles(BundleTable.Bundles);
        }

        void Application_Error(object sender, EventArgs e)
        {

            Exception olusanHata = Server.GetLastError();

            using (System.IO.FileStream stream = new System.IO.FileStream(Server.MapPath("~/HataLogDosyasi.txt"), System.IO.FileMode.Append, System.IO.FileAccess.Write))
            {
                System.IO.StreamWriter writer = new System.IO.StreamWriter(stream);
                writer.WriteLine("Hata Zamanı " + DateTime.Now.ToString() + "\n" + olusanHata.InnerException + "\n\n");
                writer.Close();
            }
        }

        //void Application_PreRequestHandlerExecute(object sender, EventArgs e)
        //{
        //    HttpApplication app = sender as HttpApplication;
        //    string acceptEncoding = app.Request.Headers["Accept-Encoding"];
        //    Stream prevUncompressedStream = app.Response.Filter;

        //    if (!(app.Context.CurrentHandler is Page ||
        //        app.Context.CurrentHandler.GetType().Name == "SyncSessionlessHandler") ||
        //        app.Request["HTTP_X_MICROSOFTAJAX"] != null)
        //        return;

        //    if (acceptEncoding == null || acceptEncoding.Length == 0)
        //        return;

        //    acceptEncoding = acceptEncoding.ToLower();

        //    // gzip
        //    app.Response.Filter = new GZipStream(prevUncompressedStream,
        //        CompressionMode.Compress);
        //    app.Response.AppendHeader("Content-Encoding", "gzip");
        //}


    }
}