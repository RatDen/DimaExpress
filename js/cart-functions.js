function itemsInCartOutput() {
	$.ajax({
	  type: "POST",
	  url: "php/itemsInCartOutput.php",
	  dataType: 'json',
	  success: function(data) {
	    var idArr        	=   data['product_id'].split("&");
	    var quantityArr		=	data['quantity'].split("&");
	    var nameArr    		=   data['name'].split("&");
	    var descriptionArr  =   data['description'].split("&");
	    var priceArr   		=   data['price'].split("&");
	    var imageArr        =   data['image'].split("&");
	    var sum				=	data['sum'];

	    const container	= document.getElementById('products-container');
	    const template 	= document.getElementById('product-card-template');
	    const card 		= template.content.querySelector('.card');
	    const title 	= template.content.querySelector('.card-title');
	    const text 		= template.content.querySelector('.card-text');
	    const price 	= template.content.querySelector('.price');
	    const image 	= template.content.querySelector('.card-img');
	    const quantity 	= template.content.querySelector('.quantity');
	    var cardTmp;


	    for (let i = idArr.length - 1; i >= 0 ; i--) {	    	
	    	card.setAttribute('id', idArr[i]);
	    	quantity.textContent 	= quantityArr[i];
	    	title.textContent		= nameArr[i];
	    	text.textContent 		= descriptionArr[i];
	    	price.textContent 		= priceArr[i];
	    	image.setAttribute('src', imageArr[i]);

	    	container.append(template.content.cloneNode(true));
	    }

	    const totalPrice = document.getElementById('sum');
	    totalPrice.textContent = sum;
	  }
	});
}

function minusItem(button) {
	const product_id = button.parentNode.parentNode.getAttribute('id');

	$.ajax({
	  type: "POST",
	  url: "php/minusItem.php",
	  data: 'product_id=' + product_id,
	  dataType: 'json',
	  success: function(result) {
	  	if (result == "deleted") {
	  		button.parentNode.parentNode.parentNode.removeChild(product_id);
	  	} else {
	  		button.parentNode.querySelector('.quantity').textContent = result['result'];
	  		document.getElementById('sum').textContent = result['sum'];
	  	}
	  }
	});
}

function plusItem(button) {
	const product_id = button.parentNode.parentNode.getAttribute('id');

	$.ajax({
	  type: "POST",
	  url: "php/plusItem.php",
	  data: 'product_id=' + product_id,
	  dataType: 'json',
	  success: function(result) {
	  	button.parentNode.querySelector('.quantity').textContent = result['quantity'];
	  	document.getElementById('sum').textContent = result['sum'];
	  }
	});
}

function buy() {
	$.ajax({
	  type: "POST",
	  url: "php/buy.php",
	  dataType: 'json',
	  success: function(result) {
	  	if (result == "1") {
	  		alert("Успешно!");
	  		window.location.href = '../orders.html';
	  	} else {
	  		alert("Корзина пуста или возникла непредвиденная ошибка");
	  	}
	  }
	});
}