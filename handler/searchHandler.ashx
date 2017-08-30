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
        string result = "";

        if (method == "searchProjectHot")
        {
            result = searchProjectHot();
        }

        if (method == "searchProject")
        {
            string industry_id = context.Request["industry_id"];
            string param = context.Request["param"];
            if (industry_id == null) industry_id = "";
            if (param == null) param = "";
            result = searchProject(industry_id, param);
        }

        if (method == "searchIndustry")
        {
            result = searchIndustry();
        }


        context.Response.Write(result);
    }

    public string searchProjectHot()
    {
        DataTable dt = new DataTable();
        dt = new BLL.BLL_project().getHotProject(10);
        string jsonStr = Dtb2Json(dt);
        return jsonStr;
    }

    public string searchProject(string industry_id, string param)
    {
        DataTable dt = new DataTable();
        dt = new BLL.BLL_project().getProjectBySort(20, industry_id, param);
        string jsonStr = Dtb2Json(dt);
        return jsonStr;
    }

    public string searchIndustry()
    {
        DataTable dt = new DataTable();
        dt = new BLL.BLL_industry().getSort();
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