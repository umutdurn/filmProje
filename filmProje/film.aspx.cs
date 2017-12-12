using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.AspNet.FriendlyUrls;
using System.Data.SqlClient;
using System.Data;

namespace filmProje
{
    public partial class film : System.Web.UI.Page
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
            //Response.Cookies["syfYildiz"].Expires = DateTime.Now.AddDays(-1);
            if (dbBag.State == ConnectionState.Closed)
            {
                dbBag = baglan.dbBaglanti();
            }

            if (!IsPostBack)
            {
                filmgetir();
                partGetir();

                yildizGetir();
                incelemeYukselt();
            }
        }

        protected void filmgetir() {

            dtrAdapt = new SqlDataAdapter("Select * From film_Filmler Where URL = '" + segmentler[0] + "'", dbBag);
            dtrAdapt.Fill(dtTable);

            ViewState["filmID"] = dtTable.Rows[0]["ID"].ToString();
            Page.Title = dtTable.Rows[0]["Baslik"].ToString();
            Page.MetaDescription = dtTable.Rows[0]["MetaDesc"].ToString();

            rptfilm.DataSource = dtTable;
            rptfilm.DataBind();
        
        }

        protected void partGetir() {

            foreach (RepeaterItem item in rptfilm.Items)
            {
                DropDownList dropPart = (DropDownList)item.FindControl("dropPartlar");
                Literal literal = (Literal)item.FindControl("ltrIframe");
                int partsayi = 1;
                cmdKomut = new SqlCommand("Select * From film_Partlar Where FilmID = '" + ViewState["filmID"].ToString() + "'",dbBag);
                dtrData = cmdKomut.ExecuteReader();
                while (dtrData.Read())
                {
                    ListItem part = new ListItem();
                    part.Text = "Seçenek " + partsayi.ToString() + ": "+ dtrData["PartAdi"].ToString() + ", " + dtrData["Kalitesi"].ToString() + ", " + dtrData["Dil"].ToString();
                    part.Value = dtrData["ID"].ToString();

                    if (partsayi == 1)
                    {
                        literal.Text = dtrData["Iframe"].ToString();
                    }

                    dropPart.Items.Add(part);

                    partsayi++;
                }
                dtrData.Close();
            }
        
        }

        protected void dropPartlar_SelectedIndexChanged(object sender, EventArgs e)
        {
            DropDownList drop = (DropDownList)sender;
            Literal literal = (Literal)rptfilm.Items[0].FindControl("ltrIframe");

            cmdKomut = new SqlCommand("Select * From film_Partlar Where ID = '" + drop.SelectedValue + "'", dbBag);
            dtrData = cmdKomut.ExecuteReader();
            if (dtrData.Read())
            {
                literal.Text = dtrData["Iframe"].ToString();
            }
            dtrData.Close();
        }

        public string kategoriGetir(string katid) {

            string donen = "";

            string[] kat = katid.Split(',');

            for (int i = 0; i < kat.Length; i++)
            {
                cmdKomut = new SqlCommand("Select * From film_Kategoriler Where ID = '" + kat[i] + "'", dbBag);
                dtrData = cmdKomut.ExecuteReader();
                if (dtrData.Read())
                {
                    donen += "<div class=\"katAdi\" itemprop=\"genre\"><a href=\""+ Page.ResolveUrl("~/kategori/") + dtrData["URL"].ToString() + "\" title=\"" + dtrData["KategoriAdi"].ToString() + "\">" + dtrData["KategoriAdi"].ToString() + "</a></div>";
                }
                dtrData.Close();
            }

            return donen;
        
        }

        public string yonetmenGetir(string katid)
        {

            string donen = "";

            string[] kat = katid.Split(',');

            for (int i = 0; i < kat.Length; i++)
            {
                cmdKomut = new SqlCommand("Select * From film_Yonetmenler Where ID = '" + kat[i] + "'", dbBag);
                dtrData = cmdKomut.ExecuteReader();
                if (dtrData.Read())
                {
                    donen += "<a href=\"" + Page.ResolveUrl("~/yonetmen/") + dtrData["YonetmenURL"].ToString() + "\" class=\"katAdi\" itemprop=\"director\" itemscope itemtype=\"http://schema.org/Person\" title=\"" + dtrData["Yonetmen"].ToString() + "\">" + dtrData["Yonetmen"].ToString() + "</a>";
                }
                dtrData.Close();
            }

            return donen;

        }

        public string oyuncuGetir(string katid)
        {

            string donen = "";

            string[] kat = katid.Split(',');

            for (int i = 0; i < kat.Length; i++)
            {
                cmdKomut = new SqlCommand("Select * From film_Oyuncular Where ID = '" + kat[i] + "'", dbBag);
                dtrData = cmdKomut.ExecuteReader();
                if (dtrData.Read())
                {
                    donen += "<a href=\"" + Page.ResolveUrl("~/oyuncu/") + dtrData["OyuncuURL"].ToString() + "\" class=\"katAdi\" itemprop=\"actor\" itemscope itemtype=\"http://schema.org/Person\" title=\"" + dtrData["Oyuncu"].ToString() + "\">" + dtrData["Oyuncu"].ToString() + "</a>";
                }
                dtrData.Close();
            }

            return donen;

        }

        public string ulkeGetir(string url) {

            string ulke = "";

            cmdKomut = new SqlCommand("Select * From film_Ulkeler Where UlkeURL = '" + url + "'", dbBag);
            dtrData = cmdKomut.ExecuteReader();
            if (dtrData.Read())
            {
                ulke = dtrData["UlkeAdi"].ToString();
            }
            dtrData.Close();

            return ulke;
        }

        protected void rptfilm_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            HttpCookie yildizCookie = Request.Cookies["syfYildiz"];

            if (yildizCookie != null)
            {
                string syrURL = Request.Cookies["syfYildiz"]["syfURL"].ToString();

                if (syrURL != segmentler[0])
                {
                    if (e.CommandName == "yildizver")
                    {
                        yildizcookie(e.CommandArgument.ToString());
                        dbOyKayit(e.CommandArgument.ToString());
                        yildizGetir();
                    }
                }
            }
            else
            {
                if (e.CommandName == "yildizver")
                {
                    yildizcookie(e.CommandArgument.ToString());
                    dbOyKayit(e.CommandArgument.ToString());
                    yildizGetir();
                }
            }
        }

        protected void yildizcookie(string verilen) {

            Response.Cookies["syfYildiz"]["syfURL"] = segmentler[0];
            Response.Cookies["syfYildiz"]["Yildiz"] = verilen;
            Response.Cookies["syfYildiz"].Expires = DateTime.Now.AddYears(1);
        
        }

        protected void yildizGetir() {

            HttpCookie yildizCookie = Request.Cookies["syfYildiz"];

            if (yildizCookie != null)
            {
                string syrURL = Request.Cookies["syfYildiz"]["syfURL"].ToString();

                if (syrURL == segmentler[0])
                {
                    int yildizDeger = Convert.ToInt32(Request.Cookies["syfYildiz"]["Yildiz"].ToString());

                    foreach (RepeaterItem item in rptfilm.Items)
                    {
                        Button btnyldz1 = (Button)item.FindControl("yldz1");
                        Button btnyldz2 = (Button)item.FindControl("yldz2");
                        Button btnyldz3 = (Button)item.FindControl("yldz3");
                        Button btnyldz4 = (Button)item.FindControl("yldz4");
                        Button btnyldz5 = (Button)item.FindControl("yldz5");

                        Panel pnlKapat = (Panel)item.FindControl("pnlYildizKapa");
                        pnlKapat.Visible = true;

                        Label lbl = (Label)item.FindControl("lbloyKullandin");
                        lbl.Text = " - Oy Kullandınız!";

                        if (yildizDeger == 1)
                        {
                            btnyldz1.CssClass += " yildizhover";
                        }
                        else if (yildizDeger == 2)
                        {
                            btnyldz1.CssClass += " yildizhover";
                            btnyldz2.CssClass += " yildizhover";
                        }
                        else if (yildizDeger == 3)
                        {
                            btnyldz1.CssClass += " yildizhover";
                            btnyldz2.CssClass += " yildizhover";
                            btnyldz3.CssClass += " yildizhover";
                        }
                        else if (yildizDeger == 4)
                        {
                            btnyldz1.CssClass += " yildizhover";
                            btnyldz2.CssClass += " yildizhover";
                            btnyldz3.CssClass += " yildizhover";
                            btnyldz4.CssClass += " yildizhover";
                        }
                        else if (yildizDeger == 5)
                        {
                            btnyldz1.CssClass += " yildizhover";
                            btnyldz2.CssClass += " yildizhover";
                            btnyldz3.CssClass += " yildizhover";
                            btnyldz4.CssClass += " yildizhover";
                            btnyldz5.CssClass += " yildizhover";
                        }
                    }
                } 
            }
        
        }

        protected void dbOyKayit(string oy) {

            cmdKomut = new SqlCommand("Insert Into film_Oylar(Oy,IpAdresi,Tarih,FilmUrl) Values(@Oy,@IpAdresi,@Tarih,@FilmUrl)", dbBag);
            cmdKomut.Parameters.AddWithValue("@Oy", oy);
            cmdKomut.Parameters.AddWithValue("@IpAdresi", Request.UserHostAddress);
            cmdKomut.Parameters.AddWithValue("@Tarih", DateTime.Now);
            cmdKomut.Parameters.AddWithValue("@FilmUrl", segmentler[0]);

            cmdKomut.ExecuteNonQuery();
        
        }

        protected void incelemeYukselt() {

            int sayi = 0;

            cmdKomut = new SqlCommand("Select * From film_Filmler Where URL = '" + segmentler[0] + "'", dbBag);
            dtrData = cmdKomut.ExecuteReader();
            if (dtrData.Read())
            {
                if (dtrData["Inceleme"].ToString() != "")
                {
                    sayi = Convert.ToInt32(dtrData["Inceleme"]);
                }

                sayi++;
            }
            dtrData.Close();

            cmdKomut = new SqlCommand("Update film_Filmler SET Inceleme = '" + sayi.ToString() + "'", dbBag);
            cmdKomut.ExecuteNonQuery();
        }

        public string ratCount() {

            string toplam = "0";

            cmdKomut = new SqlCommand("Select COUNT (*) as ToplamSatir From film_Oylar Where FilmURL = '" + segmentler[0] + "'", dbBag);
            dtrData = cmdKomut.ExecuteReader();
            if (dtrData.Read())
            {
                toplam = dtrData["ToplamSatir"].ToString();
            }
            dtrData.Close();

            return toplam;
        }
    }
}