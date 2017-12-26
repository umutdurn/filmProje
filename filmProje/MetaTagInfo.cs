using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for MetaTagInfo
/// </summary>
[Serializable]
public class MetaTagInfo
{
    public string Description { get; set; }
    public string Image { get; set; }
    public string Site_Name { get; set; }
    public string Title { get; set; }
    public string Type { get; set; }
    public string Url { get; set; }
}