<?php 
	$connect_string = "host=localhost port=5432 dbname='DimaExpress' user=postgres password='1369'";
	$link = pg_connect($connect_string);

	$product_id = $_POST['item_id'];

	$stmt = "SELECT EXISTS (SELECT * FROM cart_list WHERE buyer_id = 1 and product_id = $1) limit 1";
	pg_prepare($link,"isExists", $stmt);
	$result = pg_execute($link,"isExists", array($product_id));

	$is_exists = pg_fetch_assoc($result)['exists'];

	if ($is_exists == 't') {
		$stmt = "SELECT quantity from cart_list where buyer_id = 1 and product_id = $1 limit 1";
		pg_prepare($link,"getQuantity", $stmt);
		$result = pg_execute($link,"getQuantity", array($product_id));

		$quantity = pg_fetch_assoc($result)['quantity'];

		$stmt = "UPDATE cart_list set quantity = $1 where buyer_id = 1 and product_id = $2";
		pg_prepare($link,"updateCartList", $stmt);
		pg_execute($link,"updateCartList", array($quantity + 1, $product_id));
	} else {
		$stmt = "INSERT into cart_list (product_id, buyer_id, quantity) values ($1, 1, 1)";
		pg_prepare($link,"addToCartList", $stmt);
		pg_execute($link,"addToCartList", array($product_id));
	}

	pg_close($link);
?>