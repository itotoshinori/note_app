<template>
  <transition name="modal">
    <div class="modal-mask">
      <div class="modal-wrapper">
        <div class="modal-container">
          <p>
            タイトル：<br />
          	<input type="text" name="title" v-model="formObject.title"  size="50"><br />
          </p>
					<p>
            本文：<br />
          	<textarea class="text_area" name="description" v-model="formObject.description" ></textarea><br />
          </p>
		    	<button @click="update">
                OK
          </button>
          <button @click="$emit('close')">
                Close
          </button>
        </div>
      </div>
    </div>
  </transition>
</template>

<script>
  export default {
    name: 'Modal',
    props: {
      // 受け取る属性名を指定
      val: Object, // オブジェクトのみ受け取る
    },
    data:function(){
      return{
        formObject: {
          'name': this.val.name, 
          'title':this.val.title,
          'description':this.val.description,
          'id':this.val.id,
					'errorMessage1':'',
					'errorMessage2':'',
        },
      }
    },
    methods:{
      update(){
				this.$emit('panretMessage', this.formObject)
        this.post.title = ''
        this.post.description = ''
				this.$emit('close') 
      }
    }
  }
</script>

<style scoped>
.text_area{
	width: 360px;
	height: 5em;
	font-size:15px;	
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
	height: 30%;
	margin: 0px auto;
	padding: 20px 10px;
	background-color:rgb(192, 245, 179);
	border-radius: 2px;
	box-shadow: 0 2px 8px rgba(0, 0, 0, .33);
	transition: all .3s ease;
	font-family: Helvetica, Arial, sans-serif;
}
@media (max-width: 1020px) and (min-width: 768px) { 
	.modal-container {
		width: 40%;
		margin: 0px auto;
		padding: 20px 10px;
		background-color: bisque;
		border-radius: 2px;
		box-shadow: 0 2px 8px rgba(0, 0, 0, .33);
		transition: all .3s ease;
		font-family: Helvetica, Arial, sans-serif;
	}
}
@media (max-width: 767px) {
	.modal-container {
		width: 95%;
		margin: 0px auto;
		padding: 20px 10px;
		background-color:rgb(214, 243, 220);
		border-radius: 2px;
		box-shadow: 0 2px 8px rgba(0, 0, 0, .33);
		transition: all .3s ease;
		font-family: Helvetica, Arial, sans-serif;
	}
}
</style>
