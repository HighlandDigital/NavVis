using System;
using System.Collections;
using System.Data;
using System.Data.SqlClient;

namespace DAO
{
    /// <summary>
    /// SQL数据库调用类，提供经过封装的SQL调用方法，需要先设定SQL连接字符串。
    /// </summary>
    public class SQL
    {
        public string connectionString = "";

        public SQL()
        {
            string str = System.Configuration.ConfigurationManager.ConnectionStrings["connectionString"].ConnectionString;
            connectionString = str;
        }

        public SQL(string ConnectionStr)
        {
            connectionString = ConnectionStr;
        }

        #region 固定操作

        /// <summary>
        /// 获取当前指定数据库的所有表名
        /// </summary>
        /// <returns>包含所有表名的DataTable</returns>
        public DataTable GetTables()
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                DataSet ds = new DataSet();
                try
                {
                    connection.Open();
                    SqlDataAdapter command = new SqlDataAdapter("SELECT name FROM Sysobjects WHERE type = 'U' AND sysstat<200 ", connection);
                    command.Fill(ds, "ds");
                }
                catch (System.Data.SqlClient.SqlException ex)
                {
                    throw new Exception(ex.Message);
                }
                return ds.Tables[0];
            }
        }

        /// <summary>
        /// 获取指定表的主键
        /// </summary>
        /// <param name="tableName">表名</param>
        /// <returns>包含主键名的DataTable</returns>
        public DataTable GetPrimaryKey(string tableName)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                DataSet ds = new DataSet();
                try
                {
                    connection.Open();
                    SqlDataAdapter command = new SqlDataAdapter("SELECT name FROM SysColumns WHERE id=Object_Id('" + tableName + "') and colid in(select keyno from sysindexkeys where id=Object_Id('" + tableName + "'))", connection);
                    command.Fill(ds, "ds");
                }
                catch (System.Data.SqlClient.SqlException ex)
                {
                    throw new Exception(ex.Message);
                }
                return ds.Tables[0];
            }
        }

        /// <summary>
        /// 获取指定表的所有列信息
        /// </summary>
        /// <param name="tableName">表名</param>
        /// <returns>包含所有列信息的DataTable</returns>
        public DataTable GetColumns(string tableName)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                DataSet ds = new DataSet();
                try
                {
                    connection.Open();
                    SqlDataAdapter command = new SqlDataAdapter("SELECT * FROM SysColumns WHERE id=Object_Id('" + tableName + "')", connection);
                    command.Fill(ds, "ds");
                }
                catch (System.Data.SqlClient.SqlException ex)
                {
                    throw new Exception(ex.Message);
                }
                return ds.Tables[0];
            }
        }
        #endregion

        #region  数据库备份还原




        ///// <summary>
        ///// 备份数据库

        ///// </summary>
        ///// <param name="databasename">要备份的数据源名称</param>
        ///// <param name="backuptodatabase">备份到的数据库文件名称及路径</param>
        ///// <returns></returns>
        //public bool BackUpDataBase(string databasename,string backuptodatabase)
        //{

        //    string procname;
        //    string name = databasename;
        //    string sql;
        //    string conStr = "";

        //    Get_SqlServer();

        //    conStr = "data source=" + Str_SqlServer  + ";initial catalog=master;password=" + Str_SqlPassWord + ";persist security info=True;user id=" + Str_SqlUserName + ";workstation id=TOPS03496;packet size=4096";

        //    SqlConnection conn = new SqlConnection(conStr);

        //    conn.Open();        //打开数据库连接


        //    //删除逻辑备份设备，但不会删掉备份的数据库文件
        //    procname="sp_dropdevice";
        //    SqlCommand sqlcmd1=new SqlCommand(procname,conn);
        //    sqlcmd1.CommandType =CommandType.StoredProcedure;

        //    SqlParameter sqlpar=new SqlParameter();
        //    sqlpar=sqlcmd1.Parameters.Add("@logicalname",SqlDbType.VarChar,20);
        //    sqlpar.Direction =ParameterDirection.Input;
        //    sqlpar.Value =databasename;

        //    try        //如果逻辑设备不存在，略去错误
        //    {
        //        sqlcmd1.ExecuteNonQuery();
        //    }
        //    catch
        //    {
        //    }

        //    //创建逻辑备份设备
        //    procname="sp_addumpdevice";
        //    SqlCommand sqlcmd2=new SqlCommand(procname,conn);
        //    sqlcmd2.CommandType =CommandType.StoredProcedure;

        //    sqlpar=sqlcmd2.Parameters.Add("@devtype",SqlDbType.VarChar,20);
        //    sqlpar.Direction =ParameterDirection.Input;
        //    sqlpar.Value ="disk";


        //    sqlpar=sqlcmd2.Parameters.Add("@logicalname",SqlDbType.VarChar,20);//逻辑设备名

        //    sqlpar.Direction =ParameterDirection.Input;
        //    sqlpar.Value =databasename;

        //    sqlpar=sqlcmd2.Parameters.Add("@physicalname",SqlDbType.NVarChar,260);//物理设备名

        //    sqlpar.Direction =ParameterDirection.Input;
        //    sqlpar.Value =backuptodatabase;


        //    try
        //    {
        //        int i=sqlcmd2.ExecuteNonQuery();
        //    }
        //    catch(Exception err)
        //    {
        //        string str=err.Message;
        //    }

        //    //备份数据库到指定的数据库文件(完全备份)
        //    sql="BACKUP DATABASE "+databasename +" TO "+databasename +" WITH INIT";
        //    SqlCommand sqlcmd3=new SqlCommand(sql,conn);
        //    sqlcmd3.CommandType =CommandType.Text;
        //    try
        //    {
        //        sqlcmd3.ExecuteNonQuery();
        //    }
        //    catch(Exception err)
        //    {
        //        string str=err.Message ;
        //        conn.Close();



        //        return false;
        //    }

        //    conn.Close();//关闭数据库连接


        //    return true;

        //}


        ///// <summary>
        ///// 还原指定的数据库文件
        ///// </summary>
        ///// <param name="databasename">要还原的数据库</param>
        ///// <param name="databasefile">数据库备份文件及路径</param>
        ///// <returns></returns>
        //public static bool RestoreDataBase(string databasename,string databasefile )
        //{
        //    bool bOK = false;
        //    string conStr = "";

        //    Get_SqlServer();

        //    conStr = "data source=" + Str_SqlServer  + ";initial catalog=master;password=" + Str_SqlPassWord + ";persist security info=True;user id=" + Str_SqlUserName + ";workstation id=TOPS03496;packet size=4096";

        //    SqlConnection conn = new SqlConnection(conStr);

        //    if(ExePro(databasename,conStr)!=true)//执行存储过程
        //    {
        //        bOK = false;
        //    }
        //    else
        //    {				
        //        //还原指定的数据库文件
        //        string sql="RESTORE DATABASE "+databasename +" from DISK = '"+databasefile +"' ";
        //        SqlCommand sqlcmd=new SqlCommand(sql,conn);
        //        sqlcmd.CommandType =CommandType.Text;
        //        sqlcmd.CommandTimeout = 1800;

        //        conn.Open();

        //        try
        //        {

        //            sqlcmd.ExecuteNonQuery();


        //        }
        //        catch(Exception err)
        //        {
        //            string str=err.Message ;
        //            conn.Close();

        //            bOK = false;
        //            //					return bOK;
        //        }

        //        conn.Close();//关闭数据库连接



        //        bOK = true;
        //    }
        //    return bOK;
        //}


        ///// <summary>
        ///// 杀死数据库进程
        ///// </summary>
        ///// <param name="databasename">要还原的数据库</param>
        ///// <returns></returns>
        //public static bool ExePro(string databasename,string conStr)
        //{
        //    SqlConnection conn = new SqlConnection(conStr);
        //    string sql = "select spid from master..sysprocesses where dbid=db_id('" + databasename + "')"; //取得正在连接进程
        //    SqlCommand cmd = new SqlCommand(sql,conn);
        //    try
        //    {
        //        conn.Open();
        //        SqlDataReader dr = cmd.ExecuteReader();
        //        ArrayList spid = new ArrayList();
        //        while(dr.Read())
        //        {
        //            //MessageBox.Show(dr[0].ToString());
        //            spid.Add(dr[0].ToString());
        //        }

        //        dr.Close();

        //        foreach(string tmp in spid)
        //        {
        //            sql = "kill " + tmp;  //杀死进程

        //            cmd.CommandText = sql;
        //            try
        //            {
        //                cmd.ExecuteNonQuery();
        //            }
        //            catch
        //            {
        //            }

        //        }

        //        conn.Close();
        //        return true;
        //    }
        //    catch
        //    {
        //        return false;
        //    }
        //    finally
        //    {
        //        conn.Close();
        //    } 


        //}


        #endregion

        #region  执行简单SQL语句

        /// <summary>
        /// 执行SQL语句，返回影响的记录数
        /// </summary>
        /// <param name="SQLString">SQL语句</param>
        /// <returns>影响的记录数</returns>
        public int ExecuteSql(string SQLString)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(SQLString, connection))
                {
                    try
                    {
                        connection.Open();
                        int rows = cmd.ExecuteNonQuery();
                        return rows;
                    }
                    catch (System.Data.SqlClient.SqlException E)
                    {
                        connection.Close();
                        throw new Exception(E.Message);
                    }
                }
            }
        }

        /// <summary>
        /// 执行多条SQL语句，实现数据库事务。
        /// </summary>
        /// <param name="SQLStringList">多条SQL语句</param>		
        public void ExecuteSqlTran(ArrayList SQLStringList)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = conn;
                SqlTransaction tx = conn.BeginTransaction();
                cmd.Transaction = tx;
                try
                {
                    for (int n = 0; n < SQLStringList.Count; n++)
                    {
                        string strsql = SQLStringList[n].ToString();
                        if (strsql.Trim().Length > 1)
                        {
                            cmd.CommandText = strsql;
                            cmd.ExecuteNonQuery();
                        }
                    }
                    tx.Commit();
                }
                catch (System.Data.SqlClient.SqlException E)
                {
                    tx.Rollback();
                    throw new Exception(E.Message);
                }
            }
        }

        /// <summary>
        /// 执行带一个存储过程参数的的SQL语句。
        /// </summary>
        /// <param name="SQLString">SQL语句</param>
        /// <param name="content">参数内容,比如一个字段是格式复杂的文章，有特殊符号，可以通过这个方式添加</param>
        /// <returns>影响的记录数</returns>
        public int ExecuteSql(string SQLString, string content)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand(SQLString, connection);
                System.Data.SqlClient.SqlParameter myParameter = new System.Data.SqlClient.SqlParameter("@content", SqlDbType.NText);
                myParameter.Value = content;
                cmd.Parameters.Add(myParameter);
                try
                {
                    connection.Open();
                    int rows = cmd.ExecuteNonQuery();
                    return rows;
                }
                catch (System.Data.SqlClient.SqlException E)
                {
                    throw new Exception(E.Message);
                }
                finally
                {
                    cmd.Dispose();
                    connection.Close();
                }
            }
        }

        /// <summary>
        /// 向数据库里插入图像格式的字段(和上面情况类似的另一种实例)
        /// </summary>
        /// <param name="strSQL">SQL语句</param>
        /// <param name="fs">图像字节,数据库的字段类型为image的情况</param>
        /// <returns>影响的记录数</returns>
        public int ExecuteSqlInsertImg(string strSQL, byte[] fs)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand(strSQL, connection);
                System.Data.SqlClient.SqlParameter myParameter = new System.Data.SqlClient.SqlParameter("@fs", SqlDbType.Image);
                myParameter.Value = fs;
                cmd.Parameters.Add(myParameter);
                try
                {
                    connection.Open();
                    int rows = cmd.ExecuteNonQuery();
                    return rows;
                }
                catch (System.Data.SqlClient.SqlException E)
                {
                    throw new Exception(E.Message);
                }
                finally
                {
                    cmd.Dispose();
                    connection.Close();
                }
            }
        }

        /// <summary>
        /// 执行一条计算查询结果语句，返回查询结果（object）。
        /// </summary>
        /// <param name="SQLString">计算查询结果语句</param>
        /// <returns>查询结果（object）</returns>
        public object GetSingle(string SQLString)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(SQLString, connection))
                {
                    try
                    {
                        connection.Open();
                        object obj = cmd.ExecuteScalar();
                        if ((Object.Equals(obj, null)) || (Object.Equals(obj, System.DBNull.Value)))
                        {
                            return null;
                        }
                        else
                        {
                            return obj;
                        }
                    }
                    catch (System.Data.SqlClient.SqlException e)
                    {
                        connection.Close();
                        throw new Exception(e.Message);
                    }
                }
            }
        }

        /// <summary>
        /// 执行查询语句，返回SqlDataReader
        /// </summary>
        /// <param name="strSQL">查询语句</param>
        /// <returns>SqlDataReader</returns>
        public SqlDataReader ExecuteReader(string strSQL)
        {
            SqlConnection connection = new SqlConnection(connectionString);
            SqlCommand cmd = new SqlCommand(strSQL, connection);
            try
            {
                connection.Open();
                SqlDataReader myReader = cmd.ExecuteReader();
                return myReader;
            }
            catch (System.Data.SqlClient.SqlException e)
            {
                throw new Exception(e.Message);
            }

        }

        /// <summary>
        /// 执行查询语句，返回DataSet
        /// </summary>
        /// <param name="SQLString">查询语句</param>
        /// <returns>DataSet</returns>
        public DataSet Query(string SQLString)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                DataSet ds = new DataSet();
                try
                {
                    connection.Open();
                    SqlDataAdapter command = new SqlDataAdapter(SQLString, connection);
                    command.Fill(ds, "ds");
                }
                catch (System.Data.SqlClient.SqlException ex)
                {
                    throw new Exception(ex.Message);
                }
                return ds;
            }
        }

        #endregion

        #region 执行带参数的SQL语句

        /// <summary>
        /// 执行SQL语句，返回影响的记录数
        /// </summary>
        /// <param name="SQLString">SQL语句</param>
        /// <returns>影响的记录数</returns>
        public int ExecuteSql(string SQLString, params SqlParameter[] cmdParms)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand())
                {
                    try
                    {
                        PrepareCommand(cmd, connection, null, SQLString, cmdParms);
                        int rows = cmd.ExecuteNonQuery();
                        cmd.Parameters.Clear();
                        return rows;
                    }
                    catch (System.Data.SqlClient.SqlException E)
                    {
                        throw new Exception(E.Message);
                    }
                }
            }
        }

        /// <summary>
        /// 执行多条SQL语句，实现数据库事务。
        /// </summary>
        /// <param name="SQLStringList">SQL语句的哈希表（key为sql语句，value是该语句的SqlParameter[]）</param>
        public void ExecuteSqlTran(Hashtable SQLStringList)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                using (SqlTransaction trans = conn.BeginTransaction())
                {
                    SqlCommand cmd = new SqlCommand();
                    try
                    {
                        //循环
                        foreach (DictionaryEntry myDE in SQLStringList)
                        {
                            string cmdText = myDE.Key.ToString();
                            SqlParameter[] cmdParms = (SqlParameter[])myDE.Value;
                            PrepareCommand(cmd, conn, trans, cmdText, cmdParms);
                            int val = cmd.ExecuteNonQuery();
                            cmd.Parameters.Clear();

                            trans.Commit();
                        }
                    }
                    catch
                    {
                        trans.Rollback();
                        throw;
                    }
                }
            }
        }

        /// <summary>
        /// 执行一条计算查询结果语句，返回查询结果（object）。
        /// </summary>
        /// <param name="SQLString">计算查询结果语句</param>
        /// <returns>查询结果（object）</returns>
        public object GetSingle(string SQLString, params SqlParameter[] cmdParms)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand())
                {
                    try
                    {
                        PrepareCommand(cmd, connection, null, SQLString, cmdParms);
                        object obj = cmd.ExecuteScalar();
                        cmd.Parameters.Clear();
                        if ((Object.Equals(obj, null)) || (Object.Equals(obj, System.DBNull.Value)))
                        {
                            return null;
                        }
                        else
                        {
                            return obj;
                        }
                    }
                    catch (System.Data.SqlClient.SqlException e)
                    {
                        throw new Exception(e.Message);
                    }
                }
            }
        }

        /// <summary>
        /// 执行查询语句，返回SqlDataReader
        /// </summary>
        /// <param name="strSQL">查询语句</param>
        /// <returns>SqlDataReader</returns>
        public SqlDataReader ExecuteReader(string SQLString, params SqlParameter[] cmdParms)
        {
            SqlConnection connection = new SqlConnection(connectionString);
            SqlCommand cmd = new SqlCommand();
            try
            {
                PrepareCommand(cmd, connection, null, SQLString, cmdParms);
                SqlDataReader myReader = cmd.ExecuteReader();
                cmd.Parameters.Clear();
                return myReader;
            }
            catch (System.Data.SqlClient.SqlException e)
            {
                throw new Exception(e.Message);
            }

        }

        /// <summary>
        /// 执行查询语句，返回DataSet
        /// </summary>
        /// <param name="SQLString">查询语句</param>
        /// <returns>DataSet</returns>
        public DataSet Query(string SQLString, params SqlParameter[] cmdParms)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand();
                PrepareCommand(cmd, connection, null, SQLString, cmdParms);
                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    DataSet ds = new DataSet();
                    try
                    {
                        da.Fill(ds, "ds");
                        cmd.Parameters.Clear();
                    }
                    catch (System.Data.SqlClient.SqlException ex)
                    {
                        throw new Exception(ex.Message);
                    }
                    return ds;
                }
            }
        }

        private void PrepareCommand(SqlCommand cmd, SqlConnection conn, SqlTransaction trans, string cmdText, SqlParameter[] cmdParms)
        {
            if (conn.State != ConnectionState.Open)
                conn.Open();
            cmd.Connection = conn;
            cmd.CommandText = cmdText;
            if (trans != null)
                cmd.Transaction = trans;
            cmd.CommandType = CommandType.Text;//cmdType;
            if (cmdParms != null)
            {
                foreach (SqlParameter parm in cmdParms)
                    cmd.Parameters.Add(parm);
            }
        }

        #endregion

        #region 存储过程操作

        /// <summary>
        /// 执行存储过程
        /// </summary>
        /// <param name="storedProcName">存储过程名</param>
        /// <param name="parameters">存储过程参数</param>
        /// <returns>SqlDataReader</returns>
        public SqlDataReader RunProcedure(string storedProcName, IDataParameter[] parameters)
        {
            SqlConnection connection = new SqlConnection(connectionString);
            SqlDataReader returnReader;
            connection.Open();
            SqlCommand command = BuildQueryCommand(connection, storedProcName, parameters);
            command.CommandType = CommandType.StoredProcedure;
            returnReader = command.ExecuteReader();
            return returnReader;
        }

        /// <summary>
        /// 执行存储过程并返回obj
        /// </summary>
        /// <param name="storedProcName">存储过程名</param>
        /// <param name="parameters">存储过程参数</param>
        /// <returns>SqlDataReader</returns>
        public object RunProReObj(string storedProcName, IDataParameter[] parameters)
        {
            object ob;
            SqlConnection connection = new SqlConnection(connectionString);
            try
            {
                connection.Open();
                SqlCommand command = BuildQueryCommand(connection, storedProcName, parameters);
                command.CommandType = CommandType.StoredProcedure;
                ob = command.ExecuteScalar();
                return ob;
            }
            catch
            {
                return "";
            }
        }

        /// <summary>
        /// 执行存储过程
        /// </summary>
        /// <param name="storedProcName">存储过程名</param>
        /// <param name="parameters">存储过程参数</param>
        /// <param name="tableName">DataSet结果中的表名</param>
        /// <returns>DataSet</returns>
        public DataSet RunProcedure(string storedProcName, IDataParameter[] parameters, string tableName)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                DataSet dataSet = new DataSet();
                connection.Open();
                SqlDataAdapter sqlDA = new SqlDataAdapter();
                sqlDA.SelectCommand = BuildQueryCommand(connection, storedProcName, parameters);
                sqlDA.Fill(dataSet, tableName);
                connection.Close();
                return dataSet;
            }
        }

        /// <summary>
        /// 构建 SqlCommand 对象(用来返回一个结果集，而不是一个整数值)
        /// </summary>
        /// <param name="connection">数据库连接</param>
        /// <param name="storedProcName">存储过程名</param>
        /// <param name="parameters">存储过程参数</param>
        /// <returns>SqlCommand</returns>
        private SqlCommand BuildQueryCommand(SqlConnection connection, string storedProcName, IDataParameter[] parameters)
        {
            SqlCommand command = new SqlCommand(storedProcName, connection);
            command.CommandType = CommandType.StoredProcedure;
            foreach (SqlParameter parameter in parameters)
            {
                command.Parameters.Add(parameter);
            }
            return command;
        }

        /// <summary>
        /// 执行存储过程，返回影响的行数		
        /// </summary>
        /// <param name="storedProcName">存储过程名</param>
        /// <param name="parameters">存储过程参数</param>
        /// <param name="rowsAffected">影响的行数</param>
        /// <returns></returns>
        public int RunProcedure(string storedProcName, IDataParameter[] parameters, out int rowsAffected)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                int result;
                connection.Open();
                SqlCommand command = BuildIntCommand(connection, storedProcName, parameters);
                rowsAffected = command.ExecuteNonQuery();
                result = (int)command.Parameters["ReturnValue"].Value;
                //Connection.Close();
                return result;
            }
        }

        /// <summary>
        /// 执行存储过程，返回值		
        /// </summary>
        /// <param name="storedProcName">存储过程名</param>
        /// <param name="parameters">存储过程参数</param>
        /// <param name="getValue">返回的函数</param>
        /// <returns></returns>
        public object RunProGetReturn(string storedProcName, IDataParameter[] parameters, string getValue)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                SqlCommand command = new SqlCommand(storedProcName, connection);
                command.CommandType = CommandType.StoredProcedure;
                foreach (SqlParameter parameter in parameters)
                {
                    command.Parameters.Add(parameter);
                }
                command.ExecuteNonQuery();
                return command.Parameters[getValue].Value;
            }
        }

        /// <summary>
        /// 创建 SqlCommand 对象实例(用来返回一个整数值)	
        /// </summary>
        /// <param name="storedProcName">存储过程名</param>
        /// <param name="parameters">存储过程参数</param>
        /// <returns>SqlCommand 对象实例</returns>
        private SqlCommand BuildIntCommand(SqlConnection connection, string storedProcName, IDataParameter[] parameters)
        {
            SqlCommand command = BuildQueryCommand(connection, storedProcName, parameters);
            command.Parameters.Add(new SqlParameter("ReturnValue",
                SqlDbType.Int, 4, ParameterDirection.ReturnValue,
                false, 0, 0, string.Empty, DataRowVersion.Default, null));
            return command;
        }

        #endregion
    }
}
