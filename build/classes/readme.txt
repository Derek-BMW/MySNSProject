过滤器：AccessFilter：禁止访问一些资源
	   InstallFilter：访问所有的页面都有通过该过滤器

输入主页的时候：index.jsp->otherAction->BaseAction(showMessage)->space.jsp->SpaceAction(execute)
               ->BaseAction(invokeMethod反射)->SpaceAction(space_home(该函数很重要))