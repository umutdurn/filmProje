using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace filmProje
{
    public partial class SiteMaster : MasterPage
    {
        Veritabani baglan = new Veritabani();
        SqlConnection dbBag = new SqlConnection();
        SqlCommand cmdKomut;
        SqlDataReader dtrData;
        SqlDataAdapter dtrAdapt;
        DataTable dtTable = new DataTable();

        protected void Page_Load(object sender, EventArgs e)
        {

            if (dbBag.State == ConnectionState.Closed)
            {
                dbBag = baglan.dbBaglanti();
            }

            string url = Request.RawUrl.ToLower();

            ltrCanonical.Text = "<link rel=\"canonical\" href=\"" + Request.Url + "\" />";

            if (url == "/" || url == "/default")
            {
                pnlAnasayfa.Visible = true;
                pnlCarousel.Visible = true;
            }

            if (!IsPostBack)
            {
                tariheGore();
            }
        }

        protected void tariheGore() {

            dtrAdapt = new SqlDataAdapter("Select DISTINCT YapimYili From film_Filmler Order By YapimYili", dbBag);
            dtrAdapt.Fill(dtTable);

            rptTariheGore.DataSource = dtTable;
            rptTariheGore.DataBind();

            rptTariheGoreUst.DataSource = dtTable;
            rptTariheGoreUst.DataBind();

        }

        protected void btnAra_Click(object sender, EventArgs e)
        {
            Response.Redirect(Page.ResolveUrl("~/") + "ara?film=" + txtAra.Text);
        }
    }
}