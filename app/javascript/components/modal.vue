<template>
  <transition name="modal">
    <div class="modal-mask">
      <div class="modal-wrapper">
        <div class="modal-container">
			<div>
            本文：<span class="font" v-if="formObject.description.length > 100">{{ formObject.description.length }}文字</span><span class="font">{{ formObject.errorMessage1 }}</span><br />
          	<textarea class="text_area" name="description" v-model="formObject.description" ></textarea><br />
        </div>
		<div>
            リンク：<span class="font" v-if="formObject.errorMessage2"> {{ formObject.errorMessage2 }}</span><br />
          	<input class="input" type="text" name="link" v-model="formObject.link"  size="50"><br />
        </div>
					<br />
		<button @click="update" class="button_color_blue">
                OK
        </button>
        <button @click="$emit('close')" class="button_color_orange">
                Close
        </button>
        </div>
      </div>
    </div>
  </transition>
</template>

<script>
import utilsMixin from "utilities";
export default {
	mixins: [utilsMixin],
	name: 'Modal',
	props: {
		// 受け取る属性名を指定
		val: Object, // オブジェクトのみ受け取る
	},
	data:function(){
		return{
			formObject: {
				'name': this.val.name, 
				'description':this.val.description,
				'link':this.val.link,
				'id':this.val.id,
				'errorMessage1':'',
				'errorMessage2':'',
			},
		}
	},
	methods:{
		update(){
			this.$emit('panretMessage', this.formObject)
			if(this.formObject.description.length > 130 || !this.formObject.description){
				this.formObject.errorMessage1 = "1以上130文字以下で入力をお願いします"
			}
			if(this.urlCheck(this.formObject.link) == false){
				this.formObject.errorMessage2 = "URLでの入力をお願いします"
			}
		}
	}
}
</script>

<style scoped>
.input{
	width: 80%;
	height: 2em;
	font-size:14px;
	background:white;
}
.text_area{
	width: 80%;
	height: 5em;
	font-size:14px;
	background:white;	
}
.font{
	color: red;
}
.modal-mask {
	position: fixed;
	z-index: 9998;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background-color: rgba(0, 0, 0, .5);
	display: table;
	transition: opacity .3s ease;
}
.modal-wrapper {
	display: table-cell;
	vertical-align: middle;
}
.modal-container {
	width: 40%;
	height: 40%;
	margin: 0px auto;
	padding: 20px 10px;
	background-color:rgb(192, 245, 179);
	border-radius: 2px;
	box-shadow: 0 2px 8px rgba(0, 0, 0, .33);
	transition: all .3s ease;
	font-family: Helvetica, Arial, sans-serif;
}
button{
	width:100px;
	height: 30px;
}
.button_color_blue{
	  background: blue;
	  color:white;
}
.button_color_orange{
	  background: orange;
	  color:white;
}
@media (max-width: 1020px) and (min-width: 768px) { 
	.modal-container {
		width: 90%;
		margin: 0px auto;
		padding: 10px 10px;
		background-color: bisque;
		border-radius: 2px;
		box-shadow: 0 2px 8px rgba(0, 0, 0, .33);
		transition: all .3s ease;
		font-family: Helvetica, Arial, sans-serif;
	}
	.input{
		width: 90%;
		height: 2em;
		font-size:20px;
		background:white;
	}
	.text_area{
		width: 90%;
		height: 4em;
		font-size:25px;
		background:white;
	}
}
</style>
