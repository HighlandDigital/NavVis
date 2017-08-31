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
    public class DAO_point
    {
        public DAO_point()
        {
            //
            // TODO: 在此处添加构造函数逻辑
            //
        }
        
        public bool Add(int iv_id, string title, string title_img_url, string description, string description_url)
        {
            SqlParameter[] parameters =
            {
                new SqlParameter("@iv_id",SqlDbType.Int),
               new SqlParameter("@title",SqlDbType.NVarChar),
               new SqlParameter("@title_img_url",SqlDbType.NVarChar),
               new SqlParameter("@description",SqlDbType.NVarChar),
               new SqlParameter("@description_url",SqlDbType.NVarChar)
             };
            parameters[0].Value = iv_id;
            parameters[1].Value = title;
            parameters[2].Value = title_img_url;
            parameters[3].Value = description;
            parameters[4].Value = description_url;
            string strSql = "insert into obj_point(iv_id, title, title_img_url, description, description_url) values(@iv_id, @title, @title_img_url, @description, @description_url)";
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

        public bool Update(int id, int iv_id, string title, string title_img_url, string description, string description_url)
        {
            SqlParameter[] parameters =
            {
               new SqlParameter("@iv_id",SqlDbType.Int),
               new SqlParameter("@title",SqlDbType.NVarChar),
               new SqlParameter("@title_img_url",SqlDbType.NVarChar),
               new SqlParameter("@description",SqlDbType.NVarChar),
               new SqlParameter("@description_url",SqlDbType.NVarChar),
               new SqlParameter("@id",SqlDbType.Int)
            };
            parameters[0].Value = iv_id;
            parameters[1].Value = title;
            parameters[2].Value = title_img_url;
            parameters[3].Value = description;
            parameters[4].Value = description_url;
            parameters[5].Value = id;
            string strSql = "update obj_point set iv_id=@iv_id,title=@title,title_img_url=@title_img_url,description=@description,description_url=@description_url where id=@id";
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

        public bool DeleteByID(int id)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("delete from obj_point");
            strSql.Append(" where id=@id");
            SqlParameter[] parameters = {
                   new SqlParameter("@id", SqlDbType.Int)
            };
            parameters[0].Value = id;
            int rows = new SQL().ExecuteSql(strSql.ToString(), parameters);
            if (rows > 0)
            {
                return true;
            }
            else
            {
                return false;
            }
        }
        
        public DataTable GetByID(int id)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select * from obj_point ");
            strSql.Append(" where id=@id");
            SqlParameter[] parameters = {
                new SqlParameter("@id", SqlDbType.Int)
          };
            parameters[0].Value = id;
            return new SQL().Query(strSql.ToString(), parameters).Tables[0];
        }

        public DataTable GetByIVID(int ivid)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select * from obj_point ");
            strSql.Append(" where iv_id=@iv_id");
            SqlParameter[] parameters = {
                new SqlParameter("@iv_id", SqlDbType.Int)
          };
            parameters[0].Value = ivid;
            return new SQL().Query(strSql.ToString(), parameters).Tables[0];
        }

        public DataTable GetList(int pageNum, int pageSize, string title, string description, string orderBy, out int count)
        {
            StringBuilder sqlStr = new StringBuilder();//查询结果集
            StringBuilder sqlWhere = new StringBuilder();//查询条件
            StringBuilder sqlCount = new StringBuilder();//查询总数
            SqlParameter[] parameters ={
                new SqlParameter("@title",SqlDbType.NVarChar),
                new SqlParameter("@description",SqlDbType.NVarChar)
            };
            parameters[0].Value = "%" + title + "%";
            parameters[1].Value = "%" + description + "%";
            sqlCount.Append("select id from obj_point where 1=1 ");
            sqlStr.Append("select top " + pageSize + " * from obj_point where 1=1 ");//用于查询返回当前页数据
            if (title != "")
            {
                sqlWhere.Append(" and title like @title ");
            }
            if (description != "")
            {
                sqlWhere.Append(" and description like @description ");
            }
            sqlCount.Append(sqlWhere);
            sqlStr.Append(sqlWhere);
            if (pageNum > 1)
            {
                sqlStr.Append("and id not in(select top " + (pageNum - 1) * pageSize + " id from obj_point where 1=1");
                sqlStr.Append(sqlWhere);
                if (orderBy != "")
                {
                    sqlStr.Append(" order by " + orderBy);
                }
                sqlStr.Append(")");
            }
            if (orderBy != "")
            {
                sqlStr.Append(" order by " + orderBy);
            }
            count = new SQL().Query(sqlCount.ToString(), parameters).Tables[0].Rows.Count;
            return new SQL().Query(sqlStr.ToString(), parameters).Tables[0];
        }
        
    } 
}