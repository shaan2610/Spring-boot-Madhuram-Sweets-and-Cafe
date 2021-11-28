package com.madhuram.web.controller;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.madhuram.web.dao.CartDao;
import com.madhuram.web.dao.CategoryDao;
import com.madhuram.web.dao.ItemsDao;
import com.madhuram.web.dao.OrdersDao;
import com.madhuram.web.dao.ParameterDao;
import com.madhuram.web.dao.UserDao;
import com.madhuram.web.dao.ItemsDao;
import com.madhuram.web.dao.TransactionDao;
import com.madhuram.web.dao.OrderedItemsDao;
import com.madhuram.web.entities.Cart;
import com.madhuram.web.entities.CartItem;
import com.madhuram.web.entities.Items;
import com.madhuram.web.entities.OrderedItems;
import com.madhuram.web.entities.Orders;
import com.madhuram.web.entities.Parameters;
import com.madhuram.web.entities.Users;
import com.madhuram.web.entities.Transactions;
import com.madhuram.web.services.SecurityService;

@Controller
@RequestMapping("/user/payment")
public class PaymentController {
	
	private static final int BUFFER_SIZE = 4096;
	
	@Autowired
	private SecurityService securityService;
	@Autowired
	UserDao userDao;
	@Autowired
	OrdersDao ordersDao;
	@Autowired
	CartDao cartDao;
	@Autowired
	ItemsDao itemsDao;
	@Autowired
	CategoryDao categoryDao;
	@Autowired
	ParameterDao parameterDao;
	@Autowired
	TransactionDao transactionDao;
	@Autowired
	OrderedItemsDao orderedItemsDao;
	
	@GetMapping("/")
	public String home() {
		return "home";
	}
	
	@ModelAttribute
	public void addAttributes(Model model) {
	    model.addAttribute("username", securityService.findLoggedInUsername());
	    model.addAttribute("userid", userDao.get(securityService.findLoggedInUsername()).getUserID());
	}
	
	private String invoice(Users u, Orders o, List<OrderedItems> l) throws JSONException, IOException {
		URL url = new URL("https://invoice-generator.com");
		JSONObject data = new JSONObject();
		data.put("logo", "https://i.ibb.co/XF0R7YV/madhuram-sweets.png");
		data.put("from", "Madhuram Sweets and Cafe,\nSector-4, City Centre, Bokaro \nJharkhand - 827003");
		data.put("to", u.getName() + '\n' + "Email: " + u.getEmailAddress() + "\n" + "Phone: " + u.getPhoneNumber());
		data.put("ship_to", u.getHouseNo() + "\n" + u.getLocality() + "\n" + u.getStreet());
		data.put("number", o.getOrderID());
		data.put("currency", "INR");
		data.put("date", o.getOrderDate().toString());
		data.put("tax", o.getGST());
		data.put("shipping", o.getDeliveryCharge());
		data.put("amount_paid", 0);
		data.put("notes", "Thanks!! for shopping with us. \nWe hope you will visit again soon!!");
		JSONArray a = new JSONArray();
		for(OrderedItems item: l) {
			JSONObject itemc = new JSONObject();
			itemc.put("quantity", item.getQty());
			Items i = itemsDao.get(item.getItemID());
			itemc.put("unit_cost", i.getItemCost());
			itemc.put("name", i.getItemName());
			a.put(itemc);
		}
		data.put("items", a);
		String post_data = data.toString();
		System.out.print(post_data);
		HttpURLConnection connection = (HttpURLConnection) url.openConnection();
		connection.setRequestMethod("POST");
		connection.setRequestProperty("Content-Type", "application/json");
		connection.setDoOutput(true);
		connection.setDoInput(true);
		DataOutputStream requestWriter = new DataOutputStream(connection.getOutputStream());
		requestWriter.writeBytes(post_data);
		requestWriter.close();
		InputStream inputStream = connection.getInputStream();
		String saveFilePath = System.getProperty("user.dir") + "/src/main/resources/invoice/" + "INVOICE_ID_" + o.getOrderID() + ".pdf";
		FileOutputStream outputStream = new FileOutputStream(saveFilePath);
		System.out.println(saveFilePath);
        int bytesRead = -1;
        byte[] buffer = new byte[BUFFER_SIZE];
        while ((bytesRead = inputStream.read(buffer)) != -1) {
            outputStream.write(buffer, 0, bytesRead);
        }
        outputStream.close();
        inputStream.close();
		return saveFilePath;
	}
	
	 @RequestMapping(value = "/submitPaymentDetail")
	    public String getRedirect(Model m) throws Exception {
		 	Users user = userDao.get(securityService.findLoggedInUsername());
		 	Orders o = new Orders();
		 	o.setOrderDate(LocalDate.now());
		 	o.setOrderTime(LocalTime.now());
		 	Double qty = Double.valueOf(0.0);
		 	List<Cart> items = cartDao.getItemList(user.getUserID());
		 	for(Cart item: items) {
		 		qty += item.getQty();
		 	}
		 	o.setTotalQty(qty);
			Double total = Double.valueOf(0.0);
			for(Cart item: items) {
				Double quantity = item.getQty();
				Integer ItemID = item.getItemID();
				Items j = itemsDao.get(ItemID);
				Double unitCost = j.getItemCost();
				total += unitCost * quantity;
			}
			o.setAmount(total);
			List<Parameters> param = parameterDao.getAll();
			for(Parameters p: param) {
				if(p.getParameter().equals("Delivery Charge")) {
					o.setDeliveryCharge(p.getValue());
				}
				if(p.getParameter().equals("GST Percent")) {
					o.setGST(p.getValue());
				}
			}
			total = total * (1 + o.getGST()/100) + o.getDeliveryCharge();
			o.setTotalAmount(total);
			o.setUserID(user.getUserID());
			o.setStatus("Order placed and is under review");
			String uniquetransID = UUID.randomUUID().toString();
			String uniqueBanktransID = UUID.randomUUID().toString();
			Transactions t=new Transactions();
			t.setTransactionID(uniquetransID);
			t.setBankTransactionID(uniqueBanktransID);
			t.setStatus("Payment due");
			t.setInvoiceAmount(total);
			String uniqinv="dummy";
			t.setInvoice(uniqinv);
			t.setTransactionTime(java.time.LocalDateTime.now());
			Integer UserID=user.getUserID();
			t.setUserID(UserID);
			t.setPaymentMethod("Cash on Delivery");
			o.setTransactionID(uniquetransID);
			transactionDao.save(t);
			ordersDao.save(o);
			m.addAttribute("user", user);
			m.addAttribute("order", o);
			o = ordersDao.get(user.getUserID(), o.getOrderDate(), o.getOrderTime());
			m.addAttribute("orderId", o.getOrderID());
			System.out.println(o.getOrderID());
			List<OrderedItems> oi = new LinkedList();
			for(Cart item: items) {
				OrderedItems i = new OrderedItems();
				i.setItemID(item.getItemID());
				i.setOrderID(o.getOrderID());
				i.setQty(item.getQty());
				oi.add(i);
				orderedItemsDao.save(i);
			}
			uniqinv=invoice(user, o, oi);
			transactionDao.updateInvoice(uniquetransID, uniqinv);
			List<CartItem> cl = new LinkedList();
			for(Cart c: items) {
				Double quantity = c.getQty();
				Integer ItemID = c.getItemID();
				Items j = itemsDao.get(ItemID);
				String itemName = j.getItemName();
				Integer categoryID = j.getCategoryID();
				String categoryName = categoryDao.get(categoryID).getCategoryName();
				Double unitCost = j.getItemCost();
				CartItem cp = new CartItem(itemName, quantity, categoryName, unitCost, ItemID);
				cl.add(cp);
			}
			cartDao.clearCart(user.getUserID()); 	
	        m.addAttribute("order", o);
	        m.addAttribute("items", cl);
			m.addAttribute("txn", t);
	        return "txnsuccess";
	    }
	 
	 
	 	@ResponseBody
		@RequestMapping(
			value = "/downloadinvoice",
			produces = MediaType.APPLICATION_OCTET_STREAM_VALUE,
			method = RequestMethod.POST
		)
		private FileSystemResource download(@RequestBody MultiValueMap<String, String> formData, Model m) throws IOException {
			String tid = formData.getFirst("tid");
			System.out.println(tid);
			Transactions t = transactionDao.get(tid);
			String filepath = t.getInvoice();
			return new FileSystemResource(filepath); 
		}
}