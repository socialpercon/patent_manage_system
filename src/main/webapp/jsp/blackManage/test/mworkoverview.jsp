<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>原创成果总览</title>
	
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/table.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/js/jquery-easyui-1.4.4/themes/icon.css"/>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/js/jquery-easyui-1.4.4/themes/gray/easyui.css"/>
<script src="<%=request.getContextPath()%>/js/jquery-easyui-1.4.4/jquery.min.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/js/jquery-easyui-1.4.4/jquery.easyui.min.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/js/jquery-easyui-1.4.4/locale/easyui-lang-zh_CN.js"></script>
	
<script type="text/javascript">

$(function () {
            
            
            
            $('#roleList').datagrid({
            	
                title: '',
                loadMsg: "数据加载中，请稍后……",
                nowrap: false,
                striped: true,
                collapsible: true,
               	
                pageList: [10, 20,30,50],
                pageSize: 10,
                sortName: 'DATE',
                sortOrder: 'asc',
                remoteSort: true,
                idField: 'CODE',
                checkOnSelect:false, 
                method:'get',
                frozenColumns :[[
					{field :'ck',checkbox : true}, 
				]],
				columns: [[
				//{field : 'CODE', title : '编号',width :160,align:'center'},
				{field : 'title', title : '成果名称',width :336,align:'center'},
				{field : 'time',title : '提交时间',width : 160,align:'center',sortable:true},
				{field : 'field',title : '技术领域',width : 160,align:'center'},
				 { field: 'opt', title: '详情了解', width: 160, align: 'center',
                    formatter: function (value,row,index) {
                    	return "<a href='#' onclick='alert("+index+")'>查看详情</a>";  
                    }
                }
              
          		]],
          		toolbar: [{//在dategrid表单的头部添加按钮
              	  text: "提交创新成果",
              	  iconCls: "icon-add",
              	  handler: function () {
              		window.location.href=""; 
              	  }
                },'-',
                {
              	  text: "删除创新成果",
              	  iconCls: "icon-cut",
              	  handler: function () {
              		  var post= $('#roleList').datagrid('getSelections');
              		  var id = new Array([post.length]);
              		  for(var i=0;i<post.length;i++){
              			  id[i]=post[i].CODE;
              			  alert(id[i]);
              		  }
              		var opts = $('#roleList').datagrid('options');
                	var page=opts.pageNumber;
                	var size=opts.pageSize;
                	var sort=opts.sortName;
                	var order=opts.sortOrder;
                    $.ajax({
                        url:'<%=request.getContextPath()%>/test/test9.json',
                        data:{"pageNum":page,"pageSize":size,"sort":sort,"order":order,"remove":id},
                        type: 'post',
                        dataType : "text",
                        traditional:true,
                    	error: function(XMLHttpRequest, textStatus, errorThrown) {
        	       			alert(XMLHttpRequest.status);
        	       			alert(XMLHttpRequest.readyState);
        	       			alert(textStatus);
        	       		},
               			   
                        success: function (msg) {
                        	
                        	var result = eval("("+msg+")");
        					
         						$("#roleList").datagrid("loadData",result);
         					
                            
                     
                        }
                    });
                    $('#roleList').datagrid('clearSelections').datagrid("clearChecked");
              	  }                  
                }],
                pagination: true,
                rownumbers: true,
                onSortColumn:function(sort, order){
                	sear();
                },
                onLoadSuccess: function () {
                	
                    $('.datagrid-toolbar').append($('#txtSearch'));
                    $('#txtSearch').show();
                }
            });
            sear();
        	$('#roleList').datagrid('getPager').pagination( {
        		pageList: [10, 20,30,50],
                pageSize: 10,
				beforePageText : '第',
				afterPageText : '页    共 {pages} 页',
				displayMsg : '当前显示从{from}到{to}共{total}记录',
				onBeforeRefresh : function(pageNumber, pageSize) {
					$('#roleList').datagrid('clearSelections').datagrid("clearChecked");
					
				},
				onSelectPage:function(pageNum, pageSize){
					var gridOpts = $('#roleList').datagrid('options');
					gridOpts.pageNumber = pageNum; 
					gridOpts.pageSize = pageSize;
					sear();
				}
				

			});
                                                 
            });
        function getSelections() {
            var ids = [];
            var rows = $('#roleList').datagrid('getSelections');
            for (var i = 0; i < rows.length; i++) {
                ids.push(rows[i].RoleCode);
            }
            return ids.join(',');
        }
        function sear(){
        	var opts = $('#roleList').datagrid('options');
        	var page=opts.pageNumber;
        	var size=opts.pageSize;
        	var sort=opts.sortName;
        	var order=opts.sortOrder;
            $.ajax({
                url:'<%=request.getContextPath()%>/test/test9.json',
                data:{"pageNum":page,"pageSize":size,"sort":sort,"order":order},
                type: 'post',
                dataType : "text",
            	error: function(XMLHttpRequest, textStatus, errorThrown) {
	       			alert(XMLHttpRequest.status);
	       			alert(XMLHttpRequest.readyState);
	       			alert(textStatus);
	       		},
       			   
                success: function (msg) {
                	
                	var result = eval("("+msg+")");
					
 						$("#roleList").datagrid("loadData",result);
 					
                    
             
                }
            });
        }
 </script>
	
	
	
</head>

<body>

 <div>
     <div class="topnav"  >
	   <div  class="path" >
	      <span ><font>当前位置:</font></span>
	      <span ><font >成果发布&nbsp;&nbsp; &gt;&nbsp;&nbsp;原创成果管理</font></span>
	   </div>
     </div> 
		 
    <div class="context" style="width:870px;">
     <div class="titlebox" style="width:100%; margin:0 auto;"><span class="title" >我的创新成果</span></div>
       	<!-- 显示总览 -->
		<table id="roleList" style="width:100%;" >
	    
	    </table>
	    
	
   </div>   
 	     
 </div>
</body>
</html>