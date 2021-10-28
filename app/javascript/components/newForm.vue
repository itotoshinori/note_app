<template>
	<div class="form">
		<div class="box">
			<div class="form-group">
				<div class="errorMessage" v-if="post.description.length > 100">{{ post.description.length }}文字(130文字以下）</div>
				<textarea v-model="post.description" placeholder="本文(130字以内)" class="textarea-primary"></textarea>
				<div class="errorMessage">{{ errorMessage }}</div>
			</div>
			<div class="form-group">	
				<input v-model="post.link" placeholder="リンク https://" class="input-primary">
				<div class="errorMessage">{{ errorMessage2 }}</div>
			</div>
			<div class="form-group">	
				<button @click="send" class="button_color_orange">メモを追加</button>
				<button @click="reset" class="button_color_red">リセット</button>
			</div>
		</div>
	</div>
</template>
<script>
import utilsMixin from "utilities";
export default {
	mixins: [utilsMixin],
	data: function () {
		return {
			post: { 
					description: '',
					link:'',
			},
			errorMessage: '',
			errorMessage2: '',
		}
	},
	methods: {
		send: function () {
			this.errorMessage = ''
			this.errorMessage2 = ''
			if(this.post.description != ''&& this.post.description.length<=130 && this.urlCheck(this.post.link)){
					this.$emit('panretMessage', this.post)
					this.post.description = ''
					this.post.link = ''
			} else {
				if(!this.post.description){
					this.errorMessage = '本文を入力して下さい'
				}
				if(this.post.description.length>130){
					this.errorMessage = '130文字を超えてます'
				}
				if(this.urlCheck(this.post.link) == false){
					this.errorMessage2 = 'URLを入力して下さい'
				}
			}
		},
		reset: function (){
			this.errorMessage = ''
			this.errorMessage2 = ''
			this.post.description = ''
			this.post.link = ''
		}
	}
}
</script>
<style lang="scss" scoped>
.box {
    padding: 0.5em 1em;
    margin: 2em 0;
		width: 40%;
		margin: auto;
}
.textarea-primary {
  display: inline-block;
  vertical-align: top;
  width: 100%;
  max-height: 170px;
	padding-left:2px;
  box-sizing: border-box;
  border-radius: 5px;
  border: 1px solid #e5e5e5;
  font-size: 18px;
  outline: none;
  line-height: 1.6;
  resize: vertical;
}
.input-primary {
  display: inline-block;
  vertical-align: top;
  width: 100%;
  height: 30px;
	padding-left:2px;
  box-sizing: border-box;
  border-radius: 5px;
  border: 1px solid #e5e5e5;
  font-size: 18px;
  outline: none;
  line-height: 1.6;
}
.errorMessage {
	color:red;
}
.form-group{
	margin-bottom: 10px;
}

@media (max-width: 1020px) and (min-width: 768px) {
	.box {
    padding: 0.5em 1em;
    margin: 2em 0;
		width: 90%;
		margin: auto;
	}
}
button {
  width: 100px;
}
.button_color_orange{
	background: rgb(0, 89, 255);
	color:white;
}
.button_color_red{
	background: red;
	color:white;
}

</style>

