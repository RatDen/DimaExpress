<?php 
	$connect_string = "host=localhost port=5432 dbname='DimaExpress' user=postgres password='1369'";
	$link = pg_connect($connect_string);

	$stmt = "SELECT cart_list.product_id, cart_list.quantity, product.name, product.description, product.price, product.image
			 from cart_list
			 inner join product on product.id = cart_list.product_id
			 where cart_list.buyer_id = 1";

	pg_prepare($link,"selectItems", $stmt);
	$result = pg_execute($link,"selectItems", array());
	pg_close($link);

	$sum = 0;
	if ($row = pg_fetch_assoc($result)) {
		$id 			= 	$row['product_id'];
		$quantity		=	$row['quantity'];
		$name 			= 	$row['name'];
		$description 	= 	$row['description'];
		$price 			= 	$row['price'];
		$image 			= 	$row['image'];

		$sum += $row['quantity'] * $row['price'];

		while ($row = pg_fetch_assoc($result)) {
			$id 			= 	$id 			. "&" . $row['product_id'];
			$quantity		=	$quantity		. "&" . $row['quantity'];
			$name 			= 	$name 			. "&" . $row['name'];
			$description 	= 	$description 	. "&" . $row['description'];
			$price 			= 	$price 			. "&" . $row['price'];
			$image 			= 	$image 			. "&" . $row['image']; 

			$sum += $row['quantity'] * $row['price']; 
		}
	}

	$change = array('product_id' => $id, 'quantity' => $quantity, 'name' => $name, 'description' => $description, 'price' => $price, 'image' => $image, 'sum' => $sum);
	echo json_encode($change);
?>