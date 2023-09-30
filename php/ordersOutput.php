<?php 
	$connect_string = "host=localhost port=5432 dbname='DimaExpress' user=postgres password='1369'";
	$link = pg_connect($connect_string);

	$stmt = "SELECT order_list.order_id, order_list.product_id, order_list.quantity, product.name, product.description, product.price, product.image
			FROM order_list 
			inner join product on product.id = order_list.product_id
			where order_list.order_buyer_id = 1 
			order by order_list.order_id";
	pg_prepare($link,"selectOrders", $stmt);
	$result = pg_execute($link,"selectOrders", array());

	$data = pg_fetch_all($result);
	pg_close($link);

	echo json_encode($data);
?>