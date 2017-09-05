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
            DataTable dt = new DAO_project().GetList(1, number, "", true, 0, 0, "hotorder asc", out count);
            return dt;
        }

        public DataTable getProjectBySort(int pageSize, string sort, string param)
        {
            int s = 0;
            int.TryParse(sort, out s);
            int count = 0;
            DataTable dt = new DAO_project().GetList(1, pageSize, param, false, 0, s, "name", out count);
            return dt;
        }
    } 
}