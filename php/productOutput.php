<?php 
	$connect_string = "host=localhost port=5432 dbname='DimaExpress' user=postgres password='1369'";
	$link = pg_connect($connect_string);

	$stmt = "SELECT * FROM product";
	pg_prepare($link,"selectProduct", $stmt);
	$result = pg_execute($link,"selectProduct", array());
	pg_close($link);

	if ($row = pg_fetch_assoc($result)) {
		$id 			= 	$row['id'];
		$name 			= 	$row['name'];
		$description 	= 	$row['description'];
		$price 			= 	$row['price'];
		$image 			= 	$row['image'];

		while ($row = pg_fetch_assoc($result)) {
			$id 			= 	$id 			. "&" . $row['id'];
			$name 			= 	$name 			. "&" . $row['name'];
			$description 	= 	$description 	. "&" . $row['description'];
			$price 			= 	$price 			. "&" . $row['price'];
			$image 			= 	$image 			. "&" . $row['image'];  
		}
	}

	$change = array('id' => $id, 'name' => $name, 'description' => $description, 'price' => $price, 'image' => $image,);
	echo json_encode($change);
?>