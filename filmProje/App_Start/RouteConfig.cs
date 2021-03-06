using System;
using System.Collections.Generic;
using System.Web;
using System.Web.Routing;
using System.Web.UI;
using Microsoft.AspNet.FriendlyUrls;

namespace filmProje
{
    public static class RouteConfig
    {
        public static void RegisterRoutes(RouteCollection routes)
        {
            var settings = new FriendlyUrlSettings();
            settings.AutoRedirectMode = RedirectMode.Permanent;
            routes.EnableFriendlyUrls(settings);
        }

    }
}
