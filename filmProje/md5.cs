using System;
using System.Security.Cryptography;
using System.Text;
using System.Web;

namespace filmProje
{
    public class md5 : IHttpModule
    {
        /// <summary>
        /// Buradaki temizleme kodunuzun Web.config dosyasında bu modülü
        /// ve kullanabilmek için IIS'de kaydettirmeniz gerekecektir. Daha fazla bilgi için
        /// şu bağlantıya gidin: https://go.microsoft.com/?linkid=8101007
        /// </summary>
        #region IHttpModule Members

        public void Dispose()
        {
            //yapılandırmanız gerekecektir.
        }

        public void Init(HttpApplication context)
        {
            // Aşağıda, LogRequest olayını nasıl işleyebileceğiniz ve ona ilişkin özel günlük kaydı uygulamasını nasıl sağlayacağınız
            // konusunda bir örnek verilmiştir
            context.LogRequest += new EventHandler(OnLogRequest);
        }

        #endregion

        public void OnLogRequest(Object source, EventArgs e)
        {
            //özel günlük kaydı mantığı buraya girilebilir
        }

        public string MD5Olustur(string input)
        {
            MD5 md5Hasher = MD5.Create();
            byte[] data = md5Hasher.ComputeHash(Encoding.Default.GetBytes(input));
            StringBuilder sBuilder = new StringBuilder();
            for (int i = 0; i < data.Length; i++)
            {
                sBuilder.Append(data[i].ToString("x2"));
            }
            return sBuilder.ToString();
        }
    }
}
