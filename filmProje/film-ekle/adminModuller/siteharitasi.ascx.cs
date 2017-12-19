using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;

namespace filmProje.film_ekle.adminModuller
{
    public partial class siteharitasi : System.Web.UI.UserControl
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
        }

        protected void btnSitemap_Click(object sender, EventArgs e)
        {
            XmlWriter writer = XmlWriter.Create(Server.MapPath("../sitemap.xml"));

            writer.WriteStartDocument();
            writer.WriteStartElement("urlset", "http://www.sitemaps.org/schemas/sitemap/0.9");

            cmdKomut = new SqlCommand("Select * From film_Filmler", dbBag);
            dtrData = cmdKomut.ExecuteReader();
            while (dtrData.Read())
            {
                WriteTag("0.2", "Monthly", "http://" + Request.Url.Host + "/film/" + dtrData["URL"].ToString(), writer);
            }
            dtrData.Close();

            cmdKomut = new SqlCommand("Select * From film_Kategoriler", dbBag);
            dtrData = cmdKomut.ExecuteReader();
            while (dtrData.Read())
            {
                WriteTag("0.3", "Weekly", "http://" + Request.Url.Host + "/kategori/" + dtrData["URL"].ToString(), writer);
            }
            dtrData.Close();

            //WriteTag("0.6", "Yearly", "http://www.delshad.ir/Contact.aspx", writer);
            //WriteTag("0.8", "Monthly", "http://www.delshad.ir/About.aspx", writer);

            writer.WriteEndDocument();

            writer.Close();

            if (chckPingle.Checked)
            {
                try
                {
                    System.Net.WebRequest reqGoogle = System.Net.WebRequest.Create("http://www.google.com/webmasters/tools/ping?sitemap=" + HttpUtility.UrlEncode("http://" + Request.Url.Host + "/sitemap.xml"));
                    reqGoogle.GetResponse();
                }
                catch (WebException ex)
                {
                    lblHaritaHata.Text = "Hata:" + ex.Message.ToString() + " - Google sizi blocklamış olabilir.";
                }
            }

            
        }

        private void WriteTag(string Priority, string freq,
            string Navigation, XmlWriter MyWriter)
        {
            MyWriter.WriteStartElement("url");

            MyWriter.WriteStartElement("loc");
            MyWriter.WriteValue(Navigation);
            MyWriter.WriteEndElement();

            MyWriter.WriteStartElement("changefreq");
            MyWriter.WriteValue(freq);
            MyWriter.WriteEndElement();

            MyWriter.WriteStartElement("priority");
            MyWriter.WriteValue(Priority);
            MyWriter.WriteEndElement();

            MyWriter.WriteEndElement();
        }
    }
}