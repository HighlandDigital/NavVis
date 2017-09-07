<%@ WebHandler Language="C#" Class="ProjectHandler" %>

using System;
using System.Web;

public class ProjectHandler : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";

        string method = context.Request["ac"];
        string result = "";
        if (method == "load")
        {

            result = new BLL.BLL_project().getProjectByIVID(context.Request["ivid"]);
        }
        if (method == "sumit")
        {
            int id = 0;
            try
            {
                id = int.Parse(context.Request["id"]);
            }
            catch
            {
                id = 0;
            }
            string iv_id = context.Request["iv_id"];
            string name = context.Request["title"];
            string name_en = context.Request["title_en"];
                string img_url = context.Request["img_url"];
            string description = context.Request["description"];
            bool ishot = false;
            string strishot = context.Request["ishot"];
            if (strishot=="1")
                ishot = true;
            int industry_id=0;
                industry_id = int.Parse(context.Request["industry_id"]);
            if (id == 0)
            {//添加
                result = new BLL.BLL_project().Add(name_en, name,img_url,  description,    iv_id,   ishot,   industry_id);
            }
            else
            {//修改
                result = new BLL.BLL_project().Update(id,  name_en, name,img_url,  description,  iv_id,   ishot,  industry_id);
            }
        }
        
        context.Response.Write(result);
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}