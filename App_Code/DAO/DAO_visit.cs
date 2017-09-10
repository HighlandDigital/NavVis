using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Text;

namespace DAO
{
    /// <summary>
    /// DAO_industry 的摘要说明
    /// </summary>
    public class DAO_visit
    {
        public DAO_visit()
        {
            //
            // TODO: 在此处添加构造函数逻辑
            //
        }

        public bool Add(string poi_id, string iv_id, string visit_time)
        {
            SqlParameter[] parameters =
            {
                new SqlParameter("@poi_id",SqlDbType.NVarChar),
               new SqlParameter("@iv_id",SqlDbType.NVarChar),
               new SqlParameter("@visit_time",SqlDbType.NVarChar)
             };
            parameters[0].Value = poi_id;
            parameters[1].Value = iv_id;
            parameters[2].Value = visit_time;
            string strSql = "insert into log_visit(poi_id, iv_id, visit_time) values(@poi_id, @iv_id, @visit_time)";
            bool IsSuccess = false;
            try
            {
                int result = new SQL().ExecuteSql(strSql.ToString(), parameters);
                if (result > 0)
                {
                    IsSuccess = true;
                }
            }
            catch
            {
                throw;
            }
            return IsSuccess;
        }

    }
}