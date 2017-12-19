using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Optimization;
using System.Web.Routing;
using System.Web.Security;
using System.Web.SessionState;

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


    }
}