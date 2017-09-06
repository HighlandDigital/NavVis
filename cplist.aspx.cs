using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class cplist : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string url = HttpContext.Current.Request.Url.Query;
        if(!url.Contains("code=HL5885031")) Response.Write("<script language='javascript'>window.location='page/nav.aspx'</script>");
    }
}