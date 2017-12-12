using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using filmProje;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Collections;

namespace filmProje.film_ekle.adminModuller
{

    public partial class film_ekle : System.Web.UI.UserControl
    {
        Veritabani baglan = new Veritabani();
        SqlConnection dbBag = new SqlConnection();
        SqlCommand cmdKomut;
        SqlDataReader dtrData;
        SqlDataAdapter dtrAdapt;
        DataTable dtYonetmenler = new DataTable();
        DataTable dtOyuncular = new DataTable();
        DataTable dtPartlar = new DataTable();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (dbBag.State == ConnectionState.Closed)
            {
                dbBag = baglan.dbBaglanti();
            }

            if (!IsPostBack)
            {
                chckKategoriler.DataBind();

                yonetmenOlustur();
                oyuncuOlustur();
                partOlustur();

                if (Request["duzenle"] != null)
                {
                    partCek();
                    duzenleGetir();
                }
            }
        }

        //Düzenle Çek
        protected void duzenleGetir() {

            string Baslik = "", Icerik = "", Poster = "", Oyuncular = "", MetaDesc = "", URL = "", Kategoriler = "", YapimYili = "", IMDB = "", Yonetmenler = "", Ulke = "", Sure = "", OrjinalAdi = "";

            //Verileri Çek
            cmdKomut = new SqlCommand("Select * From film_Filmler Where ID = '" + Request["duzenle"] + "'", dbBag);
            dtrData = cmdKomut.ExecuteReader();
            if (dtrData.Read())
            {
                Baslik = dtrData["Baslik"].ToString();
                Icerik = dtrData["Icerik"].ToString();
                Poster = dtrData["Poster"].ToString();
                Oyuncular = dtrData["Oyuncular"].ToString();
                MetaDesc = dtrData["MetaDesc"].ToString();
                URL = dtrData["URL"].ToString();
                Kategoriler = dtrData["Kategoriler"].ToString();
                YapimYili = dtrData["YapimYili"].ToString();
                IMDB = dtrData["IMDB"].ToString();
                Yonetmenler = dtrData["Yonetmenler"].ToString();
                Ulke = dtrData["Ulke"].ToString();
                Sure = dtrData["Sure"].ToString();
                OrjinalAdi = dtrData["OrjinalAdi"].ToString();
            }
            dtrData.Close();

            //Verileri Göster
            txtFilmBasligi.Text = Baslik;
            txtEditor.Text = Icerik;
            ViewState["Poster"] = Poster;
            oyuncuDCek(Oyuncular);
            txtMetaDesc.Text = MetaDesc;
            txtFilmURl.Text = URL;
            kategoriDCek(Kategoriler);
            txtYapimYili.Text = YapimYili;
            txtIMDB.Text = IMDB.Replace(",",".");
            yonetmenDCek(Yonetmenler);
            dropUlkeler.SelectedValue = Ulke;
            txtFilmSuresi.Text = Sure;
            txtOrjinalAdi.Text = OrjinalAdi;
        
        }

        protected void kategoriDCek(string kategoriler) {

            string[] kategori = kategoriler.Split(',');

            foreach (ListItem item in chckKategoriler.Items)
            {
                for (int i = 0; i < kategori.Length; i++)
                {
                    if (item.Value == kategori[i])
                    {
                        item.Selected = true;
                    }
                }
            }
        
        }

        protected void yonetmenDCek(string yonetmenler)
        {

            string[] yonetmen = yonetmenler.Split(',');

            for (int i = 0; i < yonetmen.Length; i++)
            {
                cmdKomut = new SqlCommand("Select * From film_Yonetmenler Where ID = '" + yonetmen[i] + "'", dbBag);
                dtrData = cmdKomut.ExecuteReader();
                if (dtrData.Read())
                {
                    dtYonetmenler.Rows.Add(dtrData["ID"].ToString(), dtrData["Yonetmen"].ToString(), dtrData["YonetmenURL"].ToString());
                }
                dtrData.Close();
            }

            ViewState["Yonetmenler"] = dtYonetmenler;
            rptYonetmenler.DataSource = dtYonetmenler;
            rptYonetmenler.DataBind();

        }

        protected void oyuncuDCek(string oyuncular) {

            string[] oyuncu = oyuncular.Split(',');

            for (int i = 0; i < oyuncu.Length; i++)
            {
                cmdKomut = new SqlCommand("Select * From film_Oyuncular Where ID = '" + oyuncu[i] + "'", dbBag);
                dtrData = cmdKomut.ExecuteReader();
                if (dtrData.Read())
                {
                    dtOyuncular.Rows.Add(dtrData["ID"].ToString(), dtrData["Oyuncu"].ToString(), dtrData["OyuncuURL"].ToString());
                }
                dtrData.Close();
            }

            ViewState["Oyuncular"] = dtOyuncular;
            rptOyuncular.DataSource = dtOyuncular;
            rptOyuncular.DataBind();

        }

        //Ekleme
        protected void btnKaydet_Click(object sender, EventArgs e)
        {
            string komut = "";
            string poster = "";
            string yonetmenler = yonetmenGetir();
            string oyuncular = oyuncuGetir();

            if (Request["duzenle"] == null)
            {
                komut = "Insert Into film_Filmler(Baslik,Icerik,Poster,Oyuncular,MetaDesc,URL,Kategoriler,YapimYili,IMDB,Yonetmenler,Ulke,Sure,OrjinalAdi,OlusturmaTarihi) Values" +
                        "(@Baslik,@Icerik,@Poster,@Oyuncular,@MetaDesc,@URL,@Kategoriler,@YapimYili,@IMDB,@Yonetmenler,@Ulke,@Sure,@OrjinalAdi,@OlusturmaTarihi) select scope_identity();";

                if (filePoster.HasFile)
                {
                    poster = urlOlustur(Path.GetFileNameWithoutExtension(filePoster.PostedFile.FileName)) + Path.GetExtension(filePoster.PostedFile.FileName);
                    filePoster.SaveAs(Server.MapPath("~/images/upload/") + poster);
                }
                else
                {
                    poster = "resimyok.jpg";
                }
            }
            else
            {
                komut = "Update film_Filmler SET Baslik=@Baslik,Icerik=@Icerik,Poster=@Poster,Oyuncular=@Oyuncular,MetaDesc=@MetaDesc,URL=@URL,Kategoriler=@Kategoriler,YapimYili=@YapimYili,IMDB=@IMDB,Yonetmenler=@Yonetmenler,Ulke=@Ulke,Sure=@Sure,OrjinalAdi=@OrjinalAdi Where ID = '" + Request["duzenle"] + "'";

                if (filePoster.HasFile)
                {
                    poster = urlOlustur(Path.GetFileNameWithoutExtension(filePoster.PostedFile.FileName)) + Path.GetExtension(filePoster.PostedFile.FileName);
                    filePoster.SaveAs(Server.MapPath("~/images/upload/") + poster);
                }
                else
                {
                    poster = ViewState["Poster"].ToString();
                }
            }

            cmdKomut = new SqlCommand(komut,dbBag);

            //Parametreler
            cmdKomut.Parameters.Add("@Baslik", SqlDbType.NVarChar);
            cmdKomut.Parameters["@Baslik"].Value = txtFilmBasligi.Text;

            cmdKomut.Parameters.Add("@Icerik", SqlDbType.NVarChar);
            cmdKomut.Parameters["@Icerik"].Value = txtEditor.Text;

            cmdKomut.Parameters.Add("@Poster", SqlDbType.NVarChar);
            cmdKomut.Parameters["@Poster"].Value = poster;

            cmdKomut.Parameters.Add("@Oyuncular", SqlDbType.NVarChar);
            cmdKomut.Parameters["@Oyuncular"].Value = oyuncular;

            cmdKomut.Parameters.Add("@MetaDesc", SqlDbType.NVarChar);
            cmdKomut.Parameters["@MetaDesc"].Value = txtMetaDesc.Text;

            cmdKomut.Parameters.Add("@URL", SqlDbType.NVarChar);
            cmdKomut.Parameters["@URL"].Value = txtFilmURl.Text;

            string kategoriler = "";

            foreach (ListItem item in chckKategoriler.Items)
            {
                if (item.Selected)
                {
                    kategoriler += item.Value + ",";
                }
            }

            cmdKomut.Parameters.Add("@Kategoriler", SqlDbType.NVarChar);
            cmdKomut.Parameters["@Kategoriler"].Value = kategoriler;

            cmdKomut.Parameters.Add("@YapimYili", SqlDbType.NVarChar);
            cmdKomut.Parameters["@YapimYili"].Value = txtYapimYili.Text;

            cmdKomut.Parameters.Add("@IMDB", SqlDbType.NVarChar);
            cmdKomut.Parameters["@IMDB"].Value = txtIMDB.Text;

            cmdKomut.Parameters.Add("@Yonetmenler", SqlDbType.NVarChar);
            cmdKomut.Parameters["@Yonetmenler"].Value = yonetmenler;

            cmdKomut.Parameters.Add("@Ulke", SqlDbType.NVarChar);
            cmdKomut.Parameters["@Ulke"].Value = dropUlkeler.SelectedValue;

            cmdKomut.Parameters.Add("@Sure", SqlDbType.NVarChar);
            cmdKomut.Parameters["@Sure"].Value = txtFilmSuresi.Text;

            cmdKomut.Parameters.Add("@OrjinalAdi", SqlDbType.NVarChar);
            cmdKomut.Parameters["@OrjinalAdi"].Value = txtOrjinalAdi.Text;

            string id = "";

            if (Request["duzenle"] == null)
            {
                cmdKomut.Parameters.Add("@OlusturmaTarihi", SqlDbType.Date);
                cmdKomut.Parameters["@OlusturmaTarihi"].Value = DateTime.Now;

                id = cmdKomut.ExecuteScalar().ToString();
            }
            else
            {
                cmdKomut.ExecuteNonQuery();
                id = Request["duzenle"];
            }

            partKayit(id);
    
            Response.Redirect("yonetim?pnl=filmekle&duzenle=" + id);

        }

        bool IsNumeric(string text)
        {
            foreach (char chr in text)
            {
                if (!Char.IsNumber(chr)) return false;
            }
            return true;
        }

        protected void yonetmenOlustur()
        {

            dtYonetmenler.Columns.Add("ID", typeof(string));
            dtYonetmenler.Columns.Add("Yonetmen", typeof(string));
            dtYonetmenler.Columns.Add("YonetmenURL", typeof(string));

            ViewState["Yonetmenler"] = dtYonetmenler;

        }

        protected string yonetmenGetir() {

            string yonetmenler = "";

            dtYonetmenler = (DataTable)ViewState["Yonetmenler"];

            for (int i = 0; i < dtYonetmenler.Rows.Count; i++)
            {
                bool numara = IsNumeric(dtYonetmenler.Rows[i]["ID"].ToString());

                if (numara == true)
                {
                    cmdKomut = new SqlCommand("Select * From film_Yonetmenler Where ID = '" + dtYonetmenler.Rows[i]["ID"] + "'", dbBag);
                    dtrData = cmdKomut.ExecuteReader();
                    if (dtrData.Read())
                    {
                        yonetmenler += dtrData["ID"].ToString() + ",";
                        dtrData.Close();
                    }
                    else
                    {
                        dtrData.Close();

                        cmdKomut = new SqlCommand("Insert Into film_Yonetmenler(Yonetmen, YonetmenURL) Values(@Yonetmen,@YonetmenURL) select scope_identity();", dbBag);
                        cmdKomut.Parameters.AddWithValue("@Yonetmen", dtYonetmenler.Rows[i]["Yonetmen"]);
                        cmdKomut.Parameters.AddWithValue("@YonetmenURL", dtYonetmenler.Rows[i]["YonetmenURL"]);

                        string yonetmenID = cmdKomut.ExecuteScalar().ToString();

                        yonetmenler += yonetmenID + ",";
                    }
                }
                else
                {
                    cmdKomut = new SqlCommand("Select * From film_Yonetmenler Where YonetmenURL = '" + dtYonetmenler.Rows[i]["YonetmenURL"] + "'", dbBag);
                    dtrData = cmdKomut.ExecuteReader();
                    if (dtrData.Read())
                    {
                        yonetmenler += dtrData["ID"].ToString() + ",";
                        dtrData.Close();
                    }
                    else
                    {
                        dtrData.Close();
                        cmdKomut = new SqlCommand("Insert Into film_Yonetmenler(Yonetmen, YonetmenURL) Values(@Yonetmen,@YonetmenURL) select scope_identity();", dbBag);
                        cmdKomut.Parameters.AddWithValue("@Yonetmen", dtYonetmenler.Rows[i]["Yonetmen"]);
                        cmdKomut.Parameters.AddWithValue("@YonetmenURL", dtYonetmenler.Rows[i]["YonetmenURL"]);

                        string yonetmenID = cmdKomut.ExecuteScalar().ToString();

                        yonetmenler += yonetmenID + ",";
                    }
                    
                }

            }

            return yonetmenler;
        }

        protected string oyuncuGetir()
        {

            string oyuncular = "";

            dtOyuncular = (DataTable)ViewState["Oyuncular"];

            for (int i = 0; i < dtOyuncular.Rows.Count; i++)
            {
                bool numara = IsNumeric(dtOyuncular.Rows[i]["ID"].ToString());

                if (numara == true)
                {
                    cmdKomut = new SqlCommand("Select * From film_Oyuncular Where ID = '" + dtOyuncular.Rows[i]["ID"] + "'", dbBag);
                    dtrData = cmdKomut.ExecuteReader();
                    if (dtrData.Read())
                    {
                        oyuncular += dtrData["ID"].ToString() + ",";
                        dtrData.Close();
                    }
                    else
                    {
                        dtrData.Close();

                        cmdKomut = new SqlCommand("Insert Into film_Oyuncular(Oyuncu, OyuncuURL) Values(@Oyuncu,@OyuncuURL) select scope_identity();", dbBag);
                        cmdKomut.Parameters.AddWithValue("@Oyuncu", dtOyuncular.Rows[i]["Oyuncu"]);
                        cmdKomut.Parameters.AddWithValue("@OyuncuURL", dtOyuncular.Rows[i]["OyuncuURL"]);

                        string OyuncuID = cmdKomut.ExecuteScalar().ToString();

                        oyuncular += OyuncuID + ",";
                    }
                }
                else
                {
                     cmdKomut = new SqlCommand("Select * From film_Oyuncular Where OyuncuURL = '" + dtOyuncular.Rows[i]["OyuncuURL"] + "'", dbBag);
                     dtrData = cmdKomut.ExecuteReader();
                     if (dtrData.Read())
                     {
                         oyuncular += dtrData["ID"].ToString() + ",";
                         dtrData.Close();
                     }
                     else
                     {
                         dtrData.Close();
                         cmdKomut = new SqlCommand("Insert Into film_Oyuncular(Oyuncu, OyuncuURL) Values(@Oyuncu,@OyuncuURL) select scope_identity();", dbBag);
                         cmdKomut.Parameters.AddWithValue("@Oyuncu", dtOyuncular.Rows[i]["Oyuncu"]);
                         cmdKomut.Parameters.AddWithValue("@OyuncuURL", dtOyuncular.Rows[i]["OyuncuURL"]);

                         string OyuncuID = cmdKomut.ExecuteScalar().ToString();

                         oyuncular += OyuncuID + ",";
                     }
                    
                }

            }

            return oyuncular;
        }

        protected void oyuncuOlustur()
        {

            dtOyuncular.Columns.Add("ID", typeof(string));
            dtOyuncular.Columns.Add("Oyuncu", typeof(string));
            dtOyuncular.Columns.Add("OyuncuURL", typeof(string));

            ViewState["Oyuncular"] = dtOyuncular;

        }

        public string urlOlustur(string gelen)
        {

            string donen = gelen.ToLower();

            donen = donen.Replace("!", "");
            donen = donen.Replace("'", "");
            donen = donen.Replace("^", "");
            donen = donen.Replace("+", "");
            donen = donen.Replace("%", "");
            donen = donen.Replace("&", "");
            donen = donen.Replace("/", "");
            donen = donen.Replace("(", "");
            donen = donen.Replace(")", "");
            donen = donen.Replace("=", "");
            donen = donen.Replace("?", "");
            donen = donen.Replace("_", "-");
            donen = donen.Replace(" ", "-");
            donen = donen.Replace("*", "");
            donen = donen.Replace(".", "");
            donen = donen.Replace(">", "");
            donen = donen.Replace("£", "");
            donen = donen.Replace("#", "");
            donen = donen.Replace("$", "");
            donen = donen.Replace("½", "");
            donen = donen.Replace("|", "-");
            donen = donen.Replace("{", "");
            donen = donen.Replace("}", "");
            donen = donen.Replace("[", "");
            donen = donen.Replace("]", "");
            donen = donen.Replace("\\", "");
            donen = donen.Replace("ğ", "g");
            donen = donen.Replace("ü", "u");
            donen = donen.Replace("ş", "s");
            donen = donen.Replace("ö", "o");
            donen = donen.Replace("ç", "c");
            donen = donen.Replace(":", "-");
            donen = donen.Replace("ı", "i");

            return donen;

        }

        protected void btnYonetmenKayit_Click(object sender, EventArgs e)
        {
            string url = urlOlustur(txtYonetmenler.Text);

            dtYonetmenler = (DataTable)ViewState["Yonetmenler"];

            dtYonetmenler.Rows.Add(url, txtYonetmenler.Text, url);

            ViewState["Yonetmenler"] = dtYonetmenler;

            rptYonetmenler.DataSource = dtYonetmenler;
            rptYonetmenler.DataBind();

            txtYonetmenler.Text = "";
            txtYonetmenler.Focus();
        }

        protected void btnOyuncuKayit_Click(object sender, EventArgs e)
        {
            string url = urlOlustur(txtOyuncular.Text);

            dtOyuncular = (DataTable)ViewState["Oyuncular"];

            dtOyuncular.Rows.Add(url, txtOyuncular.Text, url);

            ViewState["Oyuncular"] = dtOyuncular;

            rptOyuncular.DataSource = dtOyuncular;
            rptOyuncular.DataBind();

            txtOyuncular.Text = "";
            txtOyuncular.Focus();
        }

        protected void rptYonetmenler_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "sil")
            {
                dtYonetmenler = (DataTable)ViewState["Yonetmenler"];

                for (int i = dtYonetmenler.Rows.Count - 1; i >= 0; i--)
                {
                    string esleme = dtYonetmenler.Rows[i]["ID"].ToString();

                    if (esleme == e.CommandArgument.ToString())
                    {

                        dtYonetmenler.Rows[i].Delete();

                    }
                }

                ViewState["Yonetmenler"] = dtYonetmenler;
                rptYonetmenler.DataSource = dtYonetmenler;
                rptYonetmenler.DataBind();
            }
        }

        protected void rptOyuncular_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "sil")
            {
                dtOyuncular = (DataTable)ViewState["Oyuncular"];

                for (int i = dtOyuncular.Rows.Count - 1; i >= 0; i--)
                {
                    string esleme = dtOyuncular.Rows[i]["ID"].ToString();

                    if (esleme == e.CommandArgument.ToString())
                    {

                        dtOyuncular.Rows[i].Delete();

                    }
                }

                ViewState["Oyuncular"] = dtOyuncular;
                rptOyuncular.DataSource = dtOyuncular;
                rptOyuncular.DataBind();
            }
        }

        protected void partOlustur()
        {
            dtPartlar.Columns.Add("ID", typeof(string));
            dtPartlar.Columns.Add("PartAdi", typeof(string));
            dtPartlar.Columns.Add("Iframe", typeof(string));
            dtPartlar.Columns.Add("FilmID", typeof(string));
            dtPartlar.Columns.Add("Kalitesi", typeof(string));
            dtPartlar.Columns.Add("Dil", typeof(string));

            ViewState["Partlar"] = dtPartlar;

        }

        protected void btnPartEkle_Click(object sender, EventArgs e)
        {
            dtPartlar = (DataTable)ViewState["Partlar"];

            dtPartlar.Rows.Add(urlOlustur(txtPartAdi.Text), txtPartAdi.Text, txtIframe.Text, "", dropKalite.SelectedValue, dropDil.SelectedValue);

            ViewState["Partlar"] = dtPartlar;

            rptPartlar.DataSource = dtPartlar;
            rptPartlar.DataBind();
        }

        protected void partCek() {

            dtrAdapt = new SqlDataAdapter("Select * From film_Partlar Where FilmID = '" + Request["duzenle"] + "'", dbBag);
            dtrAdapt.Fill(dtPartlar);

            ViewState["Partlar"] = dtPartlar;
            rptPartlar.DataSource = dtPartlar;
            rptPartlar.DataBind();
        }

        protected void partKayit(string filmid) {

            dtPartlar = (DataTable)ViewState["Partlar"];

            for (int i = 0; i < dtPartlar.Rows.Count; i++)
            {
                bool numara = IsNumeric(dtPartlar.Rows[i]["ID"].ToString());

                if (numara == true)
                {
                    cmdKomut = new SqlCommand("Select * From film_Partlar Where ID = '" + dtPartlar.Rows[i]["ID"] + "'", dbBag);
                    dtrData = cmdKomut.ExecuteReader();
                    if (dtrData.Read())
                    {
                        dtrData.Close();

                        cmdKomut = new SqlCommand("Update film_Partlar SET PartAdi=@PartAdi,Iframe=@Iframe,FilmID=@FilmID,Kalitesi=@Kalitesi,Dil=@Dil Where ID = '" + dtPartlar.Rows[i]["ID"] + "'", dbBag);
                        cmdKomut.Parameters.AddWithValue("@PartAdi", dtPartlar.Rows[i]["PartAdi"].ToString());
                        cmdKomut.Parameters.AddWithValue("@Iframe", dtPartlar.Rows[i]["Iframe"].ToString());
                        cmdKomut.Parameters.AddWithValue("@FilmID", filmid);
                        cmdKomut.Parameters.AddWithValue("@Kalitesi", dtPartlar.Rows[i]["Kalitesi"].ToString());
                        cmdKomut.Parameters.AddWithValue("@Dil", dtPartlar.Rows[i]["Dil"].ToString());
                        cmdKomut.ExecuteNonQuery();
                    }
                    else
                    {
                        dtrData.Close();

                        cmdKomut = new SqlCommand("Insert film_Partlar(PartAdi,Iframe,FilmID,Kalitesi,Dil) Values(@PartAdi,@Iframe,@FilmID,@Kalitesi,@Dil)", dbBag);
                        cmdKomut.Parameters.AddWithValue("@PartAdi", dtPartlar.Rows[i]["PartAdi"].ToString());
                        cmdKomut.Parameters.AddWithValue("@Iframe", dtPartlar.Rows[i]["Iframe"].ToString());
                        cmdKomut.Parameters.AddWithValue("@FilmID", filmid);
                        cmdKomut.Parameters.AddWithValue("@Kalitesi", dtPartlar.Rows[i]["Kalitesi"].ToString());
                        cmdKomut.Parameters.AddWithValue("@Dil", dtPartlar.Rows[i]["Dil"].ToString());
                        cmdKomut.ExecuteNonQuery();
                    }
                }
                else
                {
                    cmdKomut = new SqlCommand("Insert film_Partlar(PartAdi,Iframe,FilmID,Kalitesi,Dil) Values(@PartAdi,@Iframe,@FilmID,@Kalitesi,@Dil)", dbBag);
                    cmdKomut.Parameters.AddWithValue("@PartAdi", dtPartlar.Rows[i]["PartAdi"].ToString());
                    cmdKomut.Parameters.AddWithValue("@Iframe", dtPartlar.Rows[i]["Iframe"].ToString());
                    cmdKomut.Parameters.AddWithValue("@FilmID", filmid);
                    cmdKomut.Parameters.AddWithValue("@Kalitesi", dtPartlar.Rows[i]["Kalitesi"].ToString());
                    cmdKomut.Parameters.AddWithValue("@Dil", dtPartlar.Rows[i]["Dil"].ToString());
                    cmdKomut.ExecuteNonQuery();
                }
            }
        
        }

        protected void rptPartlar_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "sil")
            {
                dtPartlar = (DataTable)ViewState["Partlar"];

                for (int i = dtPartlar.Rows.Count - 1; i >= 0; i--)
                {
                    string esleme = dtPartlar.Rows[i]["ID"].ToString();

                    if (esleme == e.CommandArgument.ToString())
                    {

                        dtPartlar.Rows[i].Delete();

                    }
                }

                ViewState["Partlar"] = dtPartlar;
                rptPartlar.DataSource = dtPartlar;
                rptPartlar.DataBind();

                bool sonuc = IsNumeric(e.CommandArgument.ToString());

                if (sonuc == true)
                {
                    cmdKomut = new SqlCommand("Delete From film_Partlar Where ID = '" + e.CommandArgument + "'", dbBag);
                    cmdKomut.ExecuteNonQuery();
                }

                //partCek();
            }
        }

    }
}