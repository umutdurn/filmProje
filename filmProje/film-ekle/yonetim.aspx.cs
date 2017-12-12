using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace filmProje.film_ekle
{
    public partial class yonetim1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                panelGetir();
            }
        }

        protected void panelGetir() {

            if (Request["pnl"] != null)
            {
                Panel pnl = (Panel)AnaPanel.FindControl("pnl" + Request["pnl"]);

                if (pnl != null)
                {
                    pnl.Visible = true;
                }
            }
            else
            {
                pnlfilmlistele.Visible = true;
            }
        
        }
    }
}