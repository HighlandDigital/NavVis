using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
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

        public DataTable getPointByIVID(string id)
        {
            DataTable dt = new DAO_point().GetByIVID(id);
            return dt;
        }
    } 
}