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
        
        public bool Add(string iv_id, string title, string title_en, string title_img_url, string description, string description_mod, string description_en, string description_en_mod, bool locked)
        {
            SqlParameter[] parameters =
            {
                new SqlParameter("@iv_id",SqlDbType.NVarChar),
               new SqlParameter("@title",SqlDbType.NVarChar),
               new SqlParameter("@title_en",SqlDbType.NVarChar),
               new SqlParameter("@title_img_url",SqlDbType.NVarChar),
               new SqlParameter("@description",SqlDbType.NVarChar),
               new SqlParameter("@description_mod",SqlDbType.NVarChar),
               new SqlParameter("@description_en",SqlDbType.NVarChar),
               new SqlParameter("@description_en_mod",SqlDbType.NVarChar),
               new SqlParameter("@locked",SqlDbType.Bit)
             };
            parameters[0].Value = iv_id;
            parameters[1].Value = title;
            parameters[2].Value = title_en;
            parameters[3].Value = title_img_url;
            parameters[4].Value = description;
            parameters[5].Value = description_mod;
            parameters[6].Value = description_en;
            parameters[7].Value = description_en_mod;
            parameters[8].Value = locked;
            string strSql = "insert into obj_point( iv_id,  title,  title_en,  title_img_url,  description,  description_mod,  description_en,  description_en_mod,  locked) values(@iv_id, @title, @title_en, @title_img_url, @description, @description_mod, @description_en, @description_en_mod, @locked)";
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

        public bool Update(int id, string iv_id, string title, string title_en, string title_img_url, string description, string description_mod, string description_en, string description_en_mod, bool locked)
        {
            SqlParameter[] parameters =
            {
               new SqlParameter("@iv_id",SqlDbType.NVarChar),
               new SqlParameter("@title",SqlDbType.NVarChar),
               new SqlParameter("@title_en",SqlDbType.NVarChar),
               new SqlParameter("@title_img_url",SqlDbType.NVarChar),
               new SqlParameter("@description",SqlDbType.NVarChar),
               new SqlParameter("@description_mod",SqlDbType.NVarChar),
               new SqlParameter("@description_en",SqlDbType.NVarChar),
               new SqlParameter("@description_en_mod",SqlDbType.NVarChar),
               new SqlParameter("@locked",SqlDbType.Bit),
               new SqlParameter("@id",SqlDbType.Int)
            };
            parameters[0].Value = iv_id;
            parameters[1].Value = title;
            parameters[2].Value = title_en;
            parameters[3].Value = title_img_url;
            parameters[4].Value = description;
            parameters[5].Value = description_mod;
            parameters[6].Value = description_en;
            parameters[7].Value = description_en_mod;
            parameters[8].Value = locked;
            parameters[9].Value = id;
            string strSql = "update obj_point set iv_id=@iv_id,title=@title,title_en=@title_en,title_img_url=@title_img_url,description=@description,description_mod=@description_mod,description_en=@description_en,description_en_mod=@description_en_mod,locked=@locked where id=@id";
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

        public DataTable GetByIVID(string ivid)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select * from obj_point ");
            strSql.Append(" where iv_id=@iv_id");
            SqlParameter[] parameters = {
                new SqlParameter("@iv_id", SqlDbType.NVarChar)
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