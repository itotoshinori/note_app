<template>
  <div id="app">
    <NewForm @panretMessage="add"></NewForm>
    <modal :val="postItem" v-if="showModal" @panretMessage="update" @close="closeModal"></modal>
    <div class="flex">
      {{ message }}
      <div v-for="memo in memos" :key="memo.id" class="card">
        <div class="card-bodyz1">
          <div style="white-space:pre-line;">{{ memo.description }}</div>
          <div>NO.{{memo.id}} {{ formatDate(memo.created_at) }} {{ memo.description.length }}字
            <span v-if="memo.link"><a :href="memo.link" target="_blank">リンク</a></span>
          </div>
          <div>
            <button @click="openModal(memo)" class="button_color_add">編集</button>
            <button @click="deleteMemo(memo.id)" class="button_color_delete">削除</button>
            <button @click="toTwitter(memo.description,memo.link)" class="button_color_twitter">twitterへ</button>
            <button @click="copyToClipboard(memo.description)" class="button_color_copy">コピー</button>
            <button @click="checkWording(memo.description)" class="button_color_dowording" alt="別サイトが開きますので文言コピーしてご活用下さい">文言確認</button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import Vue from 'vue'
import axios from 'axios';
import utilsMixin from "utilities";
import NewForm from './components/newForm.vue';
import modal from './components/modal.vue';
import VueClipboard from 'vue-clipboard2'

Vue.use(VueClipboard)

export default {
  mixins: [utilsMixin],
  components: {
    NewForm,
    modal
  },
  data: function () {
    return {
      memos: "memos",
      message:'',
      message2:'',
      description: '',
      link:'',
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
        description: this.description,
        link: this.link
      })
      .then(response => (
        this.setMemo()
      ));
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
      this.description = post.description
      this.link = post.link
      this.addMemo()
    },
    openModal(item) {
      this.postItem = item;
      this.showModal = true;
    },
    update(post){
      this.description = post.description
      this.link = post.link
      this.showModal = false
      axios.put('/api/memos/'+post.id, {
        description: post.description,
        link:post.link
      })
      .then(response => (
        this.setMemo() 
      ));
      //window.location.reload();
    },
    toTwitter( description, link ) {
      let content =
        "https://twitter.com/intent/tweet?text=" +
        description +
        "&hashtags=駆け出しエンジニアと繋がりたい";
      if (link) {
        content = content + " " + link;
        this.link = link;
      }
      window.open(content, "_blank");
    },
    copyToClipboard(text) {
      this.$copyText(text).then(function (e) {
        alert('本文をコピーしました')
        console.log(e)
      }, function (e) {
        alert('Can not copy')
          console.log(e)
      })
    },
    checkWording(text){
      this.copyToClipboard(text)
      let content = "https://so-zou.jp/web-app/text/proofreading/";
      window.open(content, "_blank");
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
  button {
    width: 70px;
  }
  .button_color_add{
	  background: rgb(0, 68, 255);
	  color:white;
  }
  .button_color_delete{
	  background: red;
	  color:white;
  }
  .button_color_twitter{
	  background: rgb(0, 174, 255);
	  color:white;
  }
  .button_color_copy{
	  background: rgb(255, 0, 179);
	  color:white;
  }
  .button_color_dowording{
	  background: rgb(0, 255, 21);
	  color:white;
  }
</style>
