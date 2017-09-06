<%@ Page Language="C#" AutoEventWireup="true" CodeFile="cplist.aspx.cs" Inherits="cplist" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>

    <link rel="stylesheet" type="text/css" href="jquery-easyui-1.4.5/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="jquery-easyui-1.4.5/themes/icon.css">
    <link rel="stylesheet" type="text/css" href="jquery-easyui-1.4.5/demo/demo.css">
    <script type="text/javascript" src="jquery-easyui-1.4.5/jquery.min.js"></script>
    <script type="text/javascript" src="jquery-easyui-1.4.5/jquery.easyui.min.js"></script>

        <script type="text/javascript">
            var datagrid;
            var rowEditor = undefined;
            $(function () {

              //  CheckLogin();
             //   checkRole("0203");


                datagrid = $("#dg").datagrid({
                    url: "Handler/PointHandler.ashx?ac=init",     //加载的URL
                    isField: "id",
                    pagination: true,   //显示分页
                    pageSize: 10,       //分页大小
                    pageList: [10],     //每页的个数
                    fit: false,          //自动补全
                    fitColumns: true,
                    iconCls: "icon-save",   //图标
                    title: "热点管理",
                    columns: [[      //每个列具体内容
                              {
                                  field: 'id',
                                  title: '',
                                  width: 1,
                                  hidden: true

                              },
                             
                              {
                                  field: 'title', title: '标题', width: 200, editor: {
                                      type: 'validatebox',
                                      options: {
                                          required: true
                                      }
                                  }
                              }
                    ]],
                    toolbar: [      //工具条
                            {
                                text: "增加", iconCls: "icon-add", handler: function () {     //回调函数
                                    //添加热点信息
                                    window.location = "cpdetail.aspx";
                                }
                            },
                            {
                                text: "删除", iconCls: "icon-remove", handler: function () {
                                    var rows = datagrid.datagrid('getSelections');

                                    if (rows.length <= 0) {
                                        $.messager.alert('警告', '您没有选择', 'error');
                                    }
                                    else if (rows.length > 1) {
                                        $.messager.alert('警告', '不支持批量删除', 'error');
                                    }
                                    else {
                                        $.messager.confirm('确定', '您确定要删除吗', function (t) {
                                            if (t) {

                                                $.ajax({
                                                    url: "Handler/PointHandler.ashx",
                                                    data: {
                                                        'ac': 'del',
                                                        'id': rows[0].id
                                                    },
                                                    dataType: 'json',
                                                    success: function (result) {
                                                        if (eval(result).Msg) {
                                                            if (eval(result).Error && eval(result).Error == 'false') {
                                                                $.messager.alert('提示', eval(result).Msg, 'info', function () {
                                                                    datagrid.datagrid('reload');

                                                                });
                                                            }
                                                            else {
                                                                $.messager.alert('提示', eval(result).Msg);
                                                            }
                                                        }
                                                    }
                                                });

                                            }
                                        })
                                    }


                                }
                            },
                            {
                                text: "修改", iconCls: "icon-edit", handler: function () {
                                    
                                    var rows = datagrid.datagrid('getSelections');

                                    if (rows.length <= 0) {
                                        $.messager.alert('警告', '您没有选择', 'error');
                                    }
                                    else if (rows.length > 1) {
                                        $.messager.alert('警告', '不支持批量修改', 'error');
                                    }
                                    else {                                       
                                        window.location.href = "cpdetail.aspx?id=" + encodeURI(encodeURI(rows[0].id));
                                       

                                    }
                                }
                            },
                            {
                                text: "查询", iconCls: "icon-search", handler: function () {
                                    $('#searchInfo').window('open');
                                }
                            },
                            {
                                text: "生成未锁定的", iconCls: "icon-search", handler: function () {
                                    $.messager.confirm('确定', '您确定要重新生成吗', function (t) {
                                        if (t) {

                                            $.ajax({
                                                url: "Handler/PointHandler.ashx",
                                                data: {
                                                    'ac': 'create',
                                                    'id':'0'
                                                },
                                                dataType: 'json',
                                                success: function (result) {
                                                    if (eval(result).Msg) {
                                                        if (eval(result).Error && eval(result).Error == 'false') {
                                                            $.messager.alert('提示', eval(result).Msg);
                                                        }
                                                        else {
                                                            $.messager.alert('提示', eval(result).Msg);
                                                        }
                                                    }
                                                }
                                            });

                                        }
                                    })
                                }
                            },
                            {
                                text: "生成全部", iconCls: "icon-search", handler: function () {
                                    $.messager.confirm('确定', '您确定要全部重新生成吗', function (t) {
                                        if (t) {

                                            $.ajax({
                                                url: "Handler/PointHandler.ashx",
                                                data: {
                                                    'ac': 'create',
                                                    'id': '1'
                                                },
                                                dataType: 'json',
                                                success: function (result) {
                                                    if (eval(result).Msg) {
                                                        if (eval(result).Error && eval(result).Error == 'false') {
                                                            $.messager.alert('提示', eval(result).Msg);
                                                        }
                                                        else {
                                                            $.messager.alert('提示', eval(result).Msg);
                                                        }
                                                    }
                                                }
                                            });

                                        }
                                    })
                                }
                            }
                    ],
                    onAfterEdit: function (rowIndex, rowData, changes) {
                        var inserted = datagrid.datagrid('getChanges', 'inserted');
                        var updated = datagrid.datagrid('getChanges', 'updated');
                        if (inserted.length < 1 && updated.length < 1) {
                            editRow = undefined;
                            datagrid.datagrid('unselectAll');
                            return;
                        }

                        var url = '';
                        if (inserted.length > 0) {
                            url = "Handler/PointHandler.ashx?ac=add";
                        }
                        if (updated.length > 0) {
                            url = "Handler/PointHandler.ashx?ac=edit";
                        }

                        $.ajax({
                            url: url,
                            data: {
                                'data': JSON.stringify(rowData)
                            },
                            dataType: 'json',
                            success: function (r) {
                                if (r.Error) {
                                    datagrid.datagrid('acceptChanges');
                                    $.messager.show({
                                        msg: r.Msg,
                                        title: '成功'
                                    });
                                    editRow = undefined;
                                    datagrid.datagrid('reload');
                                } else {
                                    /*datagrid.datagrid('rejectChanges');*/
                                    //    datagrid.datagrid('beginEdit', editRow);
                                    $.messager.alert('错误', r.Msg, 'error');
                                }
                                datagrid.datagrid('unselectAll');
                            }
                        });

                    },
                    onDblClickCell: function (rowIndex, field, value) {
                        if (rowEditor == undefined) {
                            datagrid.datagrid('beginEdit', rowIndex);
                            rowEditor = rowIndex;
                        }

                    }
                });


                $("#search").click(function () {
                    datagrid.datagrid('load', {
                        text: $("#text").val()
                    });

                });

            })

            //-----------------------------------------------------查询字典-----------------------------------------------------------------
            function searchDicttype() {

              
                var page = $('#dg').datagrid('getPager').data("pagination").options.pageNumber;

                $.ajax({
                    type: 'POST',
                    url: "Handler/PointHandler.ashx",
                    data: {
                        'ac': 'search',
                        'page': page,
                        'title': $("#title").val(),
                        'description': $("#description").val()
                       
                    },
                    dataType: "json",
                    success: function (result) {
                        datagrid.datagrid('loadData', result);
                        $('#searchInfo').window('close');
                    },
                    error: function (ex) {
                        alert(eval(ex).responseText);
                    }
                });

              
            }
    </script>

</head>
<body>
    <form id="form1" runat="server">
    <table id="dg"></table>

    <!----------------------------------------------------------查询信息窗口--------------------------------------------------------->
    <div id="searchInfo" class="easyui-window" title=" 查询热点数据" closed="true" collapsible="false"
         minimizable="false" maximizable="false" iconcls="icon-search" modal="true" style="width: 300px;
        height: 150px; padding: 5px;">
        <div class="easyui-layout" fit="true">
            <div region="center" border="false" style="padding: 10px; background: #fff; border: 1px solid #ccc;">
                <table>
                    <tr>
                        <td>
                            <label>
                                标题：
                            </label>
                        </td>
                        <td></td>
                        <td>
                            <input id="title" type="text" style="width: 100px;" />                      
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label>
                                内容：
                            </label>
                        </td>
                        <td></td>
                        <td>
                            <input id="description" type="text" style="width: 100px;"  />                      
                        </td>
                    </tr>
                </table>
            </div>
            <div region="south" border="false" style="text-align: right; padding: 5px 0;">
                <a class="easyui-linkbutton" iconcls="icon-ok" href="javascript:void(0)" onclick="searchDicttype()">
                    确定
                </a> <a class="easyui-linkbutton" iconcls="icon-cancel" href="javascript:void(0)"
                        onclick="$('#searchInfo').window('close')">取消</a>
            </div>
        </div>
    </div>
    <!-----------------------------------------------------------查询信息窗口 end--------------------------------------------------------->

    </form>
</body>
</html>
