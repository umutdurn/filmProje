using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace filmProje.film_ekle.adminModuller
{
    public partial class yorumlar : System.Web.UI.UserControl
    {
        Veritabani baglan = new Veritabani();
        SqlConnection dbBag = new SqlConnection();
        SqlCommand cmdKomut;
        SqlDataReader dtrData;
        SqlDataAdapter dtrAdapt;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (dbBag.State == ConnectionState.Closed)
            {
                dbBag = baglan.dbBaglanti();
            }

            if (!IsPostBack)
            {
                filmGetir();
            }
        }

        protected void filmGetir() {

            dtrAdapt = new SqlDataAdapter("Select * From film_Filmler Order By ID Desc",dbBag);
            DataTable dttable = new DataTable();
            dtrAdapt.Fill(dttable);

            CollectionPager1.DataSource = dttable.DefaultView;
            CollectionPager1.BindToControl = rptFilmler;

            rptFilmler.DataSource = CollectionPager1.DataSourcePaged;
            rptFilmler.DataBind();
        }

        protected void CheckBox1_CheckedChanged(object sender, EventArgs e)
        {
            CheckBox c = (CheckBox)sender;
            RepeaterItem i = (RepeaterItem)c.Parent;

            CheckBox chb = (CheckBox)i.FindControl("chckSlider");
            HiddenField hdd = (HiddenField)i.FindControl("hddID");

            if (chb.Checked)
            {
                cmdKomut = new SqlCommand("Update film_Filmler SET Slider = '1' Where ID = '" + hdd.Value + "'", dbBag);
                cmdKomut.ExecuteNonQuery();
            }
            else
            {
                cmdKomut = new SqlCommand("Update film_Filmler SET Slider = NULL Where ID = '" + hdd.Value + "'", dbBag);
                cmdKomut.ExecuteNonQuery();
            }

            filmGetir();
        }
    }
}