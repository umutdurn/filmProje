using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace filmProje.film_ekle
{
    public partial class yonetim : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public string tabGetir(string gelen) {

            string sonuc = "";

            if (Request["pnl"] == gelen)
            {
                sonuc = "active_tab";
            }

            return sonuc;
        
        }
    }
}