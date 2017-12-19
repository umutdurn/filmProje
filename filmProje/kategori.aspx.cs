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
    public partial class kategori : System.Web.UI.Page
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
            cmdKomut = new SqlCommand("Select * From film_Kategoriler Where URL = '" + segmentler[0] + "'", dbBag);
            dtrData = cmdKomut.ExecuteReader();
            if (dtrData.Read())
            {
                if (Request["Page"] != null)
                {
                    Page.Title = dtrData["KategoriAdi"].ToString() + " Filmleri izle Full HD Tek Parça 1080p Seyret - Sayfa " + Request["Page"];
                    Page.MetaDescription = Request["Page"] + ". Sayfa - " + dtrData["KategoriAdi"].ToString() + " filmleri izle tek parça full hd filmleri web sitemizi ziyaret ederek donmadan izleyebilirsiniz.";
                }
                else
                {
                    Page.Title = dtrData["KategoriAdi"].ToString() + " Filmleri izle Full HD Tek Parça 1080p Seyret";
                    Page.MetaDescription = dtrData["KategoriAdi"].ToString() + " filmleri izle tek parça full hd filmleri web sitemizi ziyaret ederek donmadan izleyebilirsiniz.";
                }
            }
            dtrData.Close();
        }

        protected void filmlerGetir()
        {
            string katID = "";

            cmdKomut = new SqlCommand("Select * From film_Kategoriler Where URL = '"+ segmentler[0] + "'", dbBag);
            dtrData = cmdKomut.ExecuteReader();
            if (dtrData.Read())
            {
                katID = "," + dtrData["ID"].ToString() + ",";
            }
            dtrData.Close();
            
            dtrAdapt = new SqlDataAdapter("Select * From film_Filmler Where Kategoriler LIKE '%" + katID + "%' Order By ID Desc", dbBag);
            dtrAdapt.Fill(dtTable);

            CollectionPager1.DataSource = dtTable.DefaultView;
            CollectionPager1.BindToControl = filmler;

            filmler.DataSource = CollectionPager1.DataSourcePaged;
            filmler.DataBind();

        }
    }
}