$(function () {
	 let orderId = getQueryString("orderId");
	 let sysUsername=getQueryString("sysUsername")
	 let url='../orderprocess/list'
		 if (orderId) {
		        url += '?orderId=' + orderId;
		    }
	 if(sysUsername){
		 url+='sysUsername='+sysUsername;
	 }
    $("#jqGrid").jqGrid({
        url: url,
        datatype: "json",
        colModel: [
			{label: 'id', name: 'id', index: 'id', key: true, hidden: true},
			{label: '进度描述', name: 'desc', index: 'desc', width: 80},
			{label: '添加时间', name: 'addTime', index: 'add_time', width: 80,
				 formatter: function (value) {
	                    return transDate(value);
	                }	
			},
		
			{label: '记录人', name: 'sysUsername', index: 'sys_username', width: 80}],
		viewrecords: true,
        height: 385,
        rowNum: 10,
        rowList: [10, 30, 50],
        rownumbers: true,
        rownumWidth: 25,
        autowidth: true,
        multiselect: true,
        pager: "#jqGridPager",
        jsonReader: {
            root: "page.list",
            page: "page.currPage",
            total: "page.totalPage",
            records: "page.totalCount"
        },
        prmNames: {
            page: "page",
            rows: "limit",
            order: "order"
        },
        gridComplete: function () {
            $("#jqGrid").closest(".ui-jqgrid-bdiv").css({"overflow-x": "hidden"});
        }
    });
});

let vm = new Vue({
	el: '#rrapp',
	data: {
        showList: true,
        order:{},
        title: null,
		orderProcess: {},
		ruleValidate: {
			name: [
				{required: true, message: '名称不能为空', trigger: 'blur'}
			]
		},
		q: {
		    name: ''
		}
	},

	methods: {
		getOrderInfo: function(){
			  $.get("../order/info/" + getQueryString("orderId"), function (r) {
	          	vm.order = r.order;
	        	vm.orderProcess.orderId=vm.order.id;
	          });
		},
		query: function () {
			vm.reload();
		},
		add: function () {
			vm.showList = false;
			vm.title = "新增";
			vm.orderProcess = {};
			vm.getOrderInfo();
		
		},
		update: function (event) {
            let id = getSelectedRow();
			if (id == null) {
				return;
			}
			vm.showList = false;
            vm.title = "修改";

            vm.getInfo(id)
            vm.getOrderInfo();
		},
		saveOrUpdate: function (event) {
            let url = vm.orderProcess.id == null ? "../orderprocess/save" : "../orderprocess/update";
			$.ajax({
				type: "POST",
			    url: url,
			    contentType: "application/json",
			    data: JSON.stringify(vm.orderProcess),
                success: function (r) {
                    if (r.code === 0) {
                        alert('操作成功', function (index) {
                            vm.reload();
                        });
                    } else {
                        alert(r.msg);
                    }
                }
			});
		},
		del: function (event) {
            let ids = getSelectedRows();
			if (ids == null){
				return;
			}

			confirm('确定要删除选中的记录？', function () {
				$.ajax({
					type: "POST",
				    url: "../orderprocess/delete",
				    contentType: "application/json",
				    data: JSON.stringify(ids),
				    success: function (r) {
						if (r.code == 0) {
							alert('操作成功', function (index) {
								$("#jqGrid").trigger("reloadGrid");
							});
						} else {
							alert(r.msg);
						}
					}
				});
			});
		},
		getInfo: function(id){
			$.get("../orderprocess/info/"+id, function (r) {
                vm.orderProcess = r.orderProcess;
            });
		},
		reload: function (event) {
			vm.showList = true;
            let page = $("#jqGrid").jqGrid('getGridParam', 'page');
			$("#jqGrid").jqGrid('setGridParam', {
                postData: {'sysUsername': vm.q.sysUsername},
                page: page
            }).trigger("reloadGrid");
            vm.handleReset('formValidate');
		},
        handleSubmit: function (name) {
            handleSubmitValidate(this, name, function () {
                vm.saveOrUpdate()
            });
        },
        handleReset: function (name) {
            handleResetForm(this, name);
        }
	}
});