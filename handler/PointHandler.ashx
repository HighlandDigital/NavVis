<%@ WebHandler Language="C#" Class="PointHandler" %>

using System;
using System.Web;

public class PointHandler : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";


        string method = context.Request["ac"];
        string result = "";

        if (method == "init")
        {
            int pagesize = 0;
            pagesize=int.Parse(context.Request["page"]);

            result = new BLL.BLL_point().getList(pagesize,10,"","");

        }

        if (method == "search")
        {
            int pagesize = 0;
            pagesize = int.Parse(context.Request["page"]);

            result = new BLL.BLL_point().getList(pagesize, 10, context.Request["title"], context.Request["description"]);

        }

        if (method == "sumit")
        {
            int id = 0;
            id=int.Parse(context.Request["id"]);
            string iv_id = context.Request["iv_id"];
            string title = context.Request["title"];
            string title_en = context.Request["title_en"];
            string title_img_url = context.Request["title_img_url"];
            string description = context.Request["description"];
            string description_en = context.Request["description_en"];
            string description_mod = context.Request["description_mod"];
            string description_en_mod = context.Request["description_en_mod"];           
            bool locked = false;
            string strlocked = context.Request["locked"];
            if (strlocked=="1")
                locked = true;

            string iv_img_url = context.Request["iv_img_url"];
            if(id==0)
            {//添加
                result = new BLL.BLL_point().addPoint(iv_id, title, title_en, title_img_url, description, description_en, locked);
            }
            else
            {//修改

                result = new BLL.BLL_point().edit(id, iv_id, title, title_en, title_img_url, description, description_mod, description_en, description_en_mod, locked);
            }
        }

        if (method == "create")
        {
            string strid = context.Request["id"];

            result = new BLL.BLL_point().recreate(strid);
        
        }

        if (method == "load")
        {
            int id = 0;
            id = int.Parse(context.Request["id"]);
            result = new BLL.BLL_point().getPointByID(id);
        }

        if (method == "del")
        {
            int id = 0;
            id = int.Parse(context.Request["id"]);
            result = new BLL.BLL_point().delPointByID(id);
        }
        if (method == "industry")
        {
            //加载热点类别下拉框
            result = new BLL.BLL_point().Loadindustry();
        }
        
        
        context.Response.Write(result);
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}