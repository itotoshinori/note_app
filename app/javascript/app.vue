<template>
  <div id="app">
    <NewForm @panretMessage="add"></NewForm>
    <hr />
    <SearchForm @panretMessage="search" @panretReset="allReset"></SearchForm>
    <hr />
    <modal :val="postItem" v-if="showModal" @panretMessage="update" @close="closeModal"></modal>
    <div class="flex">
      <div v-for="memo in memos" :key="memo.id" class="card" v-bind:class="{ 'important-active' : memo.important }">
        <div class="card-body">
          <div style="white-space:pre-line;">{{ memo.description }}</div>
            <div>NO.{{memo.id}} {{ formatDate(memo.created_at) }} {{ memo.description.length }}字
              <span v-if="memo.link"><a :href="memo.link" target="_blank">Link</a></span>
            </div>
            <div class="checkbox-group">
              <input type="checkbox" name="important" :checked="memo.important" @change="updateChecked(memo,1)" />
              <label for="important"><span class="label_content">重要</span></label>
              <input type="checkbox" name="complete" :checked="memo.complete" @change="updateChecked(memo,2)" />
              <label for="complete"><span class="label_content">完了&nbsp;</span></label>
              <input type="checkbox" name="twitter" :checked="memo.twitter" @change="updateChecked(memo,3)" />
              <span class="label_content">twitter</span>
            </div>
            <div class="button-group">
              <button @click="openModal(memo)" class="button_color_add">編集</button>
              <button @click="deleteMemo(memo.id)" class="button_color_delete">削除</button>
              <button @click="copyToClipboard(memo.description, memo.link)" class="button_color_copy">Copy</button>
              <span v-if="memo.twitter"> 
                <button @click="checkWording(memo.description)" class="button_color_check">Check</button>
                <button @click="toTwitter(memo.description, memo.link)" class="button_color_twitter">twitter</button>
              </span> 
            </div>
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
import SearchForm from './components/searchForm.vue';
import modal from './components/modal.vue';
import VueClipboard from 'vue-clipboard2'
Vue.use(VueClipboard)

export default {
  mixins: [utilsMixin],
  components: {
    NewForm,
    SearchForm,
    modal
  },
  data: function () {
    return {
      memos: "memos",
      message:'',
      message2:'',
      description: '',
      link:'',
      important:'',
      complete:'',
      showModal:false,
      memo:'',
      searchWord:'',
      searchUncomplete:'',
      upImportant:''
    }
  },
  mounted () {
    setInterval(
      function() {
        this.setMemo();
        console.log('10秒後に実行');
        }.bind(this),
        10000
      );
    this.setMemo(); 
  },
  methods: {
    setMemo: function () {
      let word = ''
      if(this.searchWord){
        word = '?description=' + this.searchWord
      }
      if(this.searchUncomplete){
        if(word){
          word = word + '&complete=false'
        }else{
          word = '?complete=false'
        }
      }
      if(this.upImportant){
        if(word){
          word = word + '&upImportant=true'
        }else{
          word = '?upImportant=true'
        }
      }
      axios.get('/api/memos/' + word)
      .then(response => (
        this.memos = response.data
      ));
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
      if (window.confirm("NO." + id + "を本当に削除しますか？※削除すれば画面更新がかかります")) {
        axios.delete("/api/memos/" + id)
        window.location.reload(); 
      } 
      //this.setMemo()
    },
    add(post) {
      this.description = post.description
      this.link = post.link
      this.addMemo()
    },
    search:function(post){
      this.searchWord = post.searchWord
      this.searchUncomplete = post.searchUncomplete
      this.upImportant = post.upImportant
      this.setMemo()
    },
    openModal(item) {
      this.postItem = item;
      this.showModal = true;
    },
    update(post){
      this.description = post.description
      this.link = post.link
      this.important = post.important
      this.showModal = false
      axios.put('/api/memos/'+post.id, {
        description: post.description,
        link:post.link
      })
      .then(response => (
        this.setMemo() 
      ));
    },
    updateChecked(memo,num){
      this.description = memo.description
      this.link = memo.link
      if(num == 1){
        this.important = !memo.important
      }else{
        this.important = memo.important
      }
      if(num == 2){
        this.complete = !memo.complete
      }else{
        this.complete = memo.complete
      }
      if(num == 3){
        this.twitter = !memo.twitter
      }else{
        this.twitter = memo.twitter
      }
      axios.put('/api/memos/'+memo.id, {
        description: memo.description,
        link:memo.link,
        important:this.important,
        complete:this.complete,
        twitter:this.twitter
      })
      .then(response => (
        this.setMemo() 
      ));
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
    copyToClipboard(text,link) {
      if(link){
        text = text + " " + link
      }
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
    allReset(){
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
<style lang="scss" scoped>
  .flex {
    display: flex;
    flex-wrap: wrap;
    justify-content: center;
  }
  button {
    width: 70px;
    height: 30px;
    font-size:12px;
  }
  .button-group{
    margin-top:2px;
  }
  .button_color_add{
	  background: rgb(0, 68, 255);
	  color:white;
  }
  .button_color_delete{
	  background: red;
	  color:white;
  }
  .button_color_check{
	  background: rgb(0, 255, 128);
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
    font-size:10px;
  }
  .important-active {
    background: #99FFCC;
  }
  @media screen and (min-width:480px) {
    .card {
      width: 90%;
      border: 1px solid rgba(0,0,0,.125);
      border-radius: .25rem;
      margin: 16px;
      &-body {
      padding: 0.7rem;
      //background-color: blue;どこがかかっているのか確認する
      }
    }
  }
  @media screen and (min-width:768px) and ( max-width:1024px) {
    .card {
      width: 90%;
      border: 1px solid rgba(0,0,0,.125);
      border-radius: .25rem;
      margin: 16px;
      font-size: 28px;
      &-body {
      padding: 0.7rem;
      //background-color: red;//どこがかかっているのか確認する
      }
    }
    input[type=checkbox] {
	    transform: scale(1.5);
	    margin: 0 6px 0 0;
    }
    .checkbox-group{
      margin: 10px 20px 1px 0;
    }
    .label_content{
      font-size:16px;
    }
  }
  @media screen and (min-width:1024px){
    .card {
      width: 400px;
      border: 1px solid rgba(0,0,0,.125);
      border-radius: .25rem;
      margin: 16px;
      &-body {
      padding: 0.7rem;
      //background-color: aqua;どこがかかっているのか確認する
      }
    } 
  }

  
  
</style>
