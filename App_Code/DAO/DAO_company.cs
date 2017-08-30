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
    public class DAO_company
    {
        public DAO_company()
        {
            //
            // TODO: 在此处添加构造函数逻辑
            //
        }
        
        public bool Add(string name, string description, string img_url, int listorder)
        {
            SqlParameter[] parameters =
            {
               new SqlParameter("@name",SqlDbType.NVarChar),
               new SqlParameter("@description",SqlDbType.NVarChar),
               new SqlParameter("@img_url",SqlDbType.NVarChar),
               new SqlParameter("@listorder",SqlDbType.Int)
             };
            parameters[0].Value = name;
            parameters[1].Value = description;
            parameters[2].Value = img_url;
            parameters[3].Value = listorder;
            string strSql = "insert into obj_company(name, description, img_url, listorder) values(@name, @description, @img_url, @listorder)";
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

        public bool Update(int id, string name, string description, string img_url, int listorder)
        {
            SqlParameter[] parameters =
            {
               new SqlParameter("@name",SqlDbType.NVarChar),
               new SqlParameter("@description",SqlDbType.NVarChar),
               new SqlParameter("@img_url",SqlDbType.NVarChar),
               new SqlParameter("@listorder",SqlDbType.Int),
               new SqlParameter("@id",SqlDbType.Int)
            };
            parameters[0].Value = name;
            parameters[1].Value = description;
            parameters[2].Value = img_url;
            parameters[3].Value = listorder;
            parameters[4].Value = id;
            string strSql = "update obj_company set name=@name,description=@description,img_url=@img_url,listorder=@listorder where id=@id";
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
            strSql.Append("delete from obj_company");
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
            strSql.Append("select * from obj_company ");
            strSql.Append(" where id=@id");
            SqlParameter[] parameters = {
                new SqlParameter("@id", SqlDbType.Int)
          };
            parameters[0].Value = id;
            return new SQL().Query(strSql.ToString(), parameters).Tables[0];
        }

        public DataTable GetList(int pageNum, int pageSize, string name, string description, string orderBy, out int count)
        {
            StringBuilder sqlStr = new StringBuilder();//查询结果集
            StringBuilder sqlWhere = new StringBuilder();//查询条件
            StringBuilder sqlCount = new StringBuilder();//查询总数
            SqlParameter[] parameters ={
                new SqlParameter("@name",SqlDbType.NVarChar),
                new SqlParameter("@description",SqlDbType.NVarChar)
            };
            parameters[0].Value = "%" + name + "%";
            parameters[1].Value = "%" + description + "%";
            sqlCount.Append("select id from obj_company where 1=1 ");
            sqlStr.Append("select top " + pageSize + " * from obj_company where 1=1 ");//用于查询返回当前页数据
            if (name != "")
            {
                sqlWhere.Append(" and name like @name ");
            }
            if (description != "")
            {
                sqlWhere.Append(" and description like @description ");
            }
            sqlCount.Append(sqlWhere);
            sqlStr.Append(sqlWhere);
            if (pageNum > 1)
            {
                sqlStr.Append("and id not in(select top " + (pageNum - 1) * pageSize + " id from obj_company where 1=1");
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