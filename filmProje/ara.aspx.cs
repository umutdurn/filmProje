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
    public partial class ara : System.Web.UI.Page
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

            if (!IsPostBack)
            {
                filmlerGetir();
                sayfaBasligi();
            }
        }

        protected void sayfaBasligi()
        {

            Page.Title = "Film izle | En Yeni ve Güncel Vizyon Filmlerini izle";

            if (Request["Page"] != null)
            {
                Page.Title = Request["film"] + " kelimesi için arama sonuçları. - Sayfa " + Request["Page"];
                Page.MetaDescription = Request["Page"] + ". Sayfa - Film izleme keyfini tam anlamıyla yaşayabileceğiniz ve 1080p kalitede videoların keyfine varabileceğiniz sitemizi ziyaret edebilirsiniz.";
            }
            else
            {
                Page.Title = Request["film"] + " kelimesi için arama sonuçları.";
            }

        }
        protected void filmlerGetir()
        {

            dtrAdapt = new SqlDataAdapter("Select * From film_Filmler Where Baslik LIKE '%" + Request["film"].Replace("'", "") + "%' Order By ID Desc", dbBag);
            dtrAdapt.Fill(dtTable);

            CollectionPager1.DataSource = dtTable.DefaultView;
            CollectionPager1.BindToControl = filmler;

            filmler.DataSource = CollectionPager1.DataSourcePaged;
            filmler.DataBind();

        }
    }
}