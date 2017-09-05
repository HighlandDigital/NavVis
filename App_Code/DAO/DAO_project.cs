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
        
        public bool Add(string name, string name_en,string description, string img_url, string poi_id, string iv_id, int listorder, bool ishot,int hotorder, int company_id, int industry_id)
        {
            SqlParameter[] parameters =
            {
               new SqlParameter("@name",SqlDbType.NVarChar),
               new SqlParameter("@name_en",SqlDbType.NVarChar),
               new SqlParameter("@description",SqlDbType.NVarChar),
               new SqlParameter("@img_url",SqlDbType.NVarChar),
               new SqlParameter("@poi_id",SqlDbType.NVarChar),
               new SqlParameter("@iv_id",SqlDbType.NVarChar),
               new SqlParameter("@listorder",SqlDbType.Int),
               new SqlParameter("@ishot",SqlDbType.Bit),
               new SqlParameter("@hotorder",SqlDbType.Int),
               new SqlParameter("@company_id",SqlDbType.Int),
               new SqlParameter("@industry_id",SqlDbType.Int)
             };
            parameters[0].Value = name;
            parameters[1].Value = name_en;
            parameters[2].Value = description;
            parameters[3].Value = img_url;
            parameters[4].Value = poi_id;
            parameters[5].Value = iv_id;
            parameters[6].Value = listorder;
            parameters[7].Value = ishot;
            parameters[8].Value = hotorder;
            parameters[9].Value = company_id;
            parameters[10].Value = industry_id;
            string strSql = "insert into obj_project(name, name_en, description, img_url, poi_id, iv_id, listorder, ishot, hotorder, company_id, industry_id) values(@name, @name_en, @description, @img_url, @poi_id, @iv_id, @listorder, @ishot, @hotorder, @company_id, @industry_id)";
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

        public bool Update(int id, string name, string name_en, string description, string img_url, string poi_id, string iv_id, int listorder, bool ishot, int hotorder, int company_id, int industry_id)
        {
            SqlParameter[] parameters =
            {
               new SqlParameter("@name",SqlDbType.NVarChar),
               new SqlParameter("@name_en",SqlDbType.NVarChar),
               new SqlParameter("@description",SqlDbType.NVarChar),
               new SqlParameter("@img_url",SqlDbType.NVarChar),
               new SqlParameter("@poi_id",SqlDbType.NVarChar),
               new SqlParameter("@iv_id",SqlDbType.NVarChar),
               new SqlParameter("@listorder",SqlDbType.Int),
               new SqlParameter("@ishot",SqlDbType.Bit),
               new SqlParameter("@hotorder",SqlDbType.Int),
               new SqlParameter("@company_id",SqlDbType.Int),
               new SqlParameter("@industry_id",SqlDbType.Int),
               new SqlParameter("@id",SqlDbType.Int)
            };
            parameters[0].Value = name;
            parameters[1].Value = name_en;
            parameters[2].Value = description;
            parameters[3].Value = img_url;
            parameters[4].Value = poi_id;
            parameters[5].Value = iv_id;
            parameters[6].Value = listorder;
            parameters[7].Value = ishot;
            parameters[8].Value = hotorder;
            parameters[9].Value = company_id;
            parameters[10].Value = industry_id;
            parameters[11].Value = id;
            string strSql = "update obj_project set name=@name,name_en=@name_en,description=@description,img_url=@img_url,poi_id=@poi_id,iv_id=@iv_id,listorder=@listorder,ishot=@ishot,hotorder=@hotorder,company_id=@company_id,industry_id=@industry_id where id=@id";
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

        public DataTable GetList(int pageNum, int pageSize, string name, bool ishot, int company_id, int industry_id, string orderBy, out int count)
        {
            StringBuilder sqlStr = new StringBuilder();//查询结果集
            StringBuilder sqlWhere = new StringBuilder();//查询条件
            StringBuilder sqlCount = new StringBuilder();//查询总数
            SqlParameter[] parameters ={
                new SqlParameter("@name",SqlDbType.NVarChar),
               new SqlParameter("@ishot",SqlDbType.Bit),
               new SqlParameter("@company_id",SqlDbType.Int),
               new SqlParameter("@industry_id",SqlDbType.Int)
            };
            parameters[0].Value = "%" + name + "%";
            parameters[1].Value = ishot;
            parameters[2].Value = company_id;
            parameters[3].Value = industry_id;
            sqlCount.Append("select id from obj_project where 1=1 ");
            sqlStr.Append("select top " + pageSize + " * from obj_project where 1=1 ");//用于查询返回当前页数据
            if (name != "")
            {
                sqlWhere.Append(" and (name like @name or name_en like @name )");
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