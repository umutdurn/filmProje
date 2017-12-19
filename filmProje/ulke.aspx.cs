using Microsoft.AspNet.FriendlyUrls;
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
    public partial class ulke : System.Web.UI.Page
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

        protected void BaslikGetir()
        {
            cmdKomut = new SqlCommand("Select * From film_Ulkeler Where UlkeURL = '"+ segmentler[0] + "'", dbBag);
            dtrData = cmdKomut.ExecuteReader();
            if (dtrData.Read())
            {
                if (Request["Page"] != null)
                {
                    Page.Title = dtrData["UlkeAdi"].ToString() + " Yapımı Filmleri Full HD Tek Parça izle - Sayfa " + Request["Page"];
                    Page.MetaDescription = Request["Page"] + ". Sayfa - " + dtrData["UlkeAdi"].ToString() + " yapımı en güzel filmleri web sitemizden tek parça full hd 1080p kalitede izleyebilirsiniz.";

                }
                else
                {
                    Page.Title = dtrData["UlkeAdi"].ToString() + " Yapımı Filmleri Full HD Tek Parça izle";
                    Page.MetaDescription = dtrData["UlkeAdi"].ToString() + " yapımı en güzel filmleri web sitemizden tek parça full hd 1080p kalitede izleyebilirsiniz.";
                }

            }
            dtrData.Close();
        }

        protected void filmlerGetir()
        {

            dtrAdapt = new SqlDataAdapter("Select * From film_Filmler Where Ulke = '" + segmentler[0] + "' Order By ID Desc", dbBag);
            dtrAdapt.Fill(dtTable);

            CollectionPager1.DataSource = dtTable.DefaultView;
            CollectionPager1.BindToControl = filmler;

            filmler.DataSource = CollectionPager1.DataSourcePaged;
            filmler.DataBind();

        }
    }
}