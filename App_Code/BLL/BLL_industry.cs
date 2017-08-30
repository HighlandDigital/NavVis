using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using DAO;

namespace BLL
{
    /// <summary>
    /// BLL_industry 的摘要说明
    /// </summary>
    public class BLL_industry
    {
        public BLL_industry()
        {
            //
            // TODO: 在此处添加构造函数逻辑
            //
        }

        public DataTable getSort()
        {
            int count = 0;
            DataTable dt = new DAO_industry().GetList(1, 10, "", "", "listorder asc", out count);
            return dt;
        }
    } 
}