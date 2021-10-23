<template>
  <div id="app">
    <div class="form">
      <div class="form-group">
        <input v-model="title" placeholder="title" class="form-control">
        <div class="errorMessage">{{ errorMessage1 }}</div>
      </div>
      <div class="form-group">
        <input v-model="description" placeholder="description" class="form-control">
        <div class="errorMessage">{{ errorMessage2 }}</div>
      </div>
      <button @click="addMemo">メモを追加</button>
    </div>
    <div class="flex">
      <div v-for="memo in memos" :key="memo.id" class="card">
        <div class="card-body">
          <div class="card-title">
            {{ memo.id }}.{{ memo.title }}
          </div>
          <div>{{ memo.description }}</div>
          <div>{{ formatDate(memo.created_at) }}</div>
          <div><button @click="deleteMemo(memo.id)">削除</button></div>
        </div>
      </div>
    </div>
  </div>
</template>
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

  .flex {
    display: flex;
    flex-wrap: wrap;
    justify-content: center;
  }

  .card {
    width: 238px;
    border: 1px solid rgba(0,0,0,.125);
    border-radius: .25rem;
    margin: 16px;
    &-body {
      padding: 1.25rem;
    }
    &-title {
      margin-bottom: .75rem;
      font-weight: 600;
    }
  }
</style>


<script>
import axios from 'axios';
import utilsMixin from "utilities";

export default {
  mixins: [utilsMixin],
  data: function () {
    return {
      memos: "memos",
      title: '',
      description: '',
      errorMessage1: '',
      errorMessage2: '', 
    }
  },
  mounted () {
    this.setMemo();
  },
  methods: {
    setMemo: function () {
      axios.get('/api/memos')
      .then(response => (
        this.memos = response.data
      ))
    },
    addMemo: function() {
      this.errorMessage1 = ''
      this.errorMessage2 = ''
      if(this.title != '' && this.description != ''){
        axios.post('/api/memos', {
          title: this.title,
          description: this.description
        })
        .then(response => (
          this.setMemo()
        ));
        this.title = ''
        this.description = ''
      }else{
        if(!this.title){
          this.errorMessage1 = 'タイトルを入力して下さい'
        }
        if(!this.description){
          this.errorMessage2 = '本文を入力して下さい'
        }
      } 
    },
    deleteMemo(id){
      if (window.confirm("NO." + id + "を本当に削除しますか？")) {
        axios.delete("/api/memos/" + id)  
      } 
      window.location.reload(); 
    }
  }
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>