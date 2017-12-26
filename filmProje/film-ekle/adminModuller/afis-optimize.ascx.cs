using System;
using System.Collections.Generic;
using System.Data;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.Drawing.Imaging;
using System.IO;
using System.Linq;

namespace filmProje.film_ekle.adminModuller
{
    public partial class afis_optimize : System.Web.UI.UserControl
    {

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void afisGetir() {

            string[] klasordekiler = Directory.GetFiles(Server.MapPath("~/images/upload"));

            foreach (string resimdosyasi in klasordekiler)
            {
                System.Drawing.Image image = System.Drawing.Image.FromFile(resimdosyasi);

                if (image.Width > 216)
                {
                    int genislik = 216;

                    int yukseklik = 320;

                }
            }

        }

        public bool ThumbnailCallback()
        {
            return false;
        }

        protected void btnOptimize_Click(object sender, EventArgs e)
        {
            afisGetir();
        }
    }
}