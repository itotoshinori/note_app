<template>
  <div id="app">
    <NewForm @panretMessage="add"></NewForm>
    <modal :val="postItem" v-if="showModal" @panretMessage="update" @close="closeModal"></modal>
    <div class="flex">
      <div v-for="memo in memos" :key="memo.id" class="card">
        <div class="card-bodyz1">
          <div class="card-title">  
            {{ memo.id }}.{{ memo.title }}
          </div>
          <div style="white-space:pre-line;">{{ memo.description }}</div>
          <div>{{ formatDate(memo.created_at) }}　{{ memo.description.length }}文字
            <span v-if="memo.link"><a :href="memo.link" target="_blank">リンク</a></span>
          </div>
          <div><button @click="openModal(memo)">編集</button></div>
          <div><button @click="deleteMemo(memo.id)">削除</button></div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import axios from 'axios';
import utilsMixin from "utilities";
import NewForm from './components/newForm.vue';
import modal from './components/modal.vue';

export default {
  mixins: [utilsMixin],
  components: {
    NewForm,
    modal
  },
  data: function () {
    return {
      memos: "memos",
      title: '',
      message:'',
      message2:'',
      description: '',
      link:'',
      errorMessage1: '',
      errorMessage2: '',
      showModal:false,
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
      axios.post('/api/memos', {
        title: this.title,
        description: this.description,
        link: this.link
      })
      .then(response => (
        this.setMemo()
      ));
      this.title = ''
      this.description = ''
      this.link = ''
    },
    deleteMemo(id){
      if (window.confirm("NO." + id + "を本当に削除しますか？")) {
        axios.delete("/api/memos/" + id) 
      } 
      //this.setMemo()
      window.location.reload(); 
    },
    add(post) {
      this.title = post.title;
      this.description = post.description;
      this.link = post.link
      this.addMemo()
    },
    openModal(item) {
      this.postItem = item;
      this.showModal = true;
    },
    update(post){
      this.title = post.title 
      this.description = post.description
      this.link = post.link
      this.showModal = false
      axios.put('/api/memos/'+post.id, {
        title: post.title,
        description: post.description,
        link:post.link
      })
      .then(response => (
        this.setMemo() 
      ));
      //window.location.reload();
    },
    closeModal() {
      this.showModal = false;
    },
  }
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
<style lang="scss" scoped>
  button {
    width: 200px;
  }

  .flex {
    display: flex;
    flex-wrap: wrap;
    justify-content: center;
  }

  .card {
    width: 400px;
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
  @media (max-width: 1020px) and (min-width: 768px) { 
    .card {
      width: 95%;
    }
  }
</style>
