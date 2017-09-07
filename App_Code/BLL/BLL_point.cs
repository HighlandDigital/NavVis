using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Text;
using System.IO;

using Newtonsoft.Json;
using DAO;

namespace BLL
{
    /// <summary>
    /// BLL_point 的摘要说明
    /// </summary>
    public class BLL_point
    {
        public BLL_point()
        {
            //
            // TODO: 在此处添加构造函数逻辑
            //
        }

        /// <summary>
        /// 热点html代码
        /// </summary>
        private string htmlcodemodel = "<img src=\"$title_img_url$\" style=\"width:100%;margin-bottom:5px;\" alt=\"$title$\"/> <div>$description$</div>";



        public string Loadindustry()
        {
            DataTable dt = new DAO_project().GetList();
            string json = JsonConvert.SerializeObject(dt);
            return json;
        }
        
        public DataTable getPointByIVID(string id)
        {
            DataTable dt = new DAO_point().GetByIVID(id);
            return dt;
        }


        public string delPointByID(int id)
        {          
            DataTable dt = new DAO_point().GetByID(id);
            if (dt.Rows.Count > 0)
            {
                string ivid=dt.Rows[0]["iv_id"].ToString();

                new DAO_project().DeleteByIVID(ivid);

                bool isok = new DAO_point().DeleteByID(id);

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

        /// <summary>
        /// 返回热点信息
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public string getPointByID(int id)
        {
           
            DataTable dt = new DAO_point().GetByID(id);
            if (dt.Rows.Count > 0)
            {
                var send = new
                {
                    id = dt.Rows[0]["id"].ToString(),
                    iv_id = dt.Rows[0]["iv_id"]!=null? dt.Rows[0]["iv_id"].ToString():"",
                    title = dt.Rows[0]["title"] != null ? dt.Rows[0]["title"].ToString() : "",
                    title_en = dt.Rows[0]["title_en"] != null ? dt.Rows[0]["title_en"].ToString() : "",
                    title_img_url = dt.Rows[0]["title_img_url"] != null ? dt.Rows[0]["title_img_url"].ToString() : "",
                    description = dt.Rows[0]["description"] != null ? dt.Rows[0]["description"].ToString() : "",
                    description_mod = dt.Rows[0]["description_mod"] != null ? dt.Rows[0]["description_mod"].ToString() : "",
                    description_en = dt.Rows[0]["description_en"] != null ? dt.Rows[0]["description_en"].ToString() : "",
                    description_en_mod = dt.Rows[0]["description_en_mod"] != null ? dt.Rows[0]["description_en_mod"].ToString() : "",
                    locked = dt.Rows[0]["locked"] != null ? dt.Rows[0]["locked"].ToString() : ""
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
        /// <summary>
        /// 返回json列表
        /// </summary>
        /// <param name="pageNum"></param>
        /// <param name="pageSize"></param>
        /// <param name="title"></param>
        /// <param name="description"></param>
        /// <param name="orderBy"></param>
        /// <returns></returns>
        public string getList(int pageNum, int pageSize, string title, string description)
        {
            string strjson = "";
            string orderBy = " id asc";
            int total = 0;
            DataTable dt = new DAO_point().GetList(pageNum, pageSize, title, description, orderBy, out total);

            strjson=ToJson(dt, total);
            return strjson;
        }


        /// <summary>
        /// 添加点信息
        /// </summary>
        /// <param name="iv_id"></param>
        /// <param name="title"></param>
        /// <param name="title_en"></param>
        /// <param name="title_img_url"></param>
        /// <param name="description"></param>
        /// <param name="description_en"></param>
        /// <param name="locked"></param>
        /// <returns></returns>
        public string addPoint(string iv_id, string title, string title_en, string title_img_url, string description, string description_en, bool locked)
        {

            string description_mod = create(title, title_img_url, description);
            string description_en_mod = create(title_en, title_img_url, description_en);
            bool isok = new DAO_point().Add(iv_id, title, title_en, title_img_url, description, description_mod, description_en, description_en_mod, locked);

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

        /// <summary>
        /// 修改点信息
        /// </summary>
        /// <param name="id"></param>
        /// <param name="iv_id"></param>
        /// <param name="title"></param>
        /// <param name="title_en"></param>
        /// <param name="title_img_url"></param>
        /// <param name="description"></param>
        /// <param name="description_en"></param>
        /// <param name="locked"></param>
        /// <returns></returns>
        public string edit(int id, string iv_id, string title, string title_en, string title_img_url, string description, string description_mod, string description_en, string description_en_mod, bool locked)
        {
          

            //20170904 李久丹 不锁定则修改模板
            if (locked == false)
            {
                description_mod = create(title, title_img_url, description);
                description_en_mod = create(title_en, title_img_url, description_en);

            }
            bool isok = new DAO_point().Update(id,  iv_id,  title,  title_en,  title_img_url,  description,  description_mod,  description_en,  description_en_mod,  locked);

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

        public string recreate(string strid)
        {
          

            bool locked = true;
            if (strid == "0")
            { //重新生成未锁定的
                locked = true;
            }
            else
            {//重新生成所有
                locked = false;
            }
            
            bool isok = new DAO_point().recreate(locked, htmlcodemodel);

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
       /// <summary>
       /// 返回根据模板显示页面生成的html代码
       /// </summary>
       /// <param name="title"></param>
       /// <param name="title_img_url"></param>
       /// <param name="description"></param>
       /// <returns></returns>
        private string create(string title, string title_img_url, string description)
        {
            string strjson = "";
            strjson = htmlcodemodel;
          //  strjson=getDataFromFile("");
            strjson = strjson.Replace("$title$",title);
            strjson = strjson.Replace("$title_img_url$", title_img_url);
            strjson = strjson.Replace("$description$", description);
            return strjson;
        }


        /// <summary>
        /// 返回根据模板显示页面生成的html文件
        /// </summary>
        /// <param name="cthtml"></param>
        /// <returns></returns>
        private bool cthtml(string cthtml)
        {
            bool isok = true;


            return isok;
        
        }
        private string ToJson(DataTable table, int total)
        {
            DataGridBean dgb = new DataGridBean();
            dgb.Total = total.ToString();
            dgb.Rows = table;
            string json = JsonConvert.SerializeObject(dgb);
            return json;
        }



        /// <summary>
        ///DataGridBean 的摘要说明
        /// </summary>
        private class DataGridBean
        {
            public DataGridBean() { }

            [JsonProperty("total")]
            public string Total { get; set; }

            [JsonProperty("rows")]
            public DataTable Rows { get; set; }
        }

        private string getDataFromFile(string path)
        {
            StreamReader sr = null;
            try
            {
                sr = new StreamReader(path, Encoding.UTF8);
                return sr.ReadToEnd();

            }
            catch (Exception e)
            {
                return null;
            }
            finally
            {
                if (sr != null)
                {
                    sr.Close();
                }
            }

        }
    } 
}