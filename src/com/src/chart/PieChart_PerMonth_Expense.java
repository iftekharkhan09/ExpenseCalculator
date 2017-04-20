package com.src.chart;
import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import org.jfree.chart.ChartFactory;
import org.jfree.chart.ChartUtilities;
import org.jfree.chart.JFreeChart;
import org.jfree.data.general.DefaultPieDataset;
import java.sql.PreparedStatement;
import com.src.controller.DBConnector;

public class PieChart_PerMonth_Expense {

	public static void main(String[] args) throws SQLException, IOException {

		PieChart_PerMonth_Expense piechart = new PieChart_PerMonth_Expense();
		piechart.create_piechart();
	}

	public void create_piechart() throws SQLException, IOException {
		int width = 200;
		int height = 200;
		String title = "Monthly Expense";
		DefaultPieDataset dataset = new DefaultPieDataset();
		Connection conn = DBConnector.getDBConnection();
		String sql = "select cat.description,sum(total_price) from expense exp inner join item it on it.item_id=exp.item_id inner join Category cat on cat.category_id=it.category_id where date_of_purchase like ? group by cat.category_id";
		PreparedStatement statement = conn.prepareStatement(sql);
		statement.setString(1, "%2015%");
		ResultSet result = statement.executeQuery();
		while (result.next()) {
			dataset.setValue(result.getString(1),
					new Double(result.getDouble(2)));
		}
		statement.close();
		result.close();
		conn.close();
		JFreeChart chart = ChartFactory.createPieChart(title, dataset, true,
				true, false);
		File file = new File("Monthly Expense.jpeg");
		ChartUtilities.saveChartAsJPEG(file, chart, width, height);
	}
}