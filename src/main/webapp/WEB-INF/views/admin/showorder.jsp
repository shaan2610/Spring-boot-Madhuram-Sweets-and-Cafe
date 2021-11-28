<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<t:adminwrapper>
	<link rel="stylesheet" href="/css/rating.css"/>
	<script src="/js/rating.min.js"></script>
	<div class="container pt-4">
		<h2>Order # ${order.getOrderID()}</h2>
	</div>
	<div class="row">
		<div class="col-3" style="padding-left: 40px">
			<c:choose>
				<c:when test="${order.getStatus() == 'Order placed and is under review'}">
					<form action="/admin/orders/confirmorder/${order.getOrderID()}">
						<button type="submit" class="btn btn-outline-success btn-block" style="widht: 50px; font-size: 24px;">
							Deliver Order
						</button>
					</form>
				</c:when>
			</c:choose>
		</div>
		<div class="col-3"></div>
		<c:choose>
			<c:when test="${order.getStatus() == 'Order placed and is under review'}">
				<form action="/admin/orders/cancelorder/${order.getOrderID()}">
					<button type="submit" class="btn btn-outline-danger btn-block" style="widht: 50px; font-size: 24px;">
						Cancel Order
					</button>
				</form>
			</c:when>
		</c:choose>
	</div>
	<div class="container">
		<h5>
		<div class="row pt-4">
			<div class="col-3 font-weight-bold">
				Order Status
			</div>
			<div class="col-2">
				<c:choose>
			  		 <c:when test="${order.getStatus() == 'Order Delivered'}">
			  		 	<span class="text-success">Order Delivered</span>
			  		 </c:when>
			  		 <c:when test="${order.getStatus() == 'Order Cancelled!!'}">
			  		 	<span class="text-muted">Order Cancelled!!</span>
			  		 </c:when>
			  		 <c:otherwise>
			  		 	<span class="text-danger">${order.getStatus()}</span>
			  		 </c:otherwise>
		  		 </c:choose>
			</div>
		</div>
		<div class="row pt-4">
			<div class="col-3 font-weight-bold">
				Order Time
			</div>
			<div class="col-2">
				${order.getOrderTime()}
			</div>
		</div>
		<div class="row pt-4">
			<div class="col-3 font-weight-bold">
				Order Date
			</div>
			<div class="col-2">
				${order.getOrderDate()}
			</div>
		</div>
		<div class="row pt-4">
			<div class="col-3 font-weight-bold">
				Item Total
			</div>
			<div class="col-2">
				${order.getAmount()} ₹
			</div>
		</div>
		<div class="row pt-4">
			<div class="col-3 font-weight-bold">
				GST Charges
			</div>
			<div class="col-2">
				${order.getGST()} %
			</div>
		</div>
		<div class="row pt-4">
			<div class="col-3 font-weight-bold">
				Delivery Charges
			</div>
			<div class="col-2">
				${order.getDeliveryCharge()} ₹
			</div>
		</div>
		<div class="row pt-4">
			<div class="col-3 font-weight-bold">
				Total Amount
			</div>
			<div class="col-2">
				${order.getTotalAmount()} ₹
			</div>
		</div>
		<div class="row pt-4">
			<div class="col-3 font-weight-bold">
				Payement Method
			</div>
			<div class="col-2">
				${txn.getPaymentMethod()} 
			</div>
		</div>
		<div class="row pt-4">
			<div class="col-3 font-weight-bold">
				Delivery Address
			</div>
			<div class="col-4">
				${user.getHouseNo()}, ${user.getStreet()}
				${user.getLocality()}
			</div>
		</div>
		<div class="row pt-4">
			<div class="col-3 font-weight-bold">
				Customer Phone Number
			</div>
			<div class="col-2">
				${user.getPhoneNumber()}
			</div>
		</div>
		<div class="row pt-4">
			<div class="col-3 font-weight-bold">
				Customer Name
			</div>
			<div class="col-2">
				${user.getName()}
			</div>
		</div>
		<div class="row pt-4">
			<div class="col-3 font-weight-bold">
				Customer ID
			</div>
			<div class="col-2">
				${user.getUserID()}
			</div>
		</div>
		<div class="row pt-4">
			<div class="col-3 font-weight-bold">
				Items:
			</div>
			<div class="col-2">
			</div>
		</div>
		<div class="row pt-4">
				
				<div class="col">
					<p class="font-weight-bold">#</p>
				</div>
				<div class="col-2">
					<p class="font-weight-bold">Item Name</p>
				</div>
				<div class="col">
					<p class="font-weight-bold">Category</p>
				</div>
				<div class="col">
					<p class="font-weight-bold">Quantity</p>
				</div>
				<div class="col">
					<p class="font-weight-bold">Cost</p>
				</div>
				<!-- <div class="col-2">
					<p class="font-weight-bold">Submit Rating</p>
				</div> -->
			</div>
			<c:forEach items="${items}" var="q" varStatus="loop">
				<div class="row">
					
					<div class="col">
						<p>${loop.count}</p>
					</div>
					<div class="col-2">
						<p>${q.getItemName()}</p>
					</div>
					<div class="col">
						<p>${q.getCategory()}</p>
					</div>
					<div class="col">
						<p>${q.getQuantity()}</p>
					</div>
					<div class="col">
						<p>${q.getPrice()} ₹</p>
					</div>
					<!-- <div class="col-2">
						
					</div> -->
				</div>
			</c:forEach>
		<hr/>
		</h5>
		</div>
		<div class="row" style="padding-bottom: 40px">
			<div class="col-3">
				<form action="/downloadinvoice" method="post" target="_blank">
					<input name="tid" value="${txn.getTransactionID()}"  style="display: none;">
			 		<button type="submit" class="btn btn-outline-info float-right" style="widht: 50px; font-size: 24px;">
			 			Download Invoice
			 		</button>
			 	</form>
			</div>
			<div class="col-3">
				<form action="/admin/transactions/${txn.getTransactionID()}">
			 		<button type="submit" class="btn btn-outline-info float-right" style="widht: 50px; font-size: 24px;">
			 			View Transaction
			 		</button>
			 	</form>
			</div>
			<div class="col"></div>
		</div>
<!-- rating.js file -->
</t:adminwrapper>

