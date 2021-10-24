<template>
    <div class="form">
		<div class="form-group">
			<input v-model="post.title" placeholder="タイトル" class="form-control">
			<div class="errorMessage">{{ errorMessage1 }}</div>
		</div>
		<div class="form-group">
			<input v-model="post.description" placeholder="本文" class="form-control">
			<div class="errorMessage">{{ errorMessage2 }}</div>
		</div>
		<button @click="send">メモを追加</button>
	</div>
</template>
<script>
export default {
    data: function () {
        return {
            post: { 
                title: '',
                description: '',
            },
            errorMessage1: '',
            errorMessage2: '',
        }
    },
    methods: {
        send: function () {
            this.errorMessage1 = ''
            this.errorMessage2 = ''
            if(this.post.title != '' && this.post.description != ''){
                this.$emit('panretMessage', this.post)
                this.post.title = ''
                this.post.description = ''
            } else {
                if(!this.post.title){
                    this.errorMessage1 = 'タイトルを入力して下さい'
                }
                if(!this.post.description){
                    this.errorMessage2 = '本文を入力して下さい'
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
  margin: 32px;
  &-group {
     margin-bottom: 1rem;
  }
  &-control {
    width: 600px;
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

