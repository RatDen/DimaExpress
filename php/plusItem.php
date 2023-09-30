<?php 
	$connect_string = "host=localhost port=5432 dbname='DimaExpress' user=postgres password='1369'";
	$link = pg_connect($connect_string);

	$product_id = $_POST['product_id'];

	$stmt = "SELECT quantity from cart_list where buyer_id = 1 and product_id = $1 limit 1";
	pg_prepare($link,"getQuantity", $stmt);
	$result = pg_execute($link,"getQuantity", array($product_id));

	$quantity = pg_fetch_assoc($result)['quantity'];

	$stmt = "UPDATE cart_list set quantity = $1 where buyer_id = 1 and product_id = $2";
	pg_prepare($link,"updateCart", $stmt);
	pg_execute($link,"updateCart", array($quantity + 1, $product_id));

	$stmt = "SELECT cart_list.quantity, product.price
			 from cart_list
			 inner join product on product.id = cart_list.product_id
			 where cart_list.buyer_id = 1";
	pg_prepare($link,"getSum", $stmt);
	$result = pg_execute($link,"getSum", array());

	$sum = 0;

	while ($row = pg_fetch_assoc($result)) { 
		$sum += $row['quantity'] * $row['price'];
	}

	pg_close($link);
	echo json_encode(array('quantity' => $quantity + 1, 'sum' => $sum));
?>