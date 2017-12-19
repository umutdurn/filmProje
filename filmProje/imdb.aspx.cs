using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.AspNet.FriendlyUrls;

namespace filmProje
{
    public partial class imdb : System.Web.UI.Page
    {
        Veritabani baglan = new Veritabani();
        SqlConnection dbBag = new SqlConnection();
        SqlCommand cmdKomut;
        SqlDataReader dtrData;
        SqlDataAdapter dtrAdapt;
        DataTable dtTable = new DataTable();

        IList<string> segmentler = HttpContext.Current.Request.GetFriendlyUrlSegments();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (dbBag.State == ConnectionState.Closed)
            {
                dbBag = baglan.dbBaglanti();
            }

            if (!IsPostBack)
            {
                filmlerGetir();
                BaslikGetir();
            }
        }

        protected void BaslikGetir() {

            if (Request["Page"] != null)
            {
                Page.Title = "IMDB Puanı " + segmentler[0].Replace("-", ".") + " ve Üzeri Olan Filmler - Sayfa " + Request["Page"];
                Page.MetaDescription = Request["Page"] + ". Sayfa - IMDB puanı " + segmentler[0].Replace("-", ".") + " ve üzeri olan filmleri web sitemizin IMDB sayfasını ziyaret ederek bulabilirsiniz.";
            }
            else
            {
                Page.Title = "IMDB Puanı " + segmentler[0].Replace("-", ".") + " ve Üzeri Olan Filmler";
                Page.MetaDescription = "IMDB puanı " + segmentler[0].Replace("-", ".") + " ve üzeri olan filmleri web sitemizin IMDB sayfasını ziyaret ederek bulabilirsiniz.";
            }

        }

        protected void filmlerGetir()
        {

            dtrAdapt = new SqlDataAdapter("Select * From film_Filmler Where IMDB >= '" + segmentler[0].Replace("-", ".") + "' Order By ID Desc", dbBag);
            dtrAdapt.Fill(dtTable);

            CollectionPager1.DataSource = dtTable.DefaultView;
            CollectionPager1.BindToControl = filmler;

            filmler.DataSource = CollectionPager1.DataSourcePaged;
            filmler.DataBind();

        }
    }
}