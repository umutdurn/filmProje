using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace filmProje
{
    public class pagebase
    {
        public static void GZipSIKISTIRMA(HttpContext context)
        {
            HttpResponse Response = context.Response;
            if (GzipEtkinMi(context))
            {
                string encoding = context.Request.Headers["Accept-Encoding"];
                //deflate sıkıştırmayı destekleyenler için
                if (encoding.Contains("deflate"))
                {
                    Response.Filter = new System.IO.Compression.DeflateStream(Response.Filter, System.IO.Compression.CompressionMode.Compress);
                    Response.AppendHeader("Content - Encoding", "deflate");
                }
                else
                {
                    //Gzip sıkıştırmayı destekleyenler için
                    Response.Filter = new System.IO.Compression.GZipStream(Response.Filter, System.IO.Compression.CompressionMode.Compress);
                    Response.AppendHeader("Content - Encoding", "gzip");
                }
                //Sıkıştırılmış bilgi tarayıcıya belirtiliyor!
                Response.AppendHeader("Vary", "Content - Encoding");
            }
        }

        public static bool GzipEtkinMi(HttpContext context)
        {
            //Tarayıcı sıkıştırma destekliyor mu ?
            string AcceptEncoding = context.Request.Headers["Accept-Encoding"];
            if (!string.IsNullOrEmpty(AcceptEncoding))
            {
                //evet
                return (AcceptEncoding.Contains("gzip") || AcceptEncoding.Contains("deflate"));
            }
            else
            {
                //hayır.
                return false;
            }
        }
    }
}