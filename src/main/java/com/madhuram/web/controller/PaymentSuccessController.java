package com.madhuram.web.controller;

import java.io.DataOutputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.time.LocalDateTime;
import java.util.LinkedList;
import java.util.List;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.http.MediaType;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.view.RedirectView;

import com.madhuram.web.dao.CartDao;
import com.madhuram.web.dao.CategoryDao;
import com.madhuram.web.dao.ItemsDao;
import com.madhuram.web.dao.OrderedItemsDao;
import com.madhuram.web.dao.OrdersDao;
import com.madhuram.web.dao.TransactionDao;
import com.madhuram.web.dao.UserDao;
import com.madhuram.web.entities.Cart;
import com.madhuram.web.entities.CartItem;
import com.madhuram.web.entities.Items;
import com.madhuram.web.entities.OrderedItems;
import com.madhuram.web.entities.Orders;
import com.madhuram.web.entities.Transactions;
import com.madhuram.web.entities.Users;
import com.madhuram.web.services.SecurityService;

@Controller
public class PaymentSuccessController {
	
	private static final int BUFFER_SIZE = 4096;
	
	@Autowired
	OrdersDao ordersDao;
	
	@Autowired
	UserDao userDao;
	
	@Autowired
	ItemsDao itemDao;
	
	@Autowired
	CartDao cartDao;
	
	@Autowired
	OrderedItemsDao orderedItemsDao;
	
	@Autowired
	TransactionDao transactionDao;
	
	@Autowired
	CategoryDao categoryDao;
	
	@Autowired
	private SecurityService securityService;
	
	@Autowired
	PasswordEncoder passwordEncoder;
	
	@RequestMapping("/pgresponse/failed")
	public String failed(@ModelAttribute("data") Object flashAttribute, Model m) {
		return "/txnfailed";
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
