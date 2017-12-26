using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI.HtmlControls;
using System.Web.UI;

/// <summary>
/// Summary description for MetaTagGenerator
/// </summary>
public class MetaTagGenerator
{
    const string twitterAccount = "@serifilmizler";
    Page page = null;

    public MetaTagGenerator()
    {
        this.page = HttpContext.Current.CurrentHandler as Page;
    }

    public MetaTagGenerator(MetaTagInfo metaTagInfo)
        : this()
    {
        Generate(metaTagInfo);
    }

    public void Generate(MetaTagInfo metaTagInfo)
    {
        if (metaTagInfo != null)
        {
            string[] twitterMetas = { "url", "title", "description", "image" };

            page.Header.Controls.Add(new LiteralControl("\n"));

            HtmlMeta meta = new HtmlMeta();
            meta.Attributes["name"] = "twitter:site";
            meta.Attributes["content"] = twitterAccount;
            page.Header.Controls.Add(meta);
            page.Header.Controls.Add(new LiteralControl("\n"));

            meta = new HtmlMeta();
            meta.Attributes["name"] = "twitter:card";
            meta.Attributes["content"] = "summary";
            page.Header.Controls.Add(meta);
            page.Header.Controls.Add(new LiteralControl("\n"));

            foreach (var item in metaTagInfo.GetType().GetProperties())
            {
                var _item = item.GetValue(metaTagInfo, null);
                if (_item == null) continue;
                var bilgi = _item.ToString();
                if (!bilgi.IsNullOrEmpty())
                {
                    var name = string.Format("{0}", item.Name.ToLowerInvariant());
                    if (twitterMetas.Contains(name))
                    {
                        meta = new HtmlMeta();
                        meta.Attributes["name"] = string.Format("twitter:{0}", name); ;
                        meta.Attributes["content"] = bilgi.ToClearText().ToTemizMetin();
                        page.Header.Controls.Add(meta);
                        page.Header.Controls.Add(new LiteralControl("\n"));
                    }
                }
            }

            foreach (var item in metaTagInfo.GetType().GetProperties())
            {
                var _item = item.GetValue(metaTagInfo, null);
                if (_item == null) continue;
                var bilgi = _item.ToString();
                if (!bilgi.IsNullOrEmpty())
                {
                    var name = string.Format("{0}", item.Name.ToLowerInvariant());
                    meta = new HtmlMeta();
                    meta.Attributes["property"] = string.Format("og:{0}", name); ;
                    meta.Attributes["content"] = bilgi.ToClearText().ToTemizMetin();
                    page.Header.Controls.Add(meta);
                    page.Header.Controls.Add(new LiteralControl("\n"));
                }
            }
        }
    }
}