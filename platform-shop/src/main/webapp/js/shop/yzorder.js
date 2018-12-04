let vm = new Vue({
	el: '#rrapp',
	data: {
        showList: true,
        order:{},
        title: "有赞订单导出",
		  q: {
	            starttime:'',
	            endtime:'' ,
	            	orderStatus:''
	            },
	},

	methods: {
		time:function(e){
      	  $.each(e,function(index,item){
      		  console.log(index);
      		 if(index==0){
      			 vm.q.starttime=item
           		
      		 } 
      		 else{
      			vm.q.endtime=item
      		 }
      	  });
        },
        yzdownloadOrder:function(even){
        	window.location.href="../yzorder/downloadOrder?starttime="+vm.q.starttime+"&endtime="+vm.q.endtime+"&orderStatus="+vm.q.orderStatus;
        	 
        }

	}

});