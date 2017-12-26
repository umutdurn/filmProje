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
    public partial class yapim_yili : System.Web.UI.Page
    {
        Veritabani baglan = new Veritabani();
        SqlConnection dbBag = new SqlConnection();
        SqlCommand cmdKomut;
        SqlDataReader dtrData;
        SqlDataAdapter dtrAdapt;
        DataTable dtTable = new DataTable();

        IList<string> segmentler = HttpContext.Current.Request.GetFriendlyUrlSegments();

        MetaTagInfo MetaTags
        {
            get { return ViewState["METATAG"] as MetaTagInfo; }
            set { ViewState["METATAG"] = value; }
        }

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

            MetaTagGenerator metaTagGenerator = new MetaTagGenerator();
            metaTagGenerator.Generate(MetaTags);
        }

        protected void BaslikGetir()
        {
            string title = "";

            if (Request["Page"] != null)
            {
                Page.Title = segmentler[0] + " Filmleri Full HD Tek Parça izle - Sayfa " + Request["Page"];
                title= segmentler[0] + " Filmleri Full HD Tek Parça izle - Sayfa " + Request["Page"];
                Page.MetaDescription = Request["Page"] + ". Sayfa - " + segmentler[0] + " yılının en güzel ve en beğenilen filmlerini web sitemizi ziyaret ederek full hd kalitede izleyebilirsiniz.";

            }
            else
            {
                Page.Title = segmentler[0] + " Filmleri Full HD Tek Parça izle";
                title= segmentler[0] + " Filmleri Full HD Tek Parça izle";
                Page.MetaDescription = segmentler[0] + " yılının en güzel ve en beğenilen filmlerini web sitemizi ziyaret ederek full hd kalitede izleyebilirsiniz.";
            }

            MetaTags = new MetaTagInfo
            {
                Description = Page.MetaDescription,
                Image = "http://" + Request.Url.Host.ToLower() + "/images/screen.png",
                Site_Name = title,
                Title = title,
                Type = "article",
                Url = Request.Url.ToString()
            };


        }

        protected void filmlerGetir()
        {

            dtrAdapt = new SqlDataAdapter("Select * From film_Filmler Where YapimYili = '" + segmentler[0] + "' Order By ID Desc", dbBag);
            dtrAdapt.Fill(dtTable);

            CollectionPager1.DataSource = dtTable.DefaultView;
            CollectionPager1.BindToControl = filmler;

            filmler.DataSource = CollectionPager1.DataSourcePaged;
            filmler.DataBind();

        }
    }
}