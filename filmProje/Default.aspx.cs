using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace filmProje
{
    public partial class _Default : Page
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

        protected void sayfaBasligi() {

            Page.Title = "Film izle | En Yeni ve Güncel Vizyon Filmlerini izle";

            if (Request["Page"] != null)
            {
                Page.Title = "Film izle | En Yeni ve Güncel Vizyon Filmlerini izle - Sayfa " + Request["Page"];
                Page.MetaDescription = Request["Page"] + ". Sayfa - Film izleme keyfini tam anlamıyla yaşayabileceğiniz ve 1080p kalitede videoların keyfine varabileceğiniz sitemizi ziyaret edebilirsiniz.";
            }
            else
            {
                Page.Title = "Film izle | En Yeni ve Güncel Vizyon Filmlerini izle";
                Page.MetaDescription = "Film izleme keyfini tam anlamıyla yaşayabileceğiniz ve 1080p kalitede videoların keyfine varabileceğiniz sitemizi ziyaret edebilirsiniz.";
            }

        }
        protected void filmlerGetir() {

            dtrAdapt = new SqlDataAdapter("Select * From film_Filmler Order By ID Desc", dbBag);
            dtrAdapt.Fill(dtTable);

            CollectionPager1.DataSource = dtTable.DefaultView;
            CollectionPager1.BindToControl = filmler;

            filmler.DataSource = CollectionPager1.DataSourcePaged;
            filmler.DataBind();

        }

        protected override void SavePageStateToPersistenceMedium(object state)
        {
            LosFormatter formatter = new LosFormatter();
            StringWriter writer = new StringWriter();
            formatter.Serialize(writer, state);
            string viewState = writer.ToString();
            byte[] data = Convert.FromBase64String(viewState);
            byte[] compressedData = ZipState.Compress(data);
            string str = Convert.ToBase64String(compressedData);
            ClientScript.RegisterHiddenField("__CompressedVIEWSTATE", str);
        }

        protected override object LoadPageStateFromPersistenceMedium()
        {
            string viewstate = Request.Form["__CompressedVIEWSTATE"];
            byte[] data = Convert.FromBase64String(viewstate);
            byte[] uncompressedData = ZipState.Decompress(data);
            string str = Convert.ToBase64String(uncompressedData);
            LosFormatter formatter = new LosFormatter();
            return formatter.Deserialize(str);
        }
    }
}