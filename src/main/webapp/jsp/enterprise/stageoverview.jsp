<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>阶段管理总览</title>
	
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
				//{field : 'project_id', title : '编号',width :160,align:'center'},
				//{field : 'id', title : '序号',width :160,align:'center'},
				{field : 'project_name', title : '科技项目名称',width :336,align:'center',sortable:true},
				{field : 'type',title : '计划类别',width : 208,align:'center'},
/* 				{field : 'field',title : '技术领域',width : 160,align:'center'},  */
				{field : 'submit',title : '是否提交',width : 160,align:'center'}, 
				{field : 'evaluate',title : '是否审核',width : 160,align:'center'}, 
				{field : 'date',title : '提交时间',width : 160,align:'center',sortable:true},
				 { field: 'opt', title: '详情了解', width: 160, align: 'center',
                    formatter: function (value,row,index) {
                    	if(document.getElementById("sort").value == "项目执行情况报表（中期）"){
                    		return "<a href='<%=request.getContextPath()%>/enterprise/middleView?id="+row.id+"' >查看详情</a>"; 
                    	}
						if(document.getElementById("sort").value == "项目执行情况报表（半年）"){
							return "<a href='<%=request.getContextPath()%>/enterprise/halfyearView?id="+row.id+"' >查看详情</a>"; 
						}
						if(document.getElementById("sort").value == "项目执行情况报表（全年）"){
							return "<a href='<%=request.getContextPath()%>/enterprise/wholeyearView?id="+row.id+"' >查看详情</a>"; 
						}
                    		 
                    }//半年halfyearview，全年wholeyearview，中期middleview，编辑和待修改状态进对应的填表页面
                }
              
          		]],
          		toolbar: [ {
            		text: '<select style="width:230px;" id="sort"  name="sort"><option value="项目执行情况报表（半年）">项目执行情况报表（半年）</option><option value="项目执行情况报表（全年）">项目执行情况报表（全年）</option><option value="项目执行情况报表（中期）">项目执行情况报表（中期）</option></select>',
          	  },{
          		text: "搜索",
            	  iconCls: "icon-search",
            	  handler: function () {            		   
            		      sear();            		 
            	  }
          	  },'-',{//在dategrid表单的头部添加按钮
              	  text: "提交项目执行情况报表",
              	  iconCls: "icon-add",
              	  handler: function () {
              		var sort=$("#sort").val();
              		  window.location.href="<%=request.getContextPath()%>/jsp/enterprise/halfyear.jsp";           		  	
              	  }//不同表进对应的填表页面
                }
                ],
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
        	var state=document.getElementById("sort").value;
            $.ajax({
                url:'<%=request.getContextPath()%>/enterprise/stageoverview',
                data:{"pageNum":page,"pageSize":size,"sort":sort,"order":order,"state":state},
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
	      <span ><font >科技项目管理&nbsp;&nbsp; &gt;&nbsp;&nbsp;阶段管理</font></span>
	   </div>
     </div> 
		 
    <div class="context" style="width:1040px;">
     <div class="titlebox" style="width:100%; margin:0 auto;"><span class="title" >阶段报告总览</span></div>
       	<!-- 显示总览 -->
		<table id="roleList" style="width:100%;" >
	    
	    </table>
	    
	
   </div>   
 	     
 </div>
</body>
</html>