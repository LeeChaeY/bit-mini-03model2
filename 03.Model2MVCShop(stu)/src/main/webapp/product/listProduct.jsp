<%@ page contentType="text/html; charset=euc-kr" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:choose>
	<c:when test="${ !empty menu && menu.equals('manage') }">
		<c:set var="title" value="��ǰ ����"/>
	</c:when>
	<c:when test="${ !empty menu && menu.equals('search') }">
		<c:set var="title" value="�����ȸ"/>
	</c:when>
</c:choose>

<html>
<head>
	<title>${ title }</title>

	<link rel="stylesheet" href="/css/admin.css" type="text/css">

	<script type="text/javascript">
	
	function fncGetList(currentPage){
		document.getElementById("currentPage").value = currentPage;
		document.detailForm.submit();
	}
	
</script>
</head>

<body bgcolor="#ffffff" text="#000000">

<div style="width:98%; margin-left:10px;">

<form name="detailForm" action="/listProduct.do?menu=${!empty menu ? menu : ''}" method="post">

<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37">
			<img src="/images/ct_ttl_img01.gif" width="15" height="37"/>
		</td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left:10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">
						${ title }
					</td>
				</tr>
			</table>
		</td>
		<td width="12" height="37">
			<img src="/images/ct_ttl_img03.gif" width="12" height="37"/>
		</td>
	</tr>
</table>


<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td align="right">
			<select name="searchCondition" class="ct_input_g" style="width:80px">
				<option value="0" 
					${ !empty search.searchCondition && search.searchCondition.equals("0") ? "selected" : ""}>
						��ǰ��ȣ
				</option>
				<option value="1" 
					${!empty search.searchCondition && search.searchCondition.equals("1") ? "selected" : ""}>
						��ǰ��
				</option>
				<option value="2" 
					${!empty search.searchCondition && search.searchCondition.equals("2") ? "selected" : ""}>
						��ǰ����
				</option>
			</select>
		<input type="text" name="searchKeyword" value="${ search.searchKeyword }" 
							class="ct_input_g" style="width:200px; height:19px" />
		</td>
		<td align="right" width="70">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="17" height="23">
						<img src="/images/ct_btnbg01.gif" width="17" height="23">
					</td>
					<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top:3px;">
						<a href="javascript:fncGetList('1');">�˻�</a>
					</td>
					<td width="14" height="23">
						<img src="/images/ct_btnbg03.gif" width="14" height="23">
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>


<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td colspan="11" >
			��ü  ${ resultPage.totalCount } �Ǽ�,	���� ${ resultPage.currentPage } ������
		</td>
	</tr>
	<tr>
		<td class="ct_list_b" width="100">No</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">��ǰ��</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">����</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">�����</td>	
		<td class="ct_line02"></td>
		<td class="ct_list_b">�������</td>	
	</tr>
	<tr>
		<td colspan="11" bgcolor="808285" height="1"></td>
	</tr>
	<c:set var="i" value="0"></c:set>
	<c:forEach var="product" items="${ list }">
		<c:set var="i" value="${i+1}"/>
		<tr class="ct_list_pop">
			<td align="center">${ i }</td>
			<td></td>
			<td align="left">
				<a href="/getProduct.do?prodNo=${ product.prodNo }&menu=${ menu }">${ product.prodName }</a>
			</td>
			
			<td></td>
			<td align="left">${ product.price }</td>
			<td></td>
			<td align="left">${ product.regDate }</td>
			<td></td>
			
			<td align="left">
			<c:choose>
				<c:when test="${(empty user) || !empty user && !empty user.role && user.role.equals('user') }">
					${ empty product.proTranCode ? "�Ǹ���" : "��� ����" }
					<%-- ��� ����, �Ǹ���
					���ſ� ��ǰ ���̵� ������ �Ǹ���, ������ ��� ���� --%>			
				</c:when>
				<c:when test="${ !empty user.role && user.role.equals('admin') }">
					<%-- manage, search ������� --%>
					<c:choose>
						<c:when test="${ empty product.proTranCode }">
							�Ǹ���
						</c:when>
						<c:when test="${ product.proTranCode.equals('2') }">
							�ǸſϷ�
						</c:when>
						<c:when test="${ product.proTranCode.equals('3') }">
							�����
						</c:when>
						<c:when test="${ product.proTranCode.equals('4') }">
							��ۿϷ�
						</c:when>
					</c:choose>
					<c:if test="${ menu.equals('manage') &&  !empty product.proTranCode && product.proTranCode.equals('2') }">
						<a href="/updateTranCodeByProd.do?prodNo=${ product.prodNo }&tranCode=${product.proTranCode }">����ϱ�</a>
					</c:if>
					<%-- <a href="/updateTranCodeByProd.do?prodNo=10001&tranCode=2">����ϱ�</a>
					�����ڿ��Ը� ���̴� ��, ��ǰ �������� ����, ��ǰ �˻����� ���� 
					����ϱ� ������ ��������� ����, ��ǰ���� �������� �ٽ� ���ε�
					����ϱ� ��ư�� �ִ� ���� �Ϸ��϶� tranCode 2�� �Ѱ���--%>
				</c:when>
			</c:choose>
			</td>
		</tr>
		<tr>
			<td colspan="11" bgcolor="D6D7D6" height="1"></td>
		</tr>	
	</c:forEach>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td align="center">
			<input type="hidden" id="currentPage" name="currentPage" value=""/>
			<jsp:include page="../common/pageNavigator.jsp"/>	
		</td>
	</tr>
</table>
<!--  ������ Navigator �� -->

</form>

</div>
</body>
</html>