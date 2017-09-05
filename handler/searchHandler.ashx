<%@ WebHandler Language="C#" Class="searchHandler" %>

using System;
using System.Web;
using System.Data;
using System.Web.Script.Serialization;

public class searchHandler : IHttpHandler
{

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";

        string method = context.Request["method"];
            string lang = context.Request["lang"];
        string result = "";

        if (method == "searchProjectHot")
        {
            string pagesize = context.Request["pagesize"];
            int s = 0;
            int.TryParse(pagesize, out s);
            result = searchProjectHot(s);

        }

        if (method == "searchProject")
        {
            string pagesize = context.Request["pagesize"];
            int s = 0;
            int.TryParse(pagesize, out s);
            string industry_id = context.Request["industry_id"];
            string param = context.Request["param"];
            if (industry_id == null) industry_id = "";
            if (param == null) param = "";
            result = searchProject(s, industry_id, param);
        }

        if (method == "searchIndustry")
        {
            string pagesize = context.Request["pagesize"];
            int s = 0;
            int.TryParse(pagesize, out s);
            result = searchIndustry(s);
        }
        
        if (method == "searchPointByIVID")
        {
            string s = context.Request["ivid"];
            result = searchPointByIVID(s);
        }


        context.Response.Write(result);
    }

    public string searchProjectHot(int pagesize)
    {
        int size = 10;
        if (pagesize > 0) size = pagesize;
        DataTable dt = new DataTable();
        dt = new BLL.BLL_project().getHotProject(size);
        string jsonStr = Dtb2Json(dt);
        return jsonStr;
    }

    public string searchProject(int pagesize, string industry_id, string param)
    {
        int size = 10;
        if (pagesize > 0) size = pagesize;
        DataTable dt = new DataTable();
        dt = new BLL.BLL_project().getProjectBySort(size, industry_id, param);
        string jsonStr = Dtb2Json(dt);
        return jsonStr;
    }

    public string searchIndustry(int pagesize)
    {
        int size = 10;
        if (pagesize > 0) size = pagesize;
        DataTable dt = new DataTable();
        dt = new BLL.BLL_industry().getSort(size);
        string jsonStr = Dtb2Json(dt);
        return jsonStr;
    }

    public string searchPointByIVID(string ivid)
    {
        DataTable dt = new DataTable();
        dt = new BLL.BLL_point().getPointByIVID(ivid);
        string jsonStr = Dtb2Json(dt);
        return jsonStr;
    }

    /// 将datatable转换为json  
    /// </summary>
    /// <param name="dtb">Dt</param>
    /// <returns>JSON字符串</returns>
    public string Dtb2Json(DataTable dtb)
    {
        JavaScriptSerializer jss = new JavaScriptSerializer();
        System.Collections.ArrayList dic = new System.Collections.ArrayList();
        foreach (DataRow dr in dtb.Rows)
        {
            System.Collections.Generic.Dictionary<string, object> drow = new System.Collections.Generic.Dictionary<string, object>();
            foreach (DataColumn dc in dtb.Columns)
            {
                drow.Add(dc.ColumnName, dr[dc.ColumnName]);
            }
            dic.Add(drow);

        }
        //序列化  
        return jss.Serialize(dic);
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}