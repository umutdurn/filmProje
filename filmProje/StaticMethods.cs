using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Text.RegularExpressions;

/// <summary>
/// Summary description for StaticMethods
/// </summary>
public static class StaticMethods
{
    public const string SatirSonu = "<br />";

    public static bool IsNullOrEmpty(this string str)
    {
        return string.IsNullOrEmpty(str);
    }

    public static string ToClearText(this string str)
    {
        return Regex.Replace(str, @"<(.|\n)*?>", string.Empty).Trim();
    }

    public static string ToTemizMetin(this string s)
    {
        s = ToTemizMetin(s, false);
        return s;
    }

    public static string ToTemizMetin(this string s, bool satirSonu)
    {
        s = s.Replace("<", "&lt;");
        s = s.Replace(">", "&gt;");
        s = s.Replace("script", "scr_ipt");
        s = s.Replace("'", "`");
        s = s.Replace("\"", "`");

        if (satirSonu)
        {
            s = s.Replace("\n", "");
            s = s.Replace("\r", SatirSonu);
        }
        s = s.Trim();
        return s;
    }

    public static string BR2Space(this string s)
    {
        s = s.Replace(SatirSonu, " ");
        return s;
    }
}