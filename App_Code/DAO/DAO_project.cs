﻿using System;
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
    public class DAO_project
    {
        public DAO_project()
        {
            //
            // TODO: 在此处添加构造函数逻辑
            //
        }
        
        public bool Add(string name, string description, string img_url, string poi, bool ishot,int hotorder, int company_id, int industry_id)
        {
            SqlParameter[] parameters =
            {
               new SqlParameter("@name",SqlDbType.NVarChar),
               new SqlParameter("@description",SqlDbType.NVarChar),
               new SqlParameter("@img_url",SqlDbType.NVarChar),
               new SqlParameter("@poi",SqlDbType.NVarChar),
               new SqlParameter("@ishot",SqlDbType.Bit),
               new SqlParameter("@hotorder",SqlDbType.Int),
               new SqlParameter("@company_id",SqlDbType.Int),
               new SqlParameter("@industry_id",SqlDbType.Int)
             };
            parameters[0].Value = name;
            parameters[1].Value = description;
            parameters[2].Value = img_url;
            parameters[3].Value = poi;
            parameters[4].Value = ishot;
            parameters[5].Value = hotorder;
            parameters[6].Value = company_id;
            parameters[7].Value = industry_id;
            string strSql = "insert into obj_project(name, description, img_url, poi, ishot, hotorder, company_id, industry_id) values(@name, @description, @img_url, @poi, @ishot, @hotorder, @company_id, @industry_id)";
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

        public bool Update(int id, string name, string description, string img_url, string poi, bool ishot, int hotorder, int company_id, int industry_id)
        {
            SqlParameter[] parameters =
            {
               new SqlParameter("@name",SqlDbType.NVarChar),
               new SqlParameter("@description",SqlDbType.NVarChar),
               new SqlParameter("@img_url",SqlDbType.NVarChar),
               new SqlParameter("@poi",SqlDbType.NVarChar),
               new SqlParameter("@ishot",SqlDbType.Bit),
               new SqlParameter("@hotorder",SqlDbType.Int),
               new SqlParameter("@company_id",SqlDbType.Int),
               new SqlParameter("@industry_id",SqlDbType.Int),
               new SqlParameter("@id",SqlDbType.Int)
            };
            parameters[0].Value = name;
            parameters[1].Value = description;
            parameters[2].Value = img_url;
            parameters[3].Value = poi;
            parameters[4].Value = ishot;
            parameters[5].Value = hotorder;
            parameters[6].Value = company_id;
            parameters[7].Value = industry_id;
            parameters[8].Value = id;
            string strSql = "update obj_project set name=@name,description=@description,img_url=@img_url,poi=@poi,ishot=@ishot,hotorder=@hotorder,company_id=@company_id,industry_id=@industry_id where id=@id";
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
            strSql.Append("delete from obj_project");
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
            strSql.Append("select * from obj_project ");
            strSql.Append(" where id=@id");
            SqlParameter[] parameters = {
                new SqlParameter("@id", SqlDbType.Int)
          };
            parameters[0].Value = id;
            return new SQL().Query(strSql.ToString(), parameters).Tables[0];
        }

        public DataTable GetList(int pageNum, int pageSize, string name, string description, bool ishot, int company_id, int industry_id, string orderBy, out int count)
        {
            StringBuilder sqlStr = new StringBuilder();//查询结果集
            StringBuilder sqlWhere = new StringBuilder();//查询条件
            StringBuilder sqlCount = new StringBuilder();//查询总数
            SqlParameter[] parameters ={
                new SqlParameter("@name",SqlDbType.NVarChar),
                new SqlParameter("@description",SqlDbType.NVarChar),
               new SqlParameter("@ishot",SqlDbType.Bit),
               new SqlParameter("@company_id",SqlDbType.Int),
               new SqlParameter("@industry_id",SqlDbType.Int)
            };
            parameters[0].Value = "%" + name + "%";
            parameters[1].Value = "%" + description + "%";
            parameters[2].Value = ishot;
            parameters[3].Value = company_id;
            parameters[4].Value = industry_id;
            sqlCount.Append("select id from obj_project where 1=1 ");
            sqlStr.Append("select top " + pageSize + " * from obj_project where 1=1 ");//用于查询返回当前页数据
            if (name != "" && description != "")
            {
                sqlWhere.Append(" and (name like @name or description like @description )");
            }
            else
            {
                if (name != "")
                {
                    sqlWhere.Append(" and name like @name ");
                }
                if (description != "")
                {
                    sqlWhere.Append(" and description like @description ");
                }
            }
            if (ishot)
            {
                sqlWhere.Append(" and ishot = 1 ");
            }
            if (company_id > 0)
            {
                sqlWhere.Append(" and company_id = @company_id ");
            }
            if (industry_id > 0)
            {
                sqlWhere.Append(" and industry_id = @industry_id ");
            }
            sqlCount.Append(sqlWhere);
            sqlStr.Append(sqlWhere);
            if (pageNum > 1)
            {
                sqlStr.Append("and id not in(select top " + (pageNum - 1) * pageSize + " id from obj_project where 1=1");
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