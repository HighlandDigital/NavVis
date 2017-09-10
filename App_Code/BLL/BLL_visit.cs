using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using DAO;

namespace BLL
{
    /// <summary>
    /// BLL_company 的摘要说明
    /// </summary>
    public class BLL_visit
    {
        public BLL_visit()
        {
            //
            // TODO: 在此处添加构造函数逻辑
            //
        }

        public bool add(string poi_id, string iv_id)
        {
            bool result = new DAO_visit().Add(poi_id, iv_id, DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"));
            return result;
        }
    } 
}