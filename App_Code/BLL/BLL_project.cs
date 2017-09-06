using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using Newtonsoft.Json;
using DAO;

namespace BLL
{
    /// <summary>
    /// BLL_project 的摘要说明
    /// </summary>
    public class BLL_project
    {
        public BLL_project()
        {
            //
            // TODO: 在此处添加构造函数逻辑
            //
        }

        public DataTable getHotProject(int number)
        {
            int count = 0;
            DataTable dt = new DAO_project().GetList(1, number, "", "", true, 0, 0, "hotorder asc", out count);
            return dt;
        }

        public DataTable getProjectBySort(int pageSize, string sort, string param)
        {
            int s = 0;
            int.TryParse(sort, out s);
            int count = 0;
            DataTable dt = new DAO_project().GetList(1, pageSize, param, param, false, 0, s, "name", out count);
            return dt;
        }

        public string getProjectByIVID(string IVID)
        {            
            DataTable dt = new DAO_project().GetByIVID(IVID);
            if (dt.Rows.Count > 0)
            {
                var send = new
                {
                    id = dt.Rows[0]["id"].ToString(),
                    iv_id = dt.Rows[0]["iv_id"] != null ? dt.Rows[0]["iv_id"].ToString() : "",
                    title = dt.Rows[0]["name"] != null ? dt.Rows[0]["name"].ToString() : "",
                    title_en = dt.Rows[0]["name_en"] != null ? dt.Rows[0]["name_en"].ToString() : "",
                    ishot = dt.Rows[0]["ishot"] != null ? dt.Rows[0]["ishot"].ToString() : "",
                    industry_id = dt.Rows[0]["industry_id"] != null ? dt.Rows[0]["industry_id"].ToString() : ""
                };
                return JsonConvert.SerializeObject(send);
            }
            else
            {
                var send = new
                {
                    msg = "操作失败！",
                    success = "false"
                };
                return JsonConvert.SerializeObject(send);
            }
        
        }

        public string Add(string name_en,string name, string description,   string iv_id,  bool ishot,  int industry_id)
        {

            string img_url="image/project/"+iv_id+"/title.jpg";
            string poi_id="0";
            int listorder=0;
            int hotorder=0;
            int company_id=0;


            bool isok = new DAO_project().Add(name_en, name,  description,  img_url,  poi_id,  iv_id,  listorder,  ishot,  hotorder,  company_id,  industry_id);

            if (isok == true)
            {
                var send = new
                {
                    msg = "操作成功！",
                    success = "true"
                };
                return JsonConvert.SerializeObject(send);
            }
            else
            {
                var send = new
                {
                    msg = "操作失败！",
                    success = "false"
                };
                return JsonConvert.SerializeObject(send);
            }

        }


        public string Update(int id, string name_en,string name, string description, string iv_id,  bool ishot, int industry_id)
        {
            string img_url = "image/project/" + iv_id + "/title.jpg";
            string poi_id = "0";
            int listorder = 0;
            int hotorder = 0;
            int company_id = 0;


            bool isok = new DAO_project().Update(id,name_en, name, description, img_url, poi_id, iv_id, listorder, ishot, hotorder, company_id, industry_id);

            if (isok == true)
            {
                var send = new
                {
                    msg = "操作成功！",
                    success = "true"
                };
                return JsonConvert.SerializeObject(send);
            }
            else
            {
                var send = new
                {
                    msg = "操作失败！",
                    success = "false"
                };
                return JsonConvert.SerializeObject(send);
            }

        }
    } 
}