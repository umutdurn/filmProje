using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.AspNet.FriendlyUrls;
using System.Data.SqlClient;
using System.Data;
using System.Text.RegularExpressions;
using System.IO;

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
                filmgetir();
                partGetir();

                yildizGetir();
                incelemeYukselt();

                YorumlarGetir();
            }

            MetaTagGenerator metaTagGenerator = new MetaTagGenerator();
            metaTagGenerator.Generate(MetaTags);
        }

        protected void YorumlarGetir() {

            dtTable.Clear();

            dtrAdapt = new SqlDataAdapter("Select * From film_Yorumlar Where FilmID = '"+ ViewState["filmID"].ToString() + "' and YorumOnay = '1' Order By ID Desc",dbBag);
            dtrAdapt.Fill(dtTable);

            ltrYorumSayi.Text = dtTable.Rows.Count.ToString();

            rptFilmYorumlar.DataSource = dtTable;
            rptFilmYorumlar.DataBind();

        }

        public string ratingGetir() {

            string rating = "";

            double toplamCarpim = 0;
            double toplamOy = 0;

            double toplamoy5 = 0;
            double toplamoy4 = 0;
            double toplamoy3 = 0;
            double toplamoy2 = 0;
            double toplamoy1 = 0;

            cmdKomut = new SqlCommand("Select COUNT(Oy) as Toplam From film_Oylar Where FilmUrl = '" + segmentler[0] + "' and Oy = '5'", dbBag);
            dtrData = cmdKomut.ExecuteReader();
            while (dtrData.Read())
            {
                toplamoy5 = Convert.ToDouble(dtrData["Toplam"]);
            }
            dtrData.Close();

            cmdKomut = new SqlCommand("Select COUNT(Oy) as Toplam From film_Oylar Where FilmUrl = '" + segmentler[0] + "' and Oy = '4'", dbBag);
            dtrData = cmdKomut.ExecuteReader();
            while (dtrData.Read())
            {
                toplamoy4 = Convert.ToDouble(dtrData["Toplam"]);
            }
            dtrData.Close();

            cmdKomut = new SqlCommand("Select COUNT(Oy) as Toplam From film_Oylar Where FilmUrl = '" + segmentler[0] + "' and Oy = '3'", dbBag);
            dtrData = cmdKomut.ExecuteReader();
            while (dtrData.Read())
            {
                toplamoy3 = Convert.ToDouble(dtrData["Toplam"]);
            }
            dtrData.Close();

            cmdKomut = new SqlCommand("Select COUNT(Oy) as Toplam From film_Oylar Where FilmUrl = '" + segmentler[0] + "' and Oy = '2'", dbBag);
            dtrData = cmdKomut.ExecuteReader();
            while (dtrData.Read())
            {
                toplamoy2 = Convert.ToDouble(dtrData["Toplam"]);
            }
            dtrData.Close();

            cmdKomut = new SqlCommand("Select COUNT(Oy) as Toplam From film_Oylar Where FilmUrl = '" + segmentler[0] + "' and Oy = '1'", dbBag);
            dtrData = cmdKomut.ExecuteReader();
            while (dtrData.Read())
            {
                toplamoy1 = Convert.ToDouble(dtrData["Toplam"]);
            }
            dtrData.Close();

            double toplamsonuc5 = toplamoy5 * 5;
            double toplamsonuc4 = toplamoy4 * 4;
            double toplamsonuc3 = toplamoy3 * 3;
            double toplamsonuc2 = toplamoy2 * 2;
            double toplamsonuc1 = toplamoy1 * 1;

            toplamCarpim = toplamsonuc1 + toplamsonuc2 + toplamsonuc3 + toplamsonuc4 + toplamsonuc5;
            toplamOy = toplamoy1 + toplamoy2 + toplamoy3 + toplamoy4 + toplamoy5;

            double ratingSonuc = (toplamCarpim / toplamOy) * 2;

            rating = Math.Round(ratingSonuc, 1).ToString();

            return rating;
        }

        protected void filmgetir() {

            dtrAdapt = new SqlDataAdapter("Select * From film_Filmler Where URL = '" + segmentler[0] + "'", dbBag);
            dtrAdapt.Fill(dtTable);

            ViewState["filmID"] = dtTable.Rows[0]["ID"].ToString();
            ViewState["filmAfis"] = dtTable.Rows[0]["Poster"].ToString();
            ltrFilmAdi.Text = dtTable.Rows[0]["Baslik"].ToString();
            ltrOrjinalAdi.Text = dtTable.Rows[0]["OrjinalAdi"].ToString();
            ltrFilmAdiYorum.Text = dtTable.Rows[0]["OrjinalAdi"].ToString();
            Page.Title = dtTable.Rows[0]["Baslik"].ToString();
            Page.MetaDescription = dtTable.Rows[0]["MetaDesc"].ToString();

            MetaTags = new MetaTagInfo
            {
                Description = Page.MetaDescription,
                Image = "http://" + Request.Url.Host.ToLower() + "/images/upload/" + ViewState["filmAfis"].ToString(),
                Site_Name = dtTable.Rows[0]["Baslik"].ToString(),
                Title = dtTable.Rows[0]["Baslik"].ToString(),
                Type = "article",
                Url = Request.Url.ToString()
            };

            rptfilm.DataSource = dtTable;
            rptfilm.DataBind();
        
        }

        protected void partGetir() {

            dtTable.Clear();

            Literal literal = (Literal)rptfilm.Items[0].FindControl("ltrIframe");

            dtrAdapt = new SqlDataAdapter("Select * From film_Partlar Where FilmID = '" + ViewState["filmID"].ToString() + "'", dbBag);
            dtrAdapt.Fill(dtTable);

            literal.Text = dtTable.Rows[0]["Iframe"].ToString();

            rptPartlar.DataSource = dtTable;
            rptPartlar.DataBind();

            Button btn = (Button)rptPartlar.Items[0].FindControl("btnPart");
            btn.CssClass += " fragmanpart";

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
                    donen += "<div class=\"katAdi\" itemprop=\"genre\"><a href=\""+ Page.ResolveUrl("~/kategori/") + dtrData["URL"].ToString() + "\" title=\"" + dtrData["KategoriAdi"].ToString() + " Filmleri\">" + dtrData["KategoriAdi"].ToString() + "</a></div>";
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
                    donen += "<a href=\"" + Page.ResolveUrl("~/yonetmen/") + dtrData["YonetmenURL"].ToString() + "\" class=\"katAdi\" itemprop=\"director\" itemscope itemtype=\"http://schema.org/Person\" title=\"" + dtrData["Yonetmen"].ToString() + "\"><span itemprop=\"name\">" + dtrData["Yonetmen"].ToString() + "</span></a>";
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
                    donen += "<a href=\"" + Page.ResolveUrl("~/oyuncu/") + dtrData["OyuncuURL"].ToString() + "\" class=\"katAdi\" itemprop=\"actor\" itemscope itemtype=\"http://schema.org/Person\" title=\"" + dtrData["Oyuncu"].ToString() + "\"><span itemprop=\"name\">" + dtrData["Oyuncu"].ToString() + "</span></a>";
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
            HttpCookie yildizCookie = Request.Cookies["syfYildiz_" + ViewState["filmID"].ToString()];

            if (yildizCookie != null)
            {
                string syrURL = Request.Cookies["syfYildiz_" + ViewState["filmID"].ToString()]["syfURL"].ToString();

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

            Response.Cookies["syfYildiz_" + ViewState["filmID"].ToString()]["syfURL"] = segmentler[0];
            Response.Cookies["syfYildiz_" + ViewState["filmID"].ToString()]["Yildiz"] = verilen;
            Response.Cookies["syfYildiz_" + ViewState["filmID"].ToString()].Expires = DateTime.Now.AddYears(1);
        
        }

        protected void yildizGetir() {

            HttpCookie yildizCookie = Request.Cookies["syfYildiz_" + ViewState["filmID"].ToString()];

            if (yildizCookie != null)
            {
                string syrURL = Request.Cookies["syfYildiz_" + ViewState["filmID"].ToString()]["syfURL"].ToString();

                if (syrURL == segmentler[0])
                {
                    int yildizDeger = Convert.ToInt32(Request.Cookies["syfYildiz_" + ViewState["filmID"].ToString()]["Yildiz"].ToString());

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

            cmdKomut = new SqlCommand("Update film_Filmler SET Inceleme = '" + sayi.ToString() + "' Where URL = '" + segmentler[0] + "'", dbBag);
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

        protected void btnYorumYap_Click(object sender, EventArgs e)
        {
            if (txtYorum.Text != "" && txtYorumAdi.Text != "" && txtYorumEmail.Text != "")
            {
                try
                {
                    cmdKomut = new SqlCommand("Insert Into film_Yorumlar(Email,Nick,Yorum,YorumOnay,FilmID,YorumTarih) Values(@Email,@Nick,@Yorum,@YorumOnay,@FilmID,@YorumTarih)", dbBag);
                    cmdKomut.Parameters.Add("@Email", SqlDbType.NVarChar);
                    cmdKomut.Parameters["@Email"].Value = HTMLTemizle(txtYorumEmail.Text);

                    cmdKomut.Parameters.Add("@Nick", SqlDbType.NVarChar);
                    cmdKomut.Parameters["@Nick"].Value = HTMLTemizle(txtYorumAdi.Text);

                    cmdKomut.Parameters.Add("@Yorum", SqlDbType.NVarChar);
                    cmdKomut.Parameters["@Yorum"].Value = HTMLTemizle(txtYorum.Text);

                    cmdKomut.Parameters.Add("@YorumOnay", SqlDbType.NVarChar);
                    cmdKomut.Parameters["@YorumOnay"].Value = "0";

                    cmdKomut.Parameters.Add("@FilmID", SqlDbType.NVarChar);
                    cmdKomut.Parameters["@FilmID"].Value = ViewState["filmID"].ToString();

                    cmdKomut.Parameters.Add("@YorumTarih", SqlDbType.NVarChar);
                    cmdKomut.Parameters["@YorumTarih"].Value = DateTime.Now.ToString();

                    cmdKomut.ExecuteNonQuery();

                    ltrYorum.Text = "Yorumunuz kayıt edildi. Yönetici onayından sonra yayınlanacak.";
                }
                catch (Exception)
                {
                    ltrYorum.Text = "Yorumunuzu kayıt ederken hata oluştu. Tekrar deneyin.";
                    throw;
                }
            }
            else
            {
                ltrYorum.Text = "Hata! Lütfen tüm alanları doldurun.";
            }

            
        }

        public static string HTMLTemizle(string text)
        {
            return Regex.Replace(text, @"<(.|\n)*?>", string.Empty);
        }

        public string zaman(DateTime zamanarasi)
        {
            TimeSpan zamanfarki = DateTime.Now - zamanarasi;
            int saniye = Convert.ToInt32(Math.Round(zamanfarki.TotalSeconds));
            int dakika = Convert.ToInt32(Math.Round(zamanfarki.TotalSeconds / 60));
            int saat = Convert.ToInt32(Math.Round(zamanfarki.TotalSeconds / 3600));
            int gun = Convert.ToInt32(Math.Round(zamanfarki.TotalSeconds / 86400));
            int hafta = Convert.ToInt32(Math.Round(zamanfarki.TotalSeconds / 604800));
            int ay = Convert.ToInt32(Math.Round(zamanfarki.TotalSeconds / 2419200));
            int yil = Convert.ToInt32(Math.Round(zamanfarki.TotalSeconds / 29030400));

            if (saniye <= 59)

                if (saniye == 0)
                {
                    return "Şimdi Yazıldı";
                }
                else
                {
                    return saniye + " saniye önce";
                }

            else if (dakika <= 59)

                return dakika + " dakika önce";
            else if (saat <= 23)
                return saat + " saat önce";
            else if (gun <= 6)
                return gun + " gün önce";
            else if (ay <= 11)
                return ay + " ay önce";
            else
                return yil + " yıl önce";

        }

        protected void btnAnladim_Click(object sender, EventArgs e)
        {
            Response.Redirect(Request.Url.ToString());
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

        protected void rptPartlar_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName ==  "partgetir")
            {
                Literal literal = (Literal)rptfilm.Items[0].FindControl("ltrIframe");
                Button btn = (Button)e.Item.FindControl("btnPart");
                btn.CssClass += " scilenpart";

                cmdKomut = new SqlCommand("Select * From film_Partlar Where ID = '" + e.CommandArgument.ToString() + "'", dbBag);
                dtrData = cmdKomut.ExecuteReader();
                if (dtrData.Read())
                {
                    literal.Text = dtrData["Iframe"].ToString();
                }
                dtrData.Close();

            }
        }
    }
}