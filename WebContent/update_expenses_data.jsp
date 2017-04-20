<%@page import="com.src.controller.DBConnector"%>
<%@page import="java.sql.Connection" %>
<%@page import="java.sql.PreparedStatement" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title></title>
</head>
<%@page import="java.util.*"%>
<%@page import="com.src.controller.GetExpense_Details"%>
<body>
	<jsp:useBean id="expense" class="com.src.Model.Expense">
	</jsp:useBean>
	<jsp:setProperty property="*" name="expense" />
	<jsp:useBean id="item" class="com.src.Model.Item"></jsp:useBean>
	<jsp:setProperty property="*" name="item" />
	<jsp:useBean id="Category" class="com.src.Model.Category"></jsp:useBean>
	<jsp:setProperty property="*" name="Category" />
	<jsp:useBean id="unit" class="com.src.Model.Unit"></jsp:useBean>
	<jsp:setProperty property="*" name="unit" />
	<jsp:useBean id="reason" class="com.src.Model.Reason"></jsp:useBean>
	<jsp:setProperty property="*" name="reason" />
	<%@page import="com.src.controller.*"%>
	<%@page import="com.src.Model.*"%>
	<%@ page import="java.sql.*"%>
<body>
<%
Connection conn=DBConnector.getDBConnection();
String expense_id=request.getParameter("id");
String delete_transaction="delete from transaction where expense_id=?";
PreparedStatement pre_del_transaction=conn.prepareStatement(delete_transaction);
pre_del_transaction.setString(1, expense_id);
int del_trans=pre_del_transaction.executeUpdate();
String delete_expense="delete from expense where expense_id=?";
PreparedStatement pre_del_statement=conn.prepareStatement(delete_expense);
pre_del_statement.setString(1, expense_id);
int del=pre_del_statement.executeUpdate();
		String exclude[] = request.getParameterValues("exclude");
		String roott = null;
		int j = 0;
		if (exclude != null) {
			String buffer = new String();
			for (String exclu : exclude) {
				j++;
				buffer += exclu + ",";
			}
			int length = buffer.length();
			roott = buffer.substring(0, length - 1);
		}
		conn = DBConnector.getDBConnection();
		String item_sql = "select item_id from item where description=?";
		PreparedStatement item_statement = conn
				.prepareStatement(item_sql);
		item_statement.setString(1, item.getDescription());
		ResultSet item_resultset = item_statement.executeQuery();
		int item_id = 0;
		while (item_resultset.next()) {
			item_id = item_resultset.getInt(1);
		}
		item_statement.close();
		item_resultset.close();
		if (item_id > 0) {
			//do nothing..
		} else {
			int category_id = 0;
			int measurement_id = 0;
			String category_statement = "select Category_id from Category where description=?";
			PreparedStatement cat_statement = conn
					.prepareStatement(category_statement);
			cat_statement.setString(1,
					Category.getCategory_description());
			ResultSet sett = cat_statement.executeQuery();
			while (sett.next()) {
				category_id = sett.getInt(1);
			}
			cat_statement.close();
			sett.close();
			String sqlunit = "select unit_id from unit where description=?";
			PreparedStatement pre_unit = conn.prepareStatement(sqlunit);
			pre_unit.setString(1, unit.getUnit_decription());
			ResultSet set_unit = pre_unit.executeQuery();
			while (set_unit.next()) {
				measurement_id = set_unit.getInt(1);
			}
			pre_unit.close();
			set_unit.close();
			String sqlc = "insert into item(Description,Category_id,measurement_unit)values(?,?,?)";
			PreparedStatement pre = conn.prepareStatement(sqlc);
			pre.setString(1, item.getDescription());
			pre.setInt(2, category_id);
			pre.setInt(3, measurement_id);
			int up = pre.executeUpdate();
			if (up > 0) {
				String sql3 = "select item_id from item where Description=?";
				PreparedStatement item_statememt = conn
						.prepareStatement(sql3);
				item_statememt.setString(1, item.getDescription());
				ResultSet itemid_resultset = item_statememt
						.executeQuery();
				while (itemid_resultset.next()) {
					item_id = itemid_resultset.getInt(1);
				}
			}
			pre.close();
		}
		String i = request.getParameter("paid_by");
		String[] splited = i.split("\\s+");
		String first_name = splited[0];
		String last_name = splited[1];
		String s = "select user_id from user inner join name on user.name_id=name.name_id where name.first_name=? and name.last_name=?";
		PreparedStatement st = conn.prepareStatement(s);
		st.setString(1, first_name);
		st.setString(2, last_name);
		ResultSet r = st.executeQuery();
		int staff_id = 0;
		while (r.next()) {
			staff_id = r.getInt(1);
		}
		st.close();
		r.close();
		String username = session.getAttribute("username").toString();
		Connection fuck = DBConnector.getDBConnection();
		String d = "select staff_id from staff where user_name=?";
		PreparedStatement fg = fuck.prepareStatement(d);
		fg.setString(1, username);
		ResultSet set = fg.executeQuery();
		int staff1 = 0;
		while (set.next()) {
			staff1 = set.getInt(1);
		}
		fg.close();
		set.close();
		String reason_sql = "select reason_id from reason where Description=?";
		PreparedStatement reason_statement = conn
				.prepareStatement(reason_sql);
		reason_statement.setString(1, reason.getReason_description());
		ResultSet reasonset = reason_statement.executeQuery();
		int reason_id = 0;
		while (reasonset.next()) {
			reason_id = reasonset.getInt(1);
		}
		String get_total_users = "select count(*) from user where is_active='Y'";
		Statement sta = conn.createStatement();
		ResultSet ss = sta.executeQuery(get_total_users);
		int h = 0;
		while (ss.next()) {
			h = ss.getInt(1);
		}
		int ex = 0;
		int actual_users = 0;
		if (exclude == null) {
			actual_users = h - ex;
		} else {
			actual_users = h - j;
		}
		double individual_share = 0.0;
		double total_amt = expense.getTotal_price();
		if (actual_users == 0) {
%>
<jsp:include page="Home1.jsp"></jsp:include>
<%
	} else {
			boolean saved = false;
			individual_share = total_amt / actual_users;
			GetExpense_Details expensedetails = new GetExpense_Details();
			boolean save = expensedetails.save_expense_details(expense,
					item_id, staff_id, staff1, reason_id, roott,
					individual_share);
			
			if (save) {
				String get_max_exp_id = "select max(expense_id) from expense";
				Statement statement = conn.createStatement();
				ResultSet get_max_exp_id_set = statement
						.executeQuery(get_max_exp_id);
				int max_id = 0;
				while (get_max_exp_id_set.next()) {
					max_id = get_max_exp_id_set.getInt(1);
				}
				String get_exclude="select exclude from expense where expense_id=?";
				PreparedStatement exclude_statement=conn.prepareStatement(get_exclude);
				exclude_statement.setInt(1,max_id);
				ResultSet exclude_set=exclude_statement.executeQuery();
				
				String exclude1=null;
				while(exclude_set.next())
				{
					exclude1=exclude_set.getString(1);
				}
				String getdetails = "select date_of_purchase,amount_paid_by,individual_share from expense where expense_id=?";
				PreparedStatement getdetails_statement = conn
						.prepareStatement(getdetails);
				getdetails_statement.setInt(1, max_id);
				ResultSet getdet_set = getdetails_statement
						.executeQuery();
				java.sql.Date date_of_purchase = null;
				int amount_paid_by = 0;
				double individual_share1 = 0.0;
				while (getdet_set.next()) {
					date_of_purchase = getdet_set.getDate(1);
					amount_paid_by = getdet_set.getInt(2);
					individual_share1 = getdet_set.getDouble(3);
				}
				String get_users = "select na.first_name from name na inner join user us on us.name_id=na.name_id where us.is_active='Y' and us.start_date<=? order by us.user_id";
				PreparedStatement get_user_statement = conn
						.prepareStatement(get_users);
				get_user_statement.setDate(1, date_of_purchase);
				ResultSet get_user_set = get_user_statement
						.executeQuery();
				String first_namee = null;
				while (get_user_set.next()) {
					first_namee = get_user_set.getString(1);
					
					String first_namee1="%"+first_namee+"%";
					if(exclude1!=null)
					{
					String chk_eclude = "select expense_id from expense where exclude NOT LIKE ? and expense_id=?";
					PreparedStatement statementy = conn
							.prepareStatement(chk_eclude);
					statementy.setString(1, first_namee1);
					statementy.setInt(2, max_id);
					ResultSet chk_set = statementy.executeQuery();
					int id = 0;
					while (chk_set.next()) {
						id = chk_set.getInt(1);

						if (id > 0) {
							String get_id = "select user_id from user where name_id in(select name_id from name where first_name=?)";
							PreparedStatement staty = conn
									.prepareStatement(get_id);
							staty.setString(1, first_namee);
							int user_idd = 0;
							ResultSet mm = staty.executeQuery();
							while (mm.next()) {
								user_idd = mm.getInt(1);

							}	
							saved = GetExpense_Details.insert_data(
									max_id, amount_paid_by, user_idd,
									date_of_purchase, individual_share);
						}
						if(saved)
						{
							out.print("Update has been Successfull!!");

				}
					}
						
			}
					else
					{
						/* out.print("babu"); */
						String chk_eclude = "select expense_id from expense where expense_id=?";
						PreparedStatement statementy = conn
								.prepareStatement(chk_eclude);
					
						statementy.setInt(1, max_id);
						ResultSet chk_set = statementy.executeQuery();
						int id = 0;
						while (chk_set.next()) {
							id = chk_set.getInt(1);

							if (id > 0) {
								String get_id = "select user_id from user where name_id in(select name_id from name where first_name=?)";
								PreparedStatement staty = conn
										.prepareStatement(get_id);
								staty.setString(1, first_namee);
								int user_idd = 0;
								ResultSet mm = staty.executeQuery();
								while (mm.next()) {
									user_idd = mm.getInt(1);

								}
								saved = GetExpense_Details.insert_data(
										max_id, amount_paid_by, user_idd,
										date_of_purchase, individual_share);
							}
							if(saved)
							{
								out.print("Update has been Successfull!!");
							}
						
							
							
					}
					}
		}
			}
	}
	%>
</body>
</html>