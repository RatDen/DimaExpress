function productOutput() {
	$.ajax({
	  type: "POST",
	  url: "php/productOutput.php",
	  dataType: 'json',
	  success: function(data) {
	    var idArr        	=   data['id'].split("&");
	    var nameArr    		=   data['name'].split("&");
	    var descriptionArr  =   data['description'].split("&");
	    var priceArr   		=   data['price'].split("&");
	    var imageArr        =   data['image'].split("&");

	    const container	= document.getElementById('products-container');
	    const template 	= document.getElementById('product-card-template');
	    const card 		= template.content.querySelector('.card');
	    const title 	= template.content.querySelector('.card-title');
	    const text 		= template.content.querySelector('.card-text');
	    const price 	= template.content.querySelector('.price');
	    const image 	= template.content.querySelector('.card-img');
	    var cardTmp;


	    for (let i = idArr.length - 1; i >= 0 ; i--) {	    	
	    	card.setAttribute('id', idArr[i]);
	    	title.textContent	= nameArr[i];
	    	text.textContent 	= descriptionArr[i];
	    	price.textContent 	= priceArr[i];
	    	image.setAttribute('src', imageArr[i]);

	    	container.append(template.content.cloneNode(true));
	    } 
	  }
	});
}

function addToCart(button) {
	var item_id = button.parentNode.getAttribute("id");

	$.ajax({
		type: 'POST',
		url: 'php/addToCart.php',
		data: 'item_id=' + item_id,
		success: function() {
			alert("Успешно добавлено!");
		},
		error: function() {
		alert("Внимание, непредвиденная ошибка!");
		},
	});
};