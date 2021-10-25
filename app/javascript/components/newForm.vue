<template>
    <div class="form">
			<div class="form-group">
				<input v-model="post.title" placeholder="タイトル(１６文字以内）" class="form-control">
				<div class="errorMessage">{{ errorMessage1 }}</div>
			</div>
		<div class="form-group">
			<div class="errorMessage" v-if="post.description.length > 100">{{ post.description.length }}文字</div>
			<textarea v-model="post.description" placeholder="本文" class="form-control"></textarea>
			<div class="errorMessage">{{ errorMessage2 }}</div>
		</div>
		<div class="form-group">	
				<input v-model="post.link" placeholder="リンク https://" class="form-control">
				<div class="errorMessage">{{ errorMessage3 }}</div>
		</div>
		<button @click="send">メモを追加</button>
	</div>
</template>
<script>
import utilsMixin from "utilities";
export default {
	mixins: [utilsMixin],
	data: function () {
		return {
			post: { 
					title: '',
					description: '',
					link:'',
			},
			errorMessage1: '',
			errorMessage2: '',
			errorMessage3: '',
		}
	},
	methods: {
		send: function () {
			this.errorMessage1 = ''
			this.errorMessage2 = ''
			this.errorMessage3 = ''
			if(this.post.title != '' && this.post.description != '' && this.post.title.length<=16 && this.urlCheck(this.post.link)){
					this.$emit('panretMessage', this.post)
					this.post.title = ''
					this.post.description = ''
					this.post.link = ''
			} else {
				if(this.post.title.length>16){
					this.errorMessage1 = 'タイトルは16文字以下でお願いします'
				}
				if(!this.post.title){
					this.errorMessage1 = 'タイトルを入力して下さい'
				}
				if(!this.post.description){
					this.errorMessage2 = '本文を入力して下さい'
				}
				if(this.urlCheck(this.post.link) == false){
					this.errorMessage3 = 'URLを入力して下さい'
				}
			}
		},
	}
}
</script>
<style lang="scss" scoped>
.errorMessage {
	color:red;
}
.form {
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  margin: 20px;
  &-group {
     margin-bottom: 1rem;
  }
  &-control {
    width: 350px;
    min-height: 24px;
    font-size: 1rem;
    border: 1px solid #ced4da;
    padding: 4px 8px;
  }
}

button {
  width: 200px;
}
</style>

