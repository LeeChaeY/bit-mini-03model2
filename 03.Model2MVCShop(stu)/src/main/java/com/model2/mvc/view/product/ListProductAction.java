package com.model2.mvc.view.product;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.framework.Action;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.product.impl.ProductServiceImpl;

public class ListProductAction extends Action {
	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		Search search = new Search();
		
		int currentPage=1;
		String menu = null;
		
		if(request.getParameter("currentPage") != null)
			currentPage=Integer.parseInt(request.getParameter("currentPage"));
		if(request.getParameter("menu") != null)
			menu = request.getParameter("menu");
		
		search.setCurrentPage(currentPage);
		if (request.getParameter("searchCondition") != null)
			search.setSearchCondition(request.getParameter("searchCondition"));
		if (request.getParameter("searchKeyword") != null)
			search.setSearchKeyword(request.getParameter("searchKeyword"));
		
		int pageSize = Integer.parseInt( getServletContext().getInitParameter("pageSize"));
		int pageUnit  =  Integer.parseInt(getServletContext().getInitParameter("pageUnit"));
		search.setPageSize(pageSize);
		
		ProductService service=new ProductServiceImpl();
		Map<String,Object> map=service.getProductList(search);
		
		Page resultPage	= 
				new Page( currentPage, ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println("ListUserAction ::"+resultPage);

		request.setAttribute("list", map.get("list"));
		request.setAttribute("resultPage", resultPage);
		request.setAttribute("search", search);
		request.setAttribute("menu", menu);
		
		return "forward:/product/listProduct.jsp";
	}

}