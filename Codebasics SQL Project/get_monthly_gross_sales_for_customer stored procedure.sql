CREATE DEFINER=`root`@`localhost` PROCEDURE `get_monthly_gross_sales_for_customer`(
c_code INT
)
BEGIN
     SELECT 
       s.date,
       SUM(ROUND(s.sold_quantity*g.gross_price , 2)) as montly_sales
	 FROM fact_sales_monthly s
     JOIN fact_gross_price g
         ON g.fiscal_year = get_fiscal_year(s.date)
         AND g.product_code = s.product_code
      WHERE 
        customer_code = c_code
	  GROUP BY date;
END