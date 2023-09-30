<?php 
	$connect_string = "host=localhost port=5432 dbname='DimaExpress' user=postgres password='1369'";
	$link = pg_connect($connect_string);

	$stmt = "SELECT EXISTS (SELECT * FROM cart_list WHERE buyer_id = 1 limit 1)";
	pg_prepare($link,"isExists", $stmt);
	$result = pg_execute($link,"isExists", array());

	$is_exists = pg_fetch_assoc($result)['exists'];

	if ($is_exists == 't') {
		$stmt = "SELECT product_id, quantity from cart_list where buyer_id = 1";
		pg_prepare($link,"getDataFromCart", $stmt);
		$data = pg_execute($link,"getDataFromCart", array());

		$stmt = "INSERT into orders (buyer_id, date, address)
				 values (1, $1, 'Lipetsk')
				 returning id";
		pg_prepare($link,"prepareOrder", $stmt);
		$order_id = pg_fetch_assoc(pg_execute($link,"prepareOrder", array(date('Y-m-d'))));

		$stmt = "INSERT into order_list (product_id, order_buyer_id, order_id, quantity) 
				 values ($1, 1, $2, $3)";
		pg_prepare($link,"insertInOrder", $stmt);

		while ($row = pg_fetch_assoc($data)) {
			pg_execute($link,"insertInOrder", array($row['product_id'], $order_id['id'], $row['quantity']));
		}

		$stmt = "DELETE from cart_list where buyer_id = 1";
		pg_prepare($link,"clearCart", $stmt);
		pg_execute($link,"clearCart", array());

		pg_close($link);
		echo json_decode("true");
	} else {
		pg_close($link);
		echo json_encode("false");
	}
?>