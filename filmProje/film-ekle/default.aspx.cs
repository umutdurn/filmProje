using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace filmProje.film_ekle
{
    public partial class _default : System.Web.UI.Page
    {
        Veritabani baglan = new Veritabani();
        SqlConnection dbBag = new SqlConnection();
        SqlCommand cmdKomut;
        SqlDataReader dtrData;
        SqlDataAdapter dtrAdapt;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["ADMİN"] != null)
            {
                Response.Redirect("yonetim");
            }

            if (dbBag.State == ConnectionState.Closed)
            {
                dbBag = baglan.dbBaglanti();
            }
        }

        protected void btnGiris_Click(object sender, EventArgs e)
        {
            md5 sifrele = new md5();

            string email = txtEmail.Text.Replace("'", "");
            string parola = sifrele.MD5Olustur(txtParola.Text);

            cmdKomut = new SqlCommand("Select * From film_Kullanici Where Email=@Email and Parola=@Parola and Admin = '1'", dbBag);

            cmdKomut.Parameters.Add("@Email", SqlDbType.NVarChar);
            cmdKomut.Parameters["@Email"].Value = email;

            cmdKomut.Parameters.Add("@Parola", SqlDbType.NVarChar);
            cmdKomut.Parameters["@Parola"].Value = parola;

            dtrData = cmdKomut.ExecuteReader();
            if (dtrData.Read())
            {
                Session["ADMİN"] = "Giriş";
                Response.Redirect("yonetim");
            }
            else
            {
                lblGirisHata.Text = "Bilgileriniz hatalı.";
            }
            dtrData.Close();
        }
    }
}