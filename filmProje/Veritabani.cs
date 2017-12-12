using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace filmProje
{
    public class Veritabani
    {
        public string baglantiCumlesi = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;
        public SqlConnection dbBaglan;

        public SqlConnection dbBaglanti()
        {

            dbBaglan = new SqlConnection(baglantiCumlesi);
            dbBaglan.Open();

            return dbBaglan;

        }
    }
}