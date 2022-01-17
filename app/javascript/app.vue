<template>
  <div id="app">
    <div class="twitter_tag">
      <button @click="openModal2" class="button_color_twitter_repair">
        タグ修正
      </button>
    </div>
    <div id="overlay" v-show="showContent">
      <div id="content">
        <h5 style="padding-left: 0.7em">Twitterタグの修正</h5>
        <input v-model="tag" placeholder="twitterタグ" class="form-control" />
        <div style="padding-left: 0.7em">#は入れないこと</div>
        <button @click="okButton2" class="button_color_add">OK</button>
        <button @click="closeButton2" class="button_color_copy">Close</button>
      </div>
    </div>
    <NewForm @panretMessage="add"></NewForm>
    <div class="message">
      <div v-if="message" class="message-box">{{ message }}</div>
    </div>
    <SearchForm @panretMessage="search" @panretReset="allReset"></SearchForm>
    <modal
      :val="postItem"
      v-if="showModal"
      @panretMessage="update"
      @close="closeModal"
    ></modal>
    <div class="flex">
      <div
        v-for="memo in memos"
        :key="memo.id"
        class="card"
        v-bind:class="{ 'important-active': memo.important }"
      >
        <div class="card-body">
          <div style="white-space: pre-line">{{ memo.description }}</div>
          <div>
            NO.{{ memo.id }} {{ formatDate(memo.created_at) }}
            {{ memo.description.length }}字
            <span v-if="memo.link"
              ><a :href="memo.link" target="_blank">Link</a></span
            >
          </div>
          <div class="checkbox-group">
            <input
              type="checkbox"
              name="important"
              :checked="memo.important"
              @change="updateChecked(memo, 1)"
            />
            <label for="important"
              ><span class="label_content">重要</span></label
            >
            <input
              type="checkbox"
              name="complete"
              :checked="memo.complete"
              @change="updateChecked(memo, 2)"
            />
            <label for="complete"
              ><span class="label_content">完了&nbsp;</span></label
            >
            <input
              type="checkbox"
              name="public"
              :checked="memo.public"
              @change="updateChecked(memo, 4)"
            />
            <label for="public"
              ><span class="label_content">公開&nbsp;</span></label
            >
            <input
              type="checkbox"
              name="twitter"
              :checked="memo.twitter"
              @change="updateChecked(memo, 3)"
            />
            <span class="label_content">Twitter</span>
          </div>
          <div class="button-group">
            <button @click="openModal(memo)" class="button_color_add">
              編集
            </button>
            <button @click="deleteMemo(memo.id)" class="button_color_delete">
              削除
            </button>
            <button
              @click="copyToClipboard(memo.description, memo.link)"
              class="button_color_copy"
            >
              Copy
            </button>
            <span v-if="memo.public">
              <button @click="checkWording(memo.id)" class="button_color_check">
                Check
              </button>
            </span>
            <span v-if="memo.twitter">
              <button
                @click="toTwitter(memo.description, memo.link)"
                class="button_color_twitter"
              >
                Twitter
              </button>
            </span>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import Vue from "vue";
import axios from "axios";
import utilsMixin from "utilities";
import NewForm from "./components/newForm.vue";
import SearchForm from "./components/searchForm.vue";
import modal from "./components/modal.vue";
import VueClipboard from "vue-clipboard2";
Vue.use(VueClipboard);

export default {
  mixins: [utilsMixin],
  components: {
    NewForm,
    SearchForm,
    modal,
  },
  data: function () {
    return {
      memos: "",
      message: "",
      message2: "",
      description: "",
      link: "",
      important: "",
      complete: "",
      twitter: "",
      showModal: false,
      memo: "",
      searchWord: "",
      searchUncomplete: "",
      upImportant: "",
      searchTwitter: "",
      searchLink: "",
      showContent: false,
      info: "",
      tag: "",
    };
  },
  mounted() {
    setInterval(
      function () {
        this.setMemo();
        console.log("10秒後に実行");
      }.bind(this),
      100000
    );
    this.setMemo();
    this.setInfo();
  },
  methods: {
    setMemo: function () {
      let word = "";
      if (this.searchWord) {
        word = "?description=" + this.searchWord;
      }
      if (this.searchUncomplete) {
        if (word) {
          word = word + "&complete=false";
        } else {
          word = "?complete=false";
        }
      }
      if (this.upImportant) {
        if (word) {
          word = word + "&upImportant=true";
        } else {
          word = "?upImportant=true";
        }
      }
      if (this.updateAt) {
        if (word) {
          word = word + "&updateAt=true";
        } else {
          word = "?updateAt=true";
        }
      }
      if (this.searchTwitter) {
        if (word) {
          word = word + "&searchTwitter=true";
        } else {
          word = "?searchTwitter=true";
        }
      }
      if (this.searchLink) {
        if (word) {
          word = word + "&searchLink=true";
        } else {
          word = "?searchLink=true";
        }
      }
      axios
        .get("/api/memos/" + word)
        .then((response) => (this.memos = response.data));
    },
    setInfo: function () {
      axios
        .get("/api/infos/1")
        .then(
          (response) => (
            (this.info = response.data), (this.tag = this.info.twitter_tag)
          )
        );
    },
    updateInfo() {
      axios
        .put("/api/infos/" + this.info.id, {
          twitter_tag: this.info.twitter_tag,
          user_id: this.info.user_id,
        })
        .then((response) => (this.message = "更新に成功しました"))
        .catch((err) => {
          const message = err.response.data;
          this.message = "更新に失敗しました";
        });
    },
    addMemo: function () {
      axios
        .post("/api/memos", {
          description: this.description,
          link: this.link,
          important: this.important,
          public: this.public,
          twitter: this.twitter,
        })
        .then(
          (response) => (
            this.setMemo(), (this.message = "メッセージの登録に成功しました")
          )
        )
        .catch((err) => {
          const message = err.response.data;
          this.message = "メッセージの登録に失敗しました";
        });
    },
    deleteMemo(id) {
      if (
        window.confirm(
          "NO." + id + "を本当に削除しますか？※削除すれば画面更新がかかります"
        )
      ) {
        if (axios.delete("/api/memos/" + id)) {
          alert("削除に成功しました。画面は全更新、初期化します。");
          window.location.reload();
        } else {
          this.message = "削除に失敗しました";
        }
      }
    },
    add(post) {
      this.description = post.description;
      this.link = post.link;
      this.important = post.important;
      this.public = post.newPublic;
      this.twitter = post.twitter;
      this.addMemo();
    },
    search: function (post) {
      this.searchWord = post.searchWord;
      this.searchUncomplete = post.searchUncomplete;
      this.upImportant = post.upImportant;
      this.updateAt = post.updateAt;
      this.searchTwitter = post.searchTwitter;
      this.searchLink = post.searchLink;
      this.setMemo();
    },
    openModal(item) {
      this.postItem = item;
      this.showModal = true;
    },
    update(post) {
      this.description = post.description;
      this.link = post.link;
      this.important = post.important;
      axios
        .put("/api/memos/" + post.id, {
          description: post.description,
          link: post.link,
        })
        .then(
          (response) => (
            this.setMemo(),
            (this.showModal = false),
            (this.message = "更新に成功しました")
          )
        )
        .catch((err) => {
          const message = err.response.data;
          this.message = "更新に失敗しました";
        });
    },
    updateChecked(memo, num) {
      this.description = memo.description;
      this.link = memo.link;
      if (num == 1) {
        this.important = !memo.important;
      } else {
        this.important = memo.important;
      }
      if (num == 2) {
        this.complete = !memo.complete;
      } else {
        this.complete = memo.complete;
      }
      if (num == 3) {
        this.twitter = !memo.twitter;
      } else {
        this.twitter = memo.twitter;
      }
      if (num == 4) {
        this.public = !memo.public;
      } else {
        this.public = memo.public;
      }
      axios
        .put("/api/memos/" + memo.id, {
          description: memo.description,
          link: memo.link,
          important: this.important,
          complete: this.complete,
          twitter: this.twitter,
          public: this.public,
        })
        .then(
          (response) => (this.setMemo(), (this.message = "更新に成功しました"))
        )
        .catch((err) => {
          const message = err.response.data;
          this.message = "更新に失敗しました";
        });
    },
    toTwitter(description, link) {
      //await this.setInfo();
      //let tag = this.info.twitter_tag
      let tag = this.tag
      let tag_length = tag.length
      let tags = []
      let tag_dis =''
      for (let step = 0; step < tag_length; step++) {
        tag_step = tag.substr(step, 1)
        if(tag_step != "　" && step != tag_length -1){
          tag_dis = tag_dis + tag_step
        }else{
          tag_dis = tag_dis + tag_step
          tags.push(tag_dis)
          tag_dis = ''
        }
      }
      let content =
        "https://twitter.com/intent/tweet?text=" +
        description + "&hashtags=" + this.tag;
      if (link) {
        content = content + " " + link;
        this.link = link;
      }
      window.open(content, "_blank");
    },
    copyToClipboard(text, link) {
      if (link) {
        text = text + " " + link;
      }
      this.$copyText(text).then(
        function (e) {
          alert("本文をコピーしました");
          console.log(e);
        },
        function (e) {
          alert("コピーできません");
          console.log(e);
        }
      );
    },
    checkWording(id) {
      let content =
        "https://so-zou.jp/web-app/text/proofreading/?url=https%3A%2F%2Fnote-app-system.herokuapp.com%2Fmemos%2F" +
        id;
      window.open(content, "_blank");
    },
    closeModal() {
      this.showModal = false;
    },
    allReset() {
      window.location.reload();
    },
    openModal2() {
      this.setInfo();
      this.tag = this.info.twitter_tag;
      this.showContent = true;
    },
    okButton2() {
      this.info.twitter_tag = this.tag;
      this.updateInfo();
      this.showContent = false;
    },
    closeButton2() {
      this.showContent = false;
    },
  },
};
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
a {
  color: blue;
  text-decoration: none;
}

/* リンクがアクティブになっているときに適用 */
a.router-link-exact-active {
  color: black;
  font-weight: bold;
}
</style>
<style lang="scss" scoped>
.flex {
  display: flex;
  flex-wrap: wrap;
  justify-content: center;
  background-color: #ffffe3;
}
.message {
  background-color: #f7f7f7;
}
.message-box {
  border: 2px;
  padding: 2px;
  width: 38%;
  margin: auto;
  font-size: 20px;
  background-color: #f7f7f7;
}
button {
  width: 70px;
  height: 30px;
  font-size: 12px;
}
.button-group {
  margin-top: 2px;
}
.button_color_add {
  background: rgb(0, 68, 255);
  color: white;
}
.button_color_delete {
  background: red;
  color: white;
}
.button_color_check {
  background: rgb(0, 255, 128);
  color: white;
}
.button_color_twitter {
  background: rgb(0, 174, 255);
  color: white;
}
.button_color_copy {
  background: rgb(255, 0, 179);
  color: white;
}
.button_color_dowording {
  background: rgb(0, 255, 21);
  color: white;
  font-size: 10px;
}
.important-active {
  background: #f9efdd;
}
.twitter_tag {
  background: #f7f7f7;
  text-align: center;
}
.button_color_twitter_repair {
  background: rgb(0, 174, 255);
  color: white;
  margin: auto;
  width: 100px;
}
#overlay {
  /*　要素を重ねた時の順番　*/
  z-index: 1;

  /*　画面全体を覆う設定　*/
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background-color: rgba(0, 0, 0, 0.5);

  /*　画面の中央に要素を表示させる設定　*/
  display: flex;
  align-items: center;
  justify-content: center;
}
#content {
  z-index: 2;
  width: 30%;
  padding: 1em;
  background: #effff7;
}
@media screen and (min-width: 480px) {
  .card {
    width: 90%;
    border: 1px solid rgba(0, 0, 0, 0.125);
    border-radius: 0.25rem;
    margin: 16px;
    &-body {
      padding: 0.7rem;
      //background-color: blue;どこがかかっているのか確認する
    }
  }
}
@media screen and (min-width: 768px) and (max-width: 1024px) {
  .message-box {
    border: 2px;
    padding: 2px;
    width: 88%;
    margin: auto;
    font-size: 20px;
    background-color: #f7f7f7;
  }
  .card {
    width: 90%;
    border: 1px solid rgba(0, 0, 0, 0.125);
    border-radius: 0.25rem;
    margin: 16px;
    font-size: 28px;
    &-body {
      padding: 0.7rem;
      //background-color: red;//どこがかかっているのか確認する
    }
  }
  input[type="checkbox"] {
    transform: scale(1.5);
    margin: 0 6px 0 0;
  }
  .checkbox-group {
    margin: 10px 20px 1px 0;
  }
  .label_content {
    font-size: 16px;
  }
  #content {
    width: 70%;
  }
}
@media screen and (min-width: 1024px) {
  .card {
    width: 400px;
    border: 1px solid rgba(0, 0, 0, 0.125);
    border-radius: 0.25rem;
    margin: 16px;
    &-body {
      padding: 0.7rem;
    }
  }
}
</style>
