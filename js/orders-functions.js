function ordersOutput() {
	$.ajax({
	  type: "POST",
	  url: "php/ordersOutput.php",
	  dataType: 'json',
	  success: function(data) {
	  	const container			= document.getElementById('orders-container');
	    const orderTemplate 	= document.getElementById('order-template');
	    const order				= orderTemplate.content.querySelector('.order');
	    const orderId			= orderTemplate.content.querySelector('.order-id');
	    const orderPrice		= orderTemplate.content.querySelector('.order-price');
	    const cardTemplate 		= document.getElementById('card-template');
	    const quantity 			= cardTemplate.content.querySelector('.quantity');
	    const title 			= cardTemplate.content.querySelector('.card-title');
	    const text 				= cardTemplate.content.querySelector('.card-text');
	    const price 			= cardTemplate.content.querySelector('.price');
	    const image 			= cardTemplate.content.querySelector('.card-img');
	    var currentOrder = document;

	    for (let i = data.length - 1; i >= 0 ; i--) {	    	
	    	
	    	if (currentOrder == document.getElementById(data[i]['order_id'])) {
	    		quantity.textContent 	= data[i]['quantity'];
	    		title.textContent 		= data[i]['name'];
	    		text.textContent 		= data[i]['description'];
	    		price.textContent 		= data[i]['price'];
	    		image.setAttribute('src', data[i]['image']);

	    		currentOrder.querySelector('.order-price').textContent = Number(currentOrder.querySelector('.order-price').textContent) + data[i]['price'] * data[i]['quantity'];

	    		currentOrder.querySelector('.order-body').append(cardTemplate.content.cloneNode(true));
	    	} else {
	    		order.setAttribute('id', data[i]['order_id']);
	    		orderId.textContent 	= data[i]['order_id'];
	    		orderPrice.textContent 	= data[i]['price'] * data[i]['quantity'];

	    		container.append(orderTemplate.content.cloneNode(true));
	    		currentOrder = document.getElementById(data[i]['order_id']);

	    		quantity.textContent 	= data[i]['quantity'];
	    		title.textContent 		= data[i]['name'];
	    		text.textContent 		= data[i]['description'];
	    		price.textContent 		= data[i]['price'];
	    		image.setAttribute('src', data[i]['image']);

	    		currentOrder.querySelector('.order-body').append(cardTemplate.content.cloneNode(true));
	    	}
	    } 
	  },
	  error: function() {
	  	alert('error');
	  }
	});
}