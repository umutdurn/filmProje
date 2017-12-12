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
            }
        }

        protected void filmlerGetir() {

            dtrAdapt = new SqlDataAdapter("Select * From film_Filmler",dbBag);
            dtrAdapt.Fill(dtTable);

            CollectionPager1.DataSource = dtTable.DefaultView;
            CollectionPager1.BindToControl = filmler;

            filmler.DataSource = CollectionPager1.DataSourcePaged;
            filmler.DataBind();
        
        }
    }
}