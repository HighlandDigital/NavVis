<%@ WebHandler Language="C#" Class="VisitHandler" %>

using System;
using System.Web;

public class VisitHandler : IHttpHandler {

    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";


        string method = context.Request["m"];
        string result = "";

        if (method == "add")
        {
                string poiid = context.Request["poi"];
            string ivid = context.Request["ivid"];

            bool res = new BLL.BLL_visit().add(poiid, ivid);

        }

        context.Response.Write(result);
    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}